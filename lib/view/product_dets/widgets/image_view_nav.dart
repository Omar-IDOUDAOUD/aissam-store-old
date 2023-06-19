import 'dart:ui';

import 'package:aissam_store/core/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ImageViewNavButtons extends StatefulWidget {
  const ImageViewNavButtons(
      {Key? key,
      required this.onNext,
      required this.onBack,
      required this.isBestSelling,
      required this.onFullScreen})
      : super(key: key);

  final bool isBestSelling;
  final Function() onNext;
  final Function() onBack;
  final Function() onFullScreen;

  @override
  State<ImageViewNavButtons> createState() => _ImageViewNavButtonsState();
}

class _ImageViewNavButtonsState extends State<ImageViewNavButtons> {


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (widget.isBestSelling)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _getBestSellingMark(),
                  _getNavButton(_IconType.FULLSCREEN)
                ],
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _getNavButton(_IconType.TOLEFT),
              _getNavButton(_IconType.TORIGHT),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _getSlider(),
          ),
        ],
      ),
    );
  }

  Widget _getSlider() {
    return Center(
      child: SizedBox(
        height: 4,
        width: 50,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.8),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }

  _getNavButton(_IconType type) {
    return GestureDetector(
      onTap: type == _IconType.TORIGHT
          ? widget.onNext
          : type == _IconType.TOLEFT
              ? widget.onBack
              : widget.onFullScreen,
      child: SizedBox.square(
        dimension: 40,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 5,
              sigmaY: 5,
            ),
            child: ColoredBox(
              color: Colors.black.withOpacity(.1),
              child: Center(
                child: Icon(
                  type == _IconType.TORIGHT
                      ? CupertinoIcons.right_chevron
                      : type == _IconType.TOLEFT
                          ? CupertinoIcons.left_chevron
                          : CupertinoIcons.fullscreen,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _getBestSellingMark() {
    return Container(
      height: 17,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.only(left: 3, right: 5),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset('assets/icons/flam.svg', height: 14),
          Text(
            'Best Seller',
            style: Get.textTheme.headline6!.copyWith(
              color: CstColors.e,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

enum _IconType { TOLEFT, TORIGHT, FULLSCREEN }
