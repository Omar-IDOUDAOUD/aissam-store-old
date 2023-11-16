import 'package:aissam_store/view/conversation/message_modal.dart';
import 'package:aissam_store/view/conversation/widgets/messages/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LinkMessage extends StatelessWidget {
  LinkMessage({super.key, required this.parameters});
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
          padding: MessageWidgetConstants.padding.copyWith(top: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 50,
                child: Row(
                  children: [
                    SizedBox.square(
                      dimension: 50,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hsdi isdhf ioshef sdiohf sdfiohsd fiohusfn sdfnsd hs nsdfhuio sfhisdf ',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: sets.contentTextStyle.copyWith(
                              fontSize: MessageWidgetConstants
                                  .datetimeTextStyle.fontSize,
                            ),
                          ),
                          Text(
                            'www.figma.com',
                            style: sets.contentTextStyle.copyWith(
                              fontSize: MessageWidgetConstants
                                  .datetimeTextStyle.fontSize,
                              color:
                                  sets.contentTextStyle.color!.withOpacity(.6),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 7),
              Text(
                parameters.data.content,
                style: sets.contentTextStyle
                    .copyWith(decoration: TextDecoration.underline),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
