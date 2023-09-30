import 'dart:math';

import 'package:aissam_store/core/constants/colors.dart';
import 'package:aissam_store/view/checkout/steps/shipping.dart' as CheckoutPage
    show AddressCard;
import 'package:aissam_store/view/public/button/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class _HeaderDelegate extends SliverPersistentHeaderDelegate {
  final bool isLightTheme;

  _HeaderDelegate({this.isLightTheme = true});

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
            top: 17 + 7 * extandProgress,
            right: 25,
            child: SvgPicture.asset(
              'assets/icons/ic_fluent_location_24_regular.svg',
              height: 27,
              width: 27,
            ),
          ),
          Positioned(
            top: 20 + 7 * extandProgress,
            left: 20,
            child: GestureDetector(
              onTap: Get.back,
              child: SvgPicture.asset(
                'assets/icons/ic_fluent_chevron_left_24_filled.svg',
                color: CstColors.a,
                width: 20,
                // alignment: Alignment.center,
              ),
            ),
          ),
          Positioned(
            top: 29 + 7 * extandProgress,
            left: 28,
            width: 35 * extandProgress,
            height: 2,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: CstColors.a,
              ),
            ),
          ),
          Positioned(
            bottom: 20 * extandProgress,
            left: 25 + 35 * (1 - extandProgress),
            width: (Get.size.width - 25 * 2) * 0.7,
            height: minExtent - 5,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Transform.scale(
                alignment: Alignment.centerLeft,
                scale: 0.7 + 0.3 * extandProgress,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Addresses',
                      style: Get.textTheme.headlineLarge!.copyWith(
                        color: CstColors.a,
                        height: 1.1,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      '2 added',
                      style: Get.textTheme.bodyMedium!.copyWith(
                        color: CstColors.b,
                        // height: 1.2,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
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
  double get minExtent => 60;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return true;
  }
}

class SettingsAddresses extends StatefulWidget {
  const SettingsAddresses({super.key});

  @override
  State<SettingsAddresses> createState() => _SettingsAddressesState();
}

class _SettingsAddressesState extends State<SettingsAddresses> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
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
                children: [
                  CheckoutPage.AddressCard(isSelected: true),
                  SizedBox(height: 7),
                  CheckoutPage.AddressCard(isSelected: false),
                  Spacer(),
                  Button(
                    isHeightMinimize: true,
                    isOutline: true,
                    child: Center(
                      child: Text(
                        'Add Address',
                        style: Get.textTheme.bodyLarge!.copyWith(
                          color: CstColors.a,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
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
}
