import 'package:keshav_s_application2/widgets/app_bar/appbar_image.dart';
import 'package:keshav_s_application2/widgets/app_bar/appbar_subtitle_5.dart';
import 'package:keshav_s_application2/widgets/app_bar/custom_app_bar.dart';

import 'controller/track_order_one_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as fs;
import 'package:keshav_s_application2/core/app_export.dart';

class TrackOrderOneScreen extends GetWidget<TrackOrderOneController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.whiteA700,
        appBar: CustomAppBar(
            height: getVerticalSize(70),
            leadingWidth: 41,
            leading: AppbarImage(
                onTap: () {
                  Navigator.pop(context);
                },
                height: getVerticalSize(15),
                width: getHorizontalSize(9),
                svgPath: ImageConstant.imgArrowleft,
                margin: getMargin(left: 20, top: 32, bottom: 22)),
            title: AppbarSubtitle5(
                text: "TRACK ITEM",
                margin: getMargin(left: 19, top: 50, bottom: 40)),
            // AppbarImage(
            //     height: getVerticalSize(32),
            //     width: getHorizontalSize(106),
            //     imagePath: ImageConstant.imgFinallogo03,
            //     margin: getMargin(left: 13, top: 44, bottom: 15)),
            styleType: Style.bgShadowBlack90033),
        body: Container(
          width: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Container(
              //   width: double.maxFinite,
              //   child: Container(
              //     width: double.maxFinite,
              //     padding: getPadding(
              //       left: 52,
              //       top: 18,
              //       right: 52,
              //       bottom: 18,
              //     ),
              //     decoration: BoxDecoration(
              //       image: DecorationImage(
              //         image: fs.Svg(
              //           ImageConstant.imgGroup195,
              //         ),
              //         fit: BoxFit.cover,
              //       ),
              //     ),
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       mainAxisAlignment: MainAxisAlignment.end,
              //       children: [
              //         Padding(
              //           padding: getPadding(
              //             top: 32,
              //           ),
              //           child: Text(
              //             "lbl_track_item".tr,
              //             overflow: TextOverflow.ellipsis,
              //             textAlign: TextAlign.left,
              //             style: AppStyle.txtRobotoMedium18.copyWith(
              //               letterSpacing: getHorizontalSize(
              //                 1.62,
              //               ),
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              Expanded(
                child: Container(
                  padding: getPadding(
                    left: 14,
                    top: 12,
                    right: 14,
                    bottom: 12,
                  ),
                  decoration: AppDecoration.fillPurple5001,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          margin: getMargin(
                            left: 11,
                            top: 15,
                            right: 11,
                          ),
                          padding: getPadding(
                            left: 14,
                            top: 13,
                            right: 14,
                            bottom: 13,
                          ),
                          decoration: AppDecoration.outlineBlack900191.copyWith(
                            borderRadius: BorderRadiusStyle.customBorderBR51,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomImageView(
                                imagePath: ImageConstant.imgImage17,
                                height: getSize(
                                  82,
                                ),
                                width: getSize(
                                  82,
                                ),
                              ),
                              Padding(
                                padding: getPadding(
                                  left: 9,
                                  top: 2,
                                  right: 81,
                                  bottom: 1,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "msg_sku_id_sku541ku29".tr,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style:
                                          AppStyle.txtRobotoRegular12Black900,
                                    ),
                                    Padding(
                                      padding: getPadding(
                                        top: 46,
                                      ),
                                      child: Text(
                                        "msg_delivered_on_14_nov_2021".tr,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: AppStyle
                                            .txtRobotoMedium14Green60001
                                            .copyWith(
                                          letterSpacing: getHorizontalSize(
                                            0.7,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: getPadding(
                            top: 37,
                            right: 48,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: getPadding(
                                  top: 90,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: getHorizontalSize(
                                        72,
                                      ),
                                      child: Text(
                                        "msg_shipped_30_nov_2021".tr,
                                        maxLines: null,
                                        textAlign: TextAlign.left,
                                        style: AppStyle
                                            .txtRobotoRegular12Gray6001
                                            .copyWith(
                                          letterSpacing: getHorizontalSize(
                                            0.6,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: getHorizontalSize(
                                        64,
                                      ),
                                      margin: getMargin(
                                        top: 146,
                                      ),
                                      child: Text(
                                        "msg_delivered_1_dec_2021".tr,
                                        maxLines: null,
                                        textAlign: TextAlign.left,
                                        style: AppStyle
                                            .txtRobotoRegular12Gray6001
                                            .copyWith(
                                          letterSpacing: getHorizontalSize(
                                            0.6,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: getPadding(
                                  left: 12,
                                  bottom: 4,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: getVerticalSize(
                                            90,
                                          ),
                                          width: getHorizontalSize(
                                            20,
                                          ),
                                          margin: getMargin(
                                            top: 1,
                                          ),
                                          child: Stack(
                                            alignment: Alignment.bottomCenter,
                                            children: [
                                              Align(
                                                alignment: Alignment.topCenter,
                                                child: Container(
                                                  height: getSize(
                                                    20,
                                                  ),
                                                  width: getSize(
                                                    20,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color:
                                                        ColorConstant.green600,
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: SizedBox(
                                                  height: getVerticalSize(
                                                    71,
                                                  ),
                                                  child: VerticalDivider(
                                                    width: getHorizontalSize(
                                                      2,
                                                    ),
                                                    thickness: getVerticalSize(
                                                      2,
                                                    ),
                                                    color:
                                                        ColorConstant.green600,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: getHorizontalSize(
                                            131,
                                          ),
                                          margin: getMargin(
                                            left: 9,
                                            bottom: 61,
                                          ),
                                          child: Text(
                                            "msg_ordered_and_app".tr,
                                            maxLines: null,
                                            textAlign: TextAlign.left,
                                            style: AppStyle
                                                .txtRobotoRegular12Gray6001
                                                .copyWith(
                                              letterSpacing: getHorizontalSize(
                                                0.6,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: getVerticalSize(
                                                90,
                                              ),
                                              width: getHorizontalSize(
                                                20,
                                              ),
                                              child: Stack(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.topCenter,
                                                    child: Container(
                                                      height: getSize(
                                                        20,
                                                      ),
                                                      width: getSize(
                                                        20,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: ColorConstant
                                                            .green600,
                                                      ),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    child: SizedBox(
                                                      height: getVerticalSize(
                                                        71,
                                                      ),
                                                      child: VerticalDivider(
                                                        width:
                                                            getHorizontalSize(
                                                          2,
                                                        ),
                                                        thickness:
                                                            getVerticalSize(
                                                          2,
                                                        ),
                                                        color: ColorConstant
                                                            .green600,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: getVerticalSize(
                                                90,
                                              ),
                                              width: getHorizontalSize(
                                                20,
                                              ),
                                              child: Stack(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.topCenter,
                                                    child: Container(
                                                      height: getSize(
                                                        20,
                                                      ),
                                                      width: getSize(
                                                        20,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: ColorConstant
                                                            .green600,
                                                      ),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    child: SizedBox(
                                                      height: getVerticalSize(
                                                        71,
                                                      ),
                                                      child: VerticalDivider(
                                                        width:
                                                            getHorizontalSize(
                                                          2,
                                                        ),
                                                        thickness:
                                                            getVerticalSize(
                                                          2,
                                                        ),
                                                        color: ColorConstant
                                                            .green600,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: getSize(
                                                20,
                                              ),
                                              width: getSize(
                                                20,
                                              ),
                                              decoration: BoxDecoration(
                                                color: ColorConstant.green600,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          width: getHorizontalSize(
                                            95,
                                          ),
                                          margin: getMargin(
                                            left: 9,
                                            top: 84,
                                            bottom: 85,
                                          ),
                                          child: Text(
                                            "msg_out_for_dellivery_1_dec_2021"
                                                .tr,
                                            maxLines: null,
                                            textAlign: TextAlign.left,
                                            style: AppStyle
                                                .txtRobotoRegular12Gray6001
                                                .copyWith(
                                              letterSpacing: getHorizontalSize(
                                                0.6,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Padding(
                          padding: getPadding(
                            left: 107,
                            top: 4,
                          ),
                          child: Text(
                            "lbl_view_status".tr,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtRobotoMedium10.copyWith(
                              letterSpacing: getHorizontalSize(
                                0.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
