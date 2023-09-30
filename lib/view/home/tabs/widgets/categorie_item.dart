import 'package:aissam_store/core/constants/colors.dart';
import 'package:aissam_store/models/category.dart';
import 'package:aissam_store/view/public/button/button_scale_builder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategorieItem extends StatefulWidget {
  CategorieItem({
    Key? key,
    required this.data,
    // this.checkable = false,
    this.onCheck,
    this.checked = false,
  }) : super(key: key);
  final Category data;
  // final bool checkable;
  final bool checked;
  final Function(bool state)? onCheck;

  @override
  State<CategorieItem> createState() => _CategorieItemState();
}

class _CategorieItemState extends State<CategorieItem> {
  bool _checked = false;
  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    _checked = widget.checked;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 83,
      child: ButtonScaleBuilder(onTap: () {
        setState(() {
          _checked = !_checked;
        });
        if (widget.onCheck != null) widget.onCheck!(_checked);
      }, builder: (focus) {
        return Column(
          children: [
            CircleAvatar(
              radius: 32,
              backgroundColor: widget.data.color,
              backgroundImage: NetworkImage(widget.data.imageUrl),
              child: SizedBox.expand(
                child: Stack(
                  // fit: StackFit.expand,
                  alignment: Alignment.bottomRight,
                  // alignment: ,
                  children: [
                    AnimatedContainer(
                      duration: 100.milliseconds,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: _checked ? CstColors.g : Colors.transparent,
                          width: _checked ? 2.5 : 0,
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 10,
                      backgroundColor:
                          _checked ? CstColors.g : Colors.black.withOpacity(.1),
                      child: AnimatedScale(
                        duration: 100.milliseconds,
                        scale: _checked ? 1 : 0,
                        child: Icon(
                          Icons.check_rounded,
                          size: 13,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 2),
            Text(
              widget.data.name,
              style: Get.textTheme.displayLarge!.copyWith(
                color: _checked ? CstColors.g : CstColors.b,
              ),
            )
          ],
        );
      }),
    );
  }
}
