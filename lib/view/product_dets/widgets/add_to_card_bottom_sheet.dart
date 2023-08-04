import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddToCartBottomSheet extends StatefulWidget {
  const AddToCartBottomSheet({super.key});

  @override
  State<AddToCartBottomSheet> createState() => _AddToCartBottomSheetState();
}

class _AddToCartBottomSheetState extends State<AddToCartBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Text(
              'ADD TO CART',
              style: Get.textTheme.headlineSmall,
            ),
          ),
          // Text('Premium Jersey Hijab - Rose Quartz')
        ],
      ),
    );
  }
}
