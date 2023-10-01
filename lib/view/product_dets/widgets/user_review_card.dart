import 'package:aissam_store/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class UserReviewCard extends StatefulWidget {
  const UserReviewCard({super.key});

  @override
  State<UserReviewCard> createState() => _UserReviewCardState();
}

class _UserReviewCardState extends State<UserReviewCard> {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade200,
      ),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: Colors.grey.shade300,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Samira Tayyeb',
                            style: Get.textTheme.bodyLarge!.copyWith(
                              color: CstColors.a,
                              height: 1.2,
                            ),
                          ),
                          Spacer(),
                          ...List.generate(
                            5,
                            (index) => SvgPicture.asset(
                              'assets/icons/preview_star.svg',
                              height: 16,
                              width: 16,
                              color: index <= 2
                                  ? Colors.orange.shade200
                                  : Colors.grey.withOpacity(.5),
                            ),
                          )
                        ],
                      ),
                      Text(
                        '13 december',
                        style: Get.textTheme.bodySmall!.copyWith(
                          color: CstColors.b,
                          height: 1.6,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'A very good jean quality and beautiful color, but one small problem is that product can\'t accept more than two washes..',
              style: Get.textTheme.bodyMedium!
                  .copyWith(color: CstColors.a, height: 1.2),
            ),
            SizedBox(
              height: 7,
            ),
            Row(
              children: [
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '25 Like • ',
                          style: Get.textTheme.bodySmall!
                              .copyWith(color: CstColors.a, height: 1.2),
                        ),
                        TextSpan(
                          text: '1 Reply',
                          style: Get.textTheme.bodySmall!.copyWith(
                            color: Colors.indigo.shade700,
                            decoration: TextDecoration.underline,
                            height: 1.2,
                          ),
                        ),
                      ],
                    ),
                    // overflow: TextOverflow.fade,
                  ),
                ),
                _getButtonBackround(
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/ic_fluent_arrow_reply_24_regular.svg',
                        color: CstColors.a,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        'Reply',
                        style: Get.textTheme.bodyMedium!
                            .copyWith(color: CstColors.a, height: 1.2),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 7,
                ),
                _getButtonBackround(
                  SvgPicture.asset(
                    'assets/icons/ic_fluent_thumb_dislike_24_regular.svg',
                    color: CstColors.a,
                  ),
                ),
                SizedBox(
                  width: 7,
                ),
                _getButtonBackround(SvgPicture.asset(
                  'assets/icons/ic_fluent_thumb_like_24_regular.svg',
                  color: CstColors.a,
                )),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _getButtonBackround(Widget child) {
    return Container(
      height: 37,
      decoration: BoxDecoration(
          color: Colors.grey.shade300, borderRadius: BorderRadius.circular(20)),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      alignment: Alignment.center,
      child: child,
    );
  }
}
