import 'package:aissam_store/core/constants/colors.dart';
import 'package:aissam_store/view/onboarding/greeting/widgets/button.dart';
import 'package:aissam_store/view/onboarding/greeting/widgets/lang_drop_down_menu.dart';
import 'package:aissam_store/view/onboarding/greeting/widgets/lang_select_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class OnBoardingGreetingPage extends StatefulWidget {
  const OnBoardingGreetingPage({super.key});

  @override
  State<OnBoardingGreetingPage> createState() => _OnBoardingGreetingPageState();
}

class _OnBoardingGreetingPageState extends State<OnBoardingGreetingPage> {
  // final List<Map<String, String>> _langs =  [
  //   {
  //     'language' : 'Arabic',
  //     ''
  //   }
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/onboarding_backround.png',
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                LangSelectButton(),
                Spacer(),
                Text(
                  'Welcom Ladie',
                  style: Get.textTheme.headlineLarge!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Discover Modest Fashion For Every Moment!',
                  textAlign: TextAlign.center,
                  style: Get.textTheme.headlineMedium!.copyWith(
                    color: Colors.grey.shade300,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                CustomButton(
                    primaryButton: true,
                    iconPath: 'assets/icons/google-logo.svg',
                    label: 'Continue Using\nGoogle'),
                SizedBox(height: 15),
                CustomButton(
                  iconPath: 'assets/icons/facebook-logo.svg',
                  label: 'Continue Using\nFacebook',
                  labelColor: Colors.blue.shade900,
                  backroundColor: Colors.blue.shade100,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 1,
                          child: ColoredBox(color: Colors.grey.shade200),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'Or Continue With',
                          style: Get.textTheme.bodyMedium!.copyWith(
                            color: Colors.grey.shade200,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 1,
                          child: ColoredBox(color: Colors.grey.shade200),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        smallWidthButton: true,
                        iconPath: 'assets/icons/ic_fluent_mail_24_filled.svg',
                        label: 'Email',
                        labelColor: Colors.green.shade900,
                        iconColor: Colors.green.shade900,
                        backroundColor: Colors.green.shade100,
                        onTap: () {
                          Navigator.pushNamed(context, '/authentication');
                        },
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: CustomButton(
                        smallWidthButton: true,
                        iconPath: 'assets/icons/ic_fluent_emoji_24_filled.svg',
                        label: 'Guest\nAccount',
                        labelColor: Colors.orange.shade900,
                        iconColor: Colors.orange.shade900,
                        backroundColor: Colors.orange.shade100,
                      ),
                    ),
                  ],
                ),
                // Spacer(),
                SizedBox(height: 40),
                Text(
                  'Go next and find yourself!',
                  style: Get.textTheme.headlineSmall!.copyWith(
                    color: Colors.grey.shade200,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                // SizedBox(height: 30,)
                // Spacer(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
