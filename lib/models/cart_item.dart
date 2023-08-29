import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String productId;
  String? quantity;
  Color? color;
  String? size;

  CartItem(
      {required this.id,
      required this.productId,
      this.color,
      this.quantity,
      this.size});
}
