import 'package:aissam_store/core/constants/colors.dart';
import 'package:aissam_store/view/public/checkbox.dart';
import 'package:aissam_store/view/public/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'PAYMENT METHODE',
                    style: Get.textTheme.bodyLarge!.copyWith(
                      color: CstColors.a,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Image.asset(
                    'assets/images/visa_logo.png',
                    height: 12,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 55,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                separatorBuilder: (_, i) => const SizedBox(width: 5),
                itemBuilder: (_, i) {
                  return _PaymentMethodeCard(isSelected: i != 0);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _getText('Card Number'),
                  CustomTextField(
                    borderRadius: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _getText('Expiration'),
                            CustomTextField(
                              borderRadius: 10,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _getText('Scurity Code'),
                            CustomTextField(
                              borderRadius: 10,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 3),
                  GestureDetector(
                    onTap: () => setState(() {
                      _savePaymentData = !_savePaymentData;
                    }),
                    child: Row(
                      children: [
                        CheckBox(
                          isSelected: _savePaymentData,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        _getText('Save payment methode data'),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  bool _savePaymentData = true;

  _getText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Text(
        text,
        style: Get.textTheme.bodyMedium!.copyWith(
          color: CstColors.a,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _PaymentMethodeCard extends StatefulWidget {
  const _PaymentMethodeCard({super.key, this.isSelected = false});
  final bool isSelected;

  @override
  State<_PaymentMethodeCard> createState() => __PaymentMethodeCardState();
}

class __PaymentMethodeCardState extends State<_PaymentMethodeCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.size.width * 0.4,
      // height: 52,
      decoration: BoxDecoration(
        color: !widget.isSelected ? Colors.grey.withOpacity(.1) : null,
        borderRadius: BorderRadius.circular(7),
        border: Border.all(
            color: widget.isSelected
                ? Colors.grey.withOpacity(.1)
                : Colors.transparent,
            width: 2),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/visa_logo.png',
                height: 11,
              ),
              Expanded(
                child: Text(
                  'Visa',
                  textAlign: TextAlign.end,
                  style: Get.textTheme.bodySmall!.copyWith(
                    height: 1.2,
                    color: CstColors.b,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          ),
          Text(
            'Credit Card',
            style: Get.textTheme.bodySmall!.copyWith(
              color: CstColors.a,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
