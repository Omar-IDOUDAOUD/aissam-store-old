

import 'package:aissam_store/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';



class ColorSelection extends StatefulWidget {
  const ColorSelection({super.key});

  @override
  State<ColorSelection> createState() => __ColorSelectionState();
}

class __ColorSelectionState extends State<ColorSelection> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _getColorCircle(Colors.indigo, 'ingigo', 0),
                SizedBox(width: 5),
                _getColorCircle(Colors.yellowAccent, 'Yellow Accent', 1),
                SizedBox(width: 5),
                _getColorCircle(Colors.greenAccent, 'Green Accent', 2),
                SizedBox(width: 5),
                _getColorCircle(Colors.brown[500]!, 'Brown', 3),
              ],
            ),
          ),
          SizedBox(
            child: DecoratedBox(decoration: BoxDecoration(color: CstColors.c)),
            height: 20,
            width: 1,
          ),
          SizedBox(
            width: 5,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(7),
            child: Image.asset(
              'assets/images/image_1 1x.png',
              width: 40,
              // height: 55,
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
          RotatedBox(
            quarterTurns: 1,
            child: Text(
              'Preview',
              style: Get.textTheme.displaySmall!.copyWith(
                color: CstColors.a,
              ),
            ),
          ),
        ],
      ),
    );
  }

  int selectedColor = 0;

  _getColorCircle(Color color, String colorName, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedColor = index;
        });
      },
      child: Container(
        width: 45,
        padding: EdgeInsets.symmetric(horizontal: 2.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: color,
              child: AnimatedScale(
                scale: selectedColor == index ? 1 : 0,
                duration: 100.milliseconds,
                curve: Curves.bounceIn,
                child: SvgPicture.asset(
                  'assets/icons/ic_fluent_checkmark_24_filled.svg',
                  color: Colors.white,
                ),
              ),
            ),
            // SizedBox(height: 5),

            Expanded(
              child: Center(
                child: Text(
                  colorName,
                  style: Get.textTheme.displaySmall!
                      .copyWith(height: 1.1, color: CstColors.a),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
