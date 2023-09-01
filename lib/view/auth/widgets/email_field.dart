import 'dart:ui';

import 'package:aissam_store/core/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailField extends StatefulWidget {
  EmailField({super.key, required this.controller, this.errorMessage});

  final TextEditingController controller;
  String? errorMessage;

  @override
  State<EmailField> createState() => _EmailFieldState();
}

class _EmailFieldState extends State<EmailField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          onChanged: (v) {
            print(v);
            setState(() {
              widget.errorMessage = null;
            });
          },
          style: Get.textTheme.bodyLarge!.copyWith(
            color: widget.errorMessage != null ? Colors.red : CstColors.a,
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
            contentPadding: const EdgeInsets.all(20),
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
                  BorderSide(color: CstColors.b.withOpacity(.5), width: 4),
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

  // @override
  // void didUpdateWidget(covariant EmailField oldWidget) {
  //   // TODO: implement didUpdateWidget
  //   if (widget.errorMessage != null) {
  //     print('FIRST CASE');
  //     _showErrorSizeAn = true;
  //     1.seconds.delay().then((value) {
  //       setState(() {
  //         _showErrorOpacityAn = true;
  //       });
  //     });
  //   } else {
  //     print('2ND CASE');

  //     _showErrorOpacityAn = false;
  //     1.seconds.delay().then((value) {
  //       setState(() {
  //         _showErrorSizeAn = false;
  //       });
  //     });
  //   }
  //   super.didUpdateWidget(oldWidget);
  // }

  // bool _showErrorSizeAn = false;
  // bool _showErrorOpacityAn = false;
}
