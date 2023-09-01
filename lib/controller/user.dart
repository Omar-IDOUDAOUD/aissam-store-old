import 'package:aissam_store/models/user.dart';
import 'package:aissam_store/models/user_data.dart';
import 'package:aissam_store/services/auth/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  static UserController get instance => Get.find();
  final AuthenticationService _authenticationService =
      AuthenticationService.instance;
  final CollectionReference<UserModel> _firestoreUsers =
      FirebaseFirestore.instance.collection('Users').withConverter(
            fromFirestore: UserModel.fromFireStore,
            toFirestore: (UserModel model, _) => model.toMap(),
          );
  final CollectionReference<UserData> _firestoreUsersData =
      FirebaseFirestore.instance.collection('UsersData').withConverter(
            fromFirestore: UserData.fromFireStore,
            toFirestore: (UserData model, _) => model.toMap(),
          );
  String? get userId => _authenticationService.getUser!.uid;
  UserModel? _user;
  UserData? _userData;

  Future<void> saveUser(UserModel user, List<String> categories) async {
    try {
      await _firestoreUsers.doc(userId).set(user, SetOptions(merge: true));
      await _firestoreUsersData.doc(userId).set(
          UserData(id: userId!, categories: categories),
          SetOptions(merge: true));
    } catch (e) {
      throw Exception("can't save user and user data!, error: $e");
    }
    _user = null;
    _userData = null;
  }

  Future<UserModel> getUser() async {
    if (_user != null) return _user!;
    final userDoc = await _firestoreUsers.doc(userId).get();
    _user = userDoc.data();
    return _user!;
  }

  Future<UserData> getUserData() async {
    if (_userData != null) return _userData!;
    final userDoc = await _firestoreUsersData.doc(userId).get();
    _userData = userDoc.data();
    return _userData!;
  }

  Future<bool> checkUserExistence(uid) async {
    final docUser = await _firestoreUsers.doc(uid).get().catchError((e) {
      print('error: $e');
    });
    _user = docUser.exists ? docUser.data() : _user;
    return docUser.exists;
  }
}
