import 'dart:convert';

import 'package:aissam_store/controller/product.dart';
import 'package:aissam_store/controller/user.dart';
import 'package:aissam_store/core/constants/colors.dart';
import 'package:aissam_store/core/shared/products_collections.dart';
import 'package:aissam_store/data/source/products.dart';
import 'package:aissam_store/data/source/suggestions.dart';
import 'package:aissam_store/firebase_options.dart';

import 'package:aissam_store/data/model/product.dart';
import 'package:aissam_store/services/auth/authentication.dart';
import 'package:aissam_store/view/home/tabs/widgets/loading_product_card.dart';
import 'package:aissam_store/view/home/tabs/widgets/product_card.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:dio/dio.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  TextEditingController textEditingController =
      TextEditingController(text: 'smart');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    x();
  }

  var response = "no response yet";

  void x() async {
    final x = ProductsSearchDataSource(
        searchQuery: textEditingController.text, limit: 3);
    print('Start Receiving data:');
    final res = await x.run();
    print('data recuived!');
    setState(() {
      response = res.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: textEditingController,
            ),
            InkWell(
              child: Text('send'),
              onTap: x,
            ),
            Expanded(child: Text(response)),
          ],
        ),
      ),
    );
  }
}
