import 'package:aissam_store/core/constants/colors.dart';
import 'package:aissam_store/view/checkout/steps/payment.dart';
import 'package:aissam_store/view/checkout/steps/review.dart';
import 'package:aissam_store/view/checkout/steps/shipping.dart';
import 'package:aissam_store/view/public/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  int _currentStep = 0;
  int _userChangingStep = 0;

  late final PageController _pageController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep >= 2) return;
    setState(() {
      _currentStep++;
    });
    _pageController.animateToPage(_currentStep,
        duration: 500.milliseconds, curve: Curves.linearToEaseOut);
  }

  void _changeToStep(int stepIndex) {
    if (stepIndex > _currentStep) return;
    setState(() {
      _userChangingStep = stepIndex;
    });
    _pageController.animateToPage(_userChangingStep,
        duration: 500.milliseconds, curve: Curves.linearToEaseOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        forceMaterialTransparency: true,
        title: Text(
          'Checkout',
          style: Get.textTheme.headlineMedium!.copyWith(
            color: CstColors.a,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: Get.back,
          icon: SvgPicture.asset(
            'assets/icons/ic_fluent_chevron_left_24_filled.svg',
            color: CstColors.a,
            height: 25,
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerRight,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _Header(currentStep: _currentStep, onTapStep: _changeToStep),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: 3,
              itemBuilder: (context, i) {
                switch (i) {
                  case 0:
                    return const Shipping();
                  case 1:
                    return const Payment();
                  case 2:
                    return const Review();
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 25, left: 25, right: 25),
            child: Button(
              onPressed: _nextStep,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _buttonLabelsByStep.elementAt(_currentStep),
                    style: Get.textTheme.headlineSmall!.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  SvgPicture.asset(
                    _buttonIconByStep.elementAt(_currentStep),
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  final List<String> _buttonLabelsByStep = [
    'NEXT',
    'Confirm & Continue',
    'Place Order'
  ];
  final List<String> _buttonIconByStep = [
    'assets/icons/arrow_right.svg',
    'assets/icons/arrow_right.svg',
    'assets/icons/ic_fluent_checkmark_circle_24_regular.svg'
  ];
}

class _Header extends StatelessWidget {
  const _Header(
      {super.key, required this.currentStep, required this.onTapStep});

  final int currentStep;
  final Function(int step) onTapStep;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 85,
      child: ColoredBox(
        color: CstColors.b.withOpacity(.2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _getStepIndex(
                currentStep >= 0,
                'Shipping',
                'assets/icons/ic_fluent_vehicle_truck_profile_24_regular.svg',
                () => onTapStep(0)),
            _getStepSeperator(currentStep >= 1),
            _getStepIndex(
                currentStep >= 1,
                'Payment',
                'assets/icons/ic_fluent_payment_24_regular.svg',
                () => onTapStep(1)),
            _getStepSeperator(currentStep >= 2),
            _getStepIndex(
                currentStep >= 2,
                'Review',
                'assets/icons/ic_fluent_clipboard_task_24_regular.svg',
                () => onTapStep(2)),
          ],
        ),
      ),
    );
  }

  _getStepSeperator(bool active) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          height: 1,
          width: 17,
          child: ColoredBox(color: active ? CstColors.a : CstColors.b),
        ),
      );
  _getStepIndex(bool active, String label, String icon, Function() onTap) =>
      GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              icon,
              color: active ? CstColors.a : CstColors.b,
              width: 30,
            ),
            Text(
              label,
              style: Get.textTheme.displayMedium!.copyWith(
                color: active ? CstColors.a : CstColors.b,
                fontWeight: active ? FontWeight.bold : FontWeight.w500,
              ),
            )
          ],
        ),
      );
}
