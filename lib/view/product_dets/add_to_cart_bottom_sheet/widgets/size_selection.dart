import 'package:aissam_store/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SizeSelection extends StatefulWidget {
  const SizeSelection({super.key});

  @override
  State<SizeSelection> createState() => __SizeSelectionState();
}

class __SizeSelectionState extends State<SizeSelection> {
  int _selectedSize = 1;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: Row(
        // mainAxisAlignment: Main,
        children: [
          _getSizeItem('S', 0),
          SizedBox(width: 5),
          _getSizeItem('M', 1),
          SizedBox(width: 5),
          _getSizeItem('L', 2),
          SizedBox(width: 5),
          _getSizeItem('X', 3),
          SizedBox(width: 5),
          _getSizeItem('XXL', 4),
        ],
      ),
    );
  }

  Color get _fillColor => Colors.brown;
  Color get _outlineColor => Colors.grey;
  _getSizeItem(String name, int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedSize = index;
          });
        },
        child: AnimatedContainer(
          duration: 100.milliseconds,
          decoration: BoxDecoration(
            color:
                _selectedSize == index ? _fillColor : _fillColor.withOpacity(0),
            border: Border.all(
                color: _selectedSize == index ? _fillColor : _outlineColor),
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Text(
            name,
            style: Get.textTheme.bodyLarge!.copyWith(
              color: _selectedSize == index ? Colors.white : ColorsConsts.a,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
