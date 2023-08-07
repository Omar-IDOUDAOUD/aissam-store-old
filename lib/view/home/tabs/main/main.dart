import 'package:aissam_store/core/constants/colors.dart';
import 'package:aissam_store/core/shared/products_collections.dart';
import 'package:aissam_store/view/more_products/more_products.dart';
import 'package:aissam_store/view/home/tabs/main/widgets/header.dart';
import 'package:aissam_store/view/home/tabs/widgets/categorie_item.dart';
import 'package:aissam_store/view/home/tabs/widgets/product_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MainTab extends StatefulWidget {
  MainTab({Key? key}) : super(key: key);

  @override
  State<MainTab> createState() => _MainTabState();
}

class _MainTabState extends State<MainTab> {
  final List<Map> _items = [
    {
      'img': 'assets/images/image_1 1x.png',
      'title': 'Premier Jersey Hijabs - Rose',
      'price': 158.00,
      'is_hot': true,
      'colors_number': 23,
    },
    {
      'img': 'assets/images/image_2.png',
      'title': 'Modest Dress Pomegranate',
      'price': 205.00,
      'is_hot': false,
      'colors_number': 4,
    },
    {
      'img': 'assets/images/image_3.png',
      'title': 'Recycle .... Chifone',
      'price': 205.00,
      'is_hot': false,
      'colors_number': 11,
    },
  ];

  bool _showMorePoducts = false;

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
          // right: 0,
          width: Get.size.width,
          child: ListView(
            padding: EdgeInsets.only(bottom: 80),
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Header(),
              _paddedWidget(
                Text(
                  'Good Morning \nZahra',
                  style: Get.textTheme.headlineLarge!.copyWith(height: 1.1),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              _listTitle('Collections'),
              const SizedBox(height: 10),
              _listedItems(
                (_, i) => CategorieItem(
                  imagePath: 'assets/images/categories_abayas.png',
                  imageColor: CstColors.f,
                  title: 'Abayas',
                ),
                85,
                4,
              ),
              SizedBox(height: 10),
              _listTitle('Newest'),
              const SizedBox(height: 10),
              _listedItems(
                (_, i) => ProductCard(
                  colorsNumber: _items[i]['colors_number'],
                  imagePath: _items[i]['img'],
                  price: _items[i]['price'],
                  title: _items[i]['title'],
                  isHot: _items[i]['is_hot'],
                ),
                261,
                3,
              ),
              _listTitle('Best Sellers'),
              const SizedBox(height: 10),
              _listedItems(
                (_, i) => ProductCard(
                  colorsNumber: _items[i]['colors_number'],
                  imagePath: _items[i]['img'],
                  price: _items[i]['price'],
                  title: _items[i]['title'],
                  isHot: _items[i]['is_hot'],
                ),
                270,
                3,
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
              ? SizedBox.shrink()
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

  Widget _listTitle(String title) {
    return _paddedWidget(
      Row(
        children: [
          Text(
            title,
            style: Get.textTheme.headlineMedium,
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              setState(() {
                _clearMoreProducts = false;
                _showMorePoducts = true;
              });
            },
            child: Row(
              children: [
                Text(
                  'See all',
                  style: Get.textTheme.bodySmall,
                ),
                const SizedBox(
                  width: 5,
                ),
                SvgPicture.asset(
                  "assets/icons/next.svg",
                  height: 22,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _listedItems(
      Widget Function(BuildContext _, int i) b, double listHeight, int count) {
    return SizedBox(
      height: listHeight,
      child: ListView.separated(
        itemCount: count,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemBuilder: b,
        separatorBuilder: (_, i) => SizedBox(
          width: 10,
        ),
      ),
    );
  }
}
