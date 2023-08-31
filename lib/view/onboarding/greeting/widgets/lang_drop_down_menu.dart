import 'dart:math';

import 'package:aissam_store/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class LangDropdownMenu extends StatefulWidget {
  const LangDropdownMenu({
    super.key,
    required this.langs,
    required this.onLangSelect,
    required this.dropdownButtonKey,
    required this.activeLang,
    this.dispose,
  });
  final List<String> langs;
  final int activeLang;
  final Function() onLangSelect;
  final GlobalKey dropdownButtonKey;
  final Function()? dispose;

  @override
  State<LangDropdownMenu> createState() => _LangDropdownMenuState();
}

class _LangDropdownMenuState extends State<LangDropdownMenu> {
  final _padding = 25.0;
  final _screenSize = Get.size;
  // final _searchFieldItemHeight = 50.0;
  final _itemHeight = 45.0;

  // bool _expandAnimation = false;

  Size? _menuInitSize;
  Offset? _menuInitOffset;

  @override
  void dispose() {
    // TODO: implement dispose
    if (widget.dispose != null) widget.dispose!();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // TODO: implement initState

    _setMenuInitialSize();
    _setMenuInitialOffset();
    _setOpenDirection();

    // 100.milliseconds.delay().then((value) => setState(() {
    //       _expandAnimation = true;
    //     }));
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
    final double totalMenuItemsHeight = widget.langs.length * _itemHeight;
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
    return Center(
      child: SizedBox(
        // curve: Curves.linearToEaseOut,
        // top: !_openToTop ? _menuInitOffset!.dy : null,
        // bottom: _openToTop
        //     ? _screenSize.height -
        //         _menuInitOffset!.dy -
        //         _menuInitSize!.height
        //     : null,
        // left: Get.size.width * 0.3 / 2,
        width: Get.size.width * .7,
        height: _getMenuExpandHeight,
        // duration: 200.milliseconds,
        child: Hero(
          tag: 'menu-container',
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView.builder(
                      // padding: EdgeInsets.only(bottom: 5),
                      itemCount: widget.langs.length,
                      itemBuilder: (_, i) => SizedBox(
                        height: _itemHeight,

                        child: _LangMenuItem(
                          onLangSelect: () {
                            widget.onLangSelect();
                            Get.back();
                          },
                        ),
                        // child: ColoredBox(color: Colors.red),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LangMenuItem extends StatefulWidget {
  const _LangMenuItem({super.key, required this.onLangSelect});
  final Function() onLangSelect;

  @override
  State<_LangMenuItem> createState() => _LangMenuItemState();
}

class _LangMenuItemState extends State<_LangMenuItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onLangSelect,
      child: Row(
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
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text('Arabic',
                style: Get.textTheme.bodyLarge!.copyWith(
                  color: CstColors.a,
                  fontWeight: FontWeight.normal,
                )),
          ),
        ],
      ),
    );
  }
}

class LangDropDownMenu2 extends StatefulWidget {
  const LangDropDownMenu2({super.key});

  @override
  State<LangDropDownMenu2> createState() => LangDropDownMenu2State();
}

class LangDropDownMenu2State extends State<LangDropDownMenu2> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
    );
  }
}
