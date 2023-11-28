import 'dart:math';

import 'package:aissam_store/core/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class PhoneNumberField extends StatefulWidget {
  PhoneNumberField(
      {super.key, required this.controller, this.errorOccure = false});

  final TextEditingController controller;
  bool errorOccure;

  @override
  State<PhoneNumberField> createState() => _PhoneNumberFieldState();
}

class _PhoneNumberFieldState extends State<PhoneNumberField> {
  GlobalKey _key = GlobalKey();

  int _selectedColors = 0;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      key: _key,
      onChanged: (v) {
        print(v);
        setState(() {
          widget.errorOccure = false;
        });
      },
      style: Get.textTheme.bodyLarge!.copyWith(
        color: widget.errorOccure ? Colors.red : ColorsConsts.a,
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
                  color: ColorsConsts.a,
                ),
              ],
            ),
          ),
        ),
        hintStyle: Get.textTheme.bodyLarge!.copyWith(
          color: ColorsConsts.b,
          fontWeight: FontWeight.w400,
          height: 1.6,
        ),
        hintText: 'Phone Number (Optional)',
        contentPadding: EdgeInsets.all(20),
        filled: true,
        fillColor: widget.errorOccure
            ? Colors.red[100]!.withOpacity(.5)
            : Colors.grey.shade200,
        focusColor: widget.errorOccure ? Colors.red[100] : Colors.grey.shade400,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              BorderSide(color: ColorsConsts.b.withOpacity(.5), width: 4),
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
                        color: ColorsConsts.a,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Search color',
                        hintStyle: Get.textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.normal,
                          color: ColorsConsts.c,
                        ),
                        border: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: ColorsConsts.b, width: 1.5),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: ColorsConsts.a, width: 1.5),
                        ),
                        prefixIconConstraints: const BoxConstraints(
                          maxWidth: 25,
                          maxHeight: 20,
                        ),
                        prefixIcon: SvgPicture.asset(
                          'assets/icons/search_small.svg',
                          color: ColorsConsts.c,
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
                      color: ColorsConsts.a,
                      fontWeight: FontWeight.normal,
                    )),
                Text('54D8F2',
                    style: Get.textTheme.bodySmall!.copyWith(
                      height: 1.2,
                      color: ColorsConsts.b,
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
                color: ColorsConsts.a,
                width: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
