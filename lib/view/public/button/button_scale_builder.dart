import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ButtonScaleBuilder extends StatefulWidget {
  const ButtonScaleBuilder({
    super.key,
    // required this.color,
    required this.builder,
    this.onTap,
    // this.disabledColor,
    // this.focusColor
  });

  // final Color color;
  final Widget Function(bool focus) builder;
  final Function()? onTap;
  // final Color? disabledColor;
  // final Color? focusColor;

  @override
  State<ButtonScaleBuilder> createState() => _ButtonScaleBuilderState();
}

class _ButtonScaleBuilderState extends State<ButtonScaleBuilder>
    with SingleTickerProviderStateMixin {
  bool _isFocus = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onLongPressDown: (c) {
        setState(() {
          _isFocus = true;
        });
      },
      onLongPressCancel: () {
        setState(() {
          _isFocus = false;
        });
      },
      onLongPressUp: () {
        setState(() {
          _isFocus = false;
        });
      },
      child: AnimatedScale(
        curve: Curves.linearToEaseOut,
        scale: _isFocus ? 0.9 : 1,
        duration: _isFocus ? 50.milliseconds : 80.milliseconds,
        child: widget.builder(_isFocus),
      ),
    );
  }
}
