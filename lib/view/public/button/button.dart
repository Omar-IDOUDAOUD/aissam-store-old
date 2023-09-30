import 'package:aissam_store/core/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'button_color_builder.dart';

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
    // return MaterialButton(
    //   height: widget.isHeightMinimize ? 60 : 75,
    //   elevation: !widget.isOutline && widget.enabled ? 10 : 0,
    //   focusElevation: 0,
    //   highlightElevation: 0,
    //   padding: EdgeInsets.zero,
    //   hoverElevation: 0,
    //   color: widget.isOutline ? Colors.transparent : CstColors.a,
    //   onPressed: widget.enabled ? widget.onPressed : () {},
    //   splashColor: Colors.black.withOpacity(.1),
    //   focusColor: Colors.transparent,
    //   highlightColor: Colors.transparent,
    //   hoverColor: Colors.transparent,
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(widget.isHeightMinimize ? 12 : 15),
    //     side: widget.isOutline
    //         ? BorderSide(color: CstColors.a, width: 2)
    //         : BorderSide.none,
    //   ),
    //   child: DecoratedBox(
    //     position: DecorationPosition.foreground,
    //     decoration: BoxDecoration(
    //       borderRadius:
    //           BorderRadius.circular(widget.isHeightMinimize ? 12 : 15),
    //       color: !widget.enabled ? Colors.black.withOpacity(.2) : null,
    //     ),
    //     child: Padding(
    //       padding: widget.padding ??
    //           EdgeInsets.symmetric(
    //             horizontal: widget.isHeightMinimize ? 20 : 30,
    //             vertical: 10,
    //           ),
    //       child: widget.child,
    //     ),
    //   ),
    // );
    final borderRadius =
        BorderRadius.circular(widget.isHeightMinimize ? 12 : 15);
    return ButtonColorBuilder(
        color: widget.isOutline ? Colors.white : CstColors.a,
        onTap: widget.enabled ? widget.onPressed : null,
        builder: (color, focus) {
          return AnimatedPhysicalModel(
            borderRadius: borderRadius,
            duration: 100.milliseconds,
            shape: BoxShape.rectangle,
            animateColor: false,
            color: Colors.transparent,
            shadowColor: Colors.black,
            elevation: focus
                ? 0
                : !widget.isOutline && widget.enabled
                    ? 10
                    : 0,
            child: Container(
              // duration: 200.milliseconds,
              height: widget.isHeightMinimize ? 60 : 75,
              decoration: BoxDecoration(
                // boxShadow:
                //     ? [
                //         BoxShadow(
                //             blurRadius: 20,
                //             color: Colors.black.withOpacity(.5),
                //             offset: Offset())
                //       ]
                //     : null,
                borderRadius: borderRadius,

                color: color,
                border: widget.isOutline
                    ? Border.all(color: CstColors.a, width: 2)
                    : null,
              ),
              foregroundDecoration: BoxDecoration(
                borderRadius: borderRadius,
                color: !widget.enabled ? Colors.black.withOpacity(.2) : null,
              ),
              padding: widget.padding ??
                  EdgeInsets.symmetric(
                    horizontal: widget.isHeightMinimize ? 20 : 30,
                    vertical: 10,
                  ),
              child: widget.child,

              // splashColor: Colors.black.withOpacity(.1),
              // focusColor: Colors.transparent,
              // highlightColor: Colors.transparent,
              // hoverColor: Colors.transparent,
              // shape: RoundedRectangleBorder(
              // ),
            ),
          );
        });
  }
}
