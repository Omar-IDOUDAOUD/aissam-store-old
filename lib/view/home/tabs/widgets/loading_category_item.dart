import 'package:flutter/material.dart';

class LoadingCategoryItem extends StatefulWidget {
  const LoadingCategoryItem({super.key});

  @override
  State<LoadingCategoryItem> createState() => _LoadingCategoryItemState();
}

class _LoadingCategoryItemState extends State<LoadingCategoryItem> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 83,
      child: Column(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: Colors.grey.shade300,
          ),
          SizedBox(height: 3),
          SizedBox(
            height: 10,
            width: 30,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey.shade300,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
