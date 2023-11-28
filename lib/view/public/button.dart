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
    this.padding,
    this.enabled = true,
  });
  final Function()? onPressed;
  final Widget child;
  final bool isHeightMinimize;
  final bool isOutline;
  final EdgeInsets? padding;
  final bool enabled;

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: widget.isHeightMinimize ? 60 : 75,
      elevation: !widget.isOutline && widget.enabled ? 10 : 0,
      focusElevation: 0,
      highlightElevation: 0,
      padding: EdgeInsets.zero,
      hoverElevation: 0,
      color: widget.isOutline ? Colors.transparent : ColorsConsts.a,
      onPressed: widget.enabled ? widget.onPressed : () {},
      splashColor: Colors.black.withOpacity(.1),
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(widget.isHeightMinimize ? 12 : 15),
        side: widget.isOutline
            ? BorderSide(color: ColorsConsts.a, width: 2)
            : BorderSide.none,
      ),
      child: DecoratedBox(
        position: DecorationPosition.foreground,
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(widget.isHeightMinimize ? 12 : 15),
          color: !widget.enabled ? Colors.black.withOpacity(.2) : null,
        ),
        child: Padding(
          padding: widget.padding ??
              EdgeInsets.symmetric(
                horizontal: widget.isHeightMinimize ? 20 : 30,
                vertical: 10,
              ),
          child: widget.child,
        ),
      ),
    );
  }
}
