import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ButtonColorBuilder extends StatefulWidget {
  const ButtonColorBuilder(
      {super.key,
      required this.color,
      required this.builder,
      this.onTap,
      this.focusColor});

  final Color color;
  final Widget Function(Color currentColor, bool isFocus) builder;
  final Function()? onTap;
  final Color? focusColor;

  @override
  State<ButtonColorBuilder> createState() => _ButtonColorBuilderState();
}

class _ButtonColorBuilderState extends State<ButtonColorBuilder>
// with SingleTickerProviderStateMixin
{
  // late final AnimationController _animationController;
  // late final Animation<Color?> _animation;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   _animationController =
  //       AnimationController(vsync: this, duration: 100.milliseconds);
  //   _animation = ColorTween(
  //           begin: widget.color,
  //           end:
  //               widget.focusColor ?? Color.lerp(widget.color, Colors.black, .2))
  //       .animate(CurvedAnimation(
  //           parent: _animationController, curve: Curves.linearToEaseOut));
  // }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   _animationController.dispose();
  //   super.dispose();
  // }

  bool _isFocus = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      // onTapUp: (d) => widget.onTap != null ? widget.onTap!() : null,
      // onLongPress: widget.onTap,
      onLongPressDown: (c) {
        setState(() {
          _isFocus = true;
        });
        // _animationController.animateTo(1, duration: 50.milliseconds);
      },
      onLongPressCancel: () {
        setState(() {
          _isFocus = false;
        });
        // _animationController.reverse();
      },
      onLongPressUp: () {
        // if (widget.onTap != null) widget.onTap!();
        setState(() {
          _isFocus = false;
        });
        // _animationController.reverse();
      },
      // onTapDown: (c) {},
      // onTapCancel: () {
      //   // _animationController.animate(1);
      //   _isFocus = false;
      //   _animationController.reverse();
      // },
      // onTapUp: (c) {
      //   _isFocus = false;

      //   _animationController.reverse();
      // },
      child: TweenAnimationBuilder<Color?>(
        curve: Curves.linearToEaseOut,
        tween: _getCurrentTween,
        duration: _isFocus ? 50.milliseconds : 150.milliseconds,
        builder: (_, Color? color, c) {
          return widget.builder(color!, _isFocus);
        },
      ),
    );
  }

  Tween<Color?> get _getCurrentTween => ColorTween(
        begin: _isFocus ? widget.color : _getFocusColor,
        end: _isFocus ? _getFocusColor : widget.color,
      );
  Color get _getFocusColor =>
      widget.focusColor ??
      Color.lerp(
        widget.color,
        Colors.black,
        .2,
      )!;
}
