import 'package:aissam_store/core/constants/colors.dart';
import 'package:aissam_store/view/home/tabs/widgets/categorie_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SearchingPart extends StatelessWidget {
  const SearchingPart({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: EdgeInsets.only(right: 25, left: 25, top: 25, bottom: 15),
          sliver: SliverToBoxAdapter(
            child: Row(
              children: [
                Text(
                  'SEARCH COLLECTION',
                  style: Get.textTheme.bodyLarge!.copyWith(
                    color: CstColors.a,
                    height: 0.4,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Spacer(),
                Text(
                  '1 category | ',
                  style: Get.textTheme.bodyMedium!.copyWith(
                    color: CstColors.b,
                    height: 0.4,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  'All',
                  style: Get.textTheme.bodyMedium!.copyWith(
                    color: CstColors.g,
                    height: 0.4,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 85,
            child: ListView.separated(
              itemCount: 5,
              padding: EdgeInsets.symmetric(horizontal: 25),
              scrollDirection: Axis.horizontal,
              separatorBuilder: (_, i) => SizedBox(
                width: 10,
              ),
              itemBuilder: (_, i) => CategorieItem(
                imagePath: 'assets/images/categories_abayas.png',
                imageColor: CstColors.f,
                title: 'Abayas',
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.only(right: 25, left: 25, top: 25, bottom: 15),
          sliver: SliverToBoxAdapter(
            child: Row(
              children: [
                Text(
                  'SUGGESTIONS',
                  style: Get.textTheme.bodyLarge!.copyWith(
                    color: CstColors.a,
                    height: 0.4,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverList.separated(
          itemCount: 100,
          separatorBuilder: (_, i) => SizedBox(height: 15),
          itemBuilder: (_, i) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Whit',
                        style: Get.textTheme.headlineMedium!.copyWith(
                          color: CstColors.a,
                          height: 1.2,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                        text: 'e Abaya XL',
                        style: Get.textTheme.headlineMedium!.copyWith(
                          color: CstColors.c,
                          height: 1.2,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ),
                SvgPicture.asset('assets/icons/search_small.svg')
              ],
            ),
          ),
        ),
      ],
    );
  }
}
