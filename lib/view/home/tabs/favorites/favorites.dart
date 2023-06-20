import 'package:aissam_store/view/home/tabs/widgets/product_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class FavoritesTab extends StatelessWidget {
  FavoritesTab({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 20, bottom: 90),
      children: [
        _paddedWidget(
          Row(
            children: [
              Text(
                'Favorites',
                style: Get.textTheme.headline1,
              ),
              const Spacer(),
              SvgPicture.asset(
                'assets/icons/search.svg',
                height: 25,
              )
            ],
          ),
        ),
        _paddedWidget(
          Text(
            '+40 favotires',
            style: Get.textTheme.headline4!.copyWith(height: 1),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        _listTitle('This week', '15 favorite this week'),
        const SizedBox(height: 10),
        _listedItems(
          (_, i) => ProductCard(
            colorsNumber: _items[i]['colors_number'],
            imagePath: _items[i]['img'],
            price: _items[i]['price'],
            title: _items[i]['title'],
            isHot: _items[i]['is_hot'],
            favorited: true,
          ),
          261,
          3,
        ),
        _listTitle('Last week', '3 favorite lst week'),
        const SizedBox(height: 10),
        _listedItems(
          (_, i) => ProductCard(
            colorsNumber: _items[i]['colors_number'],
            imagePath: _items[i]['img'],
            price: _items[i]['price'],
            title: _items[i]['title'],
            isHot: _items[i]['is_hot'],
            favorited: true,
          ),
          261,
          3,
        ),
        _listTitle('Last month', '30 favorite last month'),
        const SizedBox(height: 10),
        _listedItems(
          (_, i) => ProductCard(
            colorsNumber: _items[i]['colors_number'],
            imagePath: _items[i]['img'],
            price: _items[i]['price'],
            title: _items[i]['title'],
            isHot: _items[i]['is_hot'],
            favorited: true,
          ),
          261,
          3,
        ),
      ],
    );
  }

  Widget _paddedWidget(Widget child) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: child,
    );
  }

  Widget _listTitle(String title, String subTitle) {
    return _paddedWidget(
      Row(
        children: [
          Text(
            title,
            style: Get.textTheme.headline2,
          ),
          const Spacer(),
          Text(
            subTitle,
            style: Get.textTheme.headline4,
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
        separatorBuilder: (_, i) => const SizedBox(
          width: 10,
        ),
      ),
    );
  }
}
