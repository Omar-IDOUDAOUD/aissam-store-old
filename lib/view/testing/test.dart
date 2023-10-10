import 'package:aissam_store/controller/product.dart';
import 'package:aissam_store/core/constants/colors.dart';
import 'package:aissam_store/core/shared/products_collections.dart';
import 'package:aissam_store/models/cart_item.dart';

import 'package:aissam_store/models/product.dart';
import 'package:aissam_store/view/home/tabs/my_cart/widgets/cart_item.dart';
import 'package:aissam_store/view/home/tabs/widgets/loading_product_card.dart';
import 'package:aissam_store/view/home/tabs/widgets/product_card.dart';
import 'package:aissam_store/view/public/draggable_bottom_sheet.dart';
import 'package:aissam_store/view/public/notifictaion_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          child: Text('Open'),
          onPressed: () {
            ShowDraggableBottomSheet(
                title: 'Notifications',
                actions: [
                  BottomSheetActionButton(
                    onTap: Get.back,
                    icon: SvgPicture.asset(
                      'assets/icons/ic_fluent_weather_moon_24_regular.svg',
                      height: 20,
                      color: Colors.black,
                      // width: 20,
                    ),
                  ),
                  BottomSheetActionButton(
                    onTap: Get.back,
                    icon: SvgPicture.asset(
                      'assets/icons/close.svg',
                      height: 20,
                      color: Colors.black,
                      // width: 20,
                    ),
                  )
                ],
                child: Column(
                  // mainAxisSize: MainAxisSize.min,
                  // controller: sc,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    NotificationCard(),
                    SizedBox(
                      height: 10,
                    ),
                    NotificationCard(),
                  ],
                ),
                context: context);
          },
        ),
      ),
    );
  }
}
