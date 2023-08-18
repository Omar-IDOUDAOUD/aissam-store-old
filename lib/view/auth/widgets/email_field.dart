import 'package:aissam_store/core/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailField extends StatefulWidget {
  EmailField({super.key, required this.controller, this.errorOccure = false});

  final TextEditingController controller;
  bool errorOccure;

  @override
  State<EmailField> createState() => _EmailFieldState();
}

class _EmailFieldState extends State<EmailField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (v) {
        print(v);
        setState(() {
          widget.errorOccure = false;
        });
      },
      style: Get.textTheme.bodyLarge!.copyWith(
        color:widget.errorOccure  ? Colors.red : CstColors.a,
        fontWeight: FontWeight.w400,
        height: 1.6,
      ),
      controller: widget.controller,
      decoration: InputDecoration(
        hintStyle: Get.textTheme.bodyLarge!.copyWith(
          color: CstColors.b,
          fontWeight: FontWeight.w400,
          height: 1.6,
        ),
        hintText: 'You Email Address',
        contentPadding: EdgeInsets.all(20),
        filled: true,
        fillColor: widget.errorOccure
            ? Colors.red[100]!.withOpacity(.5)
            : Colors.grey.shade200,
        focusColor: widget.errorOccure ? Colors.red[100] : Colors.grey.shade400,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: CstColors.b.withOpacity(.5), width: 4),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
