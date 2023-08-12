import 'package:aissam_store/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Review extends StatefulWidget {
  const Review({super.key});

  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 15),
              children: [
                _getRow(
                  title1: 'SHIP TO',
                  title2: 'Home',
                  child: Text(
                    'Noah Tankin\n68 Baker St...',
                    style: Get.textTheme.bodyMedium!.copyWith(
                      height: 1.2,
                      color: CstColors.b,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                _getDivider(),
                _getRow(
                  title1: 'DELIVERY',
                  title2: '2 to 5 days',
                ),
                _getDivider(),
                _getRow(
                  title1: 'PAYMENT',
                  title2: 'Credit Card',
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/visa_logo.png',
                        height: 10,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Visa',
                        textAlign: TextAlign.end,
                        style: Get.textTheme.bodySmall!.copyWith(
                          height: 1.2,
                          color: CstColors.b,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                _getDivider(),
                _getRow(
                  title1: 'PRODUCTS',
                  title2: '3 Produtcts',
                  child: Text(
                    '6 total items',
                    style: Get.textTheme.bodyMedium!.copyWith(
                      height: 1.2,
                      color: CstColors.b,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                _getDivider(),
                Text(
                  'TOTAL',
                  style: Get.textTheme.bodyLarge!.copyWith(
                    color: CstColors.a,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                _getRow2('6 item (of 3 products)', 1110),
                _getRow2('Shipping', 6),
                _getRow2('Discount', -0),
                // Spacer(),
              ],
            ),
          ),
          SizedBox(
            height: 2,
            child: Row(
              children: List.generate(
                (Get.size.width - 25 * 2) ~/ (5 + 4), //5: dash width, 4: hosrizontal padding(left+right)
                (index) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: SizedBox(
                        height: 2,
                        child: DecoratedBox(
                          decoration: BoxDecoration(color: CstColors.a),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total price',
                style: Get.textTheme.bodyMedium!.copyWith(
                  height: 1.2,
                  color: CstColors.a,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '1116.00 MAD',
                style: Get.textTheme.bodyMedium!.copyWith(
                  height: 1.2,
                  color: CstColors.a,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }



  _getDivider() => SizedBox(
        height: 20,
        child: Center(
          child: Divider(
            color: Colors.grey.withOpacity(.5),
            height: 2,
          ),
        ),
      );
  _getRow({required String title1, required String title2, Widget? child}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: Text(
            title1,
            style: Get.textTheme.bodyLarge!.copyWith(
              color: CstColors.a,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          flex: 8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title2,
                style: Get.textTheme.bodyLarge!.copyWith(
                  color: CstColors.a,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (child != null) child,
            ],
          ),
        ),
      ],
    );
  }
    _getRow2(String title, double price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Get.textTheme.bodyMedium!.copyWith(
            height: 1.2,
            color: CstColors.a,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          '$price MAD',
          style: Get.textTheme.bodyMedium!.copyWith(
            height: 1.2,
            color: CstColors.b,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
