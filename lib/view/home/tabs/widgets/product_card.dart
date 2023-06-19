import 'package:aissam_store/core/constants/colors.dart';
import 'package:aissam_store/view/product_dets/product_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProductCard extends StatelessWidget {
  ProductCard({
    Key? key,
    required this.title,
    required this.imagePath,
    required this.price,
    required this.colorsNumber,
    this.isHot = false,
  }) : super(key: key);
  final String title;
  final String imagePath;
  final double price;
  final int colorsNumber;
  final bool isHot;

  final _w = Get.size.width * 0.37;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/product_details');
      },
      child: SizedBox(
        width: _w,
        child: Column(
          children: [
            SizedBox(
              height: 170,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(.5),
                            Colors.black.withOpacity(.05),
                            Colors.black.withOpacity(.0),
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                    ),
                    if (isHot)
                      Positioned(
                        bottom: 10,
                        left: 10,
                        child: Container(
                          height: 17,
                          decoration: BoxDecoration(
                              color: CstColors.d,
                              borderRadius: BorderRadius.circular(8)),
                          padding: EdgeInsets.only(left: 3, right: 5),
                          child: Row(
                            children: [
                              SvgPicture.asset('assets/icons/flam.svg',
                                  height: 14),
                              Text(
                                'HOT',
                                style: Get.textTheme.headline6!.copyWith(
                                  color: CstColors.e,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$price MAD',
                  style: Get.textTheme.headline4!.copyWith(
                    color: CstColors.a,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SvgPicture.asset(
                  'assets/icons/favorite.svg',
                  height: 20,
                )
              ],
            ),
            Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Get.textTheme.headline3!.copyWith(
                color: CstColors.c,
                height: 1.3,
              ),
            ),
            Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/del_alt.svg',
                  height: 13,
                ),
                SizedBox(
                  width: 3,
                ),
                Text(
                  '$colorsNumber color',
                  style: Get.textTheme.headline4!.copyWith(
                    color: CstColors.c,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
