import 'package:flutter/material.dart';
import 'package:keshav_s_application2/core/app_export.dart';

// ignore: must_be_immutable
class AppbarSubtitle2 extends StatelessWidget {
  AppbarSubtitle2({this.text, this.margin, this.onTap});

  String? text;

  EdgeInsetsGeometry? margin;

  Function? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap?.call();
      },
      child: Padding(
        padding: margin ?? EdgeInsets.zero,
        child: Text(
          text!,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.left,
          style: AppStyle.txtRobotoBold18.copyWith(
            letterSpacing: getHorizontalSize(
              1.62,
            ),
            color: ColorConstant.purple900,
          ),
        ),
      ),
    );
  }
}
