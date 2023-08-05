

import 'package:aissam_store/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class QuantitySelection extends StatefulWidget {
  const QuantitySelection({super.key});

  @override
  State<QuantitySelection> createState() => _QuantitySelectionState();
}

class _QuantitySelectionState extends State<QuantitySelection> {
  int selectedItems = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_getSmallText('Item price:'), _getText('185.00 MAD')],
        ),
        SizedBox(
          child: DecoratedBox(decoration: BoxDecoration(color: CstColors.c)),
          height: 15,
          width: 0.5,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_getSmallText('Total price:'), _getText('370.00 MAD')],
        ),
        SizedBox(
          child: DecoratedBox(decoration: BoxDecoration(color: CstColors.c)),
          height: 15,
          width: 0.5,
        ),
        GestureDetector(
          onTap: () => setState(() {
            if (selectedItems == 1) return;
            selectedItems--;
          }),
          child: _getButton(
            'assets/icons/sub.svg',
          ),
        ),
        _getText(selectedItems.toString()),
        GestureDetector(
          onTap: () => setState(() {
            selectedItems++;
          }),
          child: _getButton(
            'assets/icons/ic_fluent_add_24_filled.svg',
          ),
        )
      ],
    );
  }

  _getButton(String iconPath) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: CstColors.b.withOpacity(.5),
      child: SvgPicture.asset(
        iconPath,
        height: 15,
      ),
    );
  }

  _getSmallText(String text) {
    return Text(
      text,
      style: Get.textTheme.bodySmall!.copyWith(
        color: CstColors.a,
      ),
    );
  }

  _getText(String text) {
    return Text(
      text,
      style: Get.textTheme.bodyMedium!.copyWith(
        color: CstColors.a,
      ),
    );
  }
}