import 'dart:async';

import 'package:aissam_store/models/user.dart';
import 'package:aissam_store/models/user_data.dart';
import 'package:aissam_store/services/auth/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  FirebaseFirestore _fbfirestore = FirebaseFirestore.instance;
  final AuthenticationService _authenticationService =
      AuthenticationService.instance;

  DocumentReference<UserModel>? firestoreUserRef;
  DocumentReference<UserData>? firestoreUserDataRef;

  @override
  // TODO: implement onDelete
  InternalFinalCallback<void> get onDelete {
    print('DELETE UserController from memory');
    return super.onDelete;
  }

  void clearUser() {
    _user = null;
    _userData = null;
    firestoreUserDataRef = null;
    firestoreUserRef = null;
  }

  void _initializeUserDocsRefs() {
    if (firestoreUserRef != null && firestoreUserDataRef != null) return;

    firestoreUserRef = _fbfirestore
        .collection('Users')
        .withConverter(
          fromFirestore: UserModel.fromFirestore,
          toFirestore: (UserModel model, _) => model.toMap(),
        )
        .doc(userId);

    firestoreUserDataRef = _fbfirestore
        .collection('UsersData')
        .withConverter(
          fromFirestore: UserData.fromFireStore,
          toFirestore: (UserData model, _) => model.toMap(),
        )
        .doc(userId);
    firestoreUserDataRef!.snapshots().listen((event) {
      _userData = event.data();
      print('SNAPSHOT EVENT DETECTED: favs: ${_userData.toString()}');
    });
  }

  String? get userId => _authenticationService.getUser!.uid;
  UserModel? _user;
  UserData? _userData;

  Future<void> saveUser(UserModel user, List<String> categories) async {
    _initializeUserDocsRefs();
    try {
      await firestoreUserRef!.set(user, SetOptions(merge: true));
      await firestoreUserDataRef!.set(
          UserData(id: userId, categories: categories),
          SetOptions(merge: true));
    } catch (e) {
      throw Exception("can't save user and user data!, error: $e");
    }
  }

  Future<void> initializeData() async {
    if (_user != null && _userData != null) return;
    _initializeUserDocsRefs();
    DocumentSnapshot<UserModel>? userDoc;
    DocumentSnapshot<UserData>? userDataDoc;

    print('===============test 1');

    initializeUser() async {
      print('===============test 2');

      userDoc = await firestoreUserRef!.get();
      if (userDoc == null) throw Exception("can't init user");
      print('===============test 3');

      userDataDoc = await firestoreUserDataRef!.get();
      if (userDataDoc == null) throw Exception("can't init user data");
      print('===============test 4');
    }

    await initializeUser();

    if (!userDoc!.exists || !userDataDoc!.exists) {
      print('===============test 5');

      final userFromAuth = _authenticationService.getUser!;
      final userToCreate = UserModel(
        email: userFromAuth.email,
        firstName: userFromAuth.displayName != null
            ? userFromAuth.displayName!.split(' ').first
            : null,
        lastName: userFromAuth.displayName != null
            ? userFromAuth.displayName!.split(' ').last
            : null,
        phoneNumber: userFromAuth.phoneNumber,
        profilePhotoUrl: userFromAuth.photoURL,
        userId: userFromAuth.uid,
      );
      print('===============test 6');

      await saveUser(userToCreate, List.empty()).then((value) async {
        await initializeUser();
      });
      print('===============test 7');
    }

    _user = userDoc!.data();
    _userData = userDataDoc!.data();
    print(
        '===============test 8 -- user: ${_user.toString()}, udata: ${_userData.toString()}');
  }

  UserModel get getUser => _user!;
  UserData get getUserData => _userData!;

  Future<bool> checkUserExistence() async {
    _initializeUserDocsRefs();
    final docUser = await firestoreUserRef!.get().catchError((e) {
      print('error: $e');
    });
    return docUser.exists;
  }
}
