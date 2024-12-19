import 'package:flutter/material.dart';
import 'package:keshav_s_application2/core/app_export.dart';
import 'package:keshav_s_application2/widgets/custom_button.dart';
import 'package:keshav_s_application2/widgets/custom_checkbox.dart';

// ignore: must_be_immutable
class AddAddressItemWidget extends StatelessWidget {
  AddAddressItemWidget({this.onTapStackedit});

  bool isCheckbox = false;

  VoidCallback? onTapStackedit;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      child: Container(
        decoration: AppDecoration.outlineBlack90019.copyWith(
          borderRadius: BorderRadiusStyle.customBorderBR50,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: getPadding(
                right: 15,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CustomButton(
                    height: getVerticalSize(
                      21,
                    ),
                    width: getHorizontalSize(
                      62,
                    ),
                    text: "Home",
                    margin: getMargin(
                      bottom: 8,
                    ),
                  ),
                  Spacer(),
                  Card(
                    clipBehavior: Clip.antiAlias,
                    elevation: 0,
                    margin: getMargin(
                      top: 10,
                    ),
                    color: ColorConstant.whiteA700,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: ColorConstant.purple900,
                        width: getHorizontalSize(
                          1,
                        ),
                      ),
                      borderRadius: BorderRadiusStyle.roundedBorder5,
                    ),
                    child: Container(
                      height: getVerticalSize(
                        19,
                      ),
                      width: getHorizontalSize(
                        26,
                      ),
                      padding: getPadding(
                        left: 9,
                        top: 4,
                        right: 9,
                        bottom: 4,
                      ),
                      decoration: AppDecoration.outlinePurple9001.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder5,
                      ),
                      child: Stack(
                        children: [
                          CustomImageView(
                            svgPath: ImageConstant.imgTrash,
                            height: getVerticalSize(
                              11,
                            ),
                            width: getHorizontalSize(
                              8,
                            ),
                            alignment: Alignment.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      onTapStackedit?.call();
                    },
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      elevation: 0,
                      margin: getMargin(
                        left: 15,
                        top: 10,
                      ),
                      color: ColorConstant.whiteA700,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: ColorConstant.purple900,
                          width: getHorizontalSize(
                            1,
                          ),
                        ),
                        borderRadius: BorderRadiusStyle.roundedBorder5,
                      ),
                      child: Container(
                        height: getVerticalSize(
                          19,
                        ),
                        width: getHorizontalSize(
                          26,
                        ),
                        padding: getPadding(
                          left: 7,
                          top: 5,
                          right: 7,
                          bottom: 5,
                        ),
                        decoration: AppDecoration.outlinePurple9001.copyWith(
                          borderRadius: BorderRadiusStyle.roundedBorder5,
                        ),
                        child: Stack(
                          children: [
                            CustomImageView(
                              svgPath: ImageConstant.imgEdit,
                              height: getVerticalSize(
                                9,
                              ),
                              width: getHorizontalSize(
                                10,
                              ),
                              alignment: Alignment.centerRight,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: getPadding(
                left: 15,
                top: 6,
              ),
              child: Text(
                "Kiran Patel",
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: AppStyle.txtRobotoMedium12,
              ),
            ),
            Padding(
              padding: getPadding(
                left: 16,
                top: 3,
              ),
              child: Text(
                "87887 87887",
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: AppStyle.txtRobotoRegular9,
              ),
            ),
            Container(
              width: getHorizontalSize(
                281,
              ),
              margin: getMargin(
                left: 16,
                top: 3,
                right: 81,
              ),
              child: Text(
                "Block No. 541, Sky Appartment, Near M.G Road, Opp. Motivihar,\nMumbai - 40002",
                maxLines: null,
                textAlign: TextAlign.left,
                style: AppStyle.txtRobotoRegular10Gray700,
              ),
            ),
            CustomCheckbox(
              text: "Mark this as default shipping address",
              iconSize: getHorizontalSize(
                12,
              ),
              value: isCheckbox,
              margin: getMargin(
                left: 16,
                top: 15,
                bottom: 14,
              ),
              fontStyle: CheckboxFontStyle.RobotoRegular10,
              onChange: (value) {
                isCheckbox = value;
              },
            ),
          ],
        ),
      ),
    );
  }
}
