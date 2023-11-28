// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:aissam_store/core/utils/hex_color.dart';
import 'package:aissam_store/data/model/category.dart';

class Product {
  final String? id;
  String? title;
  String? description;
  double? price;
  int? reviews;
  double? rankingAverage;
  String? thumbnailPicture;
  List<String>? images;

  /// color hex
  List<String>? colors;
  List<String>? categories;
  DateTime? timestamp;
  int? sales;
  int? savesNumber;
  Product({
    this.id,
    this.title,
    this.description,
    this.price,
    this.reviews,
    this.rankingAverage,
    this.thumbnailPicture,
    this.images,
    this.colors,
    this.categories,
    this.timestamp,
    this.sales,
    this.savesNumber,
    // this.tags,
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
      'thumbnail': thumbnailPicture,
      'images': images,
      'categories': categories,
      'colors': colors,
      'timestamp': FieldValue.serverTimestamp(),
      'sells': sales,
      'saves_number': savesNumber,
    };
  }

  factory Product.fromMap(Map<String, dynamic> data) {
    return Product(
      id: data['id'].toString(),
      title: data['title'],
      description: data['description'],
      price: double.parse(data['price']),
      reviews: data['reviews'],
      rankingAverage: double.parse(data['ranking_average']),
      thumbnailPicture: data['thumbnail_picture'],
      images: List.castFrom<dynamic, String>(data['images']),
      categories: List.castFrom<dynamic, String>(data['categories']),
      colors: List.castFrom<dynamic, String>(data['colors']),
      timestamp: DateTime.parse(data['timestamp']),
      sales: data['sales'],
      savesNumber: data['saves_number'],
    );
  }

  factory Product.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data()!;
    return Product(
      id: snapshot.id,
      title: data['title'],
      description: data['description'],
      price: data['price'] as double,
      reviews: data['reviews'] as int,
      rankingAverage: data['ranking_average'] as double,
      thumbnailPicture: data['thumbnail'],
      categories:
          (data['categories'] as List).map((e) => e.toString()).toList(),
      images: (data['images'] as List).map((e) => e.toString()).toList(),
      colors: (data['colors'] as List).map((e) => e.toString()).toList(),
      timestamp: DateTime.parse(data['timestamp']),
      sales: data['sells'] as int,
      savesNumber: data['sells'] as int,
      // number: data['number'] as int,
    );
  }
  factory Product.testModel() => Product(
        thumbnailPicture: "https://imageonline.co/image.jpg",
        colors: ['#fcba03', '#2c993b'],
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
        savesNumber: 5,
        sales: 10,
        timestamp: DateTime.now(),
      );

  @override
  String toString() {
    return 'Product(id: $id, title: $title, description: $description, price: $price, reviews: $reviews, rankingAverage: $rankingAverage, thumbnailPicture: $thumbnailPicture, images: $images, colors: $colors, categories: $categories, timestamp: $timestamp, sales: $sales, savesNumber: $savesNumber)';
  }
}
