import 'package:aissam_store/core/constants/colors.dart';
import 'package:aissam_store/services/auth/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Header extends StatelessWidget {
  Header({Key? key}) : super(key: key);

  final AuthenticationService _authenticationService =
      AuthenticationService.instance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(
            'assets/icons/search_small.svg',
            height: 28,
          ),
          GestureDetector(
            child: AissamLogo(),
            onTap: () async {
              await _authenticationService.signOut();
              Get.offAllNamed('/onboarding/greeting');
            },
          ),
          // SvgPicture.asset('assets/icons/menu_vertical.svg'),
          Stack(
            alignment: Alignment.bottomRight,
            clipBehavior: Clip.none,
            children: [
              SvgPicture.asset(
                'assets/icons/ic_fluent_alert_24_regular.svg',
                height: 25,
              ),
              Positioned(
                bottom: 0,
                right: -3.0 * _notificationsNumber.length,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.lerp(Colors.pink.shade100, Colors.white, 0.4),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(right: 4, left: 4, top: 1),
                    child: Text(
                      _notificationsNumber,
                      style: Get.textTheme.displaySmall!.copyWith(
                        color: Colors.pinkAccent,
                        fontWeight: FontWeight.bold,
                        // height: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  final _notificationsNumber = '3';
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
            style: Get.textTheme.headlineMedium!.copyWith(
              fontWeight: FontWeight.w600,
              height: 1,
              fontSize: 20,
            ),
          ),
          TextSpan(
              text: ' STORE\n',
              style: Get.textTheme.headlineMedium!.copyWith(
                fontWeight: FontWeight.w300,
                height: 1,
                fontSize: 20,
              )),
          TextSpan(
            text: "FOR WOMEN'S CLOTHING",
            style: Get.textTheme.headlineMedium!.copyWith(
                fontWeight: FontWeight.w400,
                color: CstColors.a,
                letterSpacing: 0.5,
                height: 1.3,
                fontSize: 11),
          ),
        ],
      ),
    );
  }
}
