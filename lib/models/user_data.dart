// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:aissam_store/controller/search.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'package:aissam_store/models/cart_item.dart';

class UserData {
  String? id;
  List<String>? categories;
  List<String>? favoritedProducts;
  List<SearchHistoryItem>? searchHistory;
  List<CartItem>? userCart;
  UserData({
    this.id,
    this.categories,
    this.favoritedProducts,
    this.searchHistory,
    this.userCart,
  }) {
    categories ??= List.empty();
    favoritedProducts ??= List.empty();
    searchHistory ??= List.empty();
    userCart ??= List.empty();
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_id': id,
      'categories': categories,
      'favorited_products': favoritedProducts,
      'search_history': searchHistory,
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      id: map['user_id'],
      categories: List<String>.from(map['categories'] as List),
      favoritedProducts: List<String>.from(map['favorited_products'] as List),
      searchHistory: List<SearchHistoryItem>.from(
          (map['search_history'] as List)
              .map((e) => SearchHistoryItem.fromMap(e))),
    );
  }
  factory UserData.fromFireStore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data()!;
    return UserData(
      id: data['user_id'],
      categories: List<String>.from(data['categories'] as List),
      favoritedProducts: List<String>.from(data['favorited_products'] as List),
      searchHistory: List<SearchHistoryItem>.from(
          (data['search_history'] as List)
              .map((e) => SearchHistoryItem.fromMap(e))),
    );
  }
}
