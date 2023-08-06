import 'package:aissam_store/view/public/text_field.dart';
import 'package:flutter/material.dart';

class SearchBarHeaderPersistent extends SliverPersistentHeaderDelegate {
  SearchBarHeaderPersistent({
    required this.focusNode,
    // this.isFloating = false,
    this.onTap,
    required this.isFloatingNotifier,
    required this.controller,
    this.onCommit,
  });

  // final ScrollController scrollController;
  final FocusNode focusNode;
  // final bool isFloating;
  final Function()? onTap;
  final ValueNotifier<bool> isFloatingNotifier;
  final TextEditingController controller;
  final Function()? onCommit;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Padding(
      padding: EdgeInsets.only(top: 20, right: 25, left: 25),
      child: GestureDetector(
        onTap: onTap,
        child: ValueListenableBuilder<bool>(
          valueListenable: isFloatingNotifier,
          builder: (context, v, c) {
            return CustomTextField(
              onTap: onTap,
              onCommit: onCommit,
              onClear: () {
                controller.clear();
                focusNode.unfocus();
              },
              focusNode: focusNode,
              enabled: !v,
              isFloating: v,
              controller: controller,
            );
          },
        ),
      ),
    );
  }

  static const double _fixExtent = 78;

  @override
  // TODO: implement maxExtent
  double get maxExtent => _fixExtent;

  @override
  // TODO: implement minExtent
  double get minExtent => _fixExtent;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return false;
  }
}
