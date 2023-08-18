import 'package:aissam_store/core/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordField extends StatefulWidget {
    PasswordField(
      {super.key, required this.controller, this.errorOccure = false});

  final TextEditingController controller;
  bool errorOccure;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool? _obscurePassword = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (v) {
        print(v);
        setState(() {
          widget.errorOccure = false;
          if (v.isEmpty)
            _obscurePassword = null;
          else
            _obscurePassword = false;
        });
      },
      style: Get.textTheme.bodyLarge!.copyWith(
        color: widget.errorOccure ? Colors.red : CstColors.a,
        fontWeight: FontWeight.w400,
        height: 1.6,
      ),
      controller: widget.controller,
      obscureText: _obscurePassword ?? false,
      decoration: InputDecoration(
        hintStyle: Get.textTheme.bodyLarge!.copyWith(
          color: CstColors.b,
          fontWeight: FontWeight.w400,
          height: 1.6,
        ),
        suffixIcon: _obscurePassword != null
            ? GestureDetector(
                onTap: () => setState(() {
                  _obscurePassword = !_obscurePassword!;
                }),
                child: Icon(
                  _obscurePassword!
                      ? CupertinoIcons.eye
                      : CupertinoIcons.eye_slash,
                  color: CstColors.c,
                  size: 20,
                ),
              )
            : null,
        hintText: 'Password',
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
