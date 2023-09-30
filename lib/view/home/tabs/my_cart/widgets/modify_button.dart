import 'package:aissam_store/view/public/button/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:aissam_store/view/product_dets/add_to_cart_bottom_sheet/add_to_card_bottom_sheet.dart'
    as ProductDetsPage;
import 'package:aissam_store/view/home/tabs/my_cart/widgets/cart_item.dart'
    as CartItemFile show Button;

class ModifyButton extends StatefulWidget {
  const ModifyButton({super.key});

  @override
  State<ModifyButton> createState() => _ModifyButtonState();
}

class _ModifyButtonState extends State<ModifyButton>
    with SingleTickerProviderStateMixin {
  late final OverlayState _modifyProductOverLayState;
  late final OverlayEntry _modifyProductButtonOverLayEntry;
  late final AnimationController _modifyProductButtonOverLayAnCtrl;
  late final Animation<Offset> _modifyProductButtonOverLayAn;
  final Duration _animationDur = 600.milliseconds;

  @override
  void dispose() {
    // TODO: implement dispose
    if (_isAddToCartInitialed) {
      _modifyProductButtonOverLayAnCtrl.dispose();
    }
    super.dispose();
  }

  bool _isAddToCartInitialed = false;

  void _initializeAddToCart() {
    if (_isAddToCartInitialed) return;
    _isAddToCartInitialed = true;
    _modifyProductButtonOverLayAnCtrl =
        AnimationController(vsync: this, duration: _animationDur);
    _modifyProductButtonOverLayAn =
        Tween<Offset>(begin: Offset(0, 100), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _modifyProductButtonOverLayAnCtrl,
        curve: Curves.linearToEaseOut,
      ),
    );

    _modifyProductOverLayState = Overlay.of(context);
    _modifyProductButtonOverLayEntry = OverlayEntry(
      builder: (_) {
        return Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: AnimatedBuilder(
            animation: _modifyProductButtonOverLayAn,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Material(
                type: MaterialType.transparency,
                child: Button(
                  isHeightMinimize: true,
                  onPressed: _closeAddToCartButton,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Save Modifications',
                        style: Get.textTheme.bodyLarge!.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      SvgPicture.asset(
                        'assets/icons/ic_fluent_checkmark_24_filled.svg',
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
            ),
            builder: (context, c) {
              return Transform.translate(
                child: c,
                offset: _modifyProductButtonOverLayAn.value,
              );
            },
          ),
        );
      },
    );
  }

  void _closeAddToCartButton() {
    Get.back();
    _modifyProductButtonOverLayAnCtrl.reverse().then((value) {
      _modifyProductButtonOverLayEntry.remove();
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
        return ProductDetsPage.AddToCartBottomSheet(
          title: 'Modify Product',
          pageController: PageController(),
          onDispose: _closeAddToCartButton,
          animationDur: _animationDur,
        );
      },
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
    );
    200.milliseconds.delay().then((value) {
      _modifyProductOverLayState.rearrange([_modifyProductButtonOverLayEntry]);
      _modifyProductButtonOverLayAnCtrl.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CartItemFile.Button(
      color: Colors.blue[800]!,
      onTap: _openAddToCartButton,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Text(
          "Modify",
          style: Get.textTheme.bodyMedium!.copyWith(
            color: Colors.blue[800],
          ),
        ),
      ),
    );
  }
}
