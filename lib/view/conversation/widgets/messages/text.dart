import 'package:aissam_store/view/conversation/message_modal.dart';
import 'package:aissam_store/view/conversation/widgets/messages/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextMessage extends StatelessWidget {
  TextMessage({super.key, required this.parameters});
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
          padding: MessageWidgetConstants.padding,
          child: Text(
            parameters.data.content,
            style: sets.contentTextStyle,
          ),
        ),
      ),
    );
  }
}
