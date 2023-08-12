import 'package:aissam_store/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Shipping extends StatefulWidget {
  const Shipping({super.key});

  @override
  State<Shipping> createState() => _ShippingState();
}

class _ShippingState extends State<Shipping> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'ADDRESSES',
                style: Get.textTheme.bodyLarge!.copyWith(
                  color: CstColors.a,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              SvgPicture.asset(
                'assets/icons/ic_fluent_add_24_filled.svg',
                color: Colors.blue.shade400,
                height: 14,
              ),
              const SizedBox(width: 3),
              GestureDetector(
                onTap: () => Get.toNamed('add_checkout_address'),
                child: Text(
                  'Add New',
                  style: Get.textTheme.bodyMedium!.copyWith(
                    color: Colors.blue.shade400,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const _AddressCard(isSelected: true),
          const SizedBox(height: 10),
          const _AddressCard(),
        ],
      ),
    );
  }
}

class _AddressCard extends StatelessWidget {
  const _AddressCard({super.key, this.isSelected = false});
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: isSelected ? Colors.grey.withOpacity(.1) : null,
        border: isSelected
            ? null
            : Border.all(color: Colors.grey.withOpacity(.1), width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Home',
                  style: Get.textTheme.bodyMedium!.copyWith(
                    color: CstColors.a,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                _getText('Noah Tankin'),
                _getText('86 Baker St'),
                _getText('North Sedney NSW 2156'),
                _getText('Australia')
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(height: 5),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(.2),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                  child: Row(
                    children: [
                      Text(
                        'Edit',
                        style: Get.textTheme.displayLarge!.copyWith(
                          color: CstColors.c,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      SvgPicture.asset(
                        "assets/icons/ic_fluent_edit_24_filled.svg",
                        color: CstColors.c,
                        height: 11,
                      )
                    ],
                  ),
                ),
              ),
              const Spacer(),
              if (isSelected)
                SvgPicture.asset(
                  "assets/icons/ic_fluent_checkmark_24_filled.svg",
                  color: CstColors.c,
                  height: 20,
                ),
              const SizedBox(height: 3),
            ],
          ),
        ],
      ),
    );
  }

  _getText(String text) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      style: Get.textTheme.bodyMedium!.copyWith(
        color: CstColors.b,
        fontWeight: FontWeight.w400,
        height: 1.2,
      ),
    );
  }
}
