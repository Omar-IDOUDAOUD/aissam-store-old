import 'dart:math';

import 'package:aissam_store/view/fullscreen_image/fullscreen_image.dart';
import 'package:aissam_store/view/product_dets/widgets/header_buttons.dart';
import 'package:aissam_store/view/product_dets/widgets/image_view_nav.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageView extends StatefulWidget {
  const ImageView({
    Key? key,
    required this.images,
    required this.pageController,
    this.shrinkOffset,
    required this.initialHeight,
    // required this.buildImageHeight,
    // this.tag = 'NO-TAG',
  }) : super(key: key);
  final List<String> images;
  final double initialHeight;
  final double? shrinkOffset;
  final PageController pageController;
  // final String tag;
  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  // final _maxHeight = Get.size.height * 0.99;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final bool showHeader =
    //     (widget.shrinkOffset ?? (widget.initialHeight / 2)) <=
    //         widget.initialHeight / 2;
    final double bottomAndTopSpacing =
        widget.shrinkOffset != null ? widget.shrinkOffset! / 2 : 0;
    // print(
    //     'bottomAndTopSpacing= $bottomAndTopSpacing, initialHeight/2= ${widget.initialHeight / 4}, initialHeight= ${widget.initialHeight}');
    return FittedBox(
      fit: BoxFit.fitWidth,
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        width: Get.size.width,
        height: widget.initialHeight,
        child: ColoredBox(
          color: Colors.grey.withOpacity(.3),
          child: Stack(
            fit: StackFit.expand,
            children: [
              PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: widget.pageController,
                itemCount: widget.images.length,
                itemBuilder: (_, i) {
                  return Hero(
                    tag: i,
                    child: Image.asset(
                      widget.images.elementAt(i),
                      fit: BoxFit.contain,
                      alignment: Alignment.center,
                    ),
                  );
                },
              ),
              Positioned(
                bottom: bottomAndTopSpacing,
                right: 0,
                left: 0,
                child: ImageViewNavButtons(
                  pageController: widget.pageController,
                  onFullScreen: () {
                    Get.toNamed('/fullscreen_image', arguments: {
                      'images': widget.images,
                      'active_image': widget.pageController.page!.toInt()
                    });
                  },
                ),
              ),
              Positioned(
                // duration: 150.milliseconds,
                // curve: showHeader ? Curves.easeOutBack : Curves.easeInToLinear,
                top: 20 + min(bottomAndTopSpacing, (widget.initialHeight / 4)),
                right: 20,
                left: 20,
                child: const HeaderButtons(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
