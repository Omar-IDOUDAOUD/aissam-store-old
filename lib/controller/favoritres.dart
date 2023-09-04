import 'package:aissam_store/controller/user.dart';
import 'package:aissam_store/core/shared/pagination_data_result.dart';
import 'package:aissam_store/core/utils/error_popup.dart';
import 'package:aissam_store/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

///UNCOMPLETED WORK
class FavoritedProduct {
  final DateTime? favoritedAt;
  final String? productId;
  Product? product;

  FavoritedProduct({this.favoritedAt, this.productId, this.product});

  factory FavoritedProduct.fromMap(Map<String, dynamic> data) {
    return FavoritedProduct(
      productId: data['product_id'],
      favoritedAt: (data['created_at'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'product_id': productId,
      'created_at': Timestamp.fromDate(favoritedAt!),
    };
  }
}

////
class FavoritesController extends GetxController {
  static FavoritesController get instance => Get.find();

  late CollectionReference<Product> _cloudProducts;
  final FirebaseFirestore _fbfirestore = FirebaseFirestore.instance;
  final UserController _userController = UserController.instance;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _cloudProducts = _fbfirestore.collection('Products').withConverter(
        fromFirestore: Product.fromFirestore,
        toFirestore: (Product model, _) => model.toMap());
  }

  final _fpdr =
      PaginationDataResult<Product>(); //FavoritesPadinationDataResultes.
  PaginationDataResult<Product> get paginationDataResult => _fpdr;

  Future<PaginationDataResult<Product>> loadFavsPagination() async {
    if (!_fpdr.canLoadMoreData || _fpdr.isLoading) return _fpdr;
    _fpdr.hasError = false;
    _fpdr.isLoading = true;
    update([_fpdr.widgetToUpdateTag]);

    final List<String> _productsIds = await _userController
        .getUserData()
        .then<List<String>>((data) => data.favoritedProducts!);
    if (_productsIds.isEmpty) {
      _fpdr.isLoading = false;
      _fpdr.canLoadMoreData = false;
      update([_fpdr.widgetToUpdateTag]);
      return _fpdr;
    }
    Query<Product> query =
        _cloudProducts.where(FieldPath.documentId, whereIn: _productsIds);
    if (_fpdr.lastLoadedDoc != null)
      query = query.startAfterDocument(_fpdr.lastLoadedDoc!);

    query = query.limit(10);

    QuerySnapshot<Product> result = await query.get().then((value) {
      return value;
    }, onError: (e) {
      print('ctach error: ' + e.toString());
      _fpdr.hasError = true;
      update([_fpdr.widgetToUpdateTag]);
      TestingErrorPopup.show(e.toString());
    });

    print('get next pagination. l: ${result.docs.length}');

    if (result.docs.isNotEmpty) _fpdr.lastLoadedDoc = result.docs.last;

    _fpdr.isLoading = false;
    _fpdr.canLoadMoreData = result.docs.isNotEmpty;
    _fpdr.loadedData.addAll(result.docs.map((e) => e.data()));
    update([_fpdr.widgetToUpdateTag]);
    return _fpdr;
  }

  Future<void> addFavoritedProduct(String id) async {
    await _userController.firestoreUserData.update({
      'favorited_products': FieldValue.arrayUnion([id])
    }).then((value) {
      _fpdr.reset();
    });
  }

  Future<void> removeFavoritedProduct(String id) async {
    await _userController.firestoreUserData.update({
      'favorited_products': FieldValue.arrayRemove([id])
    }).then((value) {
      _fpdr.loadedData.removeWhere((element) => element.id == id);
    });
  }

  Future<bool> checkProductIsFavorited(String productId) async {
    final List<String> userFavsPrdsIds = await _userController
        .getUserData()
        .then((value) => value.favoritedProducts!);
    return userFavsPrdsIds.contains(productId);
  }
}
