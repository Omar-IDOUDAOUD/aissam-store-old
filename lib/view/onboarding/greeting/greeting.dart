import 'package:aissam_store/core/constants/colors.dart';
import 'package:aissam_store/services/auth/auth_result.dart';
import 'package:aissam_store/services/auth/authentication.dart';
import 'package:aissam_store/view/onboarding/greeting/widgets/button.dart';
import 'package:aissam_store/view/onboarding/greeting/widgets/lang_select_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingGreetingPage extends StatefulWidget {
  const OnBoardingGreetingPage({super.key});

  @override
  State<OnBoardingGreetingPage> createState() => _OnBoardingGreetingPageState();
}

class _OnBoardingGreetingPageState extends State<OnBoardingGreetingPage> {
  final AuthenticationService _authenticationService =
      AuthenticationService.instance;

  SignInButtonState _signInGoogleState = SignInButtonState.noState;
  SignInButtonState _signInFacebookState = SignInButtonState.noState;
  SignInButtonState _signInAnonymousState = SignInButtonState.noState;

  // Future<bool> _onSignIn(Future<AuthResult> Function() provider) async {

  // }

  void _showFailSnackBar(String errorMessage) {
    Get.showSnackbar(
      GetSnackBar(
        snackPosition: SnackPosition.TOP,
        titleText: Text(
          'Google Sign In Failed!',
          style: Get.textTheme.bodyLarge!.copyWith(
            color: Colors.white,
            height: 1.1,
          ),
        ),
        messageText: Text(
          errorMessage,
          style: Get.textTheme.bodySmall!.copyWith(
            color: Colors.white.withOpacity(.5),
            height: 1.1,
          ),
        ),
        backgroundColor: CstColors.a,
        margin: const EdgeInsets.all(25),
        borderRadius: 10,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        duration: 2.seconds,
        shouldIconPulse: false,
        icon: const Icon(
          Icons.info,
          color: Colors.white,
        ),
      ),
    );
  }

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
                const LangSelectButton(),
                const Spacer(),
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
                const Spacer(),
                CustomButton(
                  state: _signInGoogleState,
                  onTap: () async {
                    setState(() {
                      _signInGoogleState = SignInButtonState.loading;
                    });
                    final AuthResult response =
                        await _authenticationService.signInWithGoogle();
                    setState(() {
                      _signInGoogleState = response.success
                          ? SignInButtonState.success
                          : SignInButtonState.fail;
                    });
                    if (response.success) {
                      await 1.seconds.delay();
                      Get.toNamed('/onboarding/user_info_customization');
                    } else {
                      _showFailSnackBar(response.message!);
                    }
                  },
                  primaryButton: true,
                  iconPath: 'assets/icons/google-logo.svg',
                  label: 'Continue Using\nGoogle',
                ),
                const SizedBox(height: 15),
                CustomButton(
                  state: _signInFacebookState,
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
                        padding: const EdgeInsets.symmetric(horizontal: 10),
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
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: CustomButton(
                        // isLoading:
                        // _signInFacebookState == SignInButtonState.loading,
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
                const SizedBox(height: 40),
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
