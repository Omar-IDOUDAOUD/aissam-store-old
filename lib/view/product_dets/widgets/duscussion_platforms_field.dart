import 'package:aissam_store/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class DiscussionPlatforms extends StatefulWidget {
  const DiscussionPlatforms({super.key});

  @override
  State<DiscussionPlatforms> createState() => _DiscussionPlatformsState();
}

class _DiscussionPlatformsState extends State<DiscussionPlatforms> {
  // late final AnimationController _animationController;
  // late final Animation<double> _animation;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   _animationController =
  //       AnimationController(vsync: this, duration: 300.milliseconds);
  //   _animation =
  //       Tween<double>(begin: 0.0, end: (_buttonChildHeight + 30) * 4 + (7 * 3))
  //           .animate(_animationController);
  // }

  bool _showPlatforms = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          child: _buttonBackround(
            Row(
              children: [
                Text(
                  'Discussion platforms',
                  style: Get.textTheme.bodyLarge!.copyWith(
                    color: CstColors.a,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Spacer(),
                SvgPicture.asset(
                  'assets/icons/discussion_platforms.svg',
                ),
                SizedBox(width: 4),
                Icon(
                  _showPlatforms
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.keyboard_arrow_down_rounded,
                  size: 25,
                  color: CstColors.a,
                ),
              ],
            ),
          ),
          onTap: () {
            // if (_animationController.status == AnimationStatus.completed)
            //   _animationController.reverse();
            // else
            //   _animationController.forward();
            setState(() {
              _showPlatforms = !_showPlatforms;
            });
          },
        ),
        if (_showPlatforms)
          Column(
            children: List.generate(
              4,
              (index) => Padding(
                padding: EdgeInsets.only(top: 7),
                child: _buttonBackround(
                  index == 0
                      ? _aPlatformButtonChild(
                          'assets/icons/whatsapp_logo.svg',
                          'Whatsapp',
                          'open',
                        )
                      : index == 1
                          ? _aPlatformButtonChild(
                              'assets/icons/facebook_messenger_logo.svg',
                              'Facebook Messenger',
                              'open',
                            )
                          : index == 2
                              ? _aPlatformButtonChild(
                                  'assets/icons/Instagram_logo.svg',
                                  'Instagram',
                                  'open',
                                )
                              : _aPlatformButtonChild(
                                  'assets/icons/phone_app_logo.svg',
                                  'Phone call',
                                  'call',
                                ),
                ),
              ),
            ),
          )
      ],
    );
  }

  _aPlatformButtonChild(String logoPath, String name, String actionLabem) {
    return Row(
      children: [
        // SvgPicture.asset(
        //   logoPath,
        //   width: 20,
        // ),
        CircleAvatar(
          radius: 12,
          backgroundColor: Colors.purple,
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          name,
          style: Get.textTheme.bodyLarge!
              .copyWith(color: CstColors.a, fontWeight: FontWeight.w400),
        ),
        Spacer(),
        Text(
          actionLabem,
          style: Get.textTheme.bodyLarge!
              .copyWith(color: CstColors.b, fontWeight: FontWeight.w400),
        ),
        SizedBox(
          width: 7,
        ),
        SvgPicture.asset(
          'assets/icons/ic_fluent_open_24_regular.svg',
          height: 20,
          color: CstColors.b,
        )
      ],
    );
  }

  // final double _buttonChildHeight = 50;
  _buttonBackround(Widget child) {
    return DecoratedBox(
      decoration: BoxDecoration(
          color: Colors.grey.shade300, borderRadius: BorderRadius.circular(13)),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        child: child,
      ),
    );
  }
}
