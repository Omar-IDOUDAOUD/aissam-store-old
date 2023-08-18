import 'dart:math';

import 'package:aissam_store/core/constants/colors.dart';
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

  bool _listenToTabCtrl = true;
  @override
  void initState() {
    // TODO: implement initState
    _controller = TabController(length: 2, vsync: this)
      ..addListener(() {
        // if (_listenToTabCtrl) {
        //   print('hhhhhhhh');
        //   _listenToTabCtrl = false;
        //   setState(() {});
        // } else
        //   _listenToTabCtrl = true;
        _isRegistering = _controller.index == 0;
        if (_isRegistering && _controller.previousIndex == 1 ||
            !_isRegistering && _controller.previousIndex == 0) {
          print('hhhhhhhh');
          setState(() {});
        }
      });
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35),
                      child: Column(
                        children: [
                          _getEmailTextField(),
                          SizedBox(height: 10),
                          _PhoneNumberTextField(),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: _getPasswordTextField(),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              _getFingerprintPasswordButton(),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: Column(
                      children: [
                        _getEmailTextField(),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: _getPasswordTextField(),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            _getFingerprintPasswordButton(),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                Button(
                  isHeightMinimize: true,
                  child: Center(
                    child: Text(
                      'Register',
                      style: Get.textTheme.bodyMedium!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Button(
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
                    _singUpMethodSquare(''),
                    SizedBox(width: 7),
                    _singUpMethodSquare(''),
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
    return SizedBox.square(
      dimension: 53,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.blue.shade100.withOpacity(.5),
          borderRadius: BorderRadius.circular(11),
        ),
        child: SvgPicture.asset(companyLogoPath),
      ),
    );
  }

  Widget _getEmailTextField() {
    return TextField(
      decoration: InputDecoration(
        hintStyle: Get.textTheme.bodyLarge!.copyWith(
          color: CstColors.b,
          fontWeight: FontWeight.w400,
          height: 1.6,
        ),
        hintText: 'You Email Address',
        contentPadding: EdgeInsets.all(20),
        filled: true,
        fillColor: Colors.grey.shade200,
        focusColor: Colors.grey.shade400,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: CstColors.b.withOpacity(.5), width: 4),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  // Widget _getPhoneNumberTextField() {
  //   return SizedBox(
  //     // height: 70,
  //     child:
  //   );
  // }

  bool? _obscurePassword = false;
  Widget _getPasswordTextField() {
    return TextField(
      style: Get.textTheme.bodyLarge!.copyWith(
        color: CstColors.a,
        fontWeight: FontWeight.w400,
        height: 1.6,
      ),
      onChanged: (v) {
        setState(() {
          if (v.isEmpty)
            _obscurePassword = null;
          else
            _obscurePassword = false;
        });
      },
      obscureText: _obscurePassword ?? false,
      decoration: InputDecoration(
        hintStyle: Get.textTheme.bodyLarge!.copyWith(
          color: CstColors.b,
          fontWeight: FontWeight.w400,
          height: 1.6,
        ),
        suffixIcon: _obscurePassword != null
            ? GestureDetector(
                onTap: () => setState(() {
                  _obscurePassword = !_obscurePassword!;
                }),
                child: Icon(
                  _obscurePassword!
                      ? CupertinoIcons.eye
                      : CupertinoIcons.eye_slash,
                  color: CstColors.c,
                  size: 20,
                ),
              )
            : null,
        hintText: 'Password',
        contentPadding: EdgeInsets.all(20),
        filled: true,
        fillColor: Colors.grey.shade200,
        focusColor: Colors.grey.shade400,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: CstColors.b.withOpacity(.5), width: 4),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _getFingerprintPasswordButton() {
    return SizedBox.square(
      dimension: 56,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: SvgPicture.asset(
          'assets/icons/fingerprint-icon.svg',
        ),
      ),
    );
  }
}

class _PhoneNumberTextField extends StatefulWidget {
  const _PhoneNumberTextField({super.key});

  @override
  State<_PhoneNumberTextField> createState() => _PhoneNumberTextFieldState();
}

class _PhoneNumberTextFieldState extends State<_PhoneNumberTextField> {
  GlobalKey _key = GlobalKey();

  int _selectedColors = 0;

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: _key,
      style: Get.textTheme.bodyLarge!.copyWith(
        color: CstColors.a,
        fontWeight: FontWeight.w400,
        height: 1.6,
      ),
      decoration: InputDecoration(
        suffixIcon: GestureDetector(
          onTap: () {
            Get.dialog(
              _ColorDropdownMenu(
                onAddColor: () {
                  setState(() {
                    _selectedColors++;
                    print('----------------,$_selectedColors ');
                  });
                },
                dropdownButtonKey: _key,
                colorsNames: [
                  'red',
                  'blue',
                  'red',
                  'red',
                  'blue',
                ],
                colors: [Colors.red, Colors.blue, Colors.red, Colors.blue],
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.only(right: 15),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(width: 5),
                SizedBox(
                  width: 1,
                  height: 15,
                  child: ColoredBox(color: Colors.grey.shade500),
                ),
                SizedBox(width: 10),
                SizedBox(
                  height: 20,
                  width: 30,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: ColoredBox(color: Colors.redAccent),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Icon(
                  CupertinoIcons.chevron_down,
                  size: 15,
                  color: CstColors.a,
                ),
              ],
            ),
          ),
        ),
        hintStyle: Get.textTheme.bodyLarge!.copyWith(
          color: CstColors.b,
          fontWeight: FontWeight.w400,
          height: 1.6,
        ),
        hintText: 'Phone Number',
        contentPadding: EdgeInsets.all(20),
        filled: true,
        fillColor: Colors.grey.shade200,
        focusColor: Colors.grey.shade400,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: CstColors.b.withOpacity(.5), width: 4),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}

class _ColorDropdownMenu extends StatefulWidget {
  const _ColorDropdownMenu({
    super.key,
    required this.colorsNames,
    required this.colors,
    required this.dropdownButtonKey,
    required this.onAddColor,
  });
  final List<String> colorsNames;
  final List<Color> colors;
  final GlobalKey dropdownButtonKey;
  final Function() onAddColor;

  @override
  State<_ColorDropdownMenu> createState() => _ColorDropdownMenuState();
}

class _ColorDropdownMenuState extends State<_ColorDropdownMenu> {
  final _padding = 25.0;
  final _screenSize = Get.size;
  final _searchFieldItemHeight = 50.0;
  final _itemHeight = 45.0;

  bool _expandAnimation = false;

  Size? _menuInitSize;
  Offset? _menuInitOffset;

  @override
  void initState() {
    super.initState();
    // TODO: implement initState

    _setMenuInitialSize();
    _setMenuInitialOffset();
    _setOpenDirection();

    100.milliseconds.delay().then((value) => setState(() {
          _expandAnimation = true;
        }));
  }

  _setOpenDirection() {
    if (_menuInitOffset!.dy + (_menuInitSize!.height / 2) >=
        _screenSize.height * .5) {
      _openToTop = true;
    } else {
      _openToTop = false;
    }
  }

  bool _openToTop = false;

  double get _getMenuExpandHeight {
    late double h;
    final double totalMenuItemsHeight =
        widget.colorsNames.length * _itemHeight + _searchFieldItemHeight;
    if (_openToTop) {
      h = min(totalMenuItemsHeight,
              _menuInitOffset!.dy + _menuInitSize!.height - _padding) +
          5; //5 to add an inside padding to the end of the dialog box;
    } else {
      h = min(totalMenuItemsHeight,
              _screenSize.height - _menuInitOffset!.dy - _padding) +
          5;
    }
    return h;
  }

  double get _getMenuInitHeight => _menuInitSize!.height;

  Size _setMenuInitialSize() {
    if (_menuInitSize != null) return _menuInitSize!;
    final RenderBox renderBox = widget.dropdownButtonKey.currentContext
        ?.findRenderObject() as RenderBox;

    _menuInitSize = renderBox.size;

    return _menuInitSize!;
  }

  Offset _setMenuInitialOffset() {
    if (_menuInitOffset != null) return _menuInitOffset!;
    final RenderBox renderBox = widget.dropdownButtonKey.currentContext
        ?.findRenderObject() as RenderBox;
    _menuInitOffset = renderBox.localToGlobal(Offset.zero);
    return _menuInitOffset!;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        AnimatedPositioned(
          curve: Curves.linearToEaseOut,
          top: !_openToTop ? _menuInitOffset!.dy : null,
          bottom: _openToTop
              ? _screenSize.height - _menuInitOffset!.dy - _menuInitSize!.height
              : null,
          left: _menuInitOffset!.dx,
          width: _menuInitSize!.width,
          height: _expandAnimation ? _getMenuExpandHeight : _getMenuInitHeight,
          duration: 200.milliseconds,
          child: Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: _searchFieldItemHeight,
                    child: TextField(
                      style: Get.textTheme.bodyLarge!.copyWith(
                        color: CstColors.a,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Search color',
                        hintStyle: Get.textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.normal,
                          color: CstColors.c,
                        ),
                        border: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: CstColors.b, width: 1.5),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: CstColors.a, width: 1.5),
                        ),
                        prefixIconConstraints: const BoxConstraints(
                          maxWidth: 25,
                          maxHeight: 20,
                        ),
                        prefixIcon: SvgPicture.asset(
                          'assets/icons/search_small.svg',
                          color: CstColors.c,
                          alignment: Alignment.centerLeft,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      // padding: EdgeInsets.only(bottom: 5),
                      itemCount: widget.colorsNames.length,
                      itemBuilder: (_, i) => SizedBox(
                        height: _itemHeight,
                        child: _colorMenuItem(
                          onAddColor: widget.onAddColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _colorMenuItem extends StatefulWidget {
  const _colorMenuItem({super.key, required this.onAddColor});
  final Function() onAddColor;

  @override
  State<_colorMenuItem> createState() => __colorMenuItemState();
}

class __colorMenuItemState extends State<_colorMenuItem> {
  bool _selected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selected = !_selected;
          widget.onAddColor();
        });
      },
      child: Row(
        children: [
          SizedBox.square(
            dimension: 20,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: Colors.red,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Charcoal',
                    style: Get.textTheme.bodyLarge!.copyWith(
                      color: CstColors.a,
                      fontWeight: FontWeight.normal,
                    )),
                Text('54D8F2',
                    style: Get.textTheme.bodySmall!.copyWith(
                      height: 1.2,
                      color: CstColors.b,
                      fontWeight: FontWeight.normal,
                    )),
              ],
            ),
          ),
          AnimatedScale(
            scale: _selected ? 1 : 0,
            duration: 200.milliseconds,
            curve: Curves.easeOutBack,
            child: AnimatedOpacity(
              opacity: _selected ? 1 : 0,
              duration: 200.milliseconds,
              child: SvgPicture.asset(
                'assets/icons/ic_fluent_checkmark_24_filled.svg',
                color: CstColors.a,
                width: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
