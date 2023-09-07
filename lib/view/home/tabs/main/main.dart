import 'package:aissam_store/controller/favoritres.dart';
import 'package:aissam_store/controller/product.dart';
import 'package:aissam_store/controller/user.dart';
import 'package:aissam_store/core/shared/products_collections.dart';
import 'package:aissam_store/view/home/tabs/main/widgets/list_title.dart';
import 'package:aissam_store/view/home/tabs/main/widgets/products_by_categories.dart';
import 'package:aissam_store/view/home/tabs/main/widgets/products_list.dart';
import 'package:aissam_store/view/more_products/more_products.dart';
import 'package:aissam_store/view/home/tabs/main/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainTab extends StatefulWidget {
  MainTab({Key? key}) : super(key: key);

  @override
  State<MainTab> createState() => _MainTabState();
}

class _MainTabState extends State<MainTab> {
  final FavoritesController _favoritesController = FavoritesController.instance;
  final UserController _userController = UserController.instance;

  bool _showForYouCollectionPart = false;
  _checkAndAddForYouCollectionPart() {
    final userCats = _userController.getUserData.categories;
    if (userCats!.isNotEmpty) {
      setState(() {
        _showForYouCollectionPart = true;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    _checkAndAddForYouCollectionPart();

    super.initState();

    final List<String> ids = [
      '1pcznXNOkLnso45KBvHg',
      '3IJcVXxTtYixGG6ABoKw',
      '3PbcwdXLqDUvrjyw2o5e',
      '4ZvfZlE3sr9VKpSf2suq',
      '5vrtKubGmpPMbFDsRyW7',
      '6FBs1BJVe6qHF3i916ZI',
      '8CvIxZ8LzQJDaz2FHWkA',
      '8JlaUSrNoRip4i0M1X4B',
      '8ezXOoUHGAwsZ7L6FPsZ',
      '9O0u1CCVAWnjgfLEZ7hI',
      'AGc1WwsqPg6WoxIVt3Wr',
      'ATeGMSElenh0ekDF952j',
      'Avk1MTiEQU1pokJDopF1',
      'DhMMBDB57a8D6cr7HzjK',
    ];

    final Future Function() c = () async {
      for (var element in ids) {
        await _favoritesController.addFavoritedProduct(element);
      }
    };
    // c().then((v) {
    //   print('adding favs completed');
    // });
  }

  @override
  void dispose() {
    // TODO: implement dispose ;
    super.dispose();
  }

  bool _showMorePoducts = false;
  List<int> _selectedCategories = [];

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        AnimatedPositioned(
          duration: 500.milliseconds,
          curve: Curves.linearToEaseOut,
          left: _showMorePoducts ? -Get.size.width / 2 : 0,
          top: 0,
          bottom: 0,
          width: Get.size.width,
          child: ListView(
            padding: const EdgeInsets.only(bottom: 80),
            // crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Header(),
              _paddedWidget(
                Text(
                  'Good Morning \nZahra',
                  style: Get.textTheme.headlineLarge!.copyWith(height: 1.1),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ProductsCollectionTitle(
                title: 'Collections',
                // onSeeAllTap: () {
                //   setState(() {
                //     _clearMoreProducts = false;
                //     _showMorePoducts = true;
                //   });
                // },
              ),
              const SizedBox(height: 10),
              ProductsByCategoriesList(
                  // selectedCategories: _selectedCategories,
                  ),
              // CategoryProductsList(categories: _selectedCategories),
              const SizedBox(height: 10),
              ProductsCollectionTitle(
                title: 'Newest',
                onSeeAllTap: () {
                  setState(() {
                    _clearMoreProducts = false;
                    _showMorePoducts = true;
                  });
                },
              ),
              const SizedBox(height: 10),
              const ProductsList(collection: ProductsCollections.Newest),
              const SizedBox(height: 15),
              ProductsCollectionTitle(
                title: 'Best Selling',
                onSeeAllTap: () {
                  setState(() {
                    _clearMoreProducts = false;
                    _showMorePoducts = true;
                  });
                },
              ),
              const SizedBox(height: 10),
              const ProductsList(collection: ProductsCollections.BestSelling),
              const SizedBox(height: 15),
              AnimatedSize(
                duration: 300.milliseconds,
                curve: Curves.linearToEaseOut,
                child: !_showForYouCollectionPart
                    ? SizedBox.shrink()
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ProductsCollectionTitle(
                            title: 'For You',
                            onSeeAllTap: () {
                              setState(() {
                                _clearMoreProducts = false;
                                _showMorePoducts = true;
                              });
                            },
                          ),
                          const SizedBox(height: 10),
                          const ProductsList(
                              collection: ProductsCollections.ForYou),
                        ],
                      ),
              ),
            ],
          ),
        ),
        AnimatedPositioned(
          right: _showMorePoducts ? 0 : -Get.size.width, // -Get.size.width,
          top: 0,
          bottom: 0,
          width: Get.size.width,
          duration: 500.milliseconds,
          curve: Curves.linearToEaseOut,
          child: _clearMoreProducts
              ? const SizedBox.shrink()
              : PhysicalModel(
                  color: Colors.transparent,
                  elevation: 100,
                  shadowColor: Colors.black,
                  child: MoreProductsTab(
                    subTitle: 'Best selling clothes these days',
                    onClose: () {
                      setState(() {
                        _showMorePoducts = false;
                      });
                      500.milliseconds.delay().then((value) {
                        setState(() {
                          _clearMoreProducts = true;
                        });
                      });
                    },
                    collection: ProductsCollections.BestSelling,
                  ),
                ),
        ),
      ],
    );
  }

  bool _clearMoreProducts = true;

  Widget _paddedWidget(Widget child) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: child,
    );
  }
}
