import 'package:aissam_store/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class InboxItemCard extends StatelessWidget {
  const InboxItemCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: _getImages(),
          ),
          SizedBox(width: 10),
          Expanded(
            flex: 7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // SizedBox(
                //   height: 5,
                // ),
                Text(
                  'White Abayas with blue dots hertirafsdgf',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Get.textTheme.bodyMedium!.copyWith(
                    color: CstColors.a,
                  ),
                ),
                Text(
                  'Yes its available in you region!',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Get.textTheme.displayLarge!.copyWith(
                    color: CstColors.a,
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Today • 13:55',
                      style: Get.textTheme.displayLarge!.copyWith(
                        color: CstColors.b,
                      ),
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.greenAccent.shade100.withOpacity(.5),
                      ),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                        child: Text(
                          '2 messages',
                          style: Get.textTheme.displayMedium!.copyWith(
                            color: Colors.greenAccent.shade700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      'See and reply',
                      style: Get.textTheme.displayLarge!.copyWith(
                        color: Colors.pink,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    SvgPicture.asset(
                      'assets/icons/arrow_right.svg',
                      color: Colors.pink,
                      width: 25,
                    ),
                  ],
                ),
                // SizedBox(
                //   height: 5,
                // ),
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
                image: AssetImage('assets/images/image_5.png'),
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
                image: AssetImage('assets/images/image_4.png'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
