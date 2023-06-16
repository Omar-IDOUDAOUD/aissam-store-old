import 'package:aissam_store/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';






class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset('assets/icons/search_small.svg'),
          AissamLogo(),
          SvgPicture.asset('assets/icons/menu_vertical.svg'),
        ],
      ),
    );
  }
}

class AissamLogo extends StatelessWidget {
  const AissamLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: 'AISSAM',
            style: Get.textTheme.headline2!.copyWith(
              fontWeight: FontWeight.w600,
              height: 1,
            ),
          ),
          TextSpan(
              text: ' STORE\n',
              style: Get.textTheme.headline2!
                  .copyWith(fontWeight: FontWeight.w400, height: 1)),
          TextSpan(
            text: "FOR WOMEN'S CLOTHING",
            style: Get.textTheme.headline5!.copyWith(
                fontWeight: FontWeight.w400,
                color: CstColors.a,
                letterSpacing: 0.5,
                height: 1.3),
          ),
        ],
      ),
    );
  }
}
