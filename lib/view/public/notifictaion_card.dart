import 'package:aissam_store/core/constants/colors.dart';
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
                  _PrimaryButton(color: Colors.orange, text: 'Send feedback'),
                  SizedBox(
                    width: 7,
                  ),
                  _PrimaryButton(
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

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({
    super.key,
    required this.color,
    required this.text,
    this.textColor,
  });

  final Color color;
  final String text;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 11, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: Get.textTheme.displayLarge!.copyWith(
          color: textColor ?? Colors.white,
        ),
      ),
    );
  }
}

class _SecondaryButton extends StatelessWidget {
  const _SecondaryButton({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 11, vertical: 6),
      child: Text(
        text,
        style: Get.textTheme.displayLarge!.copyWith(
          color: Colors.white,
        ),
      ),
    );
  }
}
