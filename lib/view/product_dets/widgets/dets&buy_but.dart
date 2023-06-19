// ignore: file_names

import 'package:aissam_store/core/constants/colors.dart';
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
                      style: Get.textTheme.headline2!.copyWith(height: 1.25),
                    ),
                    _getTextH4('$price MAD', CstColors.a),
                    const SizedBox(height: 7),
                    _getTextH4('Details', CstColors.b),
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
          const SizedBox(height: 7),
          _getTextH4('Description', CstColors.b),
          _getTextH4(
              'Our cult-favorite premium jersey is super-soft, effortiess and made to last. it comes in our cult-favorite muted blush',
              CstColors.a),
          const SizedBox(height: 7),
          _getTextH4('Chat with seller', CstColors.b),
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
        _getTextH4(label, CstColors.a),
        const Spacer(),
        _getTextH4(subLabel, CstColors.c),
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
            style: Get.textTheme.headline4!.copyWith(
              color: CstColors.a,
              fontWeight: FontWeight.w600,
            ),
          ),
          TextSpan(
            text: txt2,
            style: Get.textTheme.headline4!.copyWith(
              color: CstColors.b,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _getTextH4(String text, Color color) {
    return Text(
      text,
      style: Get.textTheme.headline4!.copyWith(
        color: color,
        fontWeight: FontWeight.w600,
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
            style: Get.textTheme.headline5!.copyWith(
              color: CstColors.a,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
  Widget _getStar(bool fill) => SvgPicture.asset(
        'assets/icons/preview_star.svg',
        color: fill ? CstColors.a : CstColors.a.withOpacity(.5),
        height: 15,
      );
}

class _BuyButton extends StatelessWidget {
  const _BuyButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      decoration: BoxDecoration(
        color: CstColors.a,
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
            style: Get.textTheme.headline4!
                .copyWith(color: Colors.white, height: 1.2),
          )
        ],
      ),
    );
  }
}
