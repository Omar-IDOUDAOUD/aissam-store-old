import 'package:aissam_store/controller/product.dart';
import 'package:aissam_store/core/constants/colors.dart';
import 'package:aissam_store/core/shared/products_collections.dart';
import 'package:aissam_store/models/cart_item.dart';

import 'package:aissam_store/models/product.dart';
import 'package:aissam_store/view/chat_inbox/bottom_sheet.dart';
import 'package:aissam_store/view/home/tabs/my_cart/widgets/cart_item.dart';
import 'package:aissam_store/view/home/tabs/widgets/loading_product_card.dart';
import 'package:aissam_store/view/home/tabs/widgets/product_card.dart';
import 'package:aissam_store/view/chat_inbox/widgets/inbox_item_card.dart';
import 'package:aissam_store/view/notifications/bottom_sheet.dart';
import 'package:aissam_store/view/public/draggable_bottom_sheet.dart';
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
        child: Column(
          children: [
            TextButton(
              child: Text('Notifications'),
              onPressed: () {
                ShowNotificationsBottomSheet(context: context);
              },
            ),
            TextButton(
              child: Text('Chat Inbox'),
              onPressed: () {
                ShowChatInboxBottomSheet(context: context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
