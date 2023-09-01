import 'dart:io';

import 'package:aissam_store/view/product_dets/widgets/dets&buy_but.dart';
import 'package:aissam_store/view/product_dets/widgets/header_buttons.dart';
import 'package:aissam_store/view/product_dets/widgets/image_view.dart';
import 'package:aissam_store/view/product_dets/widgets/image_view_nav.dart';
import 'package:aissam_store/view/product_dets/widgets/images&colors_albume.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProductDetails extends StatefulWidget {
  const ProductDetails({Key? key}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  late final PageController _imageViewCtrl;
  final List<String> _images = [
    'https://www.woolha.com/media/2023/04/flutter-get-image-width-and-height-dimensions-1200x627.jpg',
    'https://www.woolha.com/media/2023/04/flutter-get-image-width-and-height-dimensions-1200x627.jpg',
    'https://www.woolha.com/media/2023/04/flutter-get-image-width-and-height-dimensions-1200x627.jpg',
  ];

  int _activeImgIndex = 0;
  int _activeClrIndex = 0;

  bool _showHeader = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _imageViewCtrl = PageController();
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.offset > _currentImageHeight / 2 && _showHeader) {
          setState(() {
            _showHeader = false;
          });
        } else if (_scrollController.offset < _currentImageHeight / 2 &&
            !_showHeader) {
          setState(() {
            _showHeader = true;
          });
        }
      });
    600.milliseconds.delay().then((value) {
      setState(() {
        _showHeader = true;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _imageViewCtrl.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  final _maxImageViewHeight = Get.size.height * 0.85;
  Future<double> _getImageHeight(int i) async {
    final response =
        await http.get(Uri.parse(_images.elementAt(i))).catchError(print);
    final bytes = response.bodyBytes;
    var decodedImage = await decodeImageFromList(bytes);

    final w = decodedImage.width.toDouble();
    final h = decodedImage.height.toDouble();
    final screenW = Get.size.width;

    setState(() {
      _currentImageHeight = h * screenW / w;
      if (_currentImageHeight > _maxImageViewHeight)
        _currentImageHeight = _maxImageViewHeight;
    });
    return _currentImageHeight;
  }

  double _currentImageHeight = 0;

  late final ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ImageView(
            images: _images,
            pageController: _imageViewCtrl,
            buildImageHeight: _getImageHeight,
            tag: _images.elementAt(_activeImgIndex),
          ),
          Positioned(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedSize(
                    duration: 200.milliseconds,
                    curve: Curves.linearToEaseOut,
                    child: Column(
                      children: [
                        SizedBox(
                          height: _currentImageHeight,
                          child: ImageViewNavButtons(
                            isBestSelling: true,
                            onNext: () {
                              if (_activeImgIndex < _images.length - 1)
                                setState(() {
                                  _activeImgIndex++;
                                });

                              _imageViewCtrl.animateToPage(
                                _imageViewCtrl.page!.toInt() + 1,
                                duration: 200.milliseconds,
                                curve: Curves.linearToEaseOut,
                              );
                            },
                            onBack: () {
                              if (_activeImgIndex > 0)
                                setState(() {
                                  _activeImgIndex--;
                                });
                              _imageViewCtrl.animateToPage(
                                _imageViewCtrl.page!.toInt() - 1,
                                duration: 200.milliseconds,
                                curve: Curves.linearToEaseOut,
                              );
                            },
                            onFullScreen: () {
                              Get.toNamed(
                                '/fullscreen_image',
                                arguments: {
                                  'image_tag_index': _activeImgIndex,
                                  'images': _images,
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  ColoredBox(
                    color: Colors.white,
                    child: Column(
                      children: [
                        ImagesAndColorsAlbum(
                          onPictureChange: (int i) {
                            setState(() {
                              _activeImgIndex = i;
                            });
                            _imageViewCtrl.animateToPage(
                              i,
                              duration: 300.milliseconds,
                              curve: Curves.linearToEaseOut,
                            );
                          },
                          onColorChange: (int i) {
                            setState(() {
                              _activeClrIndex = i;
                            });
                          },
                          images: _images,
                          activeImageIndex: _activeImgIndex,
                          activeColorIndex: _activeClrIndex,
                          colors: [
                            Colors.brown,
                            Colors.greenAccent,
                            Colors.purpleAccent,
                            Colors.redAccent,
                          ],
                          colorsNames: [
                            'brown',
                            'Green accent',
                            'Purple',
                            'Red accent',
                          ],
                        ),
                        const DetsAndBuyButton(
                          price: 185.00,
                          reviewNumber: 35,
                          reviewRank: 4,
                          title: 'Premium Jersey Hijab - Rose Quartz',
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          AnimatedPositioned(
            duration: 150.milliseconds,
            curve: _showHeader ? Curves.easeOutBack : Curves.easeInToLinear,
            top: 20,
            right: _showHeader ? 20 : -80,
            left: _showHeader ? 20 : -80,
            child: const HeaderButtons(),
          ),
        ],
      ),
    );
  }
}
