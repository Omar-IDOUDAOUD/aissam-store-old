import 'package:aissam_store/controller/favoritres.dart';
import 'package:aissam_store/core/constants/colors.dart';
import 'package:aissam_store/models/product.dart';
import 'package:aissam_store/view/public/button/button_color_builder.dart';
import 'package:aissam_store/view/public/button/button_scale_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class FavoriteCard extends StatefulWidget {
  const FavoriteCard({super.key, required this.data, this.onFavoriteChange});

  final Product data;
  final Future Function(bool b)? onFavoriteChange;

  @override
  State<FavoriteCard> createState() => _FavoriteCardState();
}

class _FavoriteCardState extends State<FavoriteCard> {
  FavoritesController? _favoritesController;

  bool _isFavorited = true;

  void _favoriteProduct() {
    setState(() {
      _isFavorited = true;
    });
    if (widget.onFavoriteChange == null) return;
    widget.onFavoriteChange!(_isFavorited).then((value) => null, onError: (e) {
      print('error occurred!1, e=$e');
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
    if (widget.onFavoriteChange == null) return;
    widget.onFavoriteChange!(_isFavorited).then((value) => null, onError: (e) {
      print('error occurred!2, e=$e');
      if (mounted)
        setState(() {
          _isFavorited = true;
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 95,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 60,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                widget.data.cardPicture!,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            width: 7,
          ),
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.data.title!,
                        style: Get.textTheme.bodyLarge!
                            .copyWith(color: CstColors.a, height: 1.2),
                      ),
                      Text(
                        widget.data.price.toString(),
                        style: Get.textTheme.bodyMedium!.copyWith(
                          color: CstColors.b,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
                      Row(
                        children:
                            List.generate(5, (index) => _getStar(index <= 2)),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: _getCircleButton(
                    color: Colors.greenAccent[700]!,
                    iconPath: 'assets/icons/arrow_right_shorter.svg',
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 45,
                  child: _getCircleButton(
                      color: Colors.pinkAccent[400]!,
                      iconPath: _isFavorited
                          ? 'assets/icons/ic_fluent_heart_24_filled.svg'
                          : 'assets/icons/favorite.svg',
                      onTap: () {
                        if (!_isFavorited)
                          _favoriteProduct();
                        else
                          _unFavoriteProduct();
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _getStar(bool fill) => SvgPicture.asset(
        'assets/icons/preview_star.svg',
        color: fill ? CstColors.a : CstColors.a.withOpacity(.5),
        height: 15,
      );
  Widget _getCircleButton(
      {required String iconPath, required Color color, onTap}) {
    return ButtonScaleBuilder(
      // color: color,
      onTap: onTap,
      // focusColor: Color.lerp(color, Colors.black, 0.5),
      builder: (focus) {
        return SizedBox.square(
          dimension: 40,
          child: ClipOval(
            // radius: 20,
            // backgroundColor: c.withOpacity(.15),
            child: ColoredBox(
              color: (focus ? Color.lerp(color, Colors.black, .5)! : color)
                  .withOpacity(.15),
              child: Center(
                child: SvgPicture.asset(
                  iconPath,
                  color: color,
                  width: 20,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
