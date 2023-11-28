import 'package:aissam_store/core/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordField extends StatefulWidget {
  PasswordField({super.key, required this.controller, this.errorMessage});

  final TextEditingController controller;
  String? errorMessage;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool? _obscurePassword = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          onChanged: (v) {
            print(v);
            setState(() {
              widget.errorMessage = null;
              if (v.isEmpty)
                _obscurePassword = null;
              else
                _obscurePassword = false;
            });
          },
          style: Get.textTheme.bodyLarge!.copyWith(
            color: widget.errorMessage != null ? Colors.red : ColorsConsts.a,
            fontWeight: FontWeight.w400,
            height: 1.6,
          ),
          controller: widget.controller,
          obscureText: _obscurePassword ?? false,
          decoration: InputDecoration(
            hintStyle: Get.textTheme.bodyLarge!.copyWith(
              color: ColorsConsts.b,
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
                      color: ColorsConsts.c,
                      size: 20,
                    ),
                  )
                : null,
            hintText: 'Password',
            contentPadding: EdgeInsets.all(20),
            filled: true,
            fillColor: widget.errorMessage != null
                ? Colors.red[100]!.withOpacity(.5)
                : Colors.grey.shade200,
            focusColor: widget.errorMessage != null
                ? Colors.red[100]
                : Colors.grey.shade400,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  BorderSide(color: ColorsConsts.b.withOpacity(.5), width: 4),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        AnimatedSize(
          alignment: Alignment.topCenter,
          curve: Curves.linearToEaseOut,
          duration: 400.milliseconds,
          child: widget.errorMessage != null
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info,
                        size: 15,
                        color: Colors.redAccent,
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          widget.errorMessage!,
                          style: Get.textTheme.bodyMedium!.copyWith(
                            color: Colors.redAccent,
                            height: 1.2,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
        )
      ],
    );
  }
}
