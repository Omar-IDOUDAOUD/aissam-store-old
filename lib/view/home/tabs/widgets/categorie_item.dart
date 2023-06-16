import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategorieItem extends StatelessWidget {
  CategorieItem(
      {Key? key,
      required this.imagePath,
      required this.imageColor,
      required this.title})
      : super(key: key);
  final String imagePath;
  final Color imageColor;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 85,
      child: Column(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: imageColor,
            foregroundImage: AssetImage(imagePath),
          ),
          SizedBox(height: 2), 
          Text(
            title,
            style: Get.textTheme.headline5,
          )
        ],
      ),
    );
  }
}
