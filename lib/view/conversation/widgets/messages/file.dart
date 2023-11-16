import 'package:aissam_store/core/utils/icon_loader.dart';
import 'package:aissam_store/view/conversation/message_modal.dart';
import 'package:aissam_store/view/conversation/widgets/messages/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FileMessage extends StatelessWidget {
  FileMessage({super.key, required this.parameters});
  MessageWidgetParameters parameters;

  @override
  Widget build(BuildContext context) {
    final MessageWidgetVaraiblesSets sets = parameters.data.isClientMessage
        ? ClientMessageWidgetSets()
        : SellerMessageWidgetSets();
    return BuildMainWidgetStructure(
      isClientMessage: parameters.data.isClientMessage,
      datetime: parameters.data.dateTime,
      child: SizedBox(
        width: MessageWidgetConstants.normaleMessageWidth,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: sets.borderRadius(parameters.isTheFirstMessage),
            color: sets.backroundColor,
          ),
          child: Padding(
              padding:
                  MessageWidgetConstants.padding.copyWith(top: 15, bottom: 15),
              child: Row(
                children: [
                  SizedBox.square(
                    dimension: 50,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: IconLoader(
                          'mc_powerpoint.png',
                          width: 30,
                          height: 30,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Instructions.docx',
                          style: sets.contentTextStyle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'Microsoft Word',
                          style:
                              MessageWidgetConstants.datetimeTextStyle.copyWith(
                            color: sets.contentMainColor.withOpacity(.5),
                          ),
                        ),
                        Text(
                          '2.1 MB',
                          style:
                              MessageWidgetConstants.datetimeTextStyle.copyWith(
                            color: sets.contentMainColor.withOpacity(.5),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
