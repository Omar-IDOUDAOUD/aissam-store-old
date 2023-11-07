import 'dart:math';

import 'package:aissam_store/controller/search.dart';
import 'package:aissam_store/core/constants/colors.dart';
import 'package:aissam_store/core/utils/hex_color.dart';
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
  final SearchControllerV2 _controller = SearchControllerV2.instance;

  void _submitChanges() {
    _controller.setResultsFilters(
      (currentFilters) => currentFilters.update(
        colors: _colorsNames.isNotEmpty ? _colorsNames : null,
        maxPrice:
            _maxPrice.text.isNotEmpty ? double.parse(_maxPrice.text) : null,
        minPrice:
            _minPrice.text.isNotEmpty ? double.parse(_minPrice.text) : null,
        size: _size,
      ),
    );
    Get.back();
  }

  void _getCurrentFilters() {
    final f = _controller.filterParameters;
    _minPrice.text = (f.minPrice ?? '').toString();
    _maxPrice.text = (f.maxPrice ?? '').toString();
    _size = f.size;
    _colorsNames = f.colors ?? [];
  }

  late final TextEditingController _minPrice;
  late final TextEditingController _maxPrice;

  int? _size;

  List<int> _colorsNames = [];

  final List<ColorName> _colors = [
    ColorName(hex: 'F30000', name: 'Red'),
    ColorName(hex: 'EEF300', name: 'Yellow'),
    ColorName(hex: '0061F3', name: 'Blue'),
    ColorName(hex: '00F353', name: 'Green'),
  ];
  final List<String> _sizes = ['S', 'M', 'L', 'X', 'XXL'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _minPrice = TextEditingController();
    _maxPrice = TextEditingController();
    _getCurrentFilters();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _minPrice.dispose();
    _maxPrice.dispose();
    super.dispose();
  }

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
                      controller: _minPrice,
                      borderRadius: 10,
                      hint: 'min',
                    )),
                    const SizedBox(width: 7),
                    Expanded(
                        child: CustomTextField(
                      controller: _maxPrice,
                      borderRadius: 10,
                      hint: 'max',
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
                  children: List.generate(
                    _sizes.length,
                    (index) => _getSizeItem(_sizes.elementAt(index), index),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                _getFieldTitle(
                    'Colors',
                    _colorsNames.isEmpty
                        ? 'All Colors'
                        : _colorsNames.length.toString()),
                const SizedBox(height: 4),
                SelectColorDropdownMenu(
                  colors: _colors,
                  onAddOrRemoveColor: (int i, bool isAdded) {
                    if (isAdded) {
                      _colorsNames.add(i);
                    } else {
                      _colorsNames.remove(i);
                    }
                    setState(() {});
                  },
                  selectedColors: _colorsNames,
                ),
                const Divider(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: _getButton('Cancel', false, Get.back),
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    Expanded(child: _getButton('Submit', true, _submitChanges)),
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

  _getButton(String label, bool recommendedButton, [Function()? onTap]) {
    return MaterialButton(
      onPressed: onTap,
      elevation: recommendedButton ? 15 : 0,
      focusElevation: 0,
      hoverElevation: 0,
      highlightElevation: 0,
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      height: 60,
      color: recommendedButton ? CstColors.a : Colors.grey.shade300,
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

  // int _selectedSize = 1;

  Color get _fillColor => Colors.brown;
  Color get _outlineColor => Colors.grey;
  _getSizeItem(String name, int index) {
    var isSelected = _size == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _size = isSelected ? null : index;
        });
      },
      child: AnimatedContainer(
        duration: 100.milliseconds,
        decoration: BoxDecoration(
          color: isSelected ? _fillColor : _fillColor.withOpacity(0),
          border: Border.all(color: isSelected ? _fillColor : _outlineColor),
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: Text(
          name,
          style: Get.textTheme.bodyLarge!.copyWith(
            color: isSelected ? Colors.white : CstColors.a,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class ColorName {
  final String hex;
  final String name;

  ColorName({required this.hex, required this.name});
}

class SelectColorDropdownMenu extends StatefulWidget {
  const SelectColorDropdownMenu(
      {super.key,
      required this.colors,
      required this.onAddOrRemoveColor,
      required this.selectedColors});

  final List<ColorName> colors;
  final List<int> selectedColors;
  final Function(int i, bool isAdded) onAddOrRemoveColor;

  @override
  State<SelectColorDropdownMenu> createState() =>
      _SelectColorDropdownMenuState();
}

class _SelectColorDropdownMenuState extends State<SelectColorDropdownMenu> {
  GlobalKey _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.dialog(
          _ColorDropdownMenu(
            selectedColors: widget.selectedColors,
            dropdownButtonKey: _key,
            colors: widget.colors,
            onAddOrRemoveColor: widget.onAddOrRemoveColor,
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
                  widget.selectedColors.length.toString() + 'Color',
                  style: Get.textTheme.bodyLarge!.copyWith(
                    color: CstColors.a,
                  ),
                ),
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
    required this.colors,
    required this.dropdownButtonKey,
    required this.onAddOrRemoveColor,
    required this.selectedColors,
  });
  final List<ColorName> colors;
  final List<int> selectedColors;
  final GlobalKey dropdownButtonKey;
  final Function(int colorIndex, bool isAdded) onAddOrRemoveColor;

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
        widget.colors.length * _itemHeight + _searchFieldItemHeight;
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
                      itemCount: widget.colors.length,
                      itemBuilder: (_, i) => SizedBox(
                        height: _itemHeight,
                        child: _colorMenuItem(
                          isSelected: widget.selectedColors.contains(i),
                          color: widget.colors.elementAt(i),
                          onAddColor: (bool isAdded) =>
                              widget.onAddOrRemoveColor(i, isAdded),
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
  const _colorMenuItem(
      {super.key,
      required this.onAddColor,
      required this.color,
      required this.isSelected});
  final Function(bool isAdded) onAddColor;
  final ColorName color;
  final bool isSelected;

  @override
  State<_colorMenuItem> createState() => __colorMenuItemState();
}

class __colorMenuItemState extends State<_colorMenuItem> {
  bool _selected = false;

  Color get _color => HexColor(widget.color.hex);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selected = widget.isSelected;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selected = !_selected;
          widget.onAddColor(_selected);
        });
      },
      child: Row(
        children: [
          SizedBox.square(
            dimension: 20,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: _color,
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
                Text(widget.color.name,
                    style: Get.textTheme.bodyLarge!.copyWith(
                      color: CstColors.a,
                      fontWeight: FontWeight.normal,
                    )),
                Text(widget.color.hex,
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
