import 'package:aissam_store/core/constants/colors.dart';
import 'package:aissam_store/core/shared/products_collections.dart';
import 'package:aissam_store/view/home/tabs/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MoreProductsTab extends StatefulWidget {
  const MoreProductsTab(
      {Key? key,
      required this.collection,
      this.subTitle,
      required this.onClose})
      : super(key: key);

  final ProductsCollections collection;
  final String? subTitle;
  final Function() onClose;

  @override
  State<MoreProductsTab> createState() => _MoreProductsTabState();
}

class _MoreProductsTabState extends State<MoreProductsTab> {
  late final ScrollController _controller;

  bool _minimizeTitle = false;

  @override
  void initState() {
    // TODO: implement initState
    _controller = ScrollController()
      ..addListener(() {
        if (_controller.offset > 100 && !_minimizeTitle)
          setState(() {
            _minimizeTitle = true;
          });
        else if (_controller.offset < 100 && _minimizeTitle)
          setState(() {
            _minimizeTitle = false;
          });
      });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  final _anDur = 300.milliseconds;
  final _anCur = Curves.linearToEaseOut;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Stack(
        children: [
          Positioned.fill(
            child: GridView.builder(
              controller: _controller,
              padding:
                  const EdgeInsets.symmetric(vertical: 145, horizontal: 20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                childAspectRatio: 0.54,
              ),
              itemCount: 8,
              itemBuilder: (_, i) {
                return ProductCard(
                  title: 'Just A Test Product Title',
                  imagePath: 'assets/images/image_2.png',
                  price: 15,
                  colorsNumber: 3,
                );
              },
            ),
          ),
          AnimatedPositioned(
            height: _minimizeTitle ? 110 : 150,
            width: Get.size.width,
            duration: _anDur,
            curve: _anCur,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white,
                    Colors.white.withOpacity(.8),
                    Colors.white.withOpacity(0),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: _anDur,
            curve: _anCur,
            height: _minimizeTitle ? 25 : 30,
            width: _minimizeTitle ? 25 : 30,
            top: 30,
            left: 20,
            child: GestureDetector(
              onTap: widget.onClose,
              child: SvgPicture.asset(
                'assets/icons/back.svg',
                color: CstColors.a,
              ),
            ),
          ),
          AnimatedPositioned(
            duration: _anDur,
            curve: _anCur,
            top: _minimizeTitle ? 20 : 65,
            left: _minimizeTitle ? 55 : 20,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedDefaultTextStyle(
                  child: Text(
                    _getCollectionName(),
                  ),
                  style: _minimizeTitle
                      ? Get.textTheme.headline2!.copyWith(
                          color: CstColors.a,
                        )
                      : Get.textTheme.headline1!.copyWith(
                          color: CstColors.a,
                        ),
                  duration: _anDur,
                  curve: _anCur,
                ),
                if (widget.subTitle != null)
                  AnimatedDefaultTextStyle(
                    duration: _anDur,
                    curve: _anCur,
                    child: Text(widget.subTitle!),
                    style: _minimizeTitle
                        ? Get.textTheme.headline5!.copyWith(
                            color: CstColors.c,
                            height: 1,
                          )
                        : Get.textTheme.headline4!.copyWith(
                            color: CstColors.c,
                            height: 1,
                          ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getCollectionName() {
    switch (widget.collection) {
      case ProductsCollections.Newest:
        return 'Newest';
      case ProductsCollections.BestSelling:
        return 'Best selling';
      case ProductsCollections.ForYou:
        return 'For you';
    }
  }
}
