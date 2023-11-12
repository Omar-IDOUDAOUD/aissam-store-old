import 'dart:ui';

import 'package:aissam_store/core/constants/colors.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

const double _FixedAppBarHeight = 65;

class CustomAppBarSliver extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return CustomAppBar(isFloating: overlapsContent);
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => _FixedAppBarHeight;

  @override
  // TODO: implement minExtent
  double get minExtent => _FixedAppBarHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({super.key, required this.isFloating});
  final bool isFloating;
  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  final BorderRadius _borderRadius =
      BorderRadius.vertical(bottom: Radius.circular(25));

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: _FixedAppBarHeight,
      duration: 200.milliseconds,
      foregroundDecoration: BoxDecoration(
        borderRadius: _borderRadius,
        border: Border.all(width: 1, color: Colors.white),
      ),
      decoration: BoxDecoration(
        borderRadius: _borderRadius,
        color: Colors.white.withOpacity(.9),
        boxShadow: !widget.isFloating
            ? null
            : [
                BoxShadow(
                  offset: Offset(0, 4),
                  blurStyle: BlurStyle.outer,
                  blurRadius: 35,
                  color: Colors.black.withOpacity(.15),
                ),
              ],
      ),
      clipBehavior: Clip.hardEdge,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 15,
          sigmaY: 15,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              Icon(
                FluentIcons.chevron_left_20_regular,
                color: CstColors.a,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Customer chat service',
                      maxLines: 1,
                      style: Get.textTheme.headlineSmall!.copyWith(
                        height: 1.2,
                        color: CstColors.a,
                        fontWeight: FontWeight.w600,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      'Not available now',
                      style: Get.textTheme.bodySmall!.copyWith(
                        color: Colors.redAccent.shade400,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                FluentIcons.more_vertical_20_regular,
                color: CstColors.a,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
