// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:aissam_store/models/product.dart';

class CartItemData {
  final String id;
  final String productId;
  Product? product;
  int? quantity;
  String? color;
  String? size;

  CartItemData(
      {
      // required this.id,
      required this.id,
      required this.productId,
      this.quantity,
      this.color,
      this.size});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      // 'id': id,
      'product_id': productId,
      'quantity': quantity,
      'color': color,
      'size': size,
    };
  }

  factory CartItemData.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final map = snapshot.data()!;
    return CartItemData(
      // id: map['id'],
      id: snapshot.id,
      productId: map['product_id'],
      quantity: map['quantity'],
      color: map['color'],
      size: map['size'],
    );
  }

  CartItemData copyWith({required CartItemData mergeWith}) {
    return CartItemData(
      id: id,
      productId: productId,
      quantity: mergeWith.quantity ?? quantity,
      color: mergeWith.color ?? color,
      size: mergeWith.size ?? size,
    )..product = product;
  }
}
