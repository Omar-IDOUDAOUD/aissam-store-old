import 'package:aissam_store/controller/user.dart';
import 'package:aissam_store/core/shared/pagination_data_result.dart';
import 'package:aissam_store/models/cart_item.dart';
import 'package:aissam_store/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class UserCartController extends GetxController {
  static UserCartController get instance => Get.find();

  final PaginationDataResult<CartItemData> _ucpd =
      PaginationDataResult<CartItemData>();

  PaginationDataResult<CartItemData> get cartItemsPaginationData => _ucpd;
  late final CollectionReference<Product> _cloudProducts;
  late final CollectionReference<CartItemData> _cartsRef;
  final FirebaseFirestore _fbfirestore = FirebaseFirestore.instance;
  UserController _userController = UserController.instance;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _cloudProducts = _fbfirestore.collection('Products').withConverter(
        fromFirestore: Product.fromFirestore,
        toFirestore: (Product model, _) => model.toMap());
    _cartsRef = _userController.firestoreUserDataRef!
        .collection('cart')
        .withConverter(
            fromFirestore: CartItemData.fromFirestore,
            toFirestore: (CartItemData d, _) => d.toMap());
  }

  Future<void> loadData() async {
    if (!_ucpd.canLoadMoreData || _ucpd.isLoading) return;
    _ucpd.hasError = false;
    _ucpd.isLoading = true;
    update([_ucpd.widgetToUpdateTag]);

    ///LOAD CART ITEMS
    Query<CartItemData> query = _cartsRef;
    if (_ucpd.lastLoadedDoc != null)
      query = query.startAfterDocument(_ucpd.lastLoadedDoc!);

    query = query.limit(10);

    List<CartItemData> result = await query.get().then(
      (value) {
        _ucpd.lastLoadedDoc = value.docs.lastOrNull;
        return value.docs.map((e) => e.data()).toList();
      },
    );

    if (result.isEmpty) {
      _ucpd.isLoading = false;
      _ucpd.canLoadMoreData = false;
      update([_ucpd.widgetToUpdateTag]);
      return;
    }
    ////

    /// LOAD PRODUCTS
    final List<Product> products =
        await _loadProducts(result.map<String>((e) => e.productId))
            .then((value) => value.toList());
    for (var i = 0; i < result.length; i++) {
      result[i].product = products.elementAt(i);
    }
    ////
    _ucpd.isLoading = false;
    _ucpd.canLoadMoreData = result.isNotEmpty;
    _ucpd.loadedData.addAll(result);
    update([_ucpd.widgetToUpdateTag]);
  }

  Future<Iterable<Product>> _loadProducts(Iterable<String> ids) async {
    return await _cloudProducts
        .where(FieldPath.documentId, whereIn: ids)
        .get()
        .then((value) => value.docs.map((e) => e.data()));
  }

  Future<void> modify(CartItemData newDt, int dataIndex) async {
    final CollectionReference<CartItemData> query =
        _userController.firestoreUserDataRef!.collection('cart').withConverter(
            fromFirestore: CartItemData.fromFirestore,
            toFirestore: (CartItemData d, _) => d.toMap());
    final oldData = _ucpd.loadedData.elementAt(dataIndex);
    await query
        .doc(oldData.id)
        .set(newDt, SetOptions(merge: true))
        .then((value) {
      _ucpd.loadedData[dataIndex] = oldData.copyWith(mergeWith: newDt);
      update([_ucpd.widgetToUpdateTag]);
    });
  }

  Future<void> delete(int dataIndex) {
    final doc = _ucpd.loadedData.elementAt(dataIndex);
    _ucpd.loadedData.removeAt(dataIndex);
    return _userController.firestoreUserDataRef!
        .collection('cart')
        .doc(doc.id)
        .delete();
  }
}
