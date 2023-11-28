import 'package:aissam_store/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class LoadingFavoriteCard extends StatefulWidget {
  const LoadingFavoriteCard({super.key});

  @override
  State<LoadingFavoriteCard> createState() => _LoadingFavoriteCardState();
}

class _LoadingFavoriteCardState extends State<LoadingFavoriteCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 95,
      child: SizedBox.expand(
        child: ColoredBox(color: Colors.grey),
      ),
    );
  }

  Widget _getStar(bool fill) => SvgPicture.asset(
        'assets/icons/preview_star.svg',
        color: fill ? ColorsConsts.a : ColorsConsts.a.withOpacity(.5),
        height: 15,
      );
}

class _CircleButton extends StatefulWidget {
  const _CircleButton(
      {super.key,
      required this.iconPath,
      required this.color,
      this.onpressedIconPath});
  final String iconPath;
  final Color color;
  final String? onpressedIconPath;

  @override
  State<_CircleButton> createState() => _CircleButtonState();
}

class _CircleButtonState extends State<_CircleButton> {
  bool _pressed = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.onpressedIconPath == null) return;
        setState(() {
          _pressed = !_pressed;
        });
      },
      child: CircleAvatar(
        radius: 20,
        backgroundColor: widget.color.withOpacity(.15),
        child: SvgPicture.asset(
          _pressed ? widget.onpressedIconPath! : widget.iconPath,
          color: widget.color,
          width: 20,
        ),
      ),
    );
  }
}
