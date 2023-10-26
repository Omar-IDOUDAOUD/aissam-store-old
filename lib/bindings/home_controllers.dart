import 'package:aissam_store/controller/cloud_storage.dart';
import 'package:aissam_store/controller/favoritres.dart';
import 'package:aissam_store/controller/product.dart';
import 'package:aissam_store/controller/search.dart';
import 'package:get/get.dart';

class HomeControllersBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(CloudStorageController());
    Get.put(FavoritesController());
    Get.put(ProductsController());
    // Get.lazyPut(() => SearchController());
    Get.lazyPut(() => SearchControllerV2());
  }
}
