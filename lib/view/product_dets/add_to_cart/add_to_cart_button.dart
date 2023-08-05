import 'package:aissam_store/view/public/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AddToCartButton extends StatefulWidget {
  const AddToCartButton(
      {super.key,
      required this.isProceedToCartState,
      required this.animation,
      this.animationDur});

  final bool isProceedToCartState;
  final Animation<Offset> animation;
  final Duration? animationDur;

  @override
  State<AddToCartButton> createState() => _AddToCartButtonState();
}

class _AddToCartButtonState extends State<AddToCartButton> {
  @override
  Widget build(BuildContext context) {
    final w = Get.width;
    return AnimatedPositioned(
      curve: Curves.linearToEaseOut,
      duration: widget.animationDur ?? 200.milliseconds,
      bottom: widget.isProceedToCartState ? -50 : 0,
      width: w,
      right: widget.isProceedToCartState ? w : 0,
      child: AnimatedBuilder(
        animation: widget.animation,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Material(
            type: MaterialType.transparency,
            child: Button(
              onPressed: () {},
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Add to cart',
                        style: Get.textTheme.bodySmall!.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '370.00 MAD',
                            style: Get.textTheme.bodyLarge!.copyWith(
                              color: Colors.white,
                              height: 1.15,
                            ),
                          ),
                          SizedBox(width: 5),
                          CircleAvatar(
                            radius: 1,
                            backgroundColor: Colors.white,
                          ),
                          SizedBox(width: 5),
                          Text(
                            '2 items',
                            style: Get.textTheme.bodySmall!.copyWith(
                                height: 1.15, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SvgPicture.asset(
                    'assets/icons/bag.svg',
                    height: 25,
                  )
                ],
              ),
            ),
          ),
        ),
        builder: (context, c) {
          return Transform.translate(
            offset: widget.animation.value,
            child: c,
          );
        },
      ),
    );
  }
}
