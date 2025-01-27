import 'package:flutter/material.dart';
import 'package:keshav_s_application2/core/app_export.dart';

// ignore: must_be_immutable
class AppbarImage extends StatelessWidget {
  AppbarImage(
      {this.height,
      this.width,
      this.imagePath,
      this.svgPath,
      this.color,
      this.margin,
      this.onTap});

  double? height;

  double? width;

  String? imagePath;

  String? svgPath;

  Color? color;

  EdgeInsetsGeometry? margin;

  Function? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap!.call();
      },
      child: Padding(
        padding: margin ?? EdgeInsets.zero,
        child: CustomImageView(
          color: color,
          svgPath: svgPath,
          imagePath: imagePath,
          height: height!,
          width: width!,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class CustomAppbarTitle extends StatelessWidget {
  CustomAppbarTitle({
    this.height,
    this.width,
    this.imagePath,
    this.svgPath,
    this.color,
    this.margin,
  });

  double? height;

  double? width;

  String? imagePath;

  String? svgPath;

  Color? color;

  EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: CustomImageView(
        color: color,
        svgPath: svgPath,
        imagePath: imagePath,
        height: height!,
        width: width!,
        fit: BoxFit.contain,
      ),
    );
  }
}
