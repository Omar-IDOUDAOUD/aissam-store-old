import 'package:aissam_store/controller/product.dart';
import 'package:aissam_store/core/constants/colors.dart';
import 'package:aissam_store/core/shared/products_collections.dart';

import 'package:aissam_store/models/product.dart';
import 'package:aissam_store/view/home/tabs/widgets/loading_product_card.dart';
import 'package:aissam_store/view/home/tabs/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  bool _canRequestData = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ProductCard(
          data: Product(
              title: 'Morocco abayas with its ultra chic polozza',
              price: 215,
              categories: ['Abaya'],
              colors: [
                Colors.orange.shade300,
                Colors.purple.shade300,
                Colors.pink.shade300,
              ],
              rankingAverage: 4.5,
              reviews: 55,
              cardPicture: 'assets/images/image_3.png'),
        ),
      ),
    );
  }
}
