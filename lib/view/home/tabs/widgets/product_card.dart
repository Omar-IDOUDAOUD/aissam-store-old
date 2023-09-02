import 'dart:math';

import 'package:aissam_store/controller/favoritres.dart';
import 'package:aissam_store/core/constants/colors.dart';
import 'package:aissam_store/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProductCard extends StatefulWidget {
  ProductCard({
    Key? key,
    required this.data,
    this.width = 0,
    this.showShadow = false,
    this.onFavorite,
    this.isFavoritedProductChecker,

    // this.isFavorited = false,
  }) : super(key: key);

  final Product data;

  // default width to 155
  final double width;
  final bool showShadow;
  final Future Function(bool b)? onFavorite;
  final Future<bool> Function(String productId)? isFavoritedProductChecker;
  // final Future Function(bool b)? onFavorite;
  // bool isFavorited;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _isFavorited = false;
  @override
  void initState() {
    // TODO: implement initState
    if (widget.isFavoritedProductChecker != null) {
      widget.isFavoritedProductChecker!(widget.data.id!).then((value) {
        if (mounted)
          setState(() {
            _isFavorited = value;
          });
      });
    }
  }

  void _favoriteProduct() {
    setState(() {
      _isFavorited = true;
    });
    if (widget.onFavorite == null) return;
    widget.onFavorite!(_isFavorited).then((value) => null, onError: (e) {
      if (mounted)
        setState(() {
          _isFavorited = false;
        });
    });
  }

  void _unFavoriteProduct() {
    setState(() {
      _isFavorited = false;
    });
    if (widget.onFavorite == null) return;
    widget.onFavorite!(_isFavorited).then((value) => null, onError: (e) {
      if (mounted)
        setState(() {
          _isFavorited = true;
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: max(widget.width, 155),
      height: 300,
      child: GestureDetector(
        onTap: () {
          Get.toNamed('/product_details');
        },
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: widget.showShadow ? Colors.white : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              if (widget.showShadow)
                BoxShadow(
                  offset: Offset(5, 0),
                  blurRadius: 60,
                  color: Colors.black.withOpacity(.1),
                )
            ],
          ),
          // elevation: showShadow ? 100 : 0,
          // shadowColor: Colors.black.withOpacity(.2),
          // decoration: BoxDecoration(
          // ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 6,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Positioned.fill(
                        child: Image.network(
                          widget.data.cardPicture!,
                          fit: BoxFit.fitWidth,
                          alignment: Alignment.topCenter,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        left: 0,
                        height: 70,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.black.withOpacity(.4),
                                Colors.black.withOpacity(.0),
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${widget.data.price} USD',
                                    style:
                                        Get.textTheme.headlineSmall!.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  // SizedBox(
                                  //   height: 7,
                                  // ),
                                  Row(
                                    children: List.generate(
                                      5,
                                      (index) => SvgPicture.asset(
                                        'assets/icons/preview_star.svg',
                                        color: index >= 3
                                            ? Colors.white.withOpacity(.4)
                                            : Colors.white,
                                        height: 16,
                                        width: 16,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (!_isFavorited)
                                  _favoriteProduct();
                                else
                                  _unFavoriteProduct();
                              },
                              child: Container(
                                height: 60,
                                width: 40,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(.1),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15)),
                                ),
                                child: SvgPicture.asset(
                                  _isFavorited
                                      ? 'assets/icons/ic_fluent_heart_24_filled.svg'
                                      : 'assets/icons/favorite.svg',
                                  color: Colors.white,
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.data.categories!.first,
                            style: Get.textTheme.bodySmall!.copyWith(
                              color: CstColors.c,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '${widget.data.price} USD',
                            style: Get.textTheme.bodySmall!.copyWith(
                              color: CstColors.a,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        widget.data.title!,
                        textAlign: TextAlign.start,
                        maxLines: 2,
                        overflow: TextOverflow.fade,
                        style: Get.textTheme.bodyMedium!.copyWith(
                          color: CstColors.a,
                          fontWeight: FontWeight.w700,
                          height: 1.3,
                        ),
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Text(
                            '${widget.data.colors!.length} colors',
                            style: Get.textTheme.bodyMedium!.copyWith(
                              color: CstColors.a,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 15,
                              child: Stack(
                                fit: StackFit.expand,
                                children: List.generate(
                                  widget.data.colors!.length,
                                  (index) => Positioned(
                                    child: _getColorCircle(
                                        widget.data.colors!.elementAt(index)),
                                    right: 7.0 * index,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/preview_star.svg',
                            color: Colors.orangeAccent,
                            height: 16,
                            width: 16,
                          ),
                          SizedBox(width: 5),
                          Text(
                            widget.data.rankingAverage.toString(),
                            style: Get.textTheme.bodyMedium!.copyWith(
                              color: CstColors.b,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Spacer(),
                          Text(
                            '${widget.data.reviews} reviews',
                            style: Get.textTheme.bodyMedium!.copyWith(
                              color: CstColors.b,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getColorCircle(Color color) => SizedBox.square(
        dimension: 15,
        child: DecoratedBox(
            decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                border: Border.all(
                    width: 1.5,
                    color: widget.showShadow
                        ? Colors.white
                        : Colors.grey.shade200))),
      );
}
