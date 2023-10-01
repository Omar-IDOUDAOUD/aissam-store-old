import 'package:aissam_store/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ImagesAndColorsAlbum extends StatefulWidget {
  const ImagesAndColorsAlbum({
    Key? key,
    // required this.onPictureChange,
    // required this.onColorChange,
    required this.images,
    required this.imageViewerController,
    this.isCollapsed,
    this.colors,
    this.colorsNames,
    // this.activeImageIndex = 0,
    // this.activeColorIndex,
  }) : super(key: key);
  final PageController imageViewerController;
  // final Function(int i) onPictureChange;
  // final Function(int i)? onColorChange;
  final List<String> images;
  final List<Color>? colors;
  final List<String>? colorsNames;
  final bool Function()? isCollapsed;
  // final int activeImageIndex;
  // final int? activeColorIndex;

  @override
  State<ImagesAndColorsAlbum> createState() => _ImagesAndColorsAlbumState();
}

class _ImagesAndColorsAlbumState extends State<ImagesAndColorsAlbum> {
  int _activePart = 0;
  int _activeImage = 0;
  int _activeColor = 0;

  late final PageController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = PageController();
    widget.imageViewerController.addListener(_imageViewerListener);
  }

  void _imageViewerListener() {
    setState(() {
      _activeImage = widget.imageViewerController.page!.round();
    });
  }

  void _toImage(int i) async {
    setState(() {
      _activeImage = i;
    });
    widget.imageViewerController.removeListener(_imageViewerListener);
    widget.isCollapsed != null && widget.isCollapsed!()
        ? widget.imageViewerController.jumpToPage(i)
        : await widget.imageViewerController.animateToPage(i,
            duration: 300.milliseconds, curve: Curves.linearToEaseOut);
    widget.imageViewerController.addListener(_imageViewerListener);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    widget.imageViewerController.removeListener(_imageViewerListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ColoredBox(
        color: Colors.transparent,
        child: SizedBox(
          height: 80,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: AnimatedAlign(
                  alignment: _activePart == 0
                      ? Alignment.topCenter
                      : Alignment.bottomCenter,
                  duration: 250.milliseconds,
                  curve: Curves.easeOutBack,
                  child: _getActivePartIndicator,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _getPartIconButton(true),
                    _getPartIconButton(false),
                  ],
                ),
              ),
              Expanded(
                child: PageView(
                  controller: _controller,
                  scrollDirection: Axis.vertical,
                  onPageChanged: (i) {
                    setState(() {
                      _activePart = i;
                    });
                  },
                  children: [
                    ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_, i) {
                        return _ListImage(
                          focus: _activeImage == i,
                          path: widget.images.elementAt(i),
                          onTap: () {
                            _toImage(i);
                            // widget.onPictureChange(i);
                          },
                        );
                      },
                      itemCount: widget.images.length,
                    ),
                    widget.colors != null
                        ? ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (_, i) {
                              return _ListColor(
                                focus: _activeColor == i,
                                color: widget.colors!.elementAt(i),
                                colorName: widget.colorsNames!.elementAt(i),
                                onTap: () {
                                  // widget.onColorChange!(i);
                                },
                              );
                            },
                            itemCount: widget.colors!.length,
                          )
                        : _getNoColorAvailabeTxt,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget get _getNoColorAvailabeTxt => Center(
        child: Text(
          'No color availabe',
          style: Get.textTheme.bodyMedium!.copyWith(
            fontStyle: FontStyle.italic,
          ),
        ),
      );

  Widget get _getActivePartIndicator => SizedBox(
        height: 30,
        width: 4,
        child: DecoratedBox(
          decoration: BoxDecoration(
              color: CstColors.a,
              borderRadius:
                  const BorderRadius.horizontal(right: Radius.circular(4))),
        ),
      );

  Widget _getPartIconButton(bool isPictures) => GestureDetector(
      onTap: () {
        _controller.animateToPage(
          isPictures ? 0 : 1,
          duration: 250.milliseconds,
          curve: Curves.linearToEaseOut,
        );
        setState(() {
          _activePart = isPictures ? 0 : 1;
        });
      },
      child: SvgPicture.asset(
          isPictures
              ? (_activePart == 0
                  ? 'assets/icons/pictures_fill.svg'
                  : 'assets/icons/pictures.svg')
              : (_activePart == 1
                  ? 'assets/icons/colors_fill.svg'
                  : 'assets/icons/colors.svg'),
          height: 26));
}

class _ListImage extends StatefulWidget {
  const _ListImage(
      {Key? key, required this.path, required this.focus, required this.onTap})
      : super(key: key);
  final String path;
  final bool focus;
  final Function() onTap;
  @override
  State<_ListImage> createState() => _ListImageState();
}

class _ListImageState extends State<_ListImage> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: 55,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Stack(
          fit: StackFit.expand,
          children: [
            AnimatedContainer(
              margin: const EdgeInsets.all(3),
              duration: 200.milliseconds,
              decoration: BoxDecoration(
                border: Border.all(
                  width: widget.focus ? 2 : 0,
                  color: widget.focus ? CstColors.a : Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            AnimatedContainer(
              curve: const Cubic(0.175, 0.885, 0.32, 2.7),
              duration: 250.milliseconds,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(widget.focus ? 8 : 10),
                image: DecorationImage(
                  image: AssetImage(widget.path),
                  fit: BoxFit.cover,
                ),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              margin: EdgeInsets.all(widget.focus ? 6 : 4),
            )
          ],
        ),
      ),
    );
  }
}

class _ListColor extends StatefulWidget {
  const _ListColor(
      {Key? key,
      required this.color,
      required this.focus,
      required this.onTap,
      required this.colorName})
      : super(key: key);
  final Color color;
  final bool focus;
  final String colorName;
  final Function() onTap;
  @override
  State<_ListColor> createState() => __ListColorState();
}

class __ListColorState extends State<_ListColor> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: 55,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Stack(
          fit: StackFit.expand,
          children: [
            AnimatedContainer(
              curve: Curves.easeOutBack,
              margin: const EdgeInsets.all(3),
              duration: 300.milliseconds,
              decoration: BoxDecoration(
                border: Border.all(
                  width: widget.focus ? 2 : 0,
                  color: widget.focus ? CstColors.a : Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            AnimatedContainer(
              curve: Curves.easeOutBack,
              duration: 300.milliseconds,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(widget.focus ? 7 : 10),
                color: widget.color,
              ),
              clipBehavior: Clip.antiAlias,
              margin: EdgeInsets.all(widget.focus ? 7 : 3),
              alignment: Alignment.bottomCenter,
            ),
            AnimatedPositioned(
              curve: Curves.easeOutBack,
              duration: 300.milliseconds,
              height: widget.focus ? 26 : 30,
              left: widget.focus ? 7 : 3,
              right: widget.focus ? 7 : 3,
              bottom: widget.focus ? 7 : 3,
              child: ColoredBox(
                color: Colors.white.withOpacity(.8),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      widget.colorName,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: Get.textTheme.bodySmall!.copyWith(
                        color: CstColors.a,
                        height: 1,
                        fontSize: 8,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
