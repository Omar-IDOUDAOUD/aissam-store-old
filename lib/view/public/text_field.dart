// ignore_for_file: must_be_immutable

import 'package:aissam_store/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CustomTextField extends StatefulWidget {
  CustomTextField({
    super.key,
    // this.isFloating = false,
    this.enabled = true,
    this.focusNode,
    this.onTap,
    this.controller,
    this.onCommit,
    this.onClear,
    this.prefixIconPath,
    this.borderRadius = 12,
    this.hint,
  }) {
    controller ??= TextEditingController();
    focusNode ??= FocusNode();
  }
  // final bool isFloating;
  final bool enabled;
  FocusNode? focusNode;
  final Function()? onTap;
  TextEditingController? controller;
  final String? prefixIconPath;
  final double borderRadius;
  final String? hint;

  /// called when submit the field text using suffix button
  final Function()? onCommit;

  /// called when clear the field text using suffix button
  final Function()? onClear;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

enum SuffixIcons { submit, clear, none }

class _CustomTextFieldState extends State<CustomTextField> {
  ///////////////new code////////////////

  bool _isFocus = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _suffixIcon =
        widget.controller!.text.isEmpty ? SuffixIcons.none : SuffixIcons.clear;
    widget.controller!.addListener(_controllerListener);
    if (widget.prefixIconPath != null)
      widget.focusNode!.addListener(_focusListener);
  }

  @override
  void dispose() {
    // TODO: implement dispose

    widget.controller!.removeListener(_controllerListener);
    widget.focusNode!.removeListener(_focusListener);
    super.dispose();
  }

  void _focusListener() {
    if (!_isFocus && widget.focusNode!.hasFocus)
      setState(() {
        _isFocus = true;
      });
    else if (_isFocus && !widget.focusNode!.hasFocus)
      setState(() {
        _isFocus = false;
      });
  }

  void _controllerListener() {
    if (widget.controller!.text.isNotEmpty && _suffixIcon != SuffixIcons.submit)
      _showIcon(SuffixIcons.submit);
    else if (widget.controller!.text.isEmpty && _suffixIcon != SuffixIcons.none)
      _showIcon(SuffixIcons.none);
  }

  SuffixIcons _suffixIcon = SuffixIcons.none;

  _showIcon(SuffixIcons newIcon) {
    setState(() {
      _suffixIcon = newIcon;
    });
  }

  void _submit() {
    widget.focusNode!.unfocus();
    _showIcon(SuffixIcons.clear);
    if (widget.onCommit != null) widget.onCommit!();
  }

  void _clear() {
    widget.controller!.clear();
    widget.focusNode!.unfocus();
    _showIcon(SuffixIcons.none);
    if (widget.onClear != null) widget.onClear!();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      onTap: widget.onTap,
      onSubmitted: (v) => _submit(),
      cursorOpacityAnimates: true,
      focusNode: widget.focusNode,
      enabled: widget.enabled,
      style: Get.textTheme.headlineSmall!.copyWith(
        color: ColorsConsts.a,
        fontWeight: FontWeight.w400,
        height: 1.6,
      ),
      decoration: InputDecoration(
        hintStyle: Get.textTheme.headlineSmall!.copyWith(
          color: ColorsConsts.a.withOpacity(.8),
          fontWeight: FontWeight.w400,
          height: 1.6,
        ),
        contentPadding: EdgeInsets.all(17),
        hintText: widget.hint,
        filled: true,
        fillColor: Colors.grey.shade200,
        prefixIcon: widget.prefixIconPath != null
            ? Padding(
                padding: const EdgeInsets.only(left: 5),
                child: SvgPicture.asset(
                  widget.prefixIconPath!,
                  height: 25,
                  width: 25,
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.center,
                  color: _isFocus ? ColorsConsts.c : ColorsConsts.b,
                ),
              )
            : null,
        prefixIconConstraints: BoxConstraints(
          minWidth: 40,
        ),
        suffixIconConstraints: BoxConstraints(
          minWidth: 50,
        ),
        suffixIcon: _getCurrentSuffixIcon(),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide:
              BorderSide(color: ColorsConsts.b.withOpacity(.5), width: 4),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
      ),
    );
  }

  Widget? _getCurrentSuffixIcon() {
    if (_suffixIcon == SuffixIcons.submit && widget.onCommit != null)
      return _getSuffixIcon('assets/icons/arrow_right_shorter.svg', _submit);
    else if (_suffixIcon == SuffixIcons.clear && widget.onClear != null)
      return _getSuffixIcon('assets/icons/close_no_padding.svg', _clear);
    // else return
    //   null;
  }

  Widget _getSuffixIcon(String iconPath, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: SvgPicture.asset(
        iconPath,
        height: 13,
        fit: BoxFit.scaleDown,
        allowDrawingOutsideViewBox: true,
        alignment: Alignment.center,
        color: ColorsConsts.c,
      ),
    );
  }
}
