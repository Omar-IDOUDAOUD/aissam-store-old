import 'dart:io';

import 'package:aissam_store/core/constants/colors.dart';
import 'package:aissam_store/view/product_dets/widgets/dets&buy_but.dart';
import 'package:aissam_store/view/product_dets/widgets/header_buttons.dart';
import 'package:aissam_store/view/product_dets/widgets/image_view.dart';
import 'package:aissam_store/view/product_dets/widgets/image_view_nav.dart';
import 'package:aissam_store/view/product_dets/widgets/images&colors_albume.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({Key? key}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  late final PageController _imageViewerController;
  late final ScrollController _scrollController;

  @override
  void initState() {
    // TODO: implement initState
    _imageViewerController = PageController()
      ..addListener(() {
        if (_scrollController.offset >= 200)
          _scrollController.animateTo(0,
              duration: 300.milliseconds, curve: Curves.linearToEaseOut);
      });
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.offset >= Get.size.height / 1.5 &&
            !__showBuyFloatingButton)
          _showBuyFloatingButton();
        else if (_scrollController.offset < Get.size.height / 1.5 &&
            __showBuyFloatingButton) _hideBuyFloatingButton();
      });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _imageViewerController.dispose();
    _scrollController.dispose();
    _hideBuyFloatingButton();
  }

  bool __showBuyFloatingButton = false;

  void _showBuyFloatingButton() {
    __showBuyFloatingButton = true;
    Get.showSnackbar(GetSnackBar(
      snackStyle: SnackStyle.FLOATING,
      borderRadius: 13,
      animationDuration: 350.milliseconds,
      forwardAnimationCurve: Curves.linearToEaseOut,
      reverseAnimationCurve: Curves.linearToEaseOut,
      margin: EdgeInsets.all(25),
      boxShadows: [
        BoxShadow(
            offset: Offset(0, 8),
            color: Colors.black.withOpacity(.3),
            blurRadius: 20)
      ],
      backgroundColor: CstColors.a,
      messageText: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 25,
          ),
          Text(
            'Add To Cart',
            style: Get.textTheme.bodyMedium!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          SvgPicture.asset(
            'assets/icons/bag.svg',
            width: 25,
          )
        ],
      ),
    ));
  }

  void _hideBuyFloatingButton() {
    __showBuyFloatingButton = false;

    Get.closeCurrentSnackbar();
  }

  final List<String> _images = [
    'assets/images/image_4.png',
    'assets/images/image_5.png',
    'assets/images/image_1 3x.png',
    'assets/images/image_7.png',
    'assets/images/image_6.png',
  ];
  final _imageViewerHeight = Get.size.height * .7;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        controller: _scrollController,
        slivers: [
          SliverPersistentHeader(
            delegate: _Header(
                imageViewerController: _imageViewerController,
                images: _images,
                framHeight: _imageViewerHeight),
          ),
          SliverAppBar(
            pinned: true,
            toolbarHeight: 100,
            titleSpacing: 0,
            elevation: 0,
            scrolledUnderElevation: 40,
            shadowColor: Colors.black.withOpacity(.1),
            backgroundColor: Colors.white,
            title: ImagesAndColorsAlbum(
              isCollapsed: () => _scrollController.offset >= _imageViewerHeight,
              images: _images,
              imageViewerController: _imageViewerController,
              colors: [
                Colors.brown,
                Colors.greenAccent,
                Colors.purpleAccent,
                Colors.redAccent,
              ],
              colorsNames: [
                'brown',
                'Green accent',
                'Purple',
                'Red accent',
              ],
            ),
            // centerTitle: true,
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: Get.size.height * 3,
              child: DetsAndBuyButton(
                price: 185.00,
                reviewNumber: 35,
                reviewRank: 4,
                title: 'Premium Jersey Hijab - Rose Quartz',
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _Header extends SliverPersistentHeaderDelegate {
  const _Header(
      {required this.imageViewerController,
      required this.images,
      required this.framHeight});
  final PageController imageViewerController;
  final List<String> images;
  final double framHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    // print(shrinkOffset);
    return ImageView(
      initialHeight: maxExtent,
      shrinkOffset: shrinkOffset,
      images: images,
      pageController: imageViewerController,
    );

    // return Image.asset(
    //   'assets/images/image_4.png',
    //   fit: BoxFit.fitWidth,
    // );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => framHeight;

  @override
  // TODO: implement minExtent
  double get minExtent => 0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return false;
  }
}
