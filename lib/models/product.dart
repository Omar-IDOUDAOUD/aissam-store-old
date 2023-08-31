// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:ui';

import 'package:aissam_store/core/utils/hex_color.dart';
import 'package:aissam_store/models/category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Product {
  final String? id;
  String? title;
  String? description;
  double? price;
  int? reviews;
  double? rankingAverage;
  String? cardPicture;
  List<String>? images;
  List<Color>? colors;
  List<String>? categories;
  Timestamp? timestamp;
  int? sells;
  Product({
    this.id,
    this.title,
    this.description,
    this.price,
    this.reviews,
    this.rankingAverage,
    this.cardPicture,
    this.images,
    this.colors,
    this.categories,
    this.timestamp,
    this.sells,
  });

  // Product copyWith({
  //   String? id,
  //   String? title,
  //   String? description,
  //   double? price,
  //   int? reviews,
  //   double? rankingAverage,
  //   String? cardPicture,
  //   List<String>? images,
  //   List<Color>? colors,
  // }) {
  //   return Product(
  //     id: id ?? this.id,
  //     title: title ?? this.title,
  //     description: description ?? this.description,
  //     price: price ?? this.price,
  //     reviews: reviews ?? this.reviews,
  //     rankingAverage: rankingAverage ?? this.rankingAverage,
  //     cardPicture: cardPicture ?? this.cardPicture,
  //     images: images ?? this.images,
  //     colors: colors ?? this.colors,
  //   );
  // }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      // 'id': id,
      'title': title,
      'description': description,
      'price': price,
      'reviews': reviews,
      'ranking_average': rankingAverage,
      'card_picture': cardPicture,
      'images': images,
      'categories': categories,
      'colors': colors!
          .map<String>(
              (c) => c.value.toRadixString(16).toUpperCase().substring(2))
          .toList(),
      'timestamp': FieldValue.serverTimestamp(),
      'sells': sells,
    };
  }

  factory Product.fromMap(Map<String, dynamic> data, String id) {
    return Product(
      id: id,
      title: data['title'],
      description: data['description'],
      price: data['price'],
      reviews: data['reviews'],
      rankingAverage: data['ranking_average'],
      cardPicture: data['card_picture'],
      images: data['images'],
      categories: data['categories'],
      colors: (data['colors'] as List<String>)
          .map<Color>((e) => HexColor(e))
          .toList(),
      timestamp: data['timestamp'] as Timestamp,
      sells: data['sells'],
      // number: data['number'] as int,
    );
  }

  factory Product.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data()!;
    return Product(
        id: snapshot.id,
        title:
            "${data['sells']}, ${(data['timestamp'] as Timestamp).toDate().second.toString()}",
        description: data['description'],
        price: data['price'],
        reviews: data['reviews'],
        rankingAverage: data['ranking_average'],
        cardPicture: data['card_picture'],
        categories:
            (data['categories'] as List).map((e) => e.toString()).toList(),
        images: (data['images'] as List).map((e) => e.toString()).toList(),
        colors: (data['colors'] as List)
            .map<Color>((e) => HexColor(e.toString()))
            .toList(),
        timestamp: data['timestamp'] as Timestamp,
        sells: data['sells']
        // number: data['number'] as int,
        );
  }
  factory Product.testModel() => Product(
        cardPicture: "https://imageonline.co/image.jpg",
        colors: [Colors.red, Colors.blue],
        title: 'Premium jersy hijab roze quatrz',
        description: 'No Description',
        images: [
          "https://imageonline.co/image.jpg",
          "https://imageonline.co/image.jpg",
          "https://imageonline.co/image.jpg",
        ],
        price: 185,
        categories: ['Qaftans'],
        reviews: 5,
        rankingAverage: 4,
      );
}
