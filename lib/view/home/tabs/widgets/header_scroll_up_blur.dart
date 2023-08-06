import 'dart:ui';

import 'package:flutter/material.dart';

class HeaderWithScrollUpBlur extends StatefulWidget {
  const HeaderWithScrollUpBlur({
    super.key,
    required this.padding,
    // required this.blurSigma,
    required this.elevation,
    required this.child,
    // this.minExtent ,
  });
  final EdgeInsets padding;
  // final double blurSigma;
  final double elevation;
  final Widget child;
  // final double? minExtent;

  @override
  State<HeaderWithScrollUpBlur> createState() => _HeaderWithScrollUpBlurState();
}

class _HeaderWithScrollUpBlurState extends State<HeaderWithScrollUpBlur> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.6),
        boxShadow: [
          BoxShadow(
            color: Colors.black54.withOpacity(widget.elevation * 0.2),
            blurRadius: 35,
            offset: Offset(0, 0),
            blurStyle: BlurStyle.outer,
          )
        ],
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: _getSigmaValue,
          sigmaY: _getSigmaValue,
        ),
        child: SizedBox.expand(child: widget.child),
      ),
    );
  }
  double get _getSigmaValue => widget.elevation == 0 ? 0 : 10;  
}
