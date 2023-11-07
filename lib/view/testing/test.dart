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

  bool _listener(n) {
    print('listener called, ${n.toString()}');
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<ScrollUpdateNotification>(
        onNotification: (ScrollUpdateNotification n) {
          if (n.metrics.pixels >= n.metrics.maxScrollExtent)
            print('load more data');
          return true;
        },
        child: ListView.builder(
          itemCount: 50,
          itemBuilder: (_, i) => ListTile(
            title: Text('Hello $i'),
          ),
        ),
      ),
    );
  }
}
