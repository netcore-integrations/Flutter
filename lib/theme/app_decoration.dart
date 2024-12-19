import 'package:flutter/material.dart';
import 'package:keshav_s_application2/core/app_export.dart';

class AppDecoration {
  static BoxDecoration get txtFillLightblueA100 => BoxDecoration(
        color: ColorConstant.lightBlueA100,
      );
  static BoxDecoration get fillLightblueA100 => BoxDecoration(
        color: ColorConstant.lightBlueA100,
      );
  static BoxDecoration get txtFillPurple900 => BoxDecoration(
        color: ColorConstant.purple900,
      );
  static BoxDecoration get outlineBlack900191 => BoxDecoration(
        color: ColorConstant.whiteA700,
        boxShadow: [
          BoxShadow(
            color: ColorConstant.black90019,
            spreadRadius: getHorizontalSize(
              2,
            ),
            blurRadius: getHorizontalSize(
              2,
            ),
            offset: Offset(
              0,
              0,
            ),
          ),
        ],
      );
  static BoxDecoration get fillPurple900 => BoxDecoration(
        color: ColorConstant.purple900,
      );
  static BoxDecoration get outlinePurple900 => BoxDecoration(
        border: Border.all(
          color: ColorConstant.purple900,
          width: getHorizontalSize(
            1,
          ),
        ),
      );
  static BoxDecoration get fillPurple5001 => BoxDecoration(
        color: ColorConstant.purple5001,
      );
  static BoxDecoration get txtOutlineBlack9003f1 => BoxDecoration(
        color: ColorConstant.red800,
        boxShadow: [
          BoxShadow(
            color: ColorConstant.black9003f,
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
      );
  static BoxDecoration get outlinePurple300 => BoxDecoration(
        color: ColorConstant.whiteA700,
        border: Border.all(
          color: ColorConstant.purple300,
          width: getHorizontalSize(
            1,
          ),
        ),
      );
  static BoxDecoration get outlineGray500 => BoxDecoration(
        border: Border.all(
          color: ColorConstant.gray500,
          width: getHorizontalSize(
            1,
          ),
        ),
      );
  static BoxDecoration get fillWhiteA700 => BoxDecoration(
        color: ColorConstant.whiteA700,
      );
  static BoxDecoration get fillPurple50 => BoxDecoration(
        color: ColorConstant.purple50,
      );
  static BoxDecoration get outlinePurple9004c => BoxDecoration(
        color: ColorConstant.gray50,
        boxShadow: [
          BoxShadow(
            color: ColorConstant.purple9004c,
            spreadRadius: getHorizontalSize(
              2,
            ),
            blurRadius: getHorizontalSize(
              2,
            ),
            offset: Offset(
              0,
              0,
            ),
          ),
        ],
      );
  static BoxDecoration get txtFillRedA700 => BoxDecoration(
        color: ColorConstant.redA700,
      );
  static BoxDecoration get outlineGray400 => BoxDecoration(
        color: ColorConstant.gray200,
        border: Border.all(
          color: ColorConstant.gray400,
          width: getHorizontalSize(
            1,
          ),
        ),
      );
  static BoxDecoration get outlineBlack9003f => BoxDecoration(
        color: ColorConstant.whiteA700,
        boxShadow: [
          BoxShadow(
            color: ColorConstant.black9003f,
            spreadRadius: getHorizontalSize(
              2,
            ),
            blurRadius: getHorizontalSize(
              2,
            ),
            offset: Offset(
              0,
              0,
            ),
          ),
        ],
      );
  static BoxDecoration get txtOutlineBlack9003f => BoxDecoration(
        color: ColorConstant.purple900,
        boxShadow: [
          BoxShadow(
            color: ColorConstant.black9003f,
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
      );
  static BoxDecoration get outlineBlack90026 => BoxDecoration(
        color: ColorConstant.whiteA700,
        boxShadow: [
          BoxShadow(
            color: ColorConstant.black90026,
            spreadRadius: getHorizontalSize(
              2,
            ),
            blurRadius: getHorizontalSize(
              2,
            ),
            offset: Offset(
              2,
              1,
            ),
          ),
        ],
      );
  static BoxDecoration get fillGray20001 => BoxDecoration(
        color: ColorConstant.gray20001,
      );
  static BoxDecoration get outlinePurple9001 => BoxDecoration(
        color: ColorConstant.whiteA700,
        border: Border.all(
          color: ColorConstant.purple900,
          width: getHorizontalSize(
            1,
          ),
        ),
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
              0,
            ),
          ),
        ],
      );
  static BoxDecoration get outlineBlack90019 => BoxDecoration(
        color: ColorConstant.whiteA700,
        boxShadow: [
          BoxShadow(
            color: ColorConstant.black90019,
            spreadRadius: getHorizontalSize(
              2,
            ),
            blurRadius: getHorizontalSize(
              2,
            ),
            offset: Offset(
              0,
              3,
            ),
          ),
        ],
      );
  static BoxDecoration get fillGray5001 => BoxDecoration(
        color: ColorConstant.gray5001,
      );
}

class BorderRadiusStyle {
  static BorderRadius customBorderBL11 = BorderRadius.only(
    bottomLeft: Radius.circular(
      getHorizontalSize(
        11,
      ),
    ),
    bottomRight: Radius.circular(
      getHorizontalSize(
        10,
      ),
    ),
  );
  static BorderRadius txtCustomBorderBL11 = BorderRadius.only(
    bottomLeft: Radius.circular(
      getHorizontalSize(
        11,
      ),
    ),
    bottomRight: Radius.circular(
      getHorizontalSize(
        10,
      ),
    ),
  );

  static BorderRadius txtCustomBorderBL25 = BorderRadius.only(
    bottomLeft: Radius.circular(
      getHorizontalSize(
        25,
      ),
    ),
  );
  static BorderRadius customBorderBR50 = BorderRadius.only(
    bottomRight: Radius.circular(
      getHorizontalSize(
        50,
      ),
    ),
  );

  static BorderRadius txtCustomBorderBR20 = BorderRadius.only(
    bottomRight: Radius.circular(
      getHorizontalSize(
        20,
      ),
    ),
  );
  static BorderRadius roundedBorder5 = BorderRadius.circular(
    getHorizontalSize(
      5,
    ),
  );

  static BorderRadius customBorderBR51 = BorderRadius.only(
    bottomRight: Radius.circular(
      getHorizontalSize(
        51,
      ),
    ),
  );

  static BorderRadius customBorderTL50 = BorderRadius.only(
    topLeft: Radius.circular(
      getHorizontalSize(
        50,
      ),
    ),
    topRight: Radius.circular(
      getHorizontalSize(
        50,
      ),
    ),
  );

  static BorderRadius customBorderBR393 = BorderRadius.only(
    bottomRight: Radius.circular(
      getHorizontalSize(
        393,
      ),
    ),
  );

  static BorderRadius customBorderLR60 = BorderRadius.only(
    topRight: Radius.circular(
      getHorizontalSize(
        60,
      ),
    ),
  );

  static BorderRadius txtCircleBorder5 = BorderRadius.circular(
    getHorizontalSize(
      5,
    ),
  );

  static BorderRadius txtCustomBorderBL20 = BorderRadius.only(
    bottomLeft: Radius.circular(
      getHorizontalSize(
        20,
      ),
    ),
  );
}

// Comment/Uncomment the below code based on your Flutter SDK version.

// For Flutter SDK Version 3.7.2 or greater.

double get strokeAlignInside => BorderSide.strokeAlignInside;

double get strokeAlignCenter => BorderSide.strokeAlignCenter;

double get strokeAlignOutside => BorderSide.strokeAlignOutside;

// For Flutter SDK Version 3.7.1 or less.

// StrokeAlign get strokeAlignInside => StrokeAlign.inside;
//
// StrokeAlign get strokeAlignCenter => StrokeAlign.center;
//
// StrokeAlign get strokeAlignOutside => StrokeAlign.outside;
