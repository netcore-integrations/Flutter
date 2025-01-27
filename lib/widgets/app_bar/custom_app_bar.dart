import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as fs;
import 'package:keshav_s_application2/core/app_export.dart';

// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar(
      {this.height,
      this.styleType,
      this.leadingWidth,
      this.leading,
      this.title,
      this.centerTitle,
      this.actions});

  double? height;

  Style? styleType;

  double? leadingWidth;

  Widget? leading;

  Widget? title;

  bool? centerTitle;

  List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      toolbarHeight: height,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      flexibleSpace: _getStyle(),
      leadingWidth: leadingWidth ?? 0,
      leading: leading,
      title: title,
      titleSpacing: 0,
      centerTitle: centerTitle ?? false,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size(
        size.width,
        height!,
      );
  _getStyle() {
    switch (styleType) {
      case Style.bgStyle_1:
        return Container(
          height: getVerticalSize(
            70,
          ),
          width: double.maxFinite,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: fs.Svg(
                ImageConstant.imgGroup888,
              ),
              fit: BoxFit.cover,
            ),
          ),
        );
      case Style.bgStyle_2:
        return Container(
          height: getVerticalSize(
            70,
          ),
          width: double.maxFinite,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: fs.Svg(
                ImageConstant.imgGroup888,
              ),
              fit: BoxFit.cover,
            ),
          ),
        );
      case Style.bgStyle:
        return Container(
          height: getVerticalSize(
            70,
          ),
          width: double.maxFinite,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: fs.Svg(
                ImageConstant.imgGroup888,
              ),
              fit: BoxFit.cover,
            ),
          ),
        );
      case Style.bgShadowBlack90033:
        return Container(
          height: getVerticalSize(
            70,
          ),
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: ColorConstant.whiteA700,
            boxShadow: [
              BoxShadow(
                color: ColorConstant.black90033,
                spreadRadius: getHorizontalSize(
                  2,
                ),
                blurRadius: getHorizontalSize(
                  2,
                ),
                offset: Offset(
                  0,
                  1,
                ),
              ),
            ],
          ),
        );
      case Style.bgShadowBlack90033height85:
        return Container(
          height: getVerticalSize(
            85,
          ),
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: ColorConstant.whiteA700,
            boxShadow: [
              BoxShadow(
                color: ColorConstant.black90033,
                spreadRadius: getHorizontalSize(
                  2,
                ),
                blurRadius: getHorizontalSize(
                  2,
                ),
                offset: Offset(
                  0,
                  1,
                ),
              ),
            ],
          ),
        );
      case Style.bgOutlineGray40003:
        return Container(
          height: getVerticalSize(
            85,
          ),
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: ColorConstant.whiteA700,
            border: Border.all(
              color: ColorConstant.gray40003,
              width: getHorizontalSize(
                1,
              ),
            ),
          ),
        );
      default:
        return null;
    }
  }
}

enum Style {
  bgStyle_1,
  bgStyle_2,
  bgStyle,
  bgShadowBlack90033,
  bgShadowBlack90033height85,
  bgOutlineGray40003,
}
