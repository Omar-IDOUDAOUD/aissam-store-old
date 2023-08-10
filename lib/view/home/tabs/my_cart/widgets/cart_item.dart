import 'package:aissam_store/core/constants/colors.dart';
import 'package:aissam_store/view/home/tabs/my_cart/widgets/modify_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CartItem extends StatefulWidget {
  const CartItem({super.key});

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  bool _appearenceAnOne = true;
  bool _appearenceAnTwo = true;
  final _anDur = 300.milliseconds;
  final _anCurve = Curves.linearToEaseOut;

  _show() async {
    setState(() {
      _appearenceAnTwo = true;
    });
    await _anDur.delay();
    if (this.mounted)
      setState(() {
        _appearenceAnOne = true;
      });
  }

  _hide() async {
    setState(() {
      _appearenceAnOne = false;
    });
    await _anDur.delay();
    if (this.mounted)
      setState(() {
        _appearenceAnTwo = false;
      });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      curve: _anCurve,
      duration: _anDur,
      child: !_appearenceAnTwo
          ? const SizedBox.shrink()
          : AnimatedOpacity(
              curve: _anCurve,
              duration: _anDur,
              opacity: _appearenceAnOne ? 1 : 0,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: SizedBox(
                  height: 95,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 60,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            'assets/images/image_1 1x.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Expanded(
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Premier Jersey Hijabs - Rose Quartz',
                                    style: Get.textTheme.bodyLarge!.copyWith(
                                        color: CstColors.a, height: 1.2),
                                  ),
                                  Spacer(),
                                  Text(
                                    '1 item',
                                    style: Get.textTheme.bodyMedium!.copyWith(
                                      color: CstColors.b,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    '185.00 MAD',
                                    style: Get.textTheme.bodyMedium!.copyWith(
                                      color: CstColors.a,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: 5,
                              right: 0,
                              child: Button(
                                onTap: () {
                                  _hide();
                                  Get.closeCurrentSnackbar();
                                  _showRestoreItemSnackBar();
                                },
                                color: Colors.pink[600]!,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 7),
                                  child: SvgPicture.asset(
                                    'assets/icons/ic_fluent_delete_24_filled.svg',
                                    color: Colors.pink[600]!,
                                    width: 20,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 5,
                              right: 40,
                              child: ModifyButton(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  void _showRestoreItemSnackBar() {
    Get.showSnackbar(
      GetSnackBar(
        dismissDirection: DismissDirection.down,
        duration: 5.seconds,
        backgroundColor: CstColors.a,
        animationDuration: 450.milliseconds,
        isDismissible: true,
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        messageText: SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Product deleted",
                      style: Get.textTheme.bodyLarge!.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Premier Jesrsy Hijab - Rose Quartz",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Get.textTheme.bodySmall!.copyWith(
                        color: Colors.white.withOpacity(.5),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10),
              MaterialButton(
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 25),
                onPressed: () {
                  _show();
                  Get.closeCurrentSnackbar();
                },
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                color: Colors.white,
                child: Row(
                  children: [
                    Icon(
                      CupertinoIcons.restart,
                      size: 18,
                      color: CstColors.a,
                    ),
                    SizedBox(width: 5),
                    Text(
                      "Restor",
                      style: Get.textTheme.bodyLarge!.copyWith(
                        color: CstColors.a,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _getStar(bool fill) => SvgPicture.asset(
        'assets/icons/preview_star.svg',
        color: fill ? CstColors.a : CstColors.a.withOpacity(.5),
        height: 15,
      );
}

class Button extends StatefulWidget {
  const Button({
    super.key,
    required this.child,
    required this.color,
    this.onTap,
  });
  final Color color;
  final Widget child;
  final Function()? onTap;

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: SizedBox(
        height: 35,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: widget.color.withOpacity(.2),
          ),
          child: Center(child: widget.child),
        ),
      ),
    );
  }
}
