import 'package:aissam_store/core/constants/colors.dart';
import 'package:aissam_store/view/notifications/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationCard extends StatefulWidget {
  const NotificationCard({super.key, this.withDivider = true});
  final bool withDivider;

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: Colors.orange,
          radius: 20,
        ),
        SizedBox(
          width: 15,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Someting Someting Someting Someting Someting',
                style: Get.textTheme.bodyMedium!.copyWith(
                  height: 1.2,
                  color: CstColors.a,
                ),
              ),
              Text(
                'Today, 12:35',
                style: Get.textTheme.displayLarge!.copyWith(
                  color: CstColors.b,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  PrimaryButton(color: Colors.orange, text: 'Send feedback'),
                  SizedBox(
                    width: 7,
                  ),
                  PrimaryButton(
                    color: Colors.grey.shade300,
                    text: 'Not delivered to me',
                    textColor: Colors.grey.shade700,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 1,
                child: ColoredBox(color: Colors.grey.shade600),
              )
            ],
          ),
        ),
      ],
    );
  }
}
