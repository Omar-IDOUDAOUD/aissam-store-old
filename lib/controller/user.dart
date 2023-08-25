import 'package:aissam_store/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  late String userId;
  UserModel? _user;

  @override
  void onInit() async {
    super.onInit();
    userId = _firebaseAuth.currentUser!.uid;
  }

  final CollectionReference<UserModel> _firestoreUsers =
      FirebaseFirestore.instance.collection('Users').withConverter(
            fromFirestore: UserModel.fromFirestore,
            toFirestore: (UserModel model, _) => model.toMap(),
          );

  UserModel getAuthUser() {
    final user = UserModel(
      userId: userId,
      email: _firebaseAuth.currentUser!.email,
      firstName: _firebaseAuth.currentUser!.displayName,
      profilePhotoUrl: _firebaseAuth.currentUser!.photoURL,
    );
    return user;
  }

  Future<bool> saveUser(UserModel user) async {
    await _firestoreUsers.doc(user.userId).set(user).catchError((e) {
      print('------------------------**faild');
      print('an error occcurred while add doc, $e');
      return false;
    }).then((value) {
      print('------------------------**seccess');
      _user = null;
    });
    return true;
  }

  Future<bool> checkUserExistence() async {
    final docUser = await _firestoreUsers
        .doc(_firebaseAuth.currentUser!.uid)
        .get()
        .catchError((e) {
      print('error: $e');
    });
    _user = docUser.exists ? docUser.data() : _user;
    return docUser.exists;
  }
}
