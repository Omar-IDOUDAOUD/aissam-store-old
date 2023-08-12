import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckBox extends StatefulWidget {
  const CheckBox({super.key, required this.isSelected});

  final bool isSelected;

  @override
  State<CheckBox> createState() => _CheckBoxState();
}

class _CheckBoxState extends State<CheckBox> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: 20,
      height: 20,
      duration: 100.milliseconds,
      decoration: BoxDecoration(
        border: Border.all(
            width: 1,
            color: !widget.isSelected
                ? Colors.deepPurpleAccent
                : Colors.deepPurpleAccent.withOpacity(0)),
        color: widget.isSelected
            ? Colors.purpleAccent[400]
            : Colors.purpleAccent[400]!.withOpacity(0),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: Icon(
          Icons.check_rounded,
          color: Colors.white,
          size: 15,
        ),
      ),
    );
  }
}
