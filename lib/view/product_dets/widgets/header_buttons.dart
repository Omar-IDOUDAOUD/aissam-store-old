import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HeaderButtons extends StatefulWidget {
  const HeaderButtons({Key? key}) : super(key: key);

  // final bool appear;
  @override
  State<HeaderButtons> createState() => _HeaderButtonsState();
}

class _HeaderButtonsState extends State<HeaderButtons> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: Get.back,
          child: _getButton(null, 'assets/icons/back.svg'),
        ),
        _getButton(Colors.white, 'assets/icons/favorite.svg'),
      ],
    );
  }

  _getButton(Color? color, String iconPath) => SizedBox.square(
        dimension: 55,
        child: PhysicalModel(
          color: Colors.transparent,
          shape: BoxShape.circle,
          elevation: color != null ? 20 : 0,
          shadowColor: Colors.black54.withOpacity(.2),
          clipBehavior: Clip.antiAlias,
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 5,
              sigmaY: 5,
            ),
            child: ColoredBox(
              color: color ?? Colors.black45.withOpacity(.1),
              child:
                  SvgPicture.asset(iconPath, height: 25, fit: BoxFit.scaleDown),
            ),
          ),
        ),
      );
}
