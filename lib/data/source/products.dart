import 'package:aissam_store/core/constants/products_server.dart';
import 'package:aissam_store/data/respository/products_server.dart';

import '../model/product.dart';

typedef PayloadType = List<Product>;

class ProductsSearchDataSource extends ProductsServerRepository<PayloadType> {
  final int? limit;
  final int? offset;
  final String searchQuery;

  ProductsSearchDataSource(
      {this.limit = 10, this.offset = 0, required this.searchQuery});

  @override
  // TODO: implement path
  String get path => ProductsServerPathsConsts.searchProducts;

  @override
  // TODO: implement requestContent
  RequestContentTypedef<PayloadType> get requestContent =>
      (requestBase) => requestBase.get(
            path,
            queryParameters: {
              'term': searchQuery,
              'limit': limit,
              'offset': offset,
            },
          );

  @override
  PayloadType responseBodyConverter(dynamic dataContent) {
    if (dataContent == null) return List.empty();
    print('TEST 20 content: $dataContent');
    print('TEST 20 type: ${dataContent.runtimeType}');
    late PayloadType res;
    try {
      res = (dataContent as List).map((e) {
        return Product.fromMap(Map<String, dynamic>.from(e));
      }).toList();
    } catch (e) {
      print('error');
      print(e);
    }

    return res;
  }
}
