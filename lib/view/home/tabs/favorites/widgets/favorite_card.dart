import 'package:aissam_store/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class FavoriteCard extends StatefulWidget {
  const FavoriteCard({super.key});

  @override
  State<FavoriteCard> createState() => _FavoriteCardState();
}

class _FavoriteCardState extends State<FavoriteCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 95,
      child: Row(
        children: [
          // SizedBox(
          //   width: 60,
          //   child: ClipRRect(
          //     borderRadius: BorderRadius.circular(10),
          //     child: Image.asset(
          //       'assets/images/image_1 1x.png',
          //       fit: BoxFit.cover,
          //     ),
          //   ),
          // ),
          SizedBox(
            width: 7,
          ),
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Premier Jersey Hijabs - Rose Quartz',
                        style: Get.textTheme.bodyLarge!
                            .copyWith(color: CstColors.a, height: 1.2),
                      ),
                      Text(
                        '185.00 MAD',
                        style: Get.textTheme.bodyMedium!.copyWith(
                          color: CstColors.b,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
                      Row(
                        children:
                            List.generate(5, (index) => _getStar(index <= 2)),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: _CircleButton(
                    color: Colors.greenAccent[700]!,
                    iconPath: 'assets/icons/arrow_right_shorter.svg',
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 45,
                  child: _CircleButton(
                    color: Colors.pinkAccent[400]!,
                    iconPath: 'assets/icons/ic_fluent_heart_24_filled.svg',
                    onpressedIconPath: 'assets/icons/favorite.svg',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _getStar(bool fill) => SvgPicture.asset(
        'assets/icons/preview_star.svg',
        color: fill ? CstColors.a : CstColors.a.withOpacity(.5),
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
