import 'package:aissam_store/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CheckoutFAB extends StatefulWidget {
  const CheckoutFAB({super.key, required this.isExpand, required this.onExpand});

  final bool isExpand;
  final Function() onExpand;

  @override
  State<CheckoutFAB> createState() => _CheckoutFABState();
}

class _CheckoutFABState extends State<CheckoutFAB> {

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      animationDuration: 500.milliseconds,
      padding: EdgeInsets.symmetric(horizontal: widget.isExpand ? 30 : 25),
      height: 50,
      minWidth: 50,
      color: CstColors.a,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(widget.isExpand ? 15 : 10),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            right: 0,
            child: SvgPicture.asset(
              'assets/icons/arrow_right.svg',
              color: Colors.white,
              width: 35,
            ),
          ),
          Positioned(
            left: 0,
            child: AnimatedOpacity(
              duration: 500.milliseconds,
              curve: Curves.linearToEaseOut,
              opacity: widget.isExpand ? 1 : 0,
              child: Text(
                'CHECKOUT',
                style: Get.textTheme.bodyLarge!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          )
        ],
      ),
      onPressed: () {
        if (!widget.isExpand) {
          widget.onExpand();
          return;
        }

        Get.toNamed('/checkout'); 
       
      },
    );
  }
}
