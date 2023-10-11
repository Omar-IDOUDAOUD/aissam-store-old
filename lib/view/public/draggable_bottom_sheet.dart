import 'package:aissam_store/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class BottomSheetActionButton {
  final Widget icon;
  final Function()? onTap;

  BottomSheetActionButton({required this.icon, this.onTap});
}

class ShowDraggableBottomSheet {
  final BuildContext context;
  final Widget Function(ScrollController scrollController) builder;
  final String title;
  final String? subTitle;
  final List<BottomSheetActionButton>? actions;
  ShowDraggableBottomSheet({
    required this.builder,
    required this.context,
    required this.title,
    this.subTitle,
    this.actions,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(.2),
      builder: (_) {
        return DraggableScrollableSheet(
          snap: true,
          snapSizes: [0.5, 0.95],
          snapAnimationDuration: 200.milliseconds,
          initialChildSize: 0.5,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          expand: false,
          builder: (_, ScrollController scrollController) {
            return Container(
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30), bottom: Radius.circular(10)),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 7,
                  ),
                  SizedBox(
                    height: 5,
                    width: 50,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: Get.textTheme.headlineMedium!
                                  .copyWith(color: CstColors.a),
                            ),
                            if (subTitle != null)
                              Text(
                                subTitle!,
                                style: Get.textTheme.bodyMedium!.copyWith(
                                  color: CstColors.b,
                                  height: 1.1,
                                ),
                              ),
                          ],
                        ),
                      ),

                      // SizedBox.square(
                      //   dimension: 20,
                      //   child: ColoredBox(color: Colors.red),
                      // ),
                      if (actions != null)
                        ...actions!.map(
                          (e) => Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: SizedBox.square(
                              dimension: 30,
                              child: GestureDetector(
                                onTap: e.onTap,
                                child: e.icon,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: builder(scrollController),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}