// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:math';

import 'package:aissam_store/controller/favoritres.dart';
import 'package:aissam_store/controller/product.dart';
import 'package:aissam_store/core/constants/colors.dart';
import 'package:aissam_store/core/shared/products_collections.dart';
import 'package:aissam_store/view/home/tabs/widgets/loading_product_card.dart';
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
  bool _minimizeTitle = false;

  final ProductsController _productsController = ProductsController.instance;
  FavoritesController _favoritesController = FavoritesController.instance;

  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent) {
          _productsController.loadPagination(widget.collection);
        }
        if (_scrollController.offset > 100 && !_minimizeTitle)
          setState(() {
            _minimizeTitle = true;
          });
        else if (_scrollController.offset < 100 && _minimizeTitle)
          setState(() {
            _minimizeTitle = false;
          });
      });

    final pd =
        _productsController.paginationDataOfCollection(widget.collection);
    if (pd.lastLoadedDoc == null)
      _productsController.loadPagination(widget.collection);
    _listUpdateTag = pd.widgetToUpdateTag;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }

  late final String _listUpdateTag;

  final _anDur = 300.milliseconds;
  final _anCur = Curves.linearToEaseOut;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Stack(
        children: [
          Positioned.fill(
              child: GetBuilder<ProductsController>(
                  id: _listUpdateTag,
                  init: _productsController,
                  builder: (controller) {
                    final paginationData = controller
                        .paginationDataOfCollection(widget.collection);
                    if (paginationData.hasError)
                      return const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.error),
                            Text('An error occurred!'),
                          ],
                        ),
                      );
                    return GridView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.symmetric(
                          vertical: 145, horizontal: 20),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        childAspectRatio: 0.54,
                      ),
                      itemCount: paginationData.loadedData.length +
                          (paginationData.isLoading ? 3 : 0),
                      itemBuilder: (_, i) {
                        if (i >= paginationData.loadedData.length)
                          return const LoadingProductCard();
                        return ProductCard(
                          data: paginationData.loadedData.elementAt(i),
                          isFavoritedProductChecker: (pId) async =>
                              _favoritesController.checkProductIsFavorited(pId),
                          onFavorite: (b) async {
                            if (b)
                              await _favoritesController.addFavoritedProduct(
                                  paginationData.loadedData.elementAt(i).id!);
                            else
                              await _favoritesController.removeFavoritedProduct(
                                  paginationData.loadedData.elementAt(i).id!);
                          },
                        );
                      },
                    );
                    /////
                  })),
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
                color: ColorsConsts.a,
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
                      ? Get.textTheme.headlineMedium!.copyWith(
                          color: ColorsConsts.a,
                        )
                      : Get.textTheme.headlineLarge!.copyWith(
                          color: ColorsConsts.a,
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
                        ? Get.textTheme.bodyMedium!.copyWith(
                            color: ColorsConsts.c,
                            height: 1,
                          )
                        : Get.textTheme.bodyLarge!.copyWith(
                            color: ColorsConsts.c,
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
      case ProductsCollections.All:
        return 'All';
      default:
        return 'Other';
    }
  }
}
