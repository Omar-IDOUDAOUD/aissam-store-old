// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:async';

import 'package:aissam_store/models/user.dart';
import 'package:aissam_store/services/auth/auth_failed_errors.dart';
import 'package:aissam_store/services/auth/auth_result.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationService extends GetxService {
  static AuthenticationService get instance => Get.find();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;


  User? user;
  UserModel? _userModel;
  UserModel? get userModel => _userModel;

  bool get userLoggenIn => _firebaseAuth.currentUser != null;


  User get getUser=> _firebaseAuth.currentUser!; 


  Future<AuthResult> registerWithEmailAndPassword(
      String email, String password) async {
    if (email.isEmpty)
      return AuthResult(emailWrongMsg: AuthErrors.EMAIL_EMPTY_MSG);
    if (password.isEmpty)
      return AuthResult(passwordWrongMsg: AuthErrors.PASSWORD_EMPTY_MSG);
    UserCredential? userCredential;
    try {
      this.user = (userCredential = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: email, password: password))
          .user;
    } on FirebaseAuthException catch (e) {
      return AuthResult.fromErrorCode(
          code: e.code,
          type: AuthenticationModes.CreateAccountWithEmailAndPassword);
    }
    // saveUserProfile(
    //   UserModel(
    //     userId: userCredential.user!.uid,
    //     email: userCredential.user!.email!,
    //   ),
    // );
    return AuthResult.success(user: userCredential);
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


  // void signOut() {
    
  //   _firebaseAuth.signOut();
  // }

  // Timer? _emailVerificationTimer;

  // Future<bool> startEmailVerification() async {
  //   var resulte = false;
  //   var completer =
  //       Completer<bool>(); // Create a Completer to handle the async result
  //   FirebaseAuth.instance.currentUser!.sendEmailVerification();
  //   _emailVerificationTimer ??= Timer.periodic(Duration(seconds: 1), (timer) {
  //     print('checking email verified!');
  //     FirebaseAuth.instance.currentUser!.reload();
  //     if (FirebaseAuth.instance.currentUser!.emailVerified) {
  //       print('checking success');
  //       resulte = true;
  //       completer.complete(resulte);
  //       cancelEmailVerification();
  //     }
  //   });
  //   return completer.future;
  // }

  // void cancelEmailVerification() {
  //   if (_emailVerificationTimer != null) {
  //     _emailVerificationTimer!.cancel();
  //     _emailVerificationTimer = null;
  //   }
  // }

  Future<AuthResult> signInWithGoogle() async {
    UserCredential? user;
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      this.user = (user =
              await FirebaseAuth.instance.signInWithCredential(credential))
          .user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        return AuthResult(
          success: false,
          message: AuthErrors.ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIALS,
        );
      }
      return AuthResult(success: false, message: e.toString());
    }
    return AuthResult(
        success: true, message: 'signed in with google', user: user);
  }

  /////LOG-IN

  Future<AuthResult> signInWithEmailAndPassword(
      String email, String password) async {
    if (email.isEmpty)
      return AuthResult(emailWrongMsg: AuthErrors.EMAIL_EMPTY_MSG);
    if (password.isEmpty)
      return AuthResult(passwordWrongMsg: AuthErrors.PASSWORD_EMPTY_MSG);

    UserCredential? user;

    try {
      this.user = (user = await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password))
          .user;
    } on FirebaseAuthException catch (e) {
      return AuthResult.fromErrorCode(
          code: e.code, type: AuthenticationModes.SignInWithEmailAndPassword);
    }
    return AuthResult.success(user: user);
  }




  Future<void> signOut() async {
    
    print('Signed Out'); 
   await  _firebaseAuth.signOut(); 
  }


}
