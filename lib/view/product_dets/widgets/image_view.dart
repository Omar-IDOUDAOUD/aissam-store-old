
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageView extends StatefulWidget {
  const ImageView({
    Key? key,
    required this.images,
    required this.pageController,
    required this.buildImageHeight,
    this.tag = 'NO-TAG'
  }) : super(key: key);
  final List<String> images;
  final PageController pageController;
  final Future<double> Function(int i) buildImageHeight;
  final String tag;
  // final Function onPageChanged;
  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  // final _maxHeight = Get.size.height * 0.99;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    400.milliseconds.delay().then((v) async {
      _setImageHeight(0);
    });
  }

  double _currentImageHeight = 0;

  Future<void> _setImageHeight(i) async {
    _currentImageHeight = await widget.buildImageHeight(i);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _currentImageHeight,
      child: PageView.builder(
        onPageChanged: (i) async {
          _setImageHeight(i);
        },
        controller: widget.pageController,
        itemCount: widget.images.length,
        itemBuilder: (_, i) {
          return GestureDetector(
            onTap: () { 
              widget.pageController.animateToPage(
                widget.pageController.page!.toInt() + 1,
                duration: 200.milliseconds,
                curve: Curves.linearToEaseOut,
              );
            },
            child: Hero(
              tag: widget.tag,
              child: Image.asset(
                widget.images.elementAt(i),
                fit: BoxFit.contain,
                alignment: Alignment.topCenter,
              ),
            ),
          );
        },
      ),
    );
  }
}
