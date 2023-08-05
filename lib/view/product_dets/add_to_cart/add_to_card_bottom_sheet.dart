import 'package:aissam_store/core/constants/colors.dart';
import 'package:aissam_store/view/product_dets/add_to_cart/widgets/color_selection.dart';
import 'package:aissam_store/view/product_dets/add_to_cart/widgets/quantity_selection.dart';
import 'package:aissam_store/view/product_dets/add_to_cart/widgets/size_selection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AddToCartBottomSheet extends StatefulWidget {
  const AddToCartBottomSheet(
      {super.key,
      required this.onDispose,
      required this.onNext,
      this.animationDur});
  final Function onDispose;
  final Function onNext;
  final Duration? animationDur;

  @override
  State<AddToCartBottomSheet> createState() => _AddToCartBottomSheetState();
}

class _AddToCartBottomSheetState extends State<AddToCartBottomSheet> {
  @override
  void dispose() {
    // TODO: implement dispose
    widget.onDispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController();
    2.seconds.delay().then((value) {
      if (!this.mounted) return;
      setState(() {
        page = 1;
      });
      widget.onNext();
      _pageController.animateToPage(1,
          duration: widget.animationDur ?? 400.milliseconds,
          curve: Curves.linearToEaseOut);
    });
  }

  int page = 0;
  late final PageController _pageController;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 15,
        ),
        Center(
          child: Text(
            'ADD TO CART',
            style: Get.textTheme.headlineSmall!
                .copyWith(color: Colors.black, fontWeight: FontWeight.w700),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        AnimatedSize(
          duration: widget.animationDur ?? 400.milliseconds,
          curve: Curves.linearToEaseOut,
          child: SizedBox(
            height: page == 0 ? Get.height * 0.8 : Get.height * 0.4,
            child: PageView(
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                _FirstPart(),
                _SecondPart(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _FirstPart extends StatelessWidget {
  const _FirstPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 12),
      child: ListView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Premium Jersey Hijab - Rose Quartz',
            style: Get.textTheme.headlineMedium!.copyWith(
              color: CstColors.a,
              height: 1.2,
            ),
          ),
          SizedBox(height: 5),
          Text(
            "Size",
            style: Get.textTheme.headlineSmall!.copyWith(color: CstColors.a),
          ),
          SizedBox(height: 5),
          SizeSelection(),
          SizedBox(height: 10),
          Text(
            "Color",
            style: Get.textTheme.headlineSmall!.copyWith(color: CstColors.a),
          ),
          SizedBox(height: 5),
          ColorSelection(),
          SizedBox(height: 10),
          Row(
            children: [
              Text(
                "Quantity",
                style:
                    Get.textTheme.headlineSmall!.copyWith(color: CstColors.a),
              ),
              Spacer(),
              Text(
                "2 items",
                style: Get.textTheme.bodyMedium!.copyWith(color: CstColors.b),
              ),
            ],
          ),
          SizedBox(height: 5),
          QuantitySelection(),
          // Spacer(),
          // SizedBox(
          //   height: Get.height * 0.3,
          // )
        ],
      ),
    );
  }
}

class _SecondPart extends StatelessWidget {
  const _SecondPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        Text('Added to cart successfully',
            style: Get.textTheme.headlineSmall!.copyWith(color: CstColors.a)),
        // SizedBox(height: 5),
        Text('Checkout now to place your order',
            style: Get.textTheme.bodySmall!.copyWith(color: CstColors.b)),
        SizedBox(height: 20),
        SvgPicture.asset(
          'assets/icons/ic_fluent_checkmark_circle_24_regular.svg',
          height: 80,
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

