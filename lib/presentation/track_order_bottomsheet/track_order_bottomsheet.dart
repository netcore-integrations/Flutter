import 'controller/track_order_controller.dart';
import 'package:flutter/material.dart';
import 'package:keshav_s_application2/core/app_export.dart';

// ignore_for_file: must_be_immutable
class TrackOrderBottomsheet extends StatelessWidget {
  TrackOrderBottomsheet(this.controller);

  TrackOrderController controller;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.maxFinite,
        child: Container(
          width: double.maxFinite,
          padding: getPadding(
            left: 23,
            top: 26,
            right: 23,
            bottom: 26,
          ),
          decoration: AppDecoration.fillWhiteA700.copyWith(
            borderRadius: BorderRadiusStyle.customBorderTL50,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  "lbl_delivered".tr,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: AppStyle.txtRobotoBold16,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: getPadding(
                    top: 25,
                  ),
                  child: Text(
                    "lbl_15_nov_2021".tr,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtRobotoBold16Black900,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: getPadding(
                    top: 11,
                  ),
                  child: Text(
                    "lbl_deliverd".tr,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtRobotoRegular16,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: getPadding(
                    top: 21,
                  ),
                  child: Divider(
                    height: getVerticalSize(
                      2,
                    ),
                    thickness: getVerticalSize(
                      2,
                    ),
                    color: ColorConstant.purple5001,
                    indent: getHorizontalSize(
                      19,
                    ),
                    endIndent: getHorizontalSize(
                      19,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: getPadding(
                  top: 18,
                ),
                child: Text(
                  "lbl_shipped2".tr,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: AppStyle.txtRobotoBold16Gray40004,
                ),
              ),
              Padding(
                padding: getPadding(
                  top: 22,
                ),
                child: Text(
                  "msg_15_november_2021".tr,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: AppStyle.txtRobotoBold16Gray40004,
                ),
              ),
              Padding(
                padding: getPadding(
                  top: 30,
                  right: 28,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: getPadding(
                        bottom: 94,
                      ),
                      child: Text(
                        "lbl_10_17_am".tr,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: AppStyle.txtRobotoMedium16Gray40004,
                      ),
                    ),
                    Container(
                      width: getHorizontalSize(
                        228,
                      ),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "msg_item_has_been_picked2".tr,
                              style: TextStyle(
                                color: ColorConstant.gray40004,
                                fontSize: getFontSize(
                                  16,
                                ),
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: "msg_53220124566_track".tr,
                              style: TextStyle(
                                color: ColorConstant.green600,
                                fontSize: getFontSize(
                                  18,
                                ),
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: getPadding(
                    top: 28,
                  ),
                  child: Divider(
                    height: getVerticalSize(
                      2,
                    ),
                    thickness: getVerticalSize(
                      2,
                    ),
                    color: ColorConstant.purple5001,
                    indent: getHorizontalSize(
                      19,
                    ),
                    endIndent: getHorizontalSize(
                      19,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: getPadding(
                  top: 29,
                ),
                child: Text(
                  "msg_orederd_and_approved".tr,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: AppStyle.txtRobotoBold16Gray40004,
                ),
              ),
              Padding(
                padding: getPadding(
                  top: 25,
                ),
                child: Text(
                  "lbl_15_nov_2021".tr,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: AppStyle.txtRobotoBold16Gray40004,
                ),
              ),
              Padding(
                padding: getPadding(
                  top: 21,
                  bottom: 11,
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: getPadding(
                        top: 1,
                      ),
                      child: Text(
                        "lbl_12_11_am".tr,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: AppStyle.txtRobotoMedium16Gray40004,
                      ),
                    ),
                    Padding(
                      padding: getPadding(
                        left: 58,
                        bottom: 1,
                      ),
                      child: Text(
                        "lbl_order_confirmed".tr,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: AppStyle.txtRobotoMedium16Gray40004,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
