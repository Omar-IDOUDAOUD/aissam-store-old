import 'package:aissam_store/core/utils/icon_loader.dart';
import 'package:aissam_store/view/conversation/message_modal.dart';
import 'package:aissam_store/view/conversation/widgets/messages/models.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageVideoMessage extends StatelessWidget {
  ImageVideoMessage({super.key, required this.parameters});
  MessageWidgetParameters parameters;
  late final MessageWidgetVaraiblesSets sets;

  @override
  Widget build(BuildContext context) {
    final isOneElement = true;
    sets = parameters.data.isClientMessage
        ? ClientMessageWidgetSets()
        : SellerMessageWidgetSets();
    return BuildMainWidgetStructure(
      isClientMessage: parameters.data.isClientMessage,
      datetime: parameters.data.dateTime,
      child: ClipRRect(
        clipBehavior: Clip.hardEdge,
        borderRadius: sets.borderRadius(parameters.isTheFirstMessage),
        child: SizedBox(
          height: Get.size.height * 0.3,
          width: MessageWidgetConstants.normaleMessageWidth,
          child: Column(
            children: [
              Expanded(
                child: _getElement(
                  url:
                      'https://cdn.pixabay.com/photo/2015/12/01/20/28/road-1072823_1280.jpg',
                  isImage: false,
                ),
              ),
              SizedBox(
                height: MessageWidgetConstants.spacing,
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: _getElement(
                        url:
                            'https://cdn.pixabay.com/photo/2015/12/01/20/28/road-1072823_1280.jpg',
                      ),
                    ),
                    SizedBox(
                      width: MessageWidgetConstants.spacing,
                    ),
                    Expanded(
                      child: _getElement(
                        url:
                            'https://cdn.pixabay.com/photo/2015/12/01/20/28/road-1072823_1280.jpg',
                        overLayContent: 2,
                        isImage: false,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // BorderRadius _getBorderRadiudByElementIndex(int index) {
  //   switch (index) {
  //     case 1:
  //       return sets.borderRadius(parameters.isTheFirstMessage).copyWith(
  //             bottomLeft: MessageWidgetConstants.minBorderRaduis,
  //             bottomRight: MessageWidgetConstants.minBorderRaduis,
  //           );
  //     case 2:
  //       return sets.borderRadius(parameters.isTheFirstMessage).copyWith(
  //             topLeft: MessageWidgetConstants.minBorderRaduis,
  //             topRight: MessageWidgetConstants.minBorderRaduis,
  //             bottomRight: MessageWidgetConstants.minBorderRaduis,
  //           );
  //     case 3:
  //       return sets.borderRadius(parameters.isTheFirstMessage).copyWith(
  //             topRight: MessageWidgetConstants.minBorderRaduis,
  //             topLeft: MessageWidgetConstants.minBorderRaduis,
  //             bottomLeft: MessageWidgetConstants.minBorderRaduis,
  //           );
  //     case 4:
  //       return sets.borderRadius(parameters.isTheFirstMessage).copyWith(
  //             topLeft: MessageWidgetConstants.minBorderRaduis,
  //             topRight: MessageWidgetConstants.minBorderRaduis,
  //           );
  //     default:
  //       return sets.borderRadius(parameters.isTheFirstMessage);
  //   }
  // }

  Widget _getElement({
    required String url,
    bool isImage = true,
    int? overLayContent,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          Image(
            image: NetworkImage(url, scale: 0.5),
            alignment: Alignment.center,
            fit: BoxFit.cover,
          ),
          if (overLayContent != null || !isImage)
            ColoredBox(
              color: overLayContent != null
                  ? Colors.black.withOpacity(.5)
                  : Colors.transparent,
              child: Center(
                child: overLayContent != null
                    ? Text(
                        '$overLayContent+',
                        style:
                            sets.contentTextStyle.copyWith(color: Colors.white),
                      )
                    : !isImage
                        ? CircleAvatar(
                            backgroundColor: Colors.white.withOpacity(.3),
                            radius: 20,
                            child: IconLoader(
                              FluentIcons.play_24_filled,
                              color: Colors.white,
                              width: 25,
                            ),
                          )
                        : null,
              ),
            )
        ],
      ),
    );
  }
}
