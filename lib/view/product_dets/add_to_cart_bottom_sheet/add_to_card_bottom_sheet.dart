import 'package:aissam_store/core/constants/colors.dart';
import 'package:aissam_store/view/product_dets/add_to_cart_bottom_sheet/widgets/color_selection.dart';
import 'package:aissam_store/view/product_dets/add_to_cart_bottom_sheet/widgets/quantity_selection.dart';
import 'package:aissam_store/view/product_dets/add_to_cart_bottom_sheet/widgets/size_selection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AddToCartBottomSheet extends StatefulWidget {
  const AddToCartBottomSheet({
    super.key,
    this.onDispose,
    this.animationDur,
    required this.pageController,
    required this.title, 
  });
  final Function()? onDispose;
  // final Function()? onSave;
  final Duration? animationDur;
  final PageController pageController;
  final String title; 

  @override
  State<AddToCartBottomSheet> createState() => _AddToCartBottomSheetState();
}

class _AddToCartBottomSheetState extends State<AddToCartBottomSheet> {
  @override
  void dispose() {
    // TODO: implement dispose
    if (widget.onDispose != null) widget.onDispose!();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    widget.pageController.addListener(() {
      if (this.mounted) setState(() {});
    });
  }

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
           widget.title,
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
            height: widget.pageController.hasClients
                ? widget.pageController.page == 0
                    ? Get.height * 0.8
                    : Get.height * 0.4
                : Get.height * 0.8,
            child: PageView(
              controller: widget.pageController,
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
