



import 'package:aissam_store/controller/cloud_storage.dart';
import 'package:aissam_store/controller/product.dart';
import 'package:get/get.dart';

class HomeControllersBindings extends Bindings{
  
  @override
  void dependencies() {
    Get.put(CloudStorageController());
    Get.put(ProductsController());
  }

}

