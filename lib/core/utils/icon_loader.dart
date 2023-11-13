import 'package:aissam_store/core/utils/asset_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget IconLoader(Object iconName,
    {Color? color,
    double? height,
    double? width,
    Key? key, 
    Alignment? alignment,
    BoxFit? fit}) {
  assert(iconName is String || iconName is IconData,
      'iconName datatype unvalide!');
  if (iconName is IconData)
    return SizedBox(
      key: key,
      height: height,
      width: width,
      child: Icon(
        iconName,
        color: color,
      ),
    );
  return SvgPicture.asset(
    AssetLoader.icon(iconName.toString()),
    color: color,
    alignment: alignment ?? Alignment.center,
    fit: fit ?? BoxFit.contain,
    height: height,
    width: width,
      key: key,

  );
}
