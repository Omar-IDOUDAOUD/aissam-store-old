// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:aissam_store/core/constants/colors.dart';
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
                SliverPersistentHeader(
                  delegate: CustomAppBarSliver(),
                  floating: true,
                ),
                SliverList.builder(
                  itemCount: Colors.accents.length,
                  itemBuilder: (_, i) => Container(
                    height: 70,
                    color: Colors.accents.elementAt(i),
                  ),
                ),
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
}
