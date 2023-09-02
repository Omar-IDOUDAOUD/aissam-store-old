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

  late final DocumentReference<UserModel> _firestoreUsers;
  late final DocumentReference<UserData> _firestoreUsersData;
  @override
  void onInit() {
    super.onInit();

    _firestoreUsers = _fbfirestore
        .collection('Users')
        .withConverter(
          fromFirestore: UserModel.fromFirestore,
          toFirestore: (UserModel model, _) => model.toMap(),
        )
        .doc(_authenticationService.getUser!.uid);

    _firestoreUsersData = _fbfirestore
        .collection('UsersData')
        .withConverter(
          fromFirestore: UserData.fromFireStore,
          toFirestore: (UserData model, _) => model.toMap(),
        )
        .doc(_authenticationService.getUser!.uid);
  }

  String? get userId => _authenticationService.getUser!.uid;
  UserModel? _user;
  UserData? _userData;

  Future<void> saveUser(UserModel user, List<String> categories) async {
    try {
      await _firestoreUsers.set(user, SetOptions(merge: true));
      await _firestoreUsersData.set(
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
    final userDoc = await _firestoreUsers.get();
    _user = userDoc.data();
    return _user!;
  }

  Future<UserData> getUserData() async {
    if (_userData != null) return _userData!;
    final userDoc = await _firestoreUsersData.get();
    _userData = userDoc.data();
    return _userData!;
  }

  Future<bool> checkUserExistence(uid) async {
    final docUser =
        await _fbfirestore.collection('Users').doc(uid).get().catchError((e) {
      print('error: $e');
    });
    return docUser.exists;
  }

  // Future<bool> addFavoritedProduct(String productId) async {
  //   bool result = true;
  //   result = await FirebaseFirestore.instance
  //       .runTransaction<bool>((transaction) async {
  //     final List<String> latestFavsIds = await transaction
  //         .get(_firestoreUsersData.doc(userId))
  //         .then<List<String>>((value) => value.data()!.favoritedProducts!);
  //     latestFavsIds.add(productId);
  //     transaction.set(_firestoreUsersData.doc(userId),
  //         UserData(favoritedProducts: latestFavsIds), SetOptions(merge: true));
  //     return true;
  //   }).then(
  //     (value) => true,
  //     onError: (e) {
  //       result = false;
  //       print('catch error: $e');
  //     },
  //   );
  //   return result;
  // }
}
