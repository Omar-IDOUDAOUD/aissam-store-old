import 'package:aissam_store/core/constants/colors.dart';
import 'package:aissam_store/view/public/button.dart';
import 'package:aissam_store/view/public/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class AddCheckoutAddress extends StatefulWidget {
  const AddCheckoutAddress({super.key});

  @override
  State<AddCheckoutAddress> createState() => _AddCheckoutAddressState();
}

class _AddCheckoutAddressState extends State<AddCheckoutAddress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        forceMaterialTransparency: true,
        title: Text(
          'Add Address',
          style: Get.textTheme.headlineMedium!
              .copyWith(color: CstColors.a, fontWeight: FontWeight.w700),
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
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 15,
              ),
              children: [
                _getText('Shipping to'),
                CustomTextField(
                  borderRadius: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _getText('First Name'),
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
                          _getText('Last Name'),
                          CustomTextField(
                            borderRadius: 10,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                _getText('Country'),
                CustomTextField(
                  borderRadius: 10,
                ),
                _getText('Address'),
                CustomTextField(
                  borderRadius: 10,
                ),
                _getText('City'),
                CustomTextField(
                  borderRadius: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _getText('State/Region'),
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
                          _getText('Postal Code'),
                          CustomTextField(
                            borderRadius: 10,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                _getText('Phone Number'),
                CustomTextField(
                  borderRadius: 10,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 25, left: 25, right: 25),
            child: Button(
              isHeightMinimize: true,
              onPressed: Get.back,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Save",
                    style: Get.textTheme.headlineSmall!.copyWith(
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
          )
        ],
      ),
    );
  }

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
