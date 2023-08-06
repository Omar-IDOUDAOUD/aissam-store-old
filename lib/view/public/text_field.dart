import 'package:aissam_store/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({super.key});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  // late FocusNode myFocusNode;

  // @override
  // void initState() {
  //   super.initState();

  //   myFocusNode = FocusNode();
  // }

  // @override
  // void dispose() {
  //   // Clean up the focus node when the Form is disposed.
  //   myFocusNode.dispose();

  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: Get.textTheme.headlineSmall!.copyWith(
        color: CstColors.a,
        fontWeight: FontWeight.w400,
        height: 1.6,
      ),
      decoration: InputDecoration(
        hintStyle: Get.textTheme.headlineSmall!.copyWith(
          color: CstColors.a.withOpacity(.8),
          fontWeight: FontWeight.w400,
          height: 1.6,
        ),
        contentPadding: EdgeInsets.all(17),
        hintText: 'White Style Abayas',
        filled: true,
        fillColor: CstColors.b.withOpacity(.3),
        prefixIcon: SvgPicture.asset(
          'assets/icons/search_small.svg',
          height: 25,
          width: 25,
          fit: BoxFit.scaleDown,
          alignment: Alignment.center,
          color: CstColors.b,
        ),
        prefixIconConstraints: BoxConstraints(
          // maxHeight: 50,
          minWidth: 40,
        ),
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
