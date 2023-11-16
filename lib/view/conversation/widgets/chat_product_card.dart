import 'package:aissam_store/core/constants/colors.dart';
import 'package:aissam_store/core/utils/asset_loader.dart';
import 'package:aissam_store/core/utils/icon_loader.dart';
import 'package:aissam_store/view/conversation/widgets/messages/models.dart';
import 'package:aissam_store/view/public/space.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ChatProductCard extends StatelessWidget {
  const ChatProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: 95,
        maxHeight: 105,
      ),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(MessageWidgetConstants.maxBorderRaduis),
        color: Colors.grey.shade200,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: _getImages(),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bla bla bla bla bla bnla nlaodj ihds euifb dsiofh siodhf osidf sdiofh sdiofh sdfiohsdf osidhf sdiofh sdfusd fisudf sdfuih',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Get.textTheme.bodyMedium!.copyWith(
                    color: CstColors.a,
                  ),
                ),
                Text(
                  '250.00 MAD',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Get.textTheme.bodySmall!.copyWith(
                    color: CstColors.b,
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    ...List.generate(
                      5,
                      (index) => IconLoader(
                        FluentIcons.star_24_filled,
                        height: 17,
                        color: Colors.orange,
                      ),
                    ),
                    Spacer(),
                    Text(
                      'Show Product',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Get.textTheme.bodySmall!.copyWith(
                        color: Colors.blue.shade900,
                      ),
                    ),
                    IconLoader(
                      FluentIcons.chevron_right_24_regular,
                      width: 13,
                      color: Colors.blue.shade900,
                    ),
                    SizedBox(width: 5)
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  _getImages() {
    return Stack(
      fit: StackFit.expand,
      children: [
        FractionallySizedBox(
          alignment: Alignment.centerLeft,
          widthFactor: .7,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(AssetLoader.image('image_3.png')),
              ),
            ),
          ),
        ),
        FractionallySizedBox(
          alignment: Alignment.centerRight,
          widthFactor: .7,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(AssetLoader.image('image_4.png')),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
