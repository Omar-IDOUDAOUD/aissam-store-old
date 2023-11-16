import 'package:aissam_store/core/utils/asset_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

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
    return Icon(
      iconName,
      size: height ?? width,
      color: color,
    );
  if (iconName is String && iconName.isImageFileName)
    return Image.asset(
      AssetLoader.icon(iconName),
      height: height,
      width: width,
      fit: fit,
      alignment: alignment ?? Alignment.center,
      key: key,
    );
  else if (iconName is String && iconName.endsWith('svg'))
    return SvgPicture.asset(
      AssetLoader.icon(iconName.toString()),
      color: color,
      alignment: alignment ?? Alignment.center,
      fit: fit ?? BoxFit.contain,
      height: height,
      width: width,
      key: key,
    );
  throw ('IconLoader icon file type unvalide!');
}
