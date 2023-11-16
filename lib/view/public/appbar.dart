import 'dart:ui';

import 'package:aissam_store/core/constants/colors.dart';
import 'package:aissam_store/core/utils/icon_loader.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/rendering/sliver_persistent_header.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

const double _FixedAppBarHeight = 65;

class CustomAppBarSliver extends SliverPersistentHeaderDelegate {
  final CustomAppBarData appBarData;
  final bool isPinned;
  final bool isFloating;

  static SliverPersistentHeader sliverPersistentHeader(
      {required CustomAppBarData data,
      bool pinned = false,
      bool floating = false}) {
    return SliverPersistentHeader(
      floating: floating,
      pinned: pinned,
      delegate: CustomAppBarSliver(
          appBarData: data, isFloating: floating, isPinned: pinned),
    );
  }

  CustomAppBarSliver(
      {required this.appBarData,
      this.isPinned = false,
      this.isFloating = false});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // print('rebuild, shrinkOffset: $shrinkOffset, evrlap: $overlapsContent');
    return CustomAppBar(
      data: appBarData,
      isFloating: isFloating
          ? overlapsContent
          : isPinned
              ? shrinkOffset >= 10
              : false,
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => _FixedAppBarHeight;

  @override
  // TODO: implement minExtent
  double get minExtent => _FixedAppBarHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class ActionIcon {
  final IconData icon;
  final Function()? onTap;

  ActionIcon(this.icon, [this.onTap]);
}

class CustomAppBarData {
  CustomAppBarData({
    this.leadingIcon,
    required this.title,
    this.actions,
  });
  final IconData? leadingIcon;
  final Widget title;
  final List<ActionIcon>? actions;
}

class CustomAppBar extends StatefulWidget {
  final CustomAppBarData data;

  final bool isFloating;

  const CustomAppBar({super.key, required this.data, this.isFloating = false});
  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  final BorderRadius _borderRadius =
      BorderRadius.vertical(bottom: Radius.circular(25));

  CustomAppBarData get _appBarParameters => widget.data;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: _FixedAppBarHeight,
      duration: 200.milliseconds,
      foregroundDecoration: BoxDecoration(
        borderRadius: _borderRadius,
        border: Border.all(width: .7, color: Colors.white.withOpacity(.7)),
      ),
      decoration: BoxDecoration(
        boxShadow: !widget.isFloating
            ? null
            : [
                BoxShadow(
                  blurStyle: BlurStyle.outer,
                  blurRadius: 35,
                  color: Colors.black.withOpacity(.15),
                ),
              ],
        borderRadius: _borderRadius,
      ),
      clipBehavior: Clip.hardEdge,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 15,
          sigmaY: 15,
        ),
        child: ColoredBox(
          color: Colors.white.withOpacity(.7),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                if (_appBarParameters.leadingIcon != null)
                  IconLoader(_appBarParameters.leadingIcon!,
                      color: CstColors.a, width: 25),
                Expanded(
                  child: _appBarParameters.title,
                ),
                if (_appBarParameters.actions != null &&
                    _appBarParameters.actions!.isNotEmpty)
                  ...List.generate(
                    _appBarParameters.actions!.length,
                    (index) => GestureDetector(
                      onTap: _appBarParameters.actions!.elementAt(index).onTap,
                      child: IconLoader(
                          _appBarParameters.actions!.elementAt(index).icon,
                          color: CstColors.a,
                          width: 25),
                    ),
                  )
                else if (_appBarParameters.leadingIcon != null)
                  SizedBox(width: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
