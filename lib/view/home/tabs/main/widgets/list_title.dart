import 'package:aissam_store/core/constants/colors.dart';
import 'package:aissam_store/view/public/button/button_color_builder.dart';
import 'package:aissam_store/view/public/button/button_scale_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProductsCollectionTitle extends StatelessWidget {
  const ProductsCollectionTitle(
      {super.key, this.onSeeAllTap, required this.title});

  final Function()? onSeeAllTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          Text(
            title,
            style: Get.textTheme.headlineMedium,
          ),
          const Spacer(),
          if (onSeeAllTap != null)
            ButtonColorBuilder(
              color: CstColors.b,
              onTap: onSeeAllTap,
              builder: (color, focus) {
                return Row(
                  children: [
                    Text(
                      'See all',
                      style: Get.textTheme.bodySmall!.copyWith(
                        color: color,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    SvgPicture.asset(
                      "assets/icons/next.svg",
                      height: 22,
                      color: color,
                    ),
                  ],
                );
              },
            ),
        ],
      ),
    );
  }
}
