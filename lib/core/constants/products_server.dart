import 'dart:convert';

import 'package:aissam_store/data/model/product.dart';
import 'package:dio/dio.dart';

abstract class ProductsServerConsts {
  static const String header_auth_username = 'aissam-store-sdproducts-db-api';
  static const String header_auth_pass = '%C7c,(9H;9PnwDN';
  static const String baseUrl = "http://192.168.8.165/aissam-store-products";
}

abstract class ProductsServerPathsConsts {
  static const String searchSuggestions = '/search/suggestions.php';
  static const String searchProducts = '/search/products.php';
  static const String fetchProduct = '/product/fetch.php';
  static const String newest = '/interfaces/newest.php';
  static const String mostLiked = '/interfaces/most_liked.php';
  static const String forYou = '/interfaces/for_you.php';
  static const String bestSelling = '/interfaces/best_selling.php';
}
