import 'package:aissam_store/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {super.key,
      this.isFloating = false,
      this.enabled = true,
      this.focusNode,
      this.onTap});
  final bool isFloating;
  final bool enabled;
  final FocusNode? focusNode;
  final Function()? onTap;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return AnimatedPhysicalModel(
      duration: 200.milliseconds,
      color:
          widget.isFloating ? Colors.white : Color.fromARGB(255, 231, 231, 231),
      elevation: widget.isFloating ? 15 : 0,
      shadowColor: Colors.black54.withOpacity(.35),
      // shape: BoxShape.circle,
      borderRadius: BorderRadius.circular(12.5),
      shape: BoxShape.rectangle,
      child: TextField(
        onTap: widget.onTap,
        cursorOpacityAnimates: true,
        focusNode: widget.focusNode,
        enabled: widget.enabled,
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
          filled: false,
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
            borderSide:
                BorderSide(color: CstColors.b.withOpacity(.5), width: 4),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
