import 'package:aissam_store/view/public/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProceedToCheckoutButton extends StatefulWidget {
  const ProceedToCheckoutButton(
      {super.key,
      required this.isProceedToCartState,
      required this.animation,
      this.animationDur});

  final bool isProceedToCartState;
  final Animation<Offset> animation;
  final Duration? animationDur;

  @override
  State<ProceedToCheckoutButton> createState() =>
      _ProceedToCheckoutButtonState();
}

class _ProceedToCheckoutButtonState extends State<ProceedToCheckoutButton> {
  @override
  Widget build(BuildContext context) {
    final w = Get.width;
    return AnimatedPositioned(
      curve: Curves.linearToEaseOut,
      duration: widget.animationDur ?? 200.milliseconds,
      bottom: widget.isProceedToCartState ? 0 : -50,
      width: w,
      right: widget.isProceedToCartState ? 0 : -w,
      child: AnimatedBuilder(
          animation: widget.animation,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Material(
              type: MaterialType.transparency,
              child: Row(
                children: [
                  Expanded(
                    child: Button(
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/close.svg',
                            height: 20,
                            color: Colors.white,
                          ),
                          Text(
                            "Close",
                            style: Get.textTheme.bodyLarge!.copyWith(
                              height: 1.1,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 3,
                    child: Button(
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Proceed to',
                                style: Get.textTheme.displayLarge!.copyWith(
                                  color: Colors.white.withOpacity(.5),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                'My Cart',
                                style: Get.textTheme.bodyLarge!.copyWith(
                                  color: Colors.white,
                                  height: 1.15,
                                ),
                              ),
                            ],
                          ), 
                          SvgPicture.asset(
                            'assets/icons/arrow_right.svg',
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          builder: (context, c) {
            return Transform.translate(
              offset: widget.animation.value,
              child: c,
            );
          }),
    );
  }
}
