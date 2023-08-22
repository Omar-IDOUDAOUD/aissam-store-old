import 'dart:math';

import 'package:aissam_store/controller/user.dart';
import 'package:aissam_store/core/constants/colors.dart';
import 'package:aissam_store/models/user.dart';
import 'package:aissam_store/services/auth/auth_result.dart';
import 'package:aissam_store/services/auth/authentication.dart';
import 'package:aissam_store/view/auth/widgets/phone_number_field.dart';
import 'package:aissam_store/view/auth/widgets/sign_in_tab_fields.dart';
import 'package:aissam_store/view/auth/widgets/sign_up_tab_field.dart';
import 'package:aissam_store/view/public/button.dart';
import 'package:aissam_store/view/public/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AthenticationStatePage();
}

class _AthenticationStatePage extends State<AuthenticationPage>
    with SingleTickerProviderStateMixin {
  bool _isRegistering = true;

  late final TabController _controller;
  late final TextEditingController _emailController,
      _passwordController,
      _phoneNumberController;

  final AuthenticationService _authService = AuthenticationService.instance;
  AuthResult _authResult = AuthResult();
  bool _waitingResponsLoading = false;

  Future<void> _onSignUpButton() async {
    _authResult = AuthResult();
    setState(() {
      _waitingResponsLoading = true;
    });

    _authResult = await _authService.registerWithEmailAndPassword(
        _emailController.text, _passwordController.text);
    print('success: ${_authResult.success}');
    print('message ${_authResult.message}');
    print('email error: ${_authResult.emailWrongMsg}');
    print('pass error: ${_authResult.passwordWrongMsg}');
    if (_authResult.success) print('user id: ${_authResult.user!.user!.uid}');
    setState(() {
      _waitingResponsLoading = false;
    });
    if (_authResult.success) {
      await 100.milliseconds.delay();
      Get.toNamed('/onboarding/user_info_setting');
    }
  }

  Future<void> _onSignInButton() async {
    _authResult = AuthResult();

    setState(() {
      _waitingResponsLoading = true;
    });
    // await 2.seconds.delay();
    _authResult = await _authService.signInWithEmailAndPassword(
        _emailController.text, _passwordController.text);
    print('success: ${_authResult.success}');
    print('message ${_authResult.message}');
    print('email error: ${_authResult.emailWrongMsg}');
    print('pass error: ${_authResult.passwordWrongMsg}');
    if (_authResult.success) print('user id: ${_authResult.user!.user!.uid}');
    setState(() {
      _waitingResponsLoading = false;
    });
    if (_authResult.success) {
      await 100.milliseconds.delay();
      Get.toNamed('/');
    }
  }

  Future<void> _onSignInWithGoogle() async {
    final UserController _userController = UserController.instance;

    _authResult = AuthResult();

    // await 2.seconds.delay();
    _authResult = await _authService.signInWithGoogle();
    print('success: ${_authResult.success}');
    print('message ${_authResult.message}');
    print('email error: ${_authResult.emailWrongMsg}');
    print('pass error: ${_authResult.passwordWrongMsg}');
    if (_authResult.success) print('user id: ${_authResult.user!.user!.email}');
    if (await _userController.checkUserExistence()) {
      setState(() {});
      await 100.milliseconds.delay();
      Get.toNamed('/');
    } else {
      setState(() {});
      await 100.milliseconds.delay();
      Get.toNamed('/onboarding/user_info_setting');
     
    }
  }

  // _onSignOut() {
  //   _authService.signOut();
  // }

  @override
  void initState() {
    // TODO: implement initState

    _emailController = TextEditingController(text: 'omar@omar.omar');
    _passwordController = TextEditingController(text: 'omaromar');
    _phoneNumberController = TextEditingController();

    _controller = TabController(length: 2, vsync: this)
      ..addListener(() {
        _isRegistering = _controller.index == 0;
        if (_isRegistering && _controller.previousIndex == 1 ||
            !_isRegistering && _controller.previousIndex == 0) {
          setState(() {});
        }
      });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: DecoratedBox(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey.shade200),
              child: TabBar(
                controller: _controller,
                labelStyle: Get.textTheme.bodySmall,
                unselectedLabelStyle: Get.textTheme.bodySmall,
                labelColor: Colors.white,
                unselectedLabelColor: CstColors.a,
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: CstColors.a,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black87.withOpacity(.2),
                        offset: Offset(0, 5),
                        blurRadius: 15,
                      )
                    ]),
                tabs: [
                  Tab(
                    height: 50,
                    text: 'Register',
                  ),
                  Tab(
                    text: 'Sign in',
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          AnimatedSize(
            alignment: Alignment.topCenter,
            duration: 200.milliseconds,
            child: AnimatedSwitcher(
              duration: 200.milliseconds,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                key: ValueKey(_isRegistering),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Text(
                          _isRegistering ? 'Create Accaount' : 'Welcom back.',
                          textAlign: TextAlign.center,
                          style: Get.textTheme.headlineMedium!.copyWith(
                            color: CstColors.a,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          _isRegistering
                              ? 'sing up now and start exploring all that our app has to offer.'
                              : "We're excited to have you here again!",
                          textAlign: TextAlign.center,
                          style: Get.textTheme.bodyLarge!.copyWith(
                            color: CstColors.c,
                            fontWeight: FontWeight.w400,
                            height: 1.3,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              transitionBuilder: (c, a) {
                return SlideTransition(
                  position: Tween<Offset>(
                          begin:
                              Offset(c.key == ValueKey(true) ? -0.1 : 0.1, 0),
                          end: Offset.zero)
                      .animate(a),
                  child: FadeTransition(
                    opacity: a,
                    child: c,
                  ),
                );
              },
              layoutBuilder:
                  (Widget? currentChild, List<Widget> previousChildren) {
                return Stack(
                  alignment: Alignment.topCenter,
                  children: <Widget>[
                    ...previousChildren,
                    if (currentChild != null) currentChild,
                  ],
                );
              },
            ),
          ),
          SizedBox(
            height: 5,
          ),

          SizedBox(height: 20),
          AnimatedSize(
            alignment: Alignment.topCenter,
            duration: 200.milliseconds,
            child: SizedBox(
              height: _controller.index == 0 ? 200 : 130,
              child: TabBarView(
                clipBehavior: Clip.none,
                controller: _controller,
                children: [
                  SingleChildScrollView(
                    clipBehavior: Clip.none,
                    physics: NeverScrollableScrollPhysics(),
                    child: SignUpTabFields(
                      authResult: _authResult,
                      emailC: _emailController,
                      phoneNumberC: _phoneNumberController,
                      passwordC: _passwordController,
                    ),
                  ),
                  SignInTabFields(
                    authResult: _authResult,
                    emailC: _emailController,
                    passwordC: _passwordController,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          if (_authResult.success) Text(_authResult.message ?? 'no message'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                Button(
                  onPressed: _isRegistering ? _onSignUpButton : _onSignInButton,
                  isHeightMinimize: true,
                  child: Center(
                      child: _waitingResponsLoading
                          ? CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            )
                          : _authResult.success
                              ? SvgPicture.asset(
                                  'assets/icons/ic_fluent_checkmark_24_filled.svg',
                                  color: Colors.white,
                                )
                              : Text(
                                  'Register',
                                  style: Get.textTheme.bodyMedium!.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )),
                ),
                SizedBox(
                  height: 10,
                ),
                Button(
                  onPressed: () {
                    _onSignInWithGoogle();
                  },
                  isHeightMinimize: true,
                  isOutline: true,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        'Sign Up With Google',
                        style: Get.textTheme.bodyMedium!.copyWith(
                          color: CstColors.a,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 1,
                      width: 40,
                      child: ColoredBox(color: CstColors.c),
                    ),
                    SizedBox(width: 5),
                    Text('Other Sign Up Methods',
                        style: Get.textTheme.displayLarge!.copyWith(
                          fontWeight: FontWeight.w400,
                          color: CstColors.c,
                        )),
                    SizedBox(width: 5),
                    SizedBox(
                      height: 1,
                      width: 40,
                      child: ColoredBox(color: CstColors.c),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _singUpMethodSquare('assets/icons/facebook-logo.svg'),
                    SizedBox(width: 7),
                    _singUpMethodSquare('assets/icons/twitter-logo.svg'),
                  ],
                ),
              ],
            ),
          ),
          // Spacer(),
          Spacer(),
          SizedBox(
            height: 40,
            child: Center(
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: 'You have an accaount ? ',
                    style: Get.textTheme.bodySmall!.copyWith(
                      // fontWeight: FontWeight.w400,
                      color: CstColors.c,
                    ),
                  ),
                  TextSpan(
                    text: 'Log-In',
                    style: Get.textTheme.bodySmall!.copyWith(
                      // fontWeight: FontWeight.w400,
                      color: CstColors.a,
                      decoration: TextDecoration.underline,
                    ),
                  )
                ]),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

  Widget _singUpMethodSquare(String companyLogoPath) {
    return GestureDetector(
      // onTap: _onSignOut,
      child: SizedBox.square(
        dimension: 53,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.blue.shade100.withOpacity(.5),
            borderRadius: BorderRadius.circular(11),
          ),
          child: SvgPicture.asset(
            companyLogoPath,
            height: 25,
            width: 25,
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
    );
  }
}
