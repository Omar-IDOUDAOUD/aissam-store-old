import 'dart:math';

import 'package:aissam_store/core/constants/colors.dart';
import 'package:aissam_store/view/public/text_field.dart'; 
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SearchFilterDialog extends StatefulWidget {
  const SearchFilterDialog({super.key});

  @override
  State<SearchFilterDialog> createState() => _SearchFilterDialogState();
}

class _SearchFilterDialogState extends State<SearchFilterDialog> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        // height: 200,
        width: Get.width * 0.8,
        child: Material(
          shadowColor: Colors.black87.withOpacity(.5),
          elevation: 20,
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Filter Search Results',
                  style: Get.textTheme.headlineSmall!.copyWith(
                    color: CstColors.a,
                  ),
                ),

                const SizedBox(
                  height: 15,
                ),
                _getFieldTitle('Price', 'All Prices'),
                const SizedBox(height: 4),

                Row(
                  children: [
                    Expanded(
                        child: CustomTextField(
                      borderRadius: 10,
                      hint: 'min',
                    )),
                    const SizedBox(width: 7),
                    Expanded(
                        child: CustomTextField(
                      borderRadius: 10,
                      hint: 'max ',
                    )),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                _getFieldTitle('Size', 'All Sizes'),
                const SizedBox(height: 4),

                GridView(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 7,
                      crossAxisSpacing: 7,
                      mainAxisExtent: 30),
                  // childAspectRatio: 5,
                  children: [
                    _getSizeItem('S', 0),
                    _getSizeItem('M', 1),
                    _getSizeItem('L', 2),
                    _getSizeItem('X', 3),
                    _getSizeItem('XXL', 4),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                _getFieldTitle('Colors', 'All Colors'),
                const SizedBox(height: 4),
                //
                const SelectColorDropdownMenu(),

                const Divider(
                  height: 20,
                ),

                Row(
                  children: [
                    Expanded(child: 
                    
                    _getButton('Cancel', false),
                    ), 
                    const SizedBox(width: 7,), 
                    Expanded(child: 
                    _getButton('Submit', true)
                    ), 
                  ],
                ), 

                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _getButton(String label, bool recommendedButton) {
    return MaterialButton(
      onPressed:Get.back,
      elevation:recommendedButton ? 15: 0,
      focusElevation: 0,
      hoverElevation: 0,
      highlightElevation: 0,
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      height: 60,
      color:recommendedButton ? CstColors.a : Colors.grey.shade300,
      child: Center(
        child: Text(
          label,
          style: Get.textTheme.bodyLarge!.copyWith(
            color: recommendedButton ? Colors.white : CstColors.a, 
            fontWeight: FontWeight.normal, 
          ),
        ),
      ),
    );
  }

  _getFieldTitle(String title, String actionLabel) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Get.textTheme.headlineSmall!.copyWith(
            color: CstColors.a,
            // fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          actionLabel,
          style: Get.textTheme.bodySmall!.copyWith(
            color: CstColors.a,
          ),
        ),
      ],
    );
  }

  int _selectedSize = 1;

  Color get _fillColor => Colors.brown;
  Color get _outlineColor => Colors.grey;
  _getSizeItem(String name, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedSize = index;
        });
      },
      child: AnimatedContainer(
        duration: 100.milliseconds,
        decoration: BoxDecoration(
          color:
              _selectedSize == index ? _fillColor : _fillColor.withOpacity(0),
          border: Border.all(
              color: _selectedSize == index ? _fillColor : _outlineColor),
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: Text(
          name,
          style: Get.textTheme.bodyLarge!.copyWith(
            color: _selectedSize == index ? Colors.white : CstColors.a,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class SelectColorDropdownMenu extends StatefulWidget {
  const SelectColorDropdownMenu({super.key});

  @override
  State<SelectColorDropdownMenu> createState() =>
      _SelectColorDropdownMenuState();
}

class _SelectColorDropdownMenuState extends State<SelectColorDropdownMenu> {
  GlobalKey _key = GlobalKey();

  int _selectedColors = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
      child: DecoratedBox(
        key: _key,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(10),
        ),
        child: SizedBox(
          height: 55,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _selectedColors == 0
                      ? 'No colors'
                      : '$_selectedColors colors',
                  style: Get.textTheme.bodyLarge!.copyWith(
                    color: CstColors.a,
                  ),
                ),
                // Expanded(
                //   child: Stack(
                //     alignment: Alignment.centerRight,
                //     children:[
                //       ...List.generate(_selectedColors, (index) {
                //         print('faken print');
                //         return Positioned(
                //         right: _selectedColors * 5,
                //         child: CircleAvatar(
                //           radius: 12,
                //           backgroundColor: Colors.accents.elementAt(0),
                //         ),
                //       );
                //       },),
                //
                //     ]
                //   ),
                // ),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: CstColors.a,
                ),
              ],
            ),
          ),
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
