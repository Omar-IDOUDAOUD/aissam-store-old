import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 11, vertical: 6),
      child: Text(
        text,
        style: Get.textTheme.displayLarge!.copyWith(
          color: Colors.white,
        ),
      ),
    );
  }
}
