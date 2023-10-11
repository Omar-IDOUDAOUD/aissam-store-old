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
            'assets/icons/close.svg',
            height: 20,
            color: Colors.black,
            // width: 20,
          ),
        )
      ],
      builder: (sc) => SingleChildScrollView(
        controller: sc,
        child: _NotificationsBottomSheetContent(),
      ),
      context: context,
    );
  }
}

class _NotificationsBottomSheetContent extends StatelessWidget {
  const _NotificationsBottomSheetContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisSize: MainAxisSize.min,
      // controller: sc,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        NotificationCard(),
        SizedBox(
          height: 10,
        ),
        NotificationCard(),
      ],
    );
  }
}
