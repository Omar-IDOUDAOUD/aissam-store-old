import 'dart:math';

import 'package:aissam_store/core/constants/colors.dart';
import 'package:aissam_store/view/public/button.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class _HeaderDelegate extends SliverPersistentHeaderDelegate {
  final bool isLightTheme;

  _HeaderDelegate({this.isLightTheme = true, required TickerProvider vsync})
      : _vsync = vsync;
  final TickerProvider _vsync;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // final showShadow = shrinkOffset >= maxExtent - minExtent;
    final extandProgress =
        1 - min(shrinkOffset, maxExtent - minExtent) / (maxExtent - minExtent);
    // final toolBarColor =
    //     Color.lerp(Colors.white, Colors.deepPurple.shade50, extandProgress);
    return AnimatedPhysicalModel(
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
      duration: 100.milliseconds,
      shadowColor: Colors.black54.withOpacity(.2),
      color: Colors.white,
      elevation: 20,
      child: Stack(
        children: [
          Positioned(
            top: 17 + 7 * extandProgress,
            right: 25,
            child: SvgPicture.asset(
              'assets/icons/ic_fluent_alert_24_regular.svg',
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
                      'Notifications',
                      style: Get.textTheme.headlineLarge!.copyWith(
                        color: CstColors.a,
                        height: 1.1,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      'Active',
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
  // TODO: implement snapConfiguration
  FloatingHeaderSnapConfiguration? get snapConfiguration =>
      FloatingHeaderSnapConfiguration(
          curve: Curves.linearToEaseOut, duration: 300.milliseconds);
  @override
  TickerProvider? get vsync => _vsync;
  @override
  // TODO: implement maxExtent
  double get maxExtent => 140;

  @override
  // TODO: implement minExtent
  double get minExtent => 70;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return true;
  }
}

class SettingsNotifications extends StatefulWidget {
  const SettingsNotifications({super.key});

  @override
  State<SettingsNotifications> createState() => _SettingsNotificationsState();
}

class _SettingsNotificationsState extends State<SettingsNotifications>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: _HeaderDelegate(vsync: this),
            floating: true,
            pinned: true,
          ),
          SliverFillRemaining(
            fillOverscroll: false,
            hasScrollBody: true,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'System notifications',
                    style: Get.textTheme.bodyLarge!.copyWith(
                      color: CstColors.a,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Text(
                      'Receive notifications about lastest updates from us',
                      style: Get.textTheme.bodyMedium!.copyWith(
                        color: CstColors.b,
                        fontWeight: FontWeight.normal,
                        height: 1.2,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  _getRow('Push'),
                  SizedBox(
                    height: 10,
                  ),
                  _getRow('Sound'),
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

  _getRow(
    String label,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Get.textTheme.headlineSmall!.copyWith(
            color: CstColors.a,
            fontWeight: FontWeight.w500,
          ),
        ),
        FlutterSwitch(
          height: 26,
          width: 45,
          padding: 3,
          value: v,
          toggleSize: 20,
          inactiveColor: CstColors.b.withOpacity(.5),
          activeColor: CstColors.a,
          onToggle: (x) {
            setState(() {
              v = x;
            });
          },
        ),
      ],
    );
  }

  bool v = true;
}
