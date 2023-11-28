import 'package:aissam_store/core/constants/products_server.dart';
import 'package:aissam_store/data/respository/products_server.dart';

typedef PayloadType = List<String>;

class SearchSuggestionsDataSource
    extends ProductsServerRepository<PayloadType> {
  final int? limit;
  final String query;

  SearchSuggestionsDataSource({this.limit = 10, required this.query});

  @override
  // TODO: implement path
  String get path => ProductsServerPathsConsts.searchSuggestions;

  @override
  // TODO: implement requestContent
  RequestContentTypedef<PayloadType> get requestContent =>
      (requestBase) => requestBase.get(
            path,
            queryParameters: {'term': query, 'limit': limit},
          );

  @override
  PayloadType responseBodyConverter(dynamic dataContent) {
    if (dataContent == null) return ['No Content hhh'];
    print('TEST 20 content: $dataContent');
    print('TEST 20 type: ${dataContent.runtimeType}');
    return dataContent as List<String>;
  }
}
