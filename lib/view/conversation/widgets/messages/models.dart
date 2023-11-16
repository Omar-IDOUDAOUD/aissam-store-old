import 'package:aissam_store/core/constants/colors.dart';
import 'package:aissam_store/view/conversation/message_modal.dart';
import 'package:aissam_store/view/conversation/widgets/messages/audio.dart';
import 'package:aissam_store/view/conversation/widgets/messages/file.dart';
import 'package:aissam_store/view/conversation/widgets/messages/image_video.dart';
import 'package:aissam_store/view/conversation/widgets/messages/link.dart';
import 'package:aissam_store/view/conversation/widgets/messages/product_link.dart';
import 'package:aissam_store/view/conversation/widgets/messages/text.dart';
import 'package:aissam_store/view/public/space.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

abstract class MessageWidgetConstants {
  static EdgeInsets get padding => EdgeInsets.fromLTRB(15, 10, 15, 10);
  static Radius get minBorderRaduis => Radius.circular(5);
  static Radius get maxBorderRaduis => Radius.circular(20);
  static double get spacing => 5;
  static Color get clientBackroundColor => Colors.grey.shade300;
  static Color get sellerBackroundColor => Colors.deepPurpleAccent;
  static Color get clientContentColor => CstColors.a;
  static Color get sellerContentColor => Colors.white;
  static TextStyle get clientTextStyle =>
      Get.textTheme.bodyLarge!.copyWith(color: CstColors.a, height: 1.4);
  static TextStyle get sellerTextStyle =>
      Get.textTheme.bodyLarge!.copyWith(color: Colors.white, height: 1.4);
  static TextStyle get datetimeTextStyle =>
      Get.textTheme.bodySmall!.copyWith(color: Colors.grey, height: 1.2);
  static double normaleMessageWidth = Get.size.width * 0.6;
}

abstract class MessageWidgetVaraiblesSets {
  Color get backroundColor;
  Color get contentMainColor;
  TextStyle get contentTextStyle;
  BorderRadius borderRadius(bool isTheFirstMessage);
}

class ClientMessageWidgetSets extends MessageWidgetVaraiblesSets {
  @override
  Color get backroundColor => MessageWidgetConstants.clientBackroundColor;

  @override
  TextStyle get contentTextStyle => MessageWidgetConstants.clientTextStyle;

  @override
  // TODO: implement contentMainColor
  Color get contentMainColor => MessageWidgetConstants.clientContentColor;

  @override
  BorderRadius borderRadius(bool isTheFirstMessage) {
    return BorderRadius.only(
      bottomRight: MessageWidgetConstants.maxBorderRaduis,
      topRight: MessageWidgetConstants.maxBorderRaduis,
      bottomLeft: MessageWidgetConstants.minBorderRaduis,
      topLeft: isTheFirstMessage
          ? MessageWidgetConstants.maxBorderRaduis
          : MessageWidgetConstants.minBorderRaduis,
    );
  }
}

class SellerMessageWidgetSets extends MessageWidgetVaraiblesSets {
  @override
  Color get backroundColor => MessageWidgetConstants.sellerBackroundColor;

  @override
  TextStyle get contentTextStyle => MessageWidgetConstants.sellerTextStyle;

  @override
  // TODO: implement contentMainColor
  Color get contentMainColor => MessageWidgetConstants.sellerContentColor;

  @override
  BorderRadius borderRadius(bool isTheFirstMessage) {
    return BorderRadius.only(
      bottomLeft: MessageWidgetConstants.maxBorderRaduis,
      topLeft: MessageWidgetConstants.maxBorderRaduis,
      bottomRight: MessageWidgetConstants.minBorderRaduis,
      topRight: isTheFirstMessage
          ? MessageWidgetConstants.maxBorderRaduis
          : MessageWidgetConstants.minBorderRaduis,
    );
  }
}

class MessageWidgetParameters {
  final Message data;
  final bool isTheFirstMessage;

  MessageWidgetParameters(
      {required this.data, required this.isTheFirstMessage});
}

Widget buildMessageWidget(MessageWidgetParameters parameters) {
  switch (parameters.data.type) {
    case MessageType.text:
      return TextMessage(parameters: parameters);
    case MessageType.imageVideo:
      return ImageVideoMessage(parameters: parameters);
    case MessageType.productLink:
      return ProductLinkMessage(parameters: parameters);
    case MessageType.audio:
      return AudioMessage(parameters: parameters);
    case MessageType.file:
      return FileMessage(parameters: parameters);
    case MessageType.link:
      return LinkMessage(parameters: parameters);
  }
}

Widget BuildMainWidgetStructure(
    {required bool isClientMessage,
    required Widget child,
    required DateTime datetime}) {
  return Align(
    alignment: isClientMessage ? Alignment.centerLeft : Alignment.centerRight,
    child: ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: Get.size.width * 0.75,
      ),
      child: Wrap(
        spacing: MessageWidgetConstants.spacing,
        runSpacing: MessageWidgetConstants.spacing,
        alignment: isClientMessage ? WrapAlignment.end : WrapAlignment.start,
        crossAxisAlignment: !isClientMessage
            ? WrapCrossAlignment.start
            : WrapCrossAlignment.end,
        verticalDirection:
            !isClientMessage ? VerticalDirection.up : VerticalDirection.down,
        children: [
          if (isClientMessage) child,
          Text(
            '${datetime.hour}:${datetime.minute}',
            style: MessageWidgetConstants.datetimeTextStyle,
          ),
          if (!isClientMessage) child,
        ],
      ),
    ),
  );
}
