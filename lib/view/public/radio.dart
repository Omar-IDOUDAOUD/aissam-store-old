import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CustomRadio<T> extends StatefulWidget {
  const CustomRadio(
      {super.key, required this.value, required this.activeValue});
  final T value;
  final T activeValue;

  @override
  State<CustomRadio> createState() => _CustomRadioState();
}

class _CustomRadioState extends State<CustomRadio> {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 9,
      backgroundColor: Colors.purpleAccent[400]!
          .withOpacity(widget.value == widget.activeValue ? 1 : .2),
      child: AnimatedOpacity(
        opacity: widget.value == widget.activeValue ? 1 : 0,
        duration: 100.milliseconds,
        child: SvgPicture.asset(
          'assets/icons/ic_fluent_checkmark_24_filled.svg',
          color: Colors.white,
          height: 15,
        ),
      ),
    );
  }
}
