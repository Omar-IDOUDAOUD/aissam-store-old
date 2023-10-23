// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:async';

import 'package:aissam_store/controller/user.dart';
import 'package:aissam_store/models/user.dart';
import 'package:aissam_store/services/auth/auth_failed_errors.dart';
import 'package:aissam_store/services/auth/auth_result.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationService extends GetxService {
  static AuthenticationService get instance => Get.find();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _firebaseAuth.authStateChanges().listen((User? user) {
      print(
          'USER STATE CHANGE=======================USER:$user====================');
      _user = user;
    });
  }

  User? _user;

  bool get userLoggedIn => _firebaseAuth.currentUser != null;

  User? get getUser => _firebaseAuth.currentUser;

  // String get getUserId => _user!.uid;

  // String get getUserId => _user!.uid;

  // String get getUserId => _user!.uid;

  Future<AuthResult> _saveUserAfterAuthenticate(
      UserCredential userCredential) async {
    final UserController userController = UserController.instance;
    AuthResult authResult = AuthResult.success(user: userCredential);
    if (await userController.checkUserExistence(userCredential.user!.uid)) {
      await userController.initializeData();
      return authResult;
    }

    // final user = userCredential.user!;
    final newUser = UserModel(
      userId: _user!.uid,
      email: _user!.email,
      firstName: _user!.displayName != null
          ? _user!.displayName!.split(' ').first
          : null,
      lastName: _user!.displayName != null
          ? _user!.displayName!.split(' ').last
          : null,
      phoneNumber: _user!.phoneNumber,
      profilePhotoUrl: _user!.photoURL,
    );
    await userController.saveUser(newUser, List.empty()).catchError((e) {
      authResult = AuthResult(message: e);
    });
    authResult.needsFillUserInfoAfterAuth = true;
    if (authResult.success) await userController.initializeData();

    return authResult;
  }

  Future<AuthResult> registerWithEmailAndPassword(String email, String password,
      [String? phone]) async {
    final emptinessValidator = _validateFieldsEmptiness(email, password, phone);
    if (emptinessValidator != null) return emptinessValidator;
    UserCredential? userCredential;

    try {
      userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      return AuthResult.fromErrorCode(
          code: e.code,
          type: AuthenticationModes.CreateAccountWithEmailAndPassword);
    }
    final authResult = await _saveUserAfterAuthenticate(userCredential);
    return authResult;
  }

  Future<AuthResult> signInWithGoogle() async {
    UserCredential? userCredential;
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        return AuthResult(
          success: false,
          message: AuthErrors.ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIALS,
        );
      }
      return AuthResult(success: false, message: e.message);
    } catch (e) {
      return AuthResult(success: false, message: e.toString());
    }

    final authResult = await _saveUserAfterAuthenticate(userCredential);
    return authResult;
  }

  /////LOG-IN

  AuthResult? _validateFieldsEmptiness(String email, String password,
      [String? phone]) {
    if (email.isEmpty)
      return AuthResult(emailWrongMsg: AuthErrors.EMAIL_EMPTY_MSG);
    if (password.isEmpty)
      return AuthResult(passwordWrongMsg: AuthErrors.PASSWORD_EMPTY_MSG);
    if (phone != null && !phone.isPhoneNumber)
      return AuthResult(passwordWrongMsg: AuthErrors.PHONE_INCORRECT);
    return null;
  }

  Future<AuthResult> signInWithEmailAndPassword(
      String email, String password) async {
    UserCredential? userCredential;
    final emptinessValidator = _validateFieldsEmptiness(email, password);
    if (emptinessValidator != null) return emptinessValidator;
    try {
      userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      return AuthResult.fromErrorCode(
          code: e.code, type: AuthenticationModes.SignInWithEmailAndPassword);
    }
    final UserController userController = UserController.instance;
    await userController.initializeData();
    return AuthResult.success(user: userCredential);
  }

  Future<void> signOut() async {
    print('Signed Out and delete user');
    await _firebaseAuth.currentUser!.delete();
    //  _firebaseAuth.signOut();
  }

  // Future<AuthResult> registerAnonymously() async {
  //   AuthResult? result;
  //   UserCredential? user;
  //   try {
  //     user = await _firebaseAuth.signInAnonymously();
  //   } on FirebaseAuthException {
  //     result = AuthResult.anErrorOccure();
  //   }
  //   result ??= AuthResult.success(user: user);
  //   return result;
  // }

  Timer? _emailVerificationTimer;

  Future<bool> startEmailVerification() async {
    var resulte = false;
    var completer =
        Completer<bool>(); // Create a Completer to handle the async result
    FirebaseAuth.instance.currentUser!.sendEmailVerification();
    _emailVerificationTimer ??= Timer.periodic(Duration(seconds: 1), (timer) {
      print('checking email verified!');
      FirebaseAuth.instance.currentUser!.reload();
      if (FirebaseAuth.instance.currentUser!.emailVerified) {
        print('checking success');
        resulte = true;
        completer.complete(resulte);
        cancelEmailVerification();
      }
    });
    return completer.future;
  }

  void cancelEmailVerification() {
    if (_emailVerificationTimer != null) {
      _emailVerificationTimer!.cancel();
      _emailVerificationTimer = null;
    }
  }
}
