import 'package:aissam_store/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class FullScreenImage extends StatefulWidget {
  const FullScreenImage({Key? key}) : super(key: key);

  @override
  State<FullScreenImage> createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
  @override
  void initState() {
    super.initState();
    _images = Get.arguments['images'];
    _activeIndex = Get.arguments['active_image'];
    // _tag = _images[_activeIndex];
    _controller = PageController(initialPage: _activeIndex);
  }

  // late final String _tag;
  late int _activeIndex;
  late final List<String> _images;
  late final PageController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CstColors.a.withOpacity(.8),
      body: Column(
        children: [
          SizedBox(
            width: Get.size.width,
            child: Padding(
              padding: EdgeInsets.fromLTRB(35, 33, 35, 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(
                    'assets/icons/back.svg',
                    height: 25,
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: (_activeIndex + 1).toString(),
                          style: Get.textTheme.headlineMedium!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        TextSpan(
                          text: '/${_images.length}',
                          style: Get.textTheme.bodySmall!.copyWith(
                            color: Colors.white.withOpacity(.7),
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        //
                      ],
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/icons/favorite.svg',
                    color: Colors.white,
                    height: 25,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: PageView.builder(
              clipBehavior: Clip.none,
              controller: _controller,
              onPageChanged: (i) {
                setState(() {
                  //TODO: try getter method.
                  // _tag = _images.elementAt(i);
                  _activeIndex = i;
                });
              },
              itemCount: _images.length,
              itemBuilder: (_, i) {
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    GestureDetector(
                      onTap: Get.back,
                      child: const ColoredBox(
                        color: Colors.transparent,
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Hero(
                        tag: _activeIndex,
                        child: Image.asset(
                          _images.elementAt(i),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
