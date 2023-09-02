import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class PaginationDataResult<M> {
  final List<M> loadedData = [];
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
}
