import 'package:aissam_store/core/constants/colors.dart';
import 'package:aissam_store/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProductCard extends StatelessWidget {
  ProductCard({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Product data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: GestureDetector(
        onTap: () {
          Get.toNamed('/product_details');
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 170,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      data.cardPicture!,
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
                    // if (isHot)
                    //   Positioned(
                    //     bottom: 10,
                    //     left: 10,
                    //     child: Container(
                    //       height: 17,
                    //       decoration: BoxDecoration(
                    //           color: CstColors.d,
                    //           borderRadius: BorderRadius.circular(8)),
                    //       padding: EdgeInsets.only(left: 3, right: 5),
                    //       child: Row(
                    //         children: [
                    //           SvgPicture.asset('assets/icons/flam.svg',
                    //               height: 14),
                    //           Text(
                    //             'HOT',
                    //             style: Get.textTheme.displayLarge!.copyWith(
                    //               color: CstColors.e,
                    //               fontWeight: FontWeight.normal,
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
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
                  '${data.price} MAD',
                  style: Get.textTheme.bodyMedium!.copyWith(
                    color: CstColors.a,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SvgPicture.asset(
                  'assets/icons/favorite.svg',
                  height: 18,
                )
              ],
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              data.title!,
              textAlign: TextAlign.start,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Get.textTheme.bodyMedium!.copyWith(
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
                  '${data.colors!.length} color',
                  style: Get.textTheme.displayLarge!.copyWith(
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
