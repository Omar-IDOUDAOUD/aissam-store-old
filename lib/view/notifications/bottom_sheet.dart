import 'package:aissam_store/core/constants/colors.dart';
import 'package:aissam_store/view/notifications/widgets/notifictaion_card.dart';
import 'package:aissam_store/view/chat_inbox/widgets/inbox_item_card.dart';
import 'package:aissam_store/view/public/draggable_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ShowNotificationsBottomSheet {
  final BuildContext context;
  ShowNotificationsBottomSheet({required this.context}) {
    ShowDraggableBottomSheet(
      title: 'Notifications',
      actions: [
        BottomSheetActionButton(
          onTap: Get.back,
          icon: SvgPicture.asset(
            'assets/icons/ic_fluent_settings_24_regular.svg',
            color: CstColors.a,
          ),
        ),
        BottomSheetActionButton(
          onTap: Get.back,
          icon: Stack(
            children: [
              Positioned.fill(
                child: SvgPicture.asset(
                  'assets/icons/ic_fluent_chat_24_regular.svg',
                  color: CstColors.a,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.pink),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                    child: Text(
                      '5',
                      style: Get.textTheme.displaySmall!
                          .copyWith(color: Colors.white, height: 1.2),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        BottomSheetActionButton(
          onTap: Get.back,
          icon: SvgPicture.asset(
            'assets/icons/close.svg',
            color: CstColors.a,
          ),
        ),
      ],
      builder: (sc) => _NotificationsBottomSheetContent(scrollController: sc),
      context: context,
      
    );
  }
}

class _NotificationsBottomSheetContent extends StatelessWidget {
  const _NotificationsBottomSheetContent(
      {super.key, required this.scrollController});
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // mainAxisSize: MainAxisSize.min,
      // controller: sc,
      // crossAxisAlignment: CrossAxisAlignment.stretch,
      controller: scrollController,
      padding: EdgeInsets.symmetric(vertical: 10),
      itemCount: 50,
      itemBuilder: (_, index) {
        if (index == 0)
          return _getLatestDividerIndicator.paddingOnly(bottom: 10);
        if (index == 3)
          return _getOldestDividerIndicator.paddingOnly(bottom: 10);
        else
          return NotificationCard(
            withDivider: index != 50,
          ).paddingOnly(bottom: 10);
      },
    );
  }

  Widget get _getLatestDividerIndicator {
    return SizedBox(
      height: 10,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'Latest',
            style: Get.textTheme.bodySmall!.copyWith(
              color: CstColors.b,
              height: 0.3,
            ),
          ),
          SizedBox(width: 4),
          Expanded(
            child: SizedBox(
              height: 1,
              child: ColoredBox(color: CstColors.b),
            ),
          ),
          SizedBox(width: 4),
          Text(
            '2 new notifications',
            style: Get.textTheme.bodySmall!.copyWith(
              color: CstColors.b,
              height: 0.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget get _getOldestDividerIndicator {
    return SizedBox(
      height: 10,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'Oldest',
            style: Get.textTheme.bodySmall!.copyWith(
              color: CstColors.b,
              height: 0.3,
            ),
          ),
          SizedBox(width: 4),
          Expanded(
            child: SizedBox(
              height: 1,
              child: ColoredBox(
                color: CstColors.b,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
