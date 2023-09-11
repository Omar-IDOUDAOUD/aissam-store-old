import 'dart:async';

import 'package:aissam_store/controller/product.dart';
import 'package:aissam_store/core/constants/colors.dart';
import 'package:aissam_store/core/shared/products_collections.dart';

import 'package:aissam_store/models/product.dart';
import 'package:aissam_store/view/home/tabs/widgets/loading_product_card.dart';
import 'package:aissam_store/view/home/tabs/widgets/product_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  void initState() {
    // TODO: implement initState
    super.initState();
    _startTimer = Timer.periodic(1.seconds, (timer) {
      if (timer.tick == 5) {
        timer.cancel();
      }
      setState(() {});
    });
  }

  Future<List<Map>> _startRequest() async {
    final fbfirestore =
        await FirebaseFirestore.instance.collection('Categories').get();
    return fbfirestore.docs.map((e) => e.data()).toList();
  }

  late final Timer _startTimer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              _startTimer.isActive
                  ? _startTimer.tick.toString()
                  : 'Get Request Started',
              style: TextStyle(fontSize: 30),
            ),
            if (!_startTimer.isActive)
              FutureBuilder<List<Map>>(
                future: _startRequest(),
                builder: (_, sn) {
                  if (sn.connectionState == ConnectionState.waiting)
                    return CircularProgressIndicator();
                  if (sn.hasData) return Text(sn.data.toString());
                  return Text('something went wrong');
                },
              ),
          ],
        ),
      ),
    );
  }
}
