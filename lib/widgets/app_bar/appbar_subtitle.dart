import 'package:flutter/material.dart';
import 'package:keshav_s_application2/core/app_export.dart';

// ignore: must_be_immutable
class AppbarSubtitle extends StatelessWidget {
  AppbarSubtitle({this.text, this.margin, this.onTap});

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
        child: Container(
          width: getSize(
            10,
          ),
          padding: getPadding(
            left: 3,
            top: 1,
            right: 3,
            bottom: 1,
          ),
          decoration: AppDecoration.txtFillRedA700.copyWith(
            borderRadius: BorderRadiusStyle.txtCircleBorder5,
          ),
          child: Text(
            text!,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: AppStyle.txtRobotoMedium6.copyWith(
              color: ColorConstant.whiteA700,
            ),
          ),
        ),
      ),
    );
  }
}
