import 'package:aissam_store/core/constants/colors.dart';
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
                style: Get.textTheme.headlineLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Text(
                '+15',
                style: Get.textTheme.headlineMedium!
                    .copyWith(color: CstColors.b, fontWeight: FontWeight.w400),
              ),
            ],
          ),
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
            style: Get.textTheme.headlineMedium,
          ),
          const Spacer(),
          Text(
            subTitle,
            style: Get.textTheme.headlineMedium,
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
