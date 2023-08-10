import 'package:aissam_store/core/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  Button({
    super.key,
    this.onPressed,
    required this.child,
    this.isHeightMinimize = false,
    this.isOutline = false,
    this.padding = const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
  });
  final Function()? onPressed;
  final Widget child;
  final bool isHeightMinimize;
  final bool isOutline;
  final EdgeInsets padding;

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        height: widget.isHeightMinimize ? 60 : 75,
        padding: widget.padding,
        decoration: BoxDecoration(
            border: widget.isOutline
                ? Border.all(color: CstColors.a, width: 2)
                : null,
            color: widget.isOutline ? Colors.transparent : CstColors.a,
            borderRadius: BorderRadius.circular(15),
            boxShadow: !widget.isOutline
                ? [
                    BoxShadow(
                      color: CstColors.a.withOpacity(.5),
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    )
                  ]
                : null),
        child: widget.child,
      ),
    );
  }
}
