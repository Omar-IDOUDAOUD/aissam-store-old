import 'package:aissam_store/core/constants/colors.dart';
import 'package:aissam_store/view/onboarding/greeting/widgets/lang_drop_down_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class LangSelectButton extends StatefulWidget {
  const LangSelectButton({super.key});

  @override
  State<LangSelectButton> createState() => _LangSelectButtonState();
}

class _LangSelectButtonState extends State<LangSelectButton> {
  GlobalKey _langSelectionWidgetKey = GlobalKey();
  bool _showButtonChild = true;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _showButtonChild = false;
        });
        Navigator.push(
          context,
          PageRouteBuilder(
            barrierColor: Colors.black.withOpacity(.5),
            barrierDismissible: true,
            transitionDuration: 300.milliseconds,
            reverseTransitionDuration: 300.milliseconds,
            pageBuilder: (_, a1, a2) {
              return FadeTransition(
                opacity: a1,
                child: LangDropdownMenu(
                  activeLang: 1,
                  dropdownButtonKey: _langSelectionWidgetKey,
                  langs: List.generate(5, (index) => 'index: $index'),
                  onLangSelect: () {},
                  dispose: () {
                    50.milliseconds.delay(() {
                      setState(() {
                        _showButtonChild = true;
                      });
                    });
                  },
                ),
              );
            },
            opaque: false,
          ),
        );
        // Get.to(
        //   LangDropdownMenu(
        //     activeLang: 1,
        //     dropdownButtonKey: _langSelectionWidgetKey,
        //     langs: List.generate(5, (index) => 'index: $index'),
        //     onLangSelect: () {},
        //   ),
        //   transition: Transition.fade,
        //   opaque: false,
        //   routeName: 'select language',
        // );
        // Get.dialog(
        //   LangDropdownMenu(
        //     activeLang: 1,
        //     dropdownButtonKey: _langSelectionWidgetKey,
        //     langs: List.generate(5, (index) => 'index: $index'),
        //     onLangSelect: () {},
        //   ),
        // );
      },
      child: Stack(
        fit: StackFit.loose,
        children: [
          Positioned.fill(
            child: Hero(
              tag: 'menu-container',
              child: DecoratedBox(
                key: _langSelectionWidgetKey,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Visibility(
            maintainState: true,
            maintainAnimation: true,
            maintainSize: true,
            visible: _showButtonChild,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 30,
                    height: 22,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(3),
                      child: SvgPicture.asset(
                        'assets/icons/countries_flags/us.svg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 7),
                  Text(
                    'English',
                    style: Get.textTheme.bodyMedium!
                        .copyWith(color: ColorsConsts.c),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
