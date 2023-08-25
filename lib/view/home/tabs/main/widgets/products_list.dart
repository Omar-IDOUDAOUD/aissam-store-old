import 'dart:math';

import 'package:aissam_store/controller/product.dart';
import 'package:aissam_store/core/shared/products_collections.dart';
import 'package:aissam_store/models/category.dart';
import 'package:aissam_store/view/home/tabs/widgets/loading_product_card.dart';
import 'package:aissam_store/view/home/tabs/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsList extends StatefulWidget {
  const ProductsList({super.key, required this.collection});

  final ProductsCollections collection;
  // final List<Category>? categories;
  @override
  State<ProductsList> createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  final ProductsController _productsController = ProductsController.instance;

  late final ScrollController _scrollController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('INITSTATE');
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent) {
          _productsController.loadPagination(widget.collection);
        }
      });
    final pd =
        _productsController.paginationDataOfCollection(widget.collection);
    if (pd.lastLoadedDoc == null)
      _productsController.loadPagination(widget.collection);
    _listUpdateTag = pd.widgetToUpdateTag;
  }

  late final String _listUpdateTag;

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 270,
      child: GetBuilder<ProductsController>(
        id: _listUpdateTag,
        init: _productsController,
        builder: (controller) {
          print('upfdaaaaaaaaaaaaaaaaaaaaaaaaa');
          final paginationData =
              controller.paginationDataOfCollection(widget.collection);
          if (paginationData.hasError)
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error),
                  Text('An error occurred!'),
                ],
              ),
            );
          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            controller: _scrollController,
            itemCount: paginationData.loadedData.length +
                (paginationData.isLoading ? 3 : 0),
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, i) {
              if (i >= paginationData.loadedData.length)
                return const LoadingProductCard();
              return ProductCard(data: paginationData.loadedData.elementAt(i));
            },
            separatorBuilder: (_, i) => const SizedBox(
              width: 10,
            ),
          );
        },
      ),
    );
  }
}
