import 'package:aissam_store/controller/user.dart';
import 'package:aissam_store/core/constants/colors.dart';
import 'package:aissam_store/services/auth/auth_result.dart';
import 'package:aissam_store/services/auth/authentication.dart';
import 'package:aissam_store/view/auth/widgets/sign_in_tab_fields.dart';
import 'package:aissam_store/view/auth/widgets/sign_up_tab_field.dart';
import 'package:aissam_store/view/public/button.dart';
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
  bool _emailSignInLoading = false;
  bool _googleSignInLoading = false;
  bool _canRequestSignInButton = true;

  Future<void> _goNextPage([bool needEmailVerification = false]) async {
    await 1.seconds.delay();
    Get.toNamed(needEmailVerification
        ? '/authentication/email_verification'
        : _authResult.needsFillUserInfoAfterAuth
            ? 'onboarding/user_info_customization'
            : '/');
  }

  ///SIGN IN
  Future<void> _onSignInButton() async {
    _authResult = AuthResult();

    setState(() {
      _emailSignInLoading = true;
      _canRequestSignInButton = false;
    });
    _authResult = await _authService.signInWithEmailAndPassword(
        _emailController.text, _passwordController.text);
    print('success: ${_authResult.success}');
    print('message ${_authResult.message}');
    print('email error: ${_authResult.emailWrongMsg}');
    print('pass error: ${_authResult.passwordWrongMsg}');
    setState(() {
      _emailSignInLoading = false;
      _canRequestSignInButton = true;
    });
    if (_authResult.success) {
      print('user id: ${_authResult.user!.user!.uid}');
      _goNextPage();
    }
  }

  ///SIGN UP
  Future<void> _onSignUpButton() async {
    _authResult = AuthResult();
    setState(() {
      _emailSignInLoading = true;
      _canRequestSignInButton = false;
    });
    // await 4.seconds.delay();
    _authResult = await _authService.registerWithEmailAndPassword(
        _emailController.text, _passwordController.text);
    print('success: ${_authResult.success}');
    print('message ${_authResult.message}');
    print('email error: ${_authResult.emailWrongMsg}');
    print('pass error: ${_authResult.passwordWrongMsg}');
    setState(() {
      _emailSignInLoading = false;
      _canRequestSignInButton = true;
    });
    if (_authResult.success) {
      print('user id: ${_authResult.user!.user!.uid}');
      _goNextPage(true);
    }
  }

  ///SIGN IN GOOGLE
  Future<void> _onSignInWithGoogle() async {
    _authResult = AuthResult();
    // await 2.seconds.delay();
    setState(() {
      _googleSignInLoading = true;
      _canRequestSignInButton = false;
    });
    _authResult = await _authService.signInWithGoogle();
    print('success: ${_authResult.success}');
    print('message ${_authResult.message}');
    print('email error: ${_authResult.emailWrongMsg}');
    print('pass error: ${_authResult.passwordWrongMsg}');
    setState(() {
      _googleSignInLoading = false;
      _canRequestSignInButton = true;
    });
    if (_authResult.success) {
      print('user id: ${_authResult.user!.user!.uid}');
      _goNextPage();
    }
  }

  @override
  void initState() {
    super.initState();
    // TODO: implement initState

    _emailController = TextEditingController(text: 'omar@omar.omar');
    _passwordController = TextEditingController(text: 'omaromar');
    _phoneNumberController = TextEditingController();

    _controller = TabController(length: 2, vsync: this);
    // ..addListener(() {
    //   print(_controller.index);

    //   _isRegistering = _controller.index == 0;
    //   if (_isRegistering && _controller.previousIndex == 1 ||
    //       !_isRegistering && _controller.previousIndex == 0) {
    //     setState(() {});
    //   }
    // });
    _controller.animation!.addListener(_pageDragHandler);
  }

  void _pageDragHandler() {
    if (_authResult.emailWrong ||
        _authResult.userNameWrong ||
        _authResult.passwordWrong ||
        _authResult.message != null) {
      setState(() {
        _authResult = AuthResult();
      });
    }
    if (_isRegistering && _controller.animation!.value > 0.5) {
      setState(() {
        _isRegistering = false;
      });
    } else if (!_isRegistering && _controller.animation!.value <= 0.5) {
      setState(() {
        _isRegistering = true;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    _phoneNumberController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(
        'rebuild widget******************************************************');
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
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
                      offset: const Offset(0, 5),
                      blurRadius: 15,
                    )
                  ],
                ),
                tabs: [
                  const Tab(
                    height: 50,
                    text: 'Register',
                  ),
                  const Tab(
                    text: 'Sign in',
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
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
                          begin: Offset(
                              c.key == const ValueKey(true) ? -0.1 : 0.1, 0),
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
          const SizedBox(
            height: 5,
          ),
          const SizedBox(height: 20),
          Expanded(
            child: TabBarView(
              clipBehavior: Clip.none,
              controller: _controller,
              children: [
                SignUpTabFields(
                  authResult: _authResult,
                  emailC: _emailController,
                  phoneNumberC: _phoneNumberController,
                  passwordC: _passwordController,
                ),
                SignInTabFields(
                  authResult: _authResult,
                  emailC: _emailController,
                  passwordC: _passwordController,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: AnimatedOpacity(
              duration: 300.milliseconds,
              opacity: _authResult.message != null ? 1 : 0,
              child: AnimatedScale(
                duration: 300.milliseconds,
                scale: _authResult.message != null ? 1 : 0.8,
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: _authResult.success
                        ? Colors.green.withOpacity(.2)
                        : Colors.red.withOpacity(.2),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        _authResult.success ? Icons.check_rounded : Icons.info,
                        size: 15,
                        color: _authResult.success
                            ? Colors.green
                            : Colors.redAccent,
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          _authResult.message ?? '',
                          style: Get.textTheme.bodyMedium!.copyWith(
                            color: _authResult.success
                                ? Colors.green
                                : Colors.redAccent,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                Button(
                  enabled: _canRequestSignInButton &&
                      !_emailSignInLoading &&
                      !_authResult.success,
                  onPressed: _isRegistering ? _onSignUpButton : _onSignInButton,
                  isHeightMinimize: true,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox.square(
                        dimension: 30,
                      ),
                      Text(
                        _isRegistering ? 'Register' : 'Log-in',
                        style: Get.textTheme.bodyMedium!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      AnimatedSwitcher(
                        duration: 300.milliseconds,
                        switchInCurve: Curves.linearToEaseOut,
                        switchOutCurve: Curves.linearToEaseOut,
                        child: SizedBox.square(
                          key: ValueKey(_emailSignInLoading),
                          dimension: 25,
                          child: _emailSignInLoading
                              ? CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                )
                              : SvgPicture.asset(
                                  'assets/icons/arrow_right_shorter.svg',
                                  color: Colors.white,
                                ),
                        ),
                        transitionBuilder: (c, a) {
                          return ScaleTransition(
                            scale: a,
                            child: FadeTransition(
                              opacity: a,
                              child: c,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
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
                    const SizedBox(width: 10),
                    Text('Other Sign Up Methods',
                        style: Get.textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.w400,
                          color: CstColors.c,
                        )),
                    const SizedBox(width: 10),
                    SizedBox(
                      height: 1,
                      width: 40,
                      child: ColoredBox(color: CstColors.c),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _singUpMethodSquare(
                      _googleSignInLoading
                          ? CircularProgressIndicator(
                              color: Colors.green.shade700,
                              strokeWidth: 2,
                            )
                          : SvgPicture.asset(
                              'assets/icons/google-logo.svg',
                              height: 28,
                              width: 28,
                              fit: BoxFit.scaleDown,
                              color: Colors.green.shade700,
                            ),
                      Colors.green,
                      _canRequestSignInButton ? _onSignInWithGoogle : null,
                    ),
                    const SizedBox(width: 7),
                    _singUpMethodSquare(
                      SvgPicture.asset(
                        'assets/icons/facebook-logo.svg',
                        height: 23,
                        width: 23,
                        fit: BoxFit.scaleDown,
                      ),
                      Colors.blue,
                    ),
                    const SizedBox(width: 7),
                    SizedBox(
                      width: 1,
                      height: 15,
                      child: ColoredBox(color: CstColors.b),
                    ),
                    const SizedBox(width: 7),
                    _singUpMethodSquare(
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/ic_fluent_emoji_24_filled.svg',
                              height: 28,
                              width: 28,
                              fit: BoxFit.scaleDown,
                              color: Colors.orangeAccent.shade200,
                            ),
                            const SizedBox(width: 7),
                            Text(
                              'Guest',
                              textAlign: TextAlign.center,
                              style: Get.textTheme.bodyMedium!.copyWith(
                                // height: 1.2,
                                color: Colors.orangeAccent.shade200,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Colors.orange,
                    ),
                  ],
                ),
              ],
            ),
          ),
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
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

  Widget _singUpMethodSquare(Widget child, Color color, [Function()? onTap]) {
    return GestureDetector(
      onTap: onTap,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minHeight: 53,
          minWidth: 53,
        ),
        child: DecoratedBox(
            decoration: BoxDecoration(
              color: color.withOpacity(.2),
              borderRadius: BorderRadius.circular(11),
            ),
            child: Center(child: child)),
      ),
    );
  }
}
