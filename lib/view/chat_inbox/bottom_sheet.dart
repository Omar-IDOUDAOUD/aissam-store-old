import 'package:aissam_store/core/constants/colors.dart';
import 'package:aissam_store/view/notifications/widgets/notifictaion_card.dart';
import 'package:aissam_store/view/chat_inbox/widgets/inbox_item_card.dart';
import 'package:aissam_store/view/public/draggable_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ShowChatInboxBottomSheet {
  final BuildContext context;
  ShowChatInboxBottomSheet({required this.context}) {
    ShowDraggableBottomSheet(
      title: 'Chat Inbox',
      subTitle: '2 unread messages',
      actions: [
        BottomSheetActionButton(
          onTap: Get.back,
          icon: SvgPicture.asset(
            'assets/icons/close.svg',
            height: 20,
            color: Colors.black,
            // width: 20,
          ),
        )
      ],
      builder: (sc) => _ChatInboxBottomSheetContent(scrollController: sc),
      context: context,
    );
  }
}

class _ChatInboxBottomSheetContent extends StatelessWidget {
  const _ChatInboxBottomSheetContent(
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
          return InboxItemCard().paddingOnly(bottom: 10);
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
            'Make all as read',
            style: Get.textTheme.bodySmall!.copyWith(
              color: Colors.indigoAccent,
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
