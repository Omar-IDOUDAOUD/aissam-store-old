// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:aissam_store/core/constants/colors.dart';
import 'package:aissam_store/view/conversation/message_modal.dart';
import 'package:aissam_store/view/conversation/widgets/sections_by_date.dart';
import 'package:aissam_store/view/conversation/widgets/messages/models.dart';
import 'package:aissam_store/view/conversation/widgets/text_field.dart';
import 'package:aissam_store/view/public/appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

class ConversationPage extends StatefulWidget {
  const ConversationPage({super.key});

  @override
  State<ConversationPage> createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: CustomScrollView(
              slivers: [
                _appBar(),
                // SliverList(
                //   delegate: SliverChildBuilderDelegate(
                //     (context, index) => MessagesSectionByDate(
                //       messages: [],
                //       date: DateTime.now(),
                //     ),
                //     childCount: 200,
                //   ),
                // ),

                ...List.generate(
                  100,
                  (index) => MessagesSectionByDate(
                    messages: [],
                    date: DateTime.now(),
                  ),
                ),

                // SliverList.builder(
                //   itemCount: 15,
                //   itemBuilder: (_, i) =>
                // )

                // MessagesSectionByDate(
                //   messages: [],
                //   date: DateTime.now(),
                // ),
                // MessagesSectionByDate(
                //   messages: [],
                //   date: DateTime.now(),
                // ),
                // MessagesSectionByDate(
                //   messages: [],
                //   date: DateTime.now(),
                // ),
                // MessagesSectionByDate(
                //   messages: [],
                //   date: DateTime.now(),
                // ),
                // MessagesSectionByDate(
                //   messages: [],
                //   date: DateTime.now(),
                // ),
                // MessagesSectionByDate(
                //   messages: [],
                //   date: DateTime.now(),
                // ),
                // MessagesSectionByDate(
                //   messages: [],
                //   date: DateTime.now(),
                // ),
                // MessagesSectionByDate(
                //   messages: [],
                //   date: DateTime.now(),
                // ),

                // MessagesSectionByDate(
                //   messages: [],
                //   date: DateTime.now(),
                // ),
                // MessagesSectionByDate(
                //   messages: [],
                //   date: DateTime.now(),
                // ),
                // MessagesSectionByDate(
                //   messages: [],
                //   date: DateTime.now(),
                // ),
                // MessagesSectionByDate(
                //   messages: [],
                //   date: DateTime.now(),
                // ),
                // MessagesSectionByDate(
                //   messages: [],
                //   date: DateTime.now(),
                // ),
                // MessagesSectionByDate(
                //   messages: [],
                //   date: DateTime.now(),
                // ),
                // MessagesSectionByDate(
                //   messages: [],
                //   date: DateTime.now(),
                // ),
                // MessagesSectionByDate(
                //   messages: [],
                //   date: DateTime.now(),
                // ),
                // MessagesSectionByDate(
                //   messages: [],
                //   date: DateTime.now(),
                // ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: MessageTextField(),
          )
        ],
      ),
    );
  }

  Widget _appBar() => CustomAppBarSliver.sliverPersistentHeader(
        floating: true,
        data: CustomAppBarData(
          leadingIcon: FluentIcons.chevron_left_20_regular,
          actions: [ActionIcon(FluentIcons.more_vertical_24_regular)],
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Customer chat service',
                maxLines: 1,
                style: Get.textTheme.headlineSmall!.copyWith(
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
      );
}
