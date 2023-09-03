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
  final ProductsController _productsController = ProductsController.instance;
  final UserController _userController = UserController.instance;

  bool _showForYouCollectionPart = false;
  _checkAndAddForYouCollectionPart() {
    _userController.getUserData().then((value) {
      if (value.categories!.isNotEmpty && mounted) {
        setState(() {
          _showForYouCollectionPart = true;
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    _checkAndAddForYouCollectionPart();

    super.initState();

    // final Function() c = () async {
    //   for (var i = 0; i < 30; i++) {
    //     await _productsController.addTestProduct();
    //     await 1.seconds.delay();
    //   }
    // };
    // c();
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
