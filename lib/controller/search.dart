// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:aissam_store/controller/user.dart';
import 'package:aissam_store/controller/product.dart';
import 'package:aissam_store/core/shared/pagination_data_result.dart';
import 'package:aissam_store/models/product.dart';
import 'package:aissam_store/view/home/tabs/search/widgets/resultes_part.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

enum ResultsTypes { all, bestSelling, mostLiked }

class SearchTerm {
  final String term;
  final String? suggestionTagId;

  SearchTerm({required this.term, this.suggestionTagId});
}

class PaginationDataByResultType {
  final PaginationDataResult<Product> paginationData;
  final ResultsTypes type;
  int? resultsNumber;

  void reset() {
    paginationData.reset();
    resultsNumber = null;
  }

  PaginationDataByResultType(
      {required this.paginationData, required this.type});
}

class SearchController extends GetxController {
  static SearchController get instance => Get.find();
  final UserController _userController = UserController.instance;
  final FirebaseFirestore _fbfirestore = FirebaseFirestore.instance;
  late CollectionReference<Product> _cloudProducts;
  final TextEditingController searchTextEditingController =
      TextEditingController();

  @override
  onInit() {
    super.onInit();
    _cloudProducts = _fbfirestore.collection('Products').withConverter(
        fromFirestore: Product.fromFirestore,
        toFirestore: (Product model, _) => model.toMap());
    searchTextEditingController.addListener(reset);
  }

  List<SearchHistoryItem> get searchHistory =>
      _userController.getUserData.searchHistory!;

  List<SearchTerm>? lastSearchSuggestions;
  String? lastSearchTerm;
  Future<List<SearchTerm>> searchSuggestions(String term) async {
    if (term == lastSearchTerm) return lastSearchSuggestions!;
    final ref = _fbfirestore.collection('Products-Tags');
    term = term.toLowerCase();
    final res = await ref
        .orderBy('tag')
        .startAt([term])
        .endAt(["$term\uf8ff"])
        .limit(11)
        .get();
    // final suggsFromHistory0 = searchHistory.where((element) =>
    //     element.searchQuery.contains(term) || element.searchQuery == term);
    // final suggsFromHistory = suggsFromHistory0
    //     .map<SearchTerm>(
    //         (e) => SearchTerm(term: e.searchQuery, suggestionTagId: e.tagId))
    //     .toList();

    lastSearchTerm = term;
    lastSearchSuggestions = res.docs
        .map<SearchTerm>(
            (e) => SearchTerm(term: e.data()['tag'], suggestionTagId: e.id))
        .toList();
    // lastSearchSuggestions!.insertAll(0, suggsFromHistory);
    return lastSearchSuggestions!;
  }

  final List<PaginationDataByResultType> _resultsData = [
    PaginationDataByResultType(
        paginationData: PaginationDataResult<Product>(),
        type: ResultsTypes.all),
    PaginationDataByResultType(
        paginationData: PaginationDataResult<Product>(),
        type: ResultsTypes.bestSelling),
    PaginationDataByResultType(
        paginationData: PaginationDataResult<Product>(),
        type: ResultsTypes.mostLiked),
  ];

  // final _spdr = PaginationDataResult<Product>(); //SearchPadinationDataResultes.
  PaginationDataResult<Product> paginationDataResultBy(ResultsTypes type) {
    return _resultsData
        .singleWhere((element) => element.type == type)
        .paginationData;
  }

  int? resultsNumberBy(ResultsTypes type) {
    return _resultsData
        .singleWhere((element) => element.type == type)
        .resultsNumber;
  }

  void reset() => _resultsData.forEach((element) => element.reset());

  SearchTerm? _searchTerm = null;
  set searchTerm(SearchTerm t) {
    if (t.suggestionTagId == null && lastSearchSuggestions != null) {
      t = lastSearchSuggestions!
          .singleWhere((element) => element.term == t.term, orElse: () => t);
    }
    searchTextEditingController.text = t.term;
    _searchTerm = t;
    final UserController userController = UserController.instance;
    userController.addSearchToHistoryLog(t.term, tagId: t.suggestionTagId);
  }

  Future<PaginationDataResult<Product>> loadSearchResults(
      ResultsTypes type) async {
    assert(_searchTerm != null, 'should a searchTerm');
    final spdr = paginationDataResultBy(type);
    if (!spdr.canLoadMoreData || spdr.isLoading) return spdr;
    spdr.hasError = false;
    spdr.isLoading = true;
    update([spdr.widgetToUpdateTag]);
    late final QuerySnapshot<Product> result;
    Query<Product> query;
    if (_searchTerm!.suggestionTagId != null) {
      final ref = _fbfirestore.collection('Products-Tags');
      var prdsIds = await ref
          .doc(_searchTerm!.suggestionTagId)
          .collection('tag_products')
          .get()
          .then((value) => value.docs.map<String>((e) => e.id).toList());
      print('list: $prdsIds, tag id: ${_searchTerm!.suggestionTagId}');
      query = _cloudProducts.where(FieldPath.documentId, whereIn: prdsIds);
      // .get()
      // .then((value) => value.docs.map((e) => e.data()).toList());
    } else
      query = _cloudProducts
          .orderBy('title')
          .startAt([_searchTerm!.term]).endAt(["${_searchTerm!.term}\uf8ff"]);

    if (spdr.lastLoadedDoc != null)
      query = query.startAfterDocument(spdr.lastLoadedDoc!);

    query = query.limit(10);

    //
    // if (resultsNumberBy(type) == null) {
    //   query.count().get().then((value) {
    //     resultsNumberBy(type) = value.count;
    //     update([searchResultsNumberWidgetId]);
    //   });
    // }
    _setResultsNumberCount(type, query);
    //
    result = await query.get().then((value) {
      return value;
    }, onError: (e) {
      print('ctach error: ' + e.toString());
      spdr.hasError = true;
      update([spdr.widgetToUpdateTag]);
    });

    if (result.docs.isNotEmpty) spdr.lastLoadedDoc = result.docs.last;

    spdr.isLoading = false;
    spdr.canLoadMoreData = result.docs.isNotEmpty;
    spdr.loadedData.addAll(result.docs.map((e) => e.data()));
    update([spdr.widgetToUpdateTag]);
    return spdr;
  }

  void _setResultsNumberCount(ResultsTypes type, Query query) {
    if (_resultsData
            .singleWhere((element) => element.type == type)
            .resultsNumber ==
        null) {
      query.count().get().then((value) {
        _resultsData
            .singleWhere((element) => element.type == type)
            .resultsNumber = value.count;
        update([searchResultsNumberWidgetId]);
      });
    }
  }

  String get searchResultsNumberWidgetId => 'SEARCH-RNUMBER-WIDGET-ID';

  final ProductsController _productsController = ProductsController.instance;

  void test() {
    final Future Function() c = () async {
      for (var i = 0; i < 30; i++) {
        await _productsController.addTestProduct();
        print('add product $i');
      }
      ;
    };
    c().then((v) {
      print('adding favs completed');
    });
  }

  // Future<int> countResults()async {
  //   return
  // }

  ///
  ///
  ///
  ///
  ///
  ///
}
