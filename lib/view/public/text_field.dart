import 'package:aissam_store/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CustomTextField extends StatefulWidget {
  CustomTextField({
    super.key,
    this.isFloating = false,
    this.enabled = true,
    required this.focusNode,
    this.onTap,
    this.controller,
    this.onCommit,
    this.onClear,
  }) {
    controller ??= TextEditingController();
    focusNode ??= FocusNode();
  }
  final bool isFloating;
  final bool enabled;
  FocusNode? focusNode;
  final Function()? onTap;
  TextEditingController? controller;

  /// called when submit the field text using suffix button
  final Function()? onCommit;

  /// called when clear the field text using suffix button
  final Function()? onClear;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool? _showSubmitSuffix;

  void _showSubmitButton(String v) {
    if (_showSubmitSuffix ?? false) return;
    if (v.isNotEmpty && widget.onCommit != null)
      setState(() {
        print('CASE ONE');
        _showSubmitSuffix = true;
      });
    else
      _hidePrefixButton();
  }

  void _showClearButton(String v) {
    if (!(_showSubmitSuffix ?? true)) return;
    if (v.isNotEmpty && widget.onClear != null)
      setState(() {
        print('CASE THREE');
        _showSubmitSuffix = false;
      });
    else
      _hidePrefixButton();
  }

  void _hidePrefixButton() {
    setState(() {
      _showSubmitSuffix = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPhysicalModel(
      duration: 200.milliseconds,
      color: Color.fromARGB(255, 231, 231, 231),
      elevation: widget.isFloating ? 20 : 0,
      shadowColor: Colors.black54.withOpacity(.2),
      // shape: BoxShape.circle,
      borderRadius: BorderRadius.circular(12.5),
      shape: BoxShape.rectangle,
      child: TextField(
        controller: widget.controller,
        onTap: widget.onTap,
        onSubmitted: (v) {
          if (widget.onCommit != null) widget.onCommit!();
          _showClearButton(v);
        },
        cursorOpacityAnimates: true,
        focusNode: widget.focusNode,
        enabled: widget.enabled,
        style: Get.textTheme.headlineSmall!.copyWith(
          color: CstColors.a,
          fontWeight: FontWeight.w400,
          height: 1.6,
        ),
        onChanged: (v) {
          print("ON CHANGED----------------");
          if (v.isEmpty)
            _hidePrefixButton();
          else
            _showSubmitButton(v);
        },
        decoration: InputDecoration(
          hintStyle: Get.textTheme.headlineSmall!.copyWith(
            color: CstColors.a.withOpacity(.8),
            fontWeight: FontWeight.w400,
            height: 1.6,
          ),
          contentPadding: EdgeInsets.all(17),
          hintText: 'White Style Abayas',
          filled: false,
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 5),
            child: SvgPicture.asset(
              'assets/icons/search_small.svg',
              height: 25,
              width: 25,
              fit: BoxFit.scaleDown,
              alignment: Alignment.center,
              color:
                  widget.focusNode!.hasPrimaryFocus ? CstColors.c : CstColors.b,
            ),
          ),
          prefixIconConstraints: BoxConstraints(
            // maxHeight: 50,
            minWidth: 40,
          ),
          suffixIconConstraints: BoxConstraints(
            // maxHeight: 50,
            minWidth: 50,
          ),
          suffixIcon: _showSubmitSuffix != null
              ? GestureDetector(
                  onTap: () {
                    _showSubmitSuffix! ? widget.onCommit!() : widget.onClear!();
                    _hidePrefixButton();
                  },
                  child: SvgPicture.asset(
                    _showSubmitSuffix!
                        ? 'assets/icons/arrow_right_shorter.svg'
                        : 'assets/icons/close.svg',
                    height: 13,
                    // width: 25,
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.center,
                    color: CstColors.c,
                  ),
                )
              : null,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:
                BorderSide(color: CstColors.b.withOpacity(.5), width: 4),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
