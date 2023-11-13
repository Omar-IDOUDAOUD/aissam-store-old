import 'dart:ui';

import 'package:aissam_store/core/utils/asset_loader.dart';
import 'package:aissam_store/core/utils/icon_loader.dart';
import 'package:aissam_store/view/conversation/message_modal.dart';
import 'package:aissam_store/view/conversation/widgets/messages/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductLinkMessage extends StatelessWidget {
  ProductLinkMessage({super.key, required this.parameters});
  MessageWidgetParameters parameters;

  @override
  Widget build(BuildContext context) {
    final MessageWidgetVaraiblesSets sets = parameters.data.isClientMessage
        ? ClientMessageWidgetSets()
        : SellerMessageWidgetSets();
    return BuildMainWidgetStructure(
      isClientMessage: parameters.data.isClientMessage,
      datetime: parameters.data.dateTime,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 250),
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius:
                    sets.borderRadius(parameters.isTheFirstMessage).copyWith(
                          bottomLeft: MessageWidgetConstants.minBorderRaduis,
                          bottomRight: MessageWidgetConstants.minBorderRaduis,
                        ),
                // color: sets.backroundColor,
                image: DecorationImage(
                  alignment: Alignment.center,
                  fit: BoxFit.cover,
                  image: AssetImage(
                    AssetLoader.image('image_2.png'),
                  ),
                ),
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: _ImageButton(),
                ),
              ),
            ),
          ),
          SizedBox(
            height: MessageWidgetConstants.spacing,
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius:
                  sets.borderRadius(parameters.isTheFirstMessage).copyWith(
                        topLeft: MessageWidgetConstants.minBorderRaduis,
                        topRight: MessageWidgetConstants.minBorderRaduis,
                      ),
              color: sets.backroundColor,
            ),
            child: Padding(
              padding: MessageWidgetConstants.padding,
              child: Text(
                parameters.data.content,
                style: sets.contentTextStyle
                    .copyWith(decoration: TextDecoration.underline),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ImageButton extends StatelessWidget {
  const _ImageButton({super.key});

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(30);
    return SizedBox(
      height: 45,
      child: ClipRRect(
        borderRadius: borderRadius,
        clipBehavior: Clip.hardEdge,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.7),
              borderRadius: borderRadius,
              border:
                  Border.all(color: Colors.white.withOpacity(.7), width: 0.7),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    SizedBox(
                      width: 25,
                    ),
                    Expanded(
                      child: Text(
                        'Open Product',
                        textAlign: TextAlign.center,
                        style: Get.textTheme.bodyMedium!.copyWith(
                          color: Colors.indigoAccent.shade700,
                        ),
                      ),
                    ),
                    IconLoader(
                      'arrow_right.svg',
                      width: 25,
                      color: Colors.indigoAccent.shade700,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
