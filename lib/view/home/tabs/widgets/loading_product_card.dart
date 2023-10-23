import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingProductCard extends StatefulWidget {
  const LoadingProductCard({super.key});

  @override
  State<LoadingProductCard> createState() => _LoadingProductCardState();
}

class _LoadingProductCardState extends State<LoadingProductCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _colorAnimationCtrl;
  late final Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    _colorAnimationCtrl =
        AnimationController(vsync: this, duration: 400.milliseconds)
          ..repeat(reverse: true)
          ..addListener(() {
            setState(() {});
          });
    _colorAnimation =
        ColorTween(begin: Colors.grey.shade500, end: Colors.grey.shade300)
            .animate(_colorAnimationCtrl);

    _w1 = _randomWidthFraction;
    _w2 = _randomWidthFraction;
    _w3 = _randomWidthFraction;
    _w4 = _randomWidthFraction;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _colorAnimationCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 170,
            child: _getLoadingBoxDec(0),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    height: 20,
                    child: FractionallySizedBox(
                      widthFactor: _w1,
                      child: _getLoadingBoxDec(0.2),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 7,
              ),
              SizedBox.square(
                dimension: 20,
                child: _getLoadingBoxDec(0.4),
              ),
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          SizedBox(
            height: 20,
            child: FractionallySizedBox(
              widthFactor: _w2,
              child: _getLoadingBoxDec(0.6),
            ),
          ),
          const SizedBox(height: 5),
          SizedBox(
            height: 12,
            child: FractionallySizedBox(
              widthFactor: _w3,
              child: _getLoadingBoxDec(0.8),
            ),
          ),
          const SizedBox(height: 5),
          SizedBox(
            height: 12,
            child: FractionallySizedBox(
              widthFactor: _w4,
              child: _getLoadingBoxDec(1),
            ),
          ),
        ],
      ),
    );
  }

  double? _w1;
  double? _w2;
  double? _w3;
  double? _w4;
  Widget _getLoadingBoxDec(franction) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color.lerp(
            _colorAnimation.value, Colors.grey.shade400, franction * 0.7),
      ),
      child: Center(),
    );
  }

  double get _randomWidthFraction {
    double w = 0;
    do {
      w = Random.secure().nextDouble() * 1;
    } while (w <= 0.4);

    return w;
  }
}
