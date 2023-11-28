import 'dart:math';

import 'package:aissam_store/core/constants/colors.dart';
import 'package:aissam_store/view/public/button.dart';
import 'package:aissam_store/view/public/radio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
            child: AnimatedSwitcher(
              duration: 400.milliseconds,
              switchInCurve: Curves.linearToEaseOut,
              // switchOutCurve: Curves.linearToEaseOut,
              transitionBuilder: (c, a) {
                return RotationTransition(
                  // turns: Tween<double>(begin: 0, end: 3).animate(a),
                  turns: Tween<double>(
                          begin: c.key == ValueKey(true) ? 0 : 1,
                          end: c.key == ValueKey(true) ? 1 : 0)
                      .animate(a),
                  child: FadeTransition(
                    opacity: a,
                    child: c,
                  ),
                );
              },
              child: Transform.rotate(
                key: ValueKey(isLightTheme),
                angle: pi / 2 * extandProgress,
                child: SvgPicture.asset(
                  isLightTheme
                      ? 'assets/icons/ic_fluent_weather_sunny_24_regular.svg'
                      : 'assets/icons/ic_fluent_weather_moon_24_regular.svg',
                  height: 27,
                  width: 27,
                ),
              ),
            ),
          ),
          Positioned(
            top: 20 + 7 * extandProgress,
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
            top: 29 + 7 * extandProgress,
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
                      'Appearence',
                      style: Get.textTheme.headlineLarge!.copyWith(
                        color: ColorsConsts.a,
                        height: 1.1,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      isLightTheme ? 'Light Theme' : 'Dark Theme',
                      style: Get.textTheme.bodyMedium!.copyWith(
                        color: ColorsConsts.b,
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

class SettingsAppearence extends StatefulWidget {
  const SettingsAppearence({super.key});

  @override
  State<SettingsAppearence> createState() => _SettingsAppearenceState();
}

class _SettingsAppearenceState extends State<SettingsAppearence> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: _HeaderDelegate(isLightTheme: activeTheme == 'Light'),
            pinned: true,
          ),
          SliverFillRemaining(
            fillOverscroll: false,
            hasScrollBody: true,
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _getThemePreview(
                            'Light', 'assets/icons/light_theme_preview.svg'),
                        _getThemePreview(
                            'Dark', 'assets/icons/dark_theme_preview.svg'),
                        _getThemePreview(
                            'System', 'assets/icons/system_theme_preview.svg'),
                      ],
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
                )),
          )
        ],
      ),
    );
  }

  _getThemePreview(String themeName, String themePreviewPath) {
    return GestureDetector(
      onTap: () {
        setState(() {
          activeTheme = themeName;
        });
      },
      child: Column(
        children: [
          SvgPicture.asset(
            themePreviewPath,
          ),
          SizedBox(height: 5),
          Text(
            themeName,
            style: Get.textTheme.bodyLarge!.copyWith(
              color: ColorsConsts.a,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(height: 10),
          CustomRadio<String>(value: themeName, activeValue: activeTheme),
        ],
      ),
    );
  }

  String activeTheme = 'Light';
}
