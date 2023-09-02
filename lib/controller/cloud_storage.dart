import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class CloudStorageController extends GetxController {
  static CloudStorageController get instance => Get.find();
  FirebaseStorage _fbstorage = FirebaseStorage.instance;

  final String _categoriesFolderPath = "app_data/categories_avatars";

  Future<String> categoryImageUrlByName(String imageName) {
    final ref = _fbstorage.ref(_categoriesFolderPath).child(imageName);
    return ref.getDownloadURL();
  }
}
