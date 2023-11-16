import 'package:aissam_store/core/utils/icon_loader.dart';
import 'package:aissam_store/view/conversation/message_modal.dart';
import 'package:aissam_store/view/conversation/widgets/messages/models.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AudioMessage extends StatelessWidget {
  AudioMessage({super.key, required this.parameters});
  MessageWidgetParameters parameters;

  @override
  Widget build(BuildContext context) {
    final MessageWidgetVaraiblesSets sets = parameters.data.isClientMessage
        ? ClientMessageWidgetSets()
        : SellerMessageWidgetSets();
    return BuildMainWidgetStructure(
      isClientMessage: parameters.data.isClientMessage,
      datetime: parameters.data.dateTime,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: sets.borderRadius(parameters.isTheFirstMessage),
          color: sets.backroundColor,
        ),
        child: Padding(
          padding: MessageWidgetConstants.padding.copyWith(top: 20, bottom: 20),
          child: SizedBox(
            width: MessageWidgetConstants.normaleMessageWidth,
            child: Row(
              children: [
                IconLoader(
                  FluentIcons.play_24_filled,
                  color: sets.contentMainColor,
                  width: 25,
                ),
                SizedBox(
                  width: 7,
                ),
                Expanded(
                    child: SizedBox(
                  height: 15,
                  child: ColoredBox(
                    color: sets.contentMainColor,
                  ),
                )),
                SizedBox(
                  width: 7,
                ),
                Text(
                  '2:05',
                  style: MessageWidgetConstants.datetimeTextStyle.copyWith(
                    color: sets.contentMainColor.withOpacity(.7),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
