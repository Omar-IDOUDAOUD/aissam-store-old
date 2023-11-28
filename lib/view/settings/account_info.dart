import 'dart:math';

import 'package:aissam_store/core/constants/colors.dart';
import 'package:aissam_store/view/public/button.dart';
import 'package:aissam_store/view/public/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class _HeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final showShadow = shrinkOffset >= maxExtent - minExtent;
    final extandProgress =
        1 - min(shrinkOffset, maxExtent - minExtent) / (maxExtent - minExtent);
    final toolBarColor =
        Color.lerp(Colors.white, Colors.deepPurple.shade50, extandProgress);
    return AnimatedPhysicalModel(
      shape: BoxShape.rectangle,
      duration: 100.milliseconds,
      shadowColor: Colors.black54.withOpacity(.2),
      color: toolBarColor!,
      elevation: showShadow ? 10 : 0,
      child: Stack(
        children: [
          Positioned(
            top: 27 - 7 * extandProgress,
            left: 20,
            child: GestureDetector(
              onTap: Get.back,
              child: SvgPicture.asset(
                'assets/icons/ic_fluent_chevron_left_24_filled.svg',
                color: ColorsConsts.a,
                width: 20,
                // alignment: Alignment.center,
              ),
            ),
          ),
          Positioned(
            top: 36 - 7 * extandProgress,
            left: 28,
            width: 35 * extandProgress,
            height: 2,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: ColorsConsts.a,
              ),
            ),
          ),
          Positioned(
            right: 25,
            bottom: 20 + 5 * extandProgress,
            child: SizedBox.square(
              dimension: 40 + 20 * extandProgress,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.bottomRight,
                child: SizedBox.square(
                  dimension: 17 + 6 * extandProgress,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: toolBarColor, width: 2),
                      color: ColorsConsts.a,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(4 + 2 * extandProgress),
                      child: SvgPicture.asset(
                        'assets/icons/ic_fluent_edit_24_filled.svg',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 15 * extandProgress,
            left: 25 + 35 * (1 - extandProgress),
            width: (Get.size.width - 25 * 2) * 0.7,
            height: minExtent,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Transform.scale(
                alignment: Alignment.centerLeft,
                scale: 0.7 + 0.3 * extandProgress,
                child: Text(
                  'Account Information',
                  style: Get.textTheme.headlineLarge!.copyWith(
                    color: ColorsConsts.a,
                    height: 1.1,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => 140;

  @override
  // TODO: implement minExtent
  double get minExtent => 80;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return true;
  }
}

class SettingsAccountInfo extends StatefulWidget {
  const SettingsAccountInfo({super.key});

  @override
  State<SettingsAccountInfo> createState() => _SettingsAccountInfoState();
}

class _SettingsAccountInfoState extends State<SettingsAccountInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // SliverT
          SliverPersistentHeader(
            delegate: _HeaderDelegate(),
            pinned: true,
          ),
          SliverFillRemaining(
            fillOverscroll: false,
            hasScrollBody: true,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _getFieldtitle(
                    'First & Last Name',
                    'assets/icons/ic_fluent_person_24_regular.svg',
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          borderRadius: 8,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: CustomTextField(
                          borderRadius: 8,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  _getFieldtitle(
                    'Phone Number',
                    'assets/icons/ic_fluent_person_call_24_regular.svg',
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  CustomTextField(
                    borderRadius: 8,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  _getFieldtitle(
                    'Delete Account',
                    'assets/icons/ic_fluent_person_delete_24_regular.svg',
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Text(
                    'You account will be permanently removed from the application. All your data will be lost!',
                    style: Get.textTheme.bodyLarge!.copyWith(
                      color: ColorsConsts.b,
                      fontWeight: FontWeight.w400,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MaterialButton(
                    onPressed: () {},
                    padding: const EdgeInsets.all(22),
                    splashColor: Colors.black87.withOpacity(.1),
                    color: Colors.redAccent.withOpacity(.2),
                    elevation: 0,
                    hoverElevation: 0,
                    highlightElevation: 0,
                    focusElevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Delete Account',
                          style: Get.textTheme.bodyLarge!.copyWith(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 3),
                        SvgPicture.asset(
                          'assets/icons/ic_fluent_delete_24_filled.svg',
                          height: 20,
                          color: Colors.redAccent,
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Button(
                    isHeightMinimize: true,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 22,
                        ),
                        Expanded(
                          child: Text(
                            'Save',
                            textAlign: TextAlign.center,
                            style: Get.textTheme.bodyLarge!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        SvgPicture.asset(
                          'assets/icons/ic_fluent_checkmark_24_filled.svg',
                          color: Colors.white,
                          width: 22,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  _getFieldtitle(String label, String iconPath) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Get.textTheme.bodyLarge!.copyWith(
            color: ColorsConsts.a,
            fontWeight: FontWeight.bold,
          ),
        ),
        SvgPicture.asset(
          iconPath,
          height: 22,
        ),
      ],
    );
  }
}
