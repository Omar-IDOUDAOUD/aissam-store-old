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

  Future<void> addTestProduct() async {
    final titles = [
      'Once upon a time in a quaint village nestled betwee',
      "rolling hills, lived a young girl named",
      ' Lily. Lily was known throughout',
      'the village for her boundless ',
      "le smiled more, shared more, and worked together more harmoniously.",
      'Once upon a time in a quaint village nestled betwee',
      "rolling hills, lived a young girl named",
      ' Lily. Lily was known throughout',
      'the village for her boundless ',
      "le smiled more, shared more, and worked together more harmoniously.",
      'Once upon a time in a quaint village nestled betwee',
      "rolling hills, lived a young girl named",
      ' Lily. Lily was known throughout',
      'the village for her boundless ',
      "le smiled more, shared more, and worked together more harmoniously.",
      'Once upon a time in a quaint village nestled betwee',
      "rolling hills, lived a young girl named",
      ' Lily. Lily was known throughout',
      'the village for her boundless ',
      "le smiled more, shared more, and worked together more harmoniously.",
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
    final tags = [
      'wfceoRY4988Zbzz0cTnB',
      'btCQfBCx1Q8m0aeDBguO',
      'DVRZXtp4egRqlwyg3UtI'
    ];
    final cats = ['Qaftans', 'Hijabs', 'Jelaba', 'Abayas'];
    try {
      await _cloudProducts
          .add(
        Product(
          cardPicture: imgs.elementAt(Random.secure().nextInt(imgs.length)),
          colors: [
            Colors.red,
            Colors.blue,
            Colors.yellow,
          ],
          description: titles.elementAt(Random.secure().nextInt(titles.length)),
          price: 152,
          title: titles.elementAt(Random.secure().nextInt(titles.length)),
          images: imgs,
          rankingAverage: 2.3,
          reviews: 5,
          categories: [cats.elementAt(Random.secure().nextInt(cats.length))],
          sells: Random.secure().nextInt(100),
          // tags: [tags.elementAt(Random.secure().nextInt(tags.length))],
          // number: _cloudProducts.count().query.get()
        ),
      )
          .then((value) async {
        print('success: $value');
        final tagId = tags.elementAt(Random.secure().nextInt(tags.length));
        await _cloudProducts
            .doc(value.id)
            .collection('search_tags')
            .doc(tagId)
            .set({
          'tag_id': tagId,
        });
      }).catchError((e) {
        print('catch error: $e');
      });
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
