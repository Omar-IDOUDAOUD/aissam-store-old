// ignore: file_names

import 'package:aissam_store/core/constants/colors.dart';
import 'package:aissam_store/view/product_dets/add_to_cart_bottom_sheet/add_to_card_bottom_sheet.dart';
import 'package:aissam_store/view/product_dets/add_to_cart_bottom_sheet/add_to_cart_button.dart';
import 'package:aissam_store/view/product_dets/add_to_cart_bottom_sheet/proceed_to_checkout_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class DetsAndBuyButton extends StatelessWidget {
  const DetsAndBuyButton(
      {Key? key,
      required this.title,
      required this.reviewRank,
      required this.reviewNumber,
      required this.price})
      : super(key: key);
  final String title;
  final int reviewRank;
  final int reviewNumber;
  final double price;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 25, left: 35, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Get.textTheme.headlineSmall!.copyWith(
                        height: 1.25,
                        fontWeight: FontWeight.w500,
                        color: ColorsConsts.a,
                      ),
                    ),
                    _getBodySmallText('${price.toStringAsFixed(2)} MAD',
                        ColorsConsts.a, FontWeight.w700),
                    const SizedBox(height: 7),
                    _getBodySmallText(
                        'Details', ColorsConsts.b, FontWeight.w600),
                    _getRichText('Material', '12-gouge cashmere'),
                    _getRichText('Shipping', 'in 2 to 5 days'),
                    _getRichText('Returns', 'ithin 30 days'),
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: _getReviewWidget,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const _BuyButton(),
                ],
              ),
            ],
          ),
          const SizedBox(height: 0),
          _getBodySmallText('Description', ColorsConsts.b, FontWeight.w600),
          _getBodyMediumText(
              'Our cult-favorite premium jersey is super-soft, effortiess and made to last. it comes in our cult-favorite muted blush',
              ColorsConsts.a,
              FontWeight.w500),
          const SizedBox(height: 7),
          _getBodySmallText(
              'Chat with seller', ColorsConsts.b, FontWeight.w600),
          _getChatWithSellerMethod('Phone Call', '+21276858745', () {}),
          _getChatWithSellerMethod('WhatsApp', '', () {})
        ],
      ),
    );
  }

  Widget _getChatWithSellerMethod(
      String label, String subLabel, Function onTap) {
    return Row(
      children: [
        _getBodySmallText(label, ColorsConsts.a, FontWeight.w600),
        const Spacer(),
        _getBodyMediumText(subLabel, ColorsConsts.c, FontWeight.normal),
        const SizedBox(
          width: 5,
        ),
        SvgPicture.asset(
          'assets/icons/next.svg',
          height: 20,
        )
      ],
    );
  }

  Widget _getRichText(String txt1, String txt2) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: '$txt1: ',
            style: Get.textTheme.bodySmall!.copyWith(
              color: ColorsConsts.a,
              fontWeight: FontWeight.w600,
            ),
          ),
          TextSpan(
            text: txt2,
            style: Get.textTheme.bodySmall!.copyWith(
              color: ColorsConsts.b,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _getBodySmallText(String text, Color color, FontWeight fontWeight) {
    return Text(
      text,
      style: Get.textTheme.bodySmall!.copyWith(
        color: color,
        fontWeight: fontWeight,
      ),
    );
  }

  Widget _getBodyMediumText(String text, Color color, FontWeight fontWeight) {
    return Text(
      text,
      style: Get.textTheme.bodyMedium!.copyWith(
        color: color,
        fontWeight: fontWeight,
      ),
    );
  }

  Widget get _getReviewWidget => Column(
        children: [
          Row(
            children: List.generate(5, (index) => _getStar(index <= 2)),
          ),
          Text(
            '35 review',
            style: Get.textTheme.bodySmall!.copyWith(
              color: ColorsConsts.a,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
  Widget _getStar(bool fill) => SvgPicture.asset(
        'assets/icons/preview_star.svg',
        color: fill ? ColorsConsts.a : ColorsConsts.a.withOpacity(.5),
        height: 15,
      );
}

class _BuyButton extends StatefulWidget {
  const _BuyButton({Key? key}) : super(key: key);

  @override
  State<_BuyButton> createState() => _BuyButtonState();
}

class _BuyButtonState extends State<_BuyButton>
    with SingleTickerProviderStateMixin {
  late final OverlayState _addToCartButtonOverLayState;
  late final OverlayEntry _addToCartButtonOverLayEntry;
  late final OverlayEntry _proceedToCartButtonOverLayEntry;
  late final AnimationController _addToCartButtonOverLayAnCtrl;
  late final Animation<Offset> _addToCartButtonOverLayAn;
  late final PageController _addToCartPageController;
  final Duration _animationDur = 600.milliseconds;

  @override
  void dispose() {
    // TODO: implement dispose
    if (_isAddToCartInitialed) {
      _addToCartPageController.dispose();
      _addToCartButtonOverLayAnCtrl.dispose();
    }
    super.dispose();
  }

  bool _isAddToCartInitialed = false;

  void _initializeAddToCart() {
    if (_isAddToCartInitialed) return;
    _isAddToCartInitialed = true;
    _addToCartPageController = PageController();
    _addToCartButtonOverLayAnCtrl =
        AnimationController(vsync: this, duration: _animationDur);
    _addToCartButtonOverLayAn =
        Tween<Offset>(begin: Offset(0, 100), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _addToCartButtonOverLayAnCtrl,
        curve: Curves.linearToEaseOut,
      ),
    );

    _addToCartButtonOverLayState = Overlay.of(context);
    _addToCartButtonOverLayEntry = OverlayEntry(
      builder: (_) {
        return AddToCartButton(
          onTap: () {
            _addToCartPageController.animateToPage(1,
                duration: _animationDur, curve: Curves.linearToEaseOut);
            _addToCartButtonOverLayState.setState(() {
              _isProceedToCartState = true;
            });
          },
          animation: _addToCartButtonOverLayAn,
          animationDur: _animationDur,
          isProceedToCartState: _isProceedToCartState,
        );
      },
    );
    _proceedToCartButtonOverLayEntry = OverlayEntry(
      builder: (_) {
        return ProceedToCheckoutButton(
          animation: _addToCartButtonOverLayAn,
          animationDur: _animationDur,
          isProceedToCartState: _isProceedToCartState,
        );
      },
    );
  }

  bool _isProceedToCartState = false;

  void _closeAddToCartButton() {
    _addToCartButtonOverLayAnCtrl.reverse().then((value) {
      _addToCartButtonOverLayEntry.remove();
      _proceedToCartButtonOverLayEntry.remove();
    });
  }

  void _openAddToCartButton() {
    _initializeAddToCart();
    showModalBottomSheet(
      constraints: BoxConstraints(maxHeight: Get.height * 0.9),
      context: context,
      enableDrag: true,
      isScrollControlled: true,
      builder: (_) {
        return AddToCartBottomSheet(
          title: 'ADD TO CART',
          pageController: _addToCartPageController,
          onDispose: _closeAddToCartButton,
          animationDur: _animationDur,
        );
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
    );
    200.milliseconds.delay().then((value) {
      _isProceedToCartState = false;
      _addToCartButtonOverLayState.rearrange(
          [_addToCartButtonOverLayEntry, _proceedToCartButtonOverLayEntry]);
      _addToCartButtonOverLayAnCtrl.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        _openAddToCartButton();
      },
      child: Container(
        width: 80,
        decoration: BoxDecoration(
          color: ColorsConsts.a,
          borderRadius: BorderRadius.circular(18),
        ),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
        child: Column(
          children: [
            SvgPicture.asset('assets/icons/bag.svg'),
            const SizedBox(
              height: 8,
            ),
            Text(
              'Add to cart',
              textAlign: TextAlign.center,
              style: Get.textTheme.bodyMedium!
                  .copyWith(color: Colors.white, height: 1.2),
            )
          ],
        ),
      ),
    );
  }
}
