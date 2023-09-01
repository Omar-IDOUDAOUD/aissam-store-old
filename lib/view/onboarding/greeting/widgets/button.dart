import 'package:aissam_store/core/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

enum SignInButtonState {
  noState,
  loading,
  success,
  fail,
}

class CustomButton extends StatefulWidget {
  final bool primaryButton;
  final Color? labelColor;
  final Color? backroundColor;
  final Color? iconColor;
  final String iconPath;
  final String label;
  final bool smallWidthButton;
  final Function()? onTap;
  final SignInButtonState state;
  CustomButton({
    super.key,
    this.state = SignInButtonState.noState,
    this.primaryButton = false,
    this.labelColor,
    this.iconColor,
    this.backroundColor,
    this.smallWidthButton = false,
    required this.iconPath,
    required this.label,
    this.onTap,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 90,
      elevation: widget.primaryButton ? 17 : 0,
      focusElevation: 0,
      highlightElevation: 0,
      hoverElevation: 0,
      color: widget.primaryButton ? CstColors.a : widget.backroundColor,
      onPressed: widget.onTap ?? () {},
      padding:
          EdgeInsets.symmetric(horizontal: widget.smallWidthButton ? 28 : 35),
      splashColor: Colors.black.withOpacity(.1),
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: AnimatedSwitcher(
        duration: 1.seconds,
        child: widget.state == SignInButtonState.loading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 3,
                ),
              )
            : widget.state == SignInButtonState.success
                ? const Center(
                    child: Icon(Icons.check_outlined, color: Colors.white))
                : Row(
                    children: [
                      SizedBox.square(
                        dimension: 25,
                        child: SvgPicture.asset(
                          widget.iconPath,
                          color: widget.primaryButton
                              ? Colors.white
                              : widget.iconColor,
                          alignment: Alignment.center,
                          width: 20,
                          height: 20,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          widget.label,
                          textAlign: TextAlign.center,
                          style: Get.textTheme.headlineSmall!.copyWith(
                            height: 1.2,
                            color: widget.primaryButton
                                ? Colors.white
                                : widget.labelColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      if (!widget.smallWidthButton)
                        SizedBox.square(
                          dimension: 25,
                          child: SvgPicture.asset(
                            widget.primaryButton
                                ? 'assets/icons/arrow_right_shorter.svg'
                                : 'assets/icons/ic_fluent_chevron_right_24_filled.svg',
                            color: widget.primaryButton
                                ? Colors.white
                                : widget.labelColor,
                            width: widget.primaryButton ? 30 : 18,
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                    ],
                  ),
        transitionBuilder: (c, a) {
          return ScaleTransition(
            scale: Tween<double>(begin: 0.7, end: 1).animate(a),
            child: FadeTransition(
              opacity: a,
              child: c,
            ),
          );
        },
      ),
    );
  }
}
