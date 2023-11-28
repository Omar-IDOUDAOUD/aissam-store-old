import 'package:aissam_store/controller/search.dart';
import 'package:aissam_store/data/model/user.dart';
import 'package:aissam_store/data/model/user_data.dart';
import 'package:aissam_store/services/auth/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();
  FirebaseFirestore _fbfirestore = FirebaseFirestore.instance;
  final AuthenticationService _authenticationService =
      AuthenticationService.instance;

  late final DocumentReference<UserModel> firestoreUser;
  late final DocumentReference<UserData> firestoreUserData;
  @override
  void onInit() {
    super.onInit();

    firestoreUser = _fbfirestore
        .collection('Users')
        .withConverter(
          fromFirestore: UserModel.fromFirestore,
          toFirestore: (UserModel model, _) => model.toMap(),
        )
        .doc(_authenticationService.getUser!.uid);

    firestoreUserData = _fbfirestore
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
      await firestoreUser.set(user, SetOptions(merge: true));
      await firestoreUserData.set(UserData(id: userId!, categories: categories),
          SetOptions(merge: true));
    } catch (e) {
      throw Exception("can't save user and user data!, error: $e");
    }
    // return;
  }

  void _startSnapshotListeners() {
    firestoreUser.snapshots().listen((event) {
      _user = event.data();
      print('NEW USER SNAPSHOT EVENT DETECTED');
    });
    firestoreUserData.snapshots().listen((event) {
      _userData = event.data();
      print('NEW USER DATA SNAPSHOT EVENT DETECTED');
    });
  }

  Future<bool> initializeData() async {
    print('-------------INITIALIZE USER DATA-------------0');
    if (_user != null && _userData != null) return true;
    print('-------------INITIALIZE USER DATA-------------1');

    DocumentSnapshot<UserModel>? userDoc;
    DocumentSnapshot<UserData>? userDataDoc;
    bool errorOccurred = false;

    getData() async {
      userDoc = await firestoreUser.get().catchError((e) {
        errorOccurred = true;
      });
      userDataDoc = await firestoreUserData.get().catchError((e) {
        errorOccurred = true;
      });
    }

    await getData();
    print(
        '-------------INITIALIZE USER DATA-------------2, docs: 1: ${userDoc!.data()}, 2: ${userDataDoc!.data()}');

    if (errorOccurred) return false;

    if (!userDoc!.exists || !userDataDoc!.exists) {
      print('-------------INITIALIZE USER DATA-------------3');
      final userAuth = _authenticationService.getUser!;

      final UserModel user = UserModel(
        userId: userAuth.uid,
        email: userAuth.email,
        firstName: userAuth.displayName != null
            ? userAuth.displayName!.split(' ').first
            : null,
        lastName: userAuth.displayName != null
            ? userAuth.displayName!.split(' ').last
            : null,
        phoneNumber: userAuth.phoneNumber,
        profilePhotoUrl: userAuth.photoURL,
      );
      await saveUser(user, List.empty()).catchError((e) {
        errorOccurred = true;
      });
      if (errorOccurred) return false;
    } else {
      _startSnapshotListeners();
      _user = userDoc!.data();
      _userData = userDataDoc!.data();
      print(
          '-------------INITIALIZE USER DATA-------------3.5, 1: $_user, 2: $_userData-------------');
      return !errorOccurred;
    }
    print('-------------INITIALIZE USER DATA-------------4');

    await getData();
    if (errorOccurred) return false;
    _startSnapshotListeners();
    _user = userDoc!.data();
    _userData = userDataDoc!.data();
    print(
        '-------------FINISH INITIALIZE USER DATA, 1: $_user, 2: $_userData-------------');
    return true;
  }

  UserModel get getUser => _user!;

  UserData get getUserData => _userData!;

  Future<bool> checkUserExistence(uid) async {
    final docUser =
        await _fbfirestore.collection('Users').doc(uid).get().catchError((e) {
      print('error: $e');
    });
    return docUser.exists;
  }

  Future<void> addSearchToHistoryLog(String searchTerm, {String? tagId}) async {
    await firestoreUserData.update({
      'search_history': FieldValue.arrayUnion([
        SearchHistoryItem(
                searchQuery: searchTerm,
                searchDateTime: DateTime.now(),
                tagId: tagId)
            .toMap()
      ])
    });
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
