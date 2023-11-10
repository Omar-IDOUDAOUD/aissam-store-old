import 'dart:async';
import 'dart:math';

import 'package:aissam_store/controller/cloud_storage.dart';
import 'package:aissam_store/controller/favoritres.dart';
import 'package:aissam_store/controller/user.dart';
import 'package:aissam_store/core/shared/products_collections.dart';
import 'package:aissam_store/core/utils/hex_color.dart';
import 'package:aissam_store/models/category.dart';
import 'package:aissam_store/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductCollectionPaginationData {
  final ProductsCollections collection;
  final List<Product> loadedData = [];
  DocumentSnapshot? lastLoadedDoc;
  bool canLoadMoreData = true;
  bool isLoading = false;
  bool hasError = false;
  final String widgetToUpdateTag = Random.secure().nextInt(1000).toString();
  void reset() {
    loadedData.clear();
    lastLoadedDoc = null;
    canLoadMoreData = true;
    isLoading = false;
    hasError = false;
  }

  // Query<Product> setOrder(Query<Product> q ){
  //   q.orderBy(field)
  // }

  ProductCollectionPaginationData({required this.collection});
}

class ProductsController extends GetxController {
  static ProductsController get instance => Get.find();
  final FirebaseFirestore _fbfirestore = FirebaseFirestore.instance;
  final UserController _userController = UserController.instance;
  final FavoritesController _favoritesController = FavoritesController.instance;

  late CollectionReference<Product> _cloudProducts;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _cloudProducts = _fbfirestore.collection('Products').withConverter(
          fromFirestore: Product.fromFirestore,
          toFirestore: (Product model, _) => model.toMap(),
        );

    _userController.firestoreUserData.snapshots().listen((event) {
      final d = event.data();

      /// handle on product favorated action:

      ///
    });
  }

  final List<ProductCollectionPaginationData> _pagingDataByCollection = [
    ProductCollectionPaginationData(collection: ProductsCollections.Newest),
    ProductCollectionPaginationData(
        collection: ProductsCollections.BestSelling),
    ProductCollectionPaginationData(collection: ProductsCollections.ForYou),
    ProductCollectionPaginationData(collection: ProductsCollections.All),
    ProductCollectionPaginationData(collection: ProductsCollections.ByCategory),
  ];

  ProductCollectionPaginationData paginationDataOfCollection(
      ProductsCollections collection) {
    return _pagingDataByCollection
        .singleWhere((element) => element.collection == collection);
  }

  List<Category> _selectedProductsCategories = [];
  void setProductsCategories(List<Category> newCategories) {
    paginationDataOfCollection(ProductsCollections.ByCategory).reset();
    // paginationDataOfCollection()
    _selectedProductsCategories.clear();
    _selectedProductsCategories.addAll(newCategories);
    loadPagination(ProductsCollections.ByCategory);
  }

  Future<List<Product>> loadPagination(ProductsCollections collection) async {
    final ProductCollectionPaginationData c =
        paginationDataOfCollection(collection);
    print('class: ${c.loadedData.length}');
    if (!c.canLoadMoreData || c.isLoading) {
      return c.loadedData;
    }
    if (collection == ProductsCollections.ByCategory &&
        _selectedProductsCategories.isEmpty) return List.empty();

    ///
    c.hasError = false;
    c.isLoading = true;
    update([c.widgetToUpdateTag]);
    late final QuerySnapshot<Product> result;
    final String orderByField =
        collection == ProductsCollections.BestSelling ? 'sells' : 'timestamp';
    Query<Product> query =
        _cloudProducts.orderBy('$orderByField', descending: true);

    if (c.lastLoadedDoc != null)
      query = query.startAfterDocument(c.lastLoadedDoc!);

    if (c.collection == ProductsCollections.ByCategory) {
      query = query.where('categories',
          arrayContainsAny:
              _selectedProductsCategories.map<String>((e) => e.name));
    }

    if (c.collection == ProductsCollections.ForYou) {
      final userData = _userController.getUserData;
      final userCats = userData!.categories;
      query = query.where('categories', arrayContainsAny: userCats);
    }

    query = query.limit(10);

    result = await query.get().then((value) {
      return value;
    }, onError: (e) {
      print('ctach error: ' + e.toString());
      c.hasError = true;
      update([c.widgetToUpdateTag]);
    });

    print('get next pagination. l: ${result.docs.length}');

    if (result.docs.isNotEmpty) c.lastLoadedDoc = result.docs.last;

    final newPaginationClip = result.docs.map((e) => e.data()).toList();

    c.isLoading = false;
    c.canLoadMoreData = result.docs.isNotEmpty;
    c.loadedData.addAll(newPaginationClip);
    update([c.widgetToUpdateTag]);

    return c.loadedData;
  }

  Future<void> addTestProducts() async {
    ////

    ///
    final titles = [
      'title 1',
      'title 2',
      'title 3',
    ];
    final imgs = [
      'https://images.unsplash.com/photo-1608744882201-52a7f7f3dd60?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8MXx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=400&q=60',
      "https://images.unsplash.com/photo-1517423440428-a5a00ad493e8?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=400&q=60",
      'https://images.unsplash.com/photo-1545218553-cdb549f13f8a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1287&q=80',
      'https://images.unsplash.com/photo-1546460573-e6c02e39568a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDJ8fHxlbnwwfHx8fHw%3D&auto=format&fit=crop&w=400&q=60',
      "https://images.unsplash.com/photo-1575785662490-1e3ce6806ed5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDN8fHxlbnwwfHx8fHw%3D&auto=format&fit=crop&w=400&q=60",
      'https://images.unsplash.com/photo-1608744882201-52a7f7f3dd60?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8MXx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=400&q=60',
      "https://images.unsplash.com/photo-1517423440428-a5a00ad493e8?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=400&q=60",
      'https://images.unsplash.com/photo-1545218553-cdb549f13f8a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1287&q=80',
      'https://images.unsplash.com/photo-1546460573-e6c02e39568a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDJ8fHxlbnwwfHx8fHw%3D&auto=format&fit=crop&w=400&q=60',
      "https://images.unsplash.com/photo-1575785662490-1e3ce6806ed5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDN8fHxlbnwwfHx8fHw%3D&auto=format&fit=crop&w=400&q=60",
    ];
    final thumbnails = [
      'https://firebasestorage.googleapis.com/v0/b/aissam-store-fb-backend.appspot.com/o/products%2Fthumbnails%2Fabaya-fluid-caftan-marwae.webp?alt=media&token=9dd01d72-b2d8-4ede-bd3e-cebb6206ee35&_gl=1*b1ioov*_ga*MTgxODE0NDQ0LjE2OTMyMzIwNzM.*_ga_CW55HF8NVT*MTY5OTQ0MTg4Ni44Mi4xLjE2OTk0NDQ0NDMuNDguMC4w',
      'https://firebasestorage.googleapis.com/v0/b/aissam-store-fb-backend.appspot.com/o/products%2Fthumbnails%2Fabaya-maheen-dress-with-sequin-trim.webp?alt=media&token=07885fd3-0993-4020-9d6a-39aa6c397576&_gl=1*ai1e3u*_ga*MTgxODE0NDQ0LjE2OTMyMzIwNzM.*_ga_CW55HF8NVT*MTY5OTQ0NzMzMy44My4wLjE2OTk0NDczMzMuNjAuMC4w',
      'https://firebasestorage.googleapis.com/v0/b/aissam-store-fb-backend.appspot.com/o/products%2Fthumbnails%2Fabaya-shirt-wafa.webp?alt=media&token=0cdba4a5-8678-4888-a739-af5f7649cdb0&_gl=1*1l76ch4*_ga*MTgxODE0NDQ0LjE2OTMyMzIwNzM.*_ga_CW55HF8NVT*MTY5OTQ0NzMzMy44My4xLjE2OTk0NDczNDQuNDkuMC4w',
      'https://firebasestorage.googleapis.com/v0/b/aissam-store-fb-backend.appspot.com/o/products%2Fthumbnails%2Fgandoura-interior-ryelle.webp?alt=media&token=138afec7-7d81-4e49-aa68-628bcb23acd1&_gl=1*1wqhg2r*_ga*MTgxODE0NDQ0LjE2OTMyMzIwNzM.*_ga_CW55HF8NVT*MTY5OTQ0NzMzMy44My4xLjE2OTk0NDczNjMuMzAuMC4w',
      'https://firebasestorage.googleapis.com/v0/b/aissam-store-fb-backend.appspot.com/o/products%2Fthumbnails%2Fgandoura-orientale-farashaa.webp?alt=media&token=9d640c2d-0835-4d52-8bc7-722564da5650&_gl=1*1bz5cy2*_ga*MTgxODE0NDQ0LjE2OTMyMzIwNzM.*_ga_CW55HF8NVT*MTY5OTQ0NzMzMy44My4xLjE2OTk0NDczNzIuMjEuMC4w',
    ];
    final cats = ['Qaftans', 'Hijabs', 'Jelaba', 'Abayas'];
    final colors = ['#595dcf', '#c7287f', '#c7287f', '#c79528', '#28c7bf'];
    final List<Product> list = List.generate(
      12,
      (index) => Product(
        thumbnailPicture: (thumbnails..shuffle()).first,
        categories: (cats..shuffle()).take(1).toList(),
        colors: (colors..shuffle()).take(2).toList(),
        description: 'No description',
        title: (titles..shuffle()).first,
        images: imgs..shuffle(),
        price: Random.secure().nextDouble() * 200.0,
        rankingAverage: Random.secure().nextDouble() * 5.0,
        sells: Random.secure().nextInt(100),
        reviews: Random.secure().nextInt(100),
        timestamp: Timestamp.now(),
        savesNumber: Random.secure().nextInt(50),
      ),
    );

    try {
      for (var element in list) {
        await _cloudProducts.add(element);
        print('a product added successfuly');
      }
    } catch (e) {
      print(e);
    }
  }

  CloudStorageController? _cloudStorageController;
  List<Category>? loadedCategories;
  bool _isCategoryLoading = false;
  Completer<List<Category>>? _categoriesLoadingCompleter;
  Future<List<Category>> categories() async {
    if (_categoriesLoadingCompleter != null)
      return _categoriesLoadingCompleter!.future;
    _categoriesLoadingCompleter = Completer();
    if (loadedCategories != null) return loadedCategories!;
    _cloudStorageController ??= CloudStorageController.instance;
    _fbfirestore.collection('Categories').get().then((res) async {
      loadedCategories = [];

      for (var element in res.docs) {
        final e = element.data();
        final cat = Category(
          id: element.id,
          name: e['name'],
          color: HexColor(e['color']),
          imageUrl: await _cloudStorageController!
              .categoryImageUrlByName(e['image_name']),
        );
        loadedCategories!.add(cat);
      }
      print('completer finished');
      _categoriesLoadingCompleter!.complete(loadedCategories);
    });

    return _categoriesLoadingCompleter!.future;
  }

//   List<String> _selectedProductsCategories = [];
// set selectedProductsCategories (List<String> newList, String id){
//   _selectedProductsCategories = newList;
//   update
// }

  // void updateSelectedCategories(List<int> newList){

  // }
}
