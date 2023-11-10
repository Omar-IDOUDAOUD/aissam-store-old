// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:async';
import 'dart:isolate';

import 'package:aissam_store/core/utils/iterable_distinct_extension.dart';
import 'package:aissam_store/models/category.dart';
import 'package:aissam_store/view/home/tabs/search/filter_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:aissam_store/controller/product.dart';
import 'package:aissam_store/controller/user.dart';
import 'package:aissam_store/core/shared/pagination_data_result.dart';
import 'package:aissam_store/models/product.dart';
import 'package:aissam_store/view/home/tabs/search/widgets/resultes_part.dart';

class SearchHistoryItem {
  final String searchQuery;
  final DateTime searchDateTime;
  final String? tagId;

  SearchHistoryItem(
      {required this.searchQuery, required this.searchDateTime, this.tagId});

  factory SearchHistoryItem.fromMap(Map<String, dynamic> map) {
    return SearchHistoryItem(
        searchQuery: map['search_query'],
        searchDateTime: (map['search_datetime'] as Timestamp).toDate(),
        tagId: map['tag_id']);
  }

  Map<String, dynamic> toMap() {
    return {
      'search_query': searchQuery,
      'search_datetime': Timestamp.fromDate(searchDateTime),
      'tag_id': tagId,
    };
  }
}

class SearchControllerV2 extends GetxController {
  static SearchControllerV2 get instance => Get.find();
  late final TextEditingController searchFieldController;
  late final FocusNode searchFieldfocusNode;

  ValueNotifier<SearchTabUIStates> currentTabUIState =
      ValueNotifier(SearchTabUIStates.History);

  final UserController _userController = UserController.instance;
  final FirebaseFirestore _fbfirestore = FirebaseFirestore.instance;
  final ProductsController _productsController = ProductsController.instance;
  late CollectionReference<Product> _cloudProducts;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // _productsController.addTestProducts();
    searchFieldController = TextEditingController()..addListener(_resetResults);
    searchFieldfocusNode = FocusNode();
    _cloudProducts = _fbfirestore.collection('Products').withConverter(
        fromFirestore: Product.fromFirestore,
        toFirestore: (Product model, _) => model.toMap());
    _test();
  }

  void _test() {
    print('start test function');
    Query<Product> query = _cloudProducts;
    query = query.where(Filter.and(
      Filter('categories', arrayContainsAny: ['Jelaba']),
      Filter('price', isLessThanOrEqualTo: 20),
      Filter('price', isGreaterThanOrEqualTo: 10),
      Filter('sells', isEqualTo: 20),
      Filter('saves_number', isEqualTo: 15),
      Filter('colors', arrayContains: '#c7287f'),
    ));
    // query = query.orderBy('price').orderBy('sells');
    final results = query.limit(5).get().then((value) {
      print(
          'Results gotted: ${value.docs.map((e) => e.data().price).toString()}');
    });
  }

  List<SearchHistoryItem> get history =>
      _userController.getUserData.searchHistory!.reversed
          .distinctBy((e) => e.searchQuery)
          .toList();

  SearchTerm? _searchTerm;

  SearchTerm? get getSearchTerm => _searchTerm;

  void setSearchTerm([SearchTerm? term]) {
    print('SETIING SEARCH TERM');
    term ??= SearchTerm(query: searchFieldController.text);
    _userController.addSearchToHistoryLog(term.query, tagId: term.id);
    _searchTerm = term;
  }

  Future<List<SearchTerm>> suggestions() async {
    final term = searchFieldController.text.toLowerCase();
    final ref = _fbfirestore.collection('Products-Tags');
    final res = await ref
        .orderBy('tag')
        .startAt([term])
        .endAt(["$term\uf8ff"])
        .limit(11)
        .get();
    final x = res.docs.map(SearchTerm.fromFirebase).toList();
    print(x);
    return x;
  }

  final PaginationDataResult<Product> paginationData = PaginationDataResult();
  ResultsFiltersParameters filterParameters = ResultsFiltersParameters(
      type: ResultsTypes.All, categoriesNames: List.empty(growable: true));

  void setResultsTypeFilter(ResultsTypes newType) {
    filterParameters.type = newType;
  }

  void setResultsFilters(
      ResultsFiltersParameters Function(ResultsFiltersParameters currentFilters)
          newFilters) {
    if (currentTabUIState.value == SearchTabUIStates.Results) {
      _resetResults(true);
      search();
    }
    filterParameters = newFilters(filterParameters);
  }

  void setCategoriesFilter(List<String> newCategoriesNames) {
    filterParameters.categoriesNames = newCategoriesNames;
  }

  Future<void> search() async {
    print('Getting Search Resultes');
    assert(_searchTerm != null, 'should a searchTerm');
    if (!paginationData.canLoadMoreData || paginationData.isLoading) return;
    print('Loading more data ');
    paginationData.isLoading = true;
    update([paginationData.widgetToUpdateTag]);
    late final List<QueryDocumentSnapshot<Product>> results;
    if (_searchTerm!.id != null) {
      final tagsRef = _fbfirestore.collection('Products-Tags');
      final List<String> productsIds = await tagsRef
          .doc(_searchTerm!.id)
          .collection('tag_products')
          .get()
          .then((value) => value.docs.map((e) => e.id).toList());
      print(
          'products ids: ${productsIds.toString()}, tag id: ${_searchTerm!.id}');
      Query<Product> query =
          _cloudProducts.where(FieldPath.documentId, whereIn: productsIds);
      _resultsCountQuery = query;
      if (paginationData.lastLoadedDoc != null)
        query = query.startAfterDocument(paginationData.lastLoadedDoc!);
      query = QueryFilter.setFilter(filterParameters, query);

      results = await query.limit(10).get().then((value) => value.docs);
    } else {
      Query<Product> query =
          QueryFilter.setFilter(filterParameters, _cloudProducts);
      query = query
          .startAt([_searchTerm!.query]).endAt(["${_searchTerm!.query}\uf8ff"]);
      _resultsCountQuery = query;
      if (paginationData.lastLoadedDoc != null)
        query = query.startAfterDocument(paginationData.lastLoadedDoc!);
      results = await query.limit(10).get().then((value) => value.docs);
    }

    paginationData.isLoading = false;
    paginationData.lastLoadedDoc = results.isNotEmpty ? results.last : null;
    paginationData.loadedData.addAll(results.isNotEmpty
        ? results.map((e) => e.data())
        : List.empty(growable: true));
    if (results.length < 10) paginationData.canLoadMoreData = false;
    print(
        'RESULTS: ${paginationData.loadedData.length}, tag id = ${paginationData.widgetToUpdateTag}');
    _countResults();
    update([paginationData.widgetToUpdateTag]);
  }

  Query<Product>? _resultsCountQuery;
  int? resultsCount;
  void _countResults() async {
    if (resultsCount != null) return;
    assert(_resultsCountQuery != null, "search results count query required");
    resultsCount = null;
    // update([resultsCountWidgetsTag]);
    print('Count Resultes Query Exucuted');
    resultsCount =
        await _resultsCountQuery!.count().get().then((value) => value.count);
    update([resultsCountWidgetsTag]);
  }

  final String resultsCountWidgetsTag = 'RESULTS_COUNT_WIDGET_TAG';

  void _resetResults([bool keepSearchTerm = false]) {
    _resultsCountQuery = resultsCount = null;
    if (!keepSearchTerm) _searchTerm = null;
    paginationData.reset();
  }
}

class SearchTerm {
  final String? id;
  final String query;

  const SearchTerm({
    this.id,
    required this.query,
  });

  factory SearchTerm.fromFirebase(QueryDocumentSnapshot<Map> docSnapshot) {
    return SearchTerm(id: docSnapshot.id, query: docSnapshot.data()['tag']);
  }
}

enum SearchTabUIStates {
  History,
  Searching,
  Results,
}

class ResultsFiltersParameters {
  ResultsTypes type;
  List<String> categoriesNames;
  double? minPrice;
  double? maxPrice;
  int? size;
  List<int>? colors;

  ResultsFiltersParameters({
    required this.type,
    required this.categoriesNames,
    this.minPrice,
    this.maxPrice,
    this.colors,
    this.size,
  });

  ResultsFiltersParameters update({
    ResultsTypes? type,
    double? minPrice,
    double? maxPrice,
    int? size,
    List<int>? colors,
  }) {
    return ResultsFiltersParameters(
      // ignore: unnecessary_this
      categoriesNames: this.categoriesNames,
      type: this.type,
      minPrice: minPrice,
      maxPrice: maxPrice,
      size: size,
      colors: colors,
    );
  }
}

abstract class QueryFilter {
  static Query<Product> setFilter(
      ResultsFiltersParameters params, Query<Product> filterableQuery) {
    final List<ColorName> colorsColl = [
      ColorName(hex: '#28c7bf', name: 'Red'),
      ColorName(hex: 'EEF300', name: 'Yellow'),
      ColorName(hex: '0061F3', name: 'Blue'),
      ColorName(hex: '00F353', name: 'Green'),
    ];
    final List<String> sizes = ['S', 'M', 'L', 'X', 'XXL'];
    // cats fil
    final catsFilter = params.categoriesNames.isNotEmpty
        ? Filter('categories', arrayContainsAny: params.categoriesNames)
        : null;
    // specs fil
    final minPrice =
        Filter('price', isGreaterThanOrEqualTo: params.minPrice ?? 0);
    final maxPrice =
        Filter('price', isLessThan: params.maxPrice ?? double.infinity);
    final price = Filter.and(minPrice, maxPrice);
    final size = params.size != null
        ? Filter('size', arrayContainsAny: [sizes.elementAt(params.size!)])
        : null;
    final colors = params.colors != null && params.colors!.isNotEmpty
        ? Filter(
            'colors',
            arrayContainsAny:
                params.colors!.map<String>((e) => colorsColl.elementAt(e).hex),
          )
        : null;
    final specsFilter = Filter.and(price, price, size, colors);
    //submit filters to query
    filterableQuery =
        filterableQuery.where(Filter.and(specsFilter, specsFilter, catsFilter));
    return filterableQuery;
  }
}

enum ResultsTypes { All, MostLikked, BestSelling }
