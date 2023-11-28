// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:aissam_store/controller/product.dart';
import 'package:aissam_store/core/shared/products_collections.dart';
import 'package:aissam_store/data/model/category.dart';
import 'package:aissam_store/view/home/tabs/main/widgets/list_title.dart';
import 'package:aissam_store/view/home/tabs/main/widgets/products_list.dart';
import 'package:aissam_store/view/home/tabs/widgets/categorie_item.dart';
import 'package:aissam_store/view/home/tabs/widgets/loading_category_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsByCategoriesList extends StatefulWidget {
  const ProductsByCategoriesList({super.key});

  // final Function(List<int> newList)? onCheckCategory;
  // final List<int>? selectedCategories;

  @override
  State<ProductsByCategoriesList> createState() =>
      _ProductsByCategoriesListState();
}

class _ProductsByCategoriesListState extends State<ProductsByCategoriesList> {
  final ProductsController _productsController = ProductsController.instance;

  List<Category> _selectedCategories = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Category>>(
      future: _productsController.categories(),
      builder: (context, snapshot) {
        if (snapshot.hasError)
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error),
                Text('An error occurred!'),
              ],
            ),
          );
        return Column(
          children: [
            SizedBox(
              height: 83,
              child: ListView.separated(
                itemCount: snapshot.hasData ? snapshot.data!.length : 4,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, i) {
                  if (snapshot.hasData)
                    return CategorieItem(
                      onCheck: (b) {
                        if (b)
                          _selectedCategories.add(snapshot.data!.elementAt(i));
                        else
                          _selectedCategories
                              .remove(snapshot.data!.elementAt(i));
                        if (_selectedCategories.isNotEmpty)
                          _productsController
                              .setProductsCategories(_selectedCategories);
                        if (_selectedCategories.isEmpty) {
                          setState(() {
                            _opacityAn = false;
                          });
                          _anDur.delay().then((value) {
                            setState(() {
                              _sizeAn = false;
                            });
                          });
                        } else {
                          setState(() {
                            _sizeAn = true;
                          });
                          _anDur.delay().then((value) {
                            setState(() {
                              _opacityAn = true;
                            });
                          });
                        }
                      },
                      data: snapshot.data!.elementAt(i),
                    );
                  return const LoadingCategoryItem();
                },
                separatorBuilder: (_, i) => const SizedBox(
                  width: 10,
                ),
              ),
            ),
            AnimatedSize(
              duration: _anDur,
              curve: Curves.linearToEaseOut,
              child: SizedBox(
                height: _sizeAn ? null : 0,
                child: AnimatedScale(
                  curve: Curves.linearToEaseOut,
                  duration: _anDur,
                  scale: _opacityAn ? 1 : 0.9,
                  child: AnimatedOpacity(
                    curve: Curves.linearToEaseOut,
                    opacity: _opacityAn ? 1 : 0,
                    duration: _anDur,
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        ProductsCollectionTitle(
                            title: _getProductsTitle, onSeeAllTap: () {}),
                        SizedBox(height: 10),
                        ProductsList(
                            collection: ProductsCollections.ByCategory),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  bool _sizeAn = false;
  bool _opacityAn = false;

  String _lastTitle = 'No Tilte';
  String get _getProductsTitle {
    if (_selectedCategories.isEmpty) return _lastTitle;
    String s = "${_selectedCategories.first.name}";
    if (_selectedCategories.length > 1)
      s = "$s and ${_selectedCategories.length - 1} others";

    _lastTitle = s;
    return s;
  }

  final Duration _anDur = 300.milliseconds;
}
