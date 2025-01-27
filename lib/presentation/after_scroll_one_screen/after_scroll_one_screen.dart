import '../after_scroll_one_screen/widgets/after_scroll1_item_widget.dart';
import 'controller/after_scroll_one_controller.dart';
import 'models/after_scroll1_item_model.dart';
import 'package:flutter/material.dart';
import 'package:keshav_s_application2/core/app_export.dart';
import 'package:keshav_s_application2/widgets/app_bar/appbar_image.dart';
import 'package:keshav_s_application2/widgets/app_bar/appbar_subtitle_6.dart';
import 'package:keshav_s_application2/widgets/app_bar/custom_app_bar.dart';

class AfterScrollOneScreen extends GetWidget<AfterScrollOneController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.whiteA700,
        body: Container(
          width: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: getVerticalSize(
                  179,
                ),
                width: double.maxFinite,
                margin: getMargin(
                  top: 1,
                ),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: getPadding(
                          left: 131,
                          top: 10,
                          right: 131,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "msg_make_everyone_go".tr,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtRobotoMedium13.copyWith(
                                letterSpacing: getHorizontalSize(
                                  0.26,
                                ),
                              ),
                            ),
                            Padding(
                              padding: getPadding(
                                top: 4,
                              ),
                              child: Text(
                                "msg_jaw_dropping_gorgeous".tr,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: AppStyle.txtRobotoRegular10Purple700
                                    .copyWith(
                                  letterSpacing: getHorizontalSize(
                                    0.2,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    CustomImageView(
                      imagePath: ImageConstant.imgImage4,
                      height: getVerticalSize(
                        124,
                      ),
                      width: getHorizontalSize(
                        153,
                      ),
                      alignment: Alignment.bottomRight,
                    ),
                    CustomAppBar(
                      height: getVerticalSize(
                        91,
                      ),
                      leadingWidth: 41,
                      leading: AppbarImage(
                        height: getVerticalSize(
                          19,
                        ),
                        width: getHorizontalSize(
                          21,
                        ),
                        svgPath: ImageConstant.imgMenu,
                        margin: getMargin(
                          left: 20,
                          top: 51,
                          bottom: 21,
                        ),
                      ),
                      title: AppbarImage(
                        height: getVerticalSize(
                          32,
                        ),
                        width: getHorizontalSize(
                          106,
                        ),
                        imagePath: ImageConstant.imgFinallogo03,
                        margin: getMargin(
                          left: 13,
                          top: 44,
                          bottom: 15,
                        ),
                      ),
                      actions: [
                        AppbarImage(
                          height: getSize(
                            21,
                          ),
                          width: getSize(
                            21,
                          ),
                          svgPath: ImageConstant.imgSearch,
                          margin: getMargin(
                            left: 12,
                            top: 51,
                            right: 19,
                          ),
                        ),
                        Container(
                          height: getVerticalSize(
                            23,
                          ),
                          width: getHorizontalSize(
                            27,
                          ),
                          margin: getMargin(
                            left: 20,
                            top: 48,
                            right: 19,
                            bottom: 1,
                          ),
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              AppbarImage(
                                height: getVerticalSize(
                                  18,
                                ),
                                width: getHorizontalSize(
                                  21,
                                ),
                                svgPath: ImageConstant.imgLocation,
                                margin: getMargin(
                                  top: 5,
                                  right: 6,
                                ),
                              ),
                              AppbarSubtitle6(
                                text: "lbl_2".tr,
                                margin: getMargin(
                                  left: 17,
                                  bottom: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: getVerticalSize(
                            24,
                          ),
                          width: getHorizontalSize(
                            29,
                          ),
                          margin: getMargin(
                            left: 14,
                            top: 48,
                            right: 31,
                          ),
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              AppbarImage(
                                height: getVerticalSize(
                                  20,
                                ),
                                width: getHorizontalSize(
                                  23,
                                ),
                                svgPath: ImageConstant.imgCart,
                                margin: getMargin(
                                  top: 4,
                                  right: 6,
                                ),
                              ),
                              AppbarSubtitle6(
                                text: "lbl_3".tr,
                                margin: getMargin(
                                  left: 19,
                                  bottom: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      styleType: Style.bgShadowBlack90033,
                    ),
                  ],
                ),
              ),
              Container(
                width: double.maxFinite,
                child: Container(
                  margin: getMargin(
                    top: 13,
                  ),
                  padding: getPadding(
                    top: 12,
                    bottom: 12,
                  ),
                  decoration: AppDecoration.fillPurple50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "msg_not_just_good_looks".tr,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: AppStyle.txtRobotoMedium13.copyWith(
                          letterSpacing: getHorizontalSize(
                            0.26,
                          ),
                        ),
                      ),
                      Padding(
                        padding: getPadding(
                          top: 4,
                        ),
                        child: Text(
                          "msg_excellent_quality".tr,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtRobotoRegular10Purple700.copyWith(
                            letterSpacing: getHorizontalSize(
                              0.2,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: getVerticalSize(
                          156,
                        ),
                        child: Obx(
                          () => ListView.separated(
                            padding: getPadding(
                              left: 16,
                              top: 10,
                              bottom: 3,
                            ),
                            scrollDirection: Axis.horizontal,
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: getVerticalSize(
                                  10,
                                ),
                              );
                            },
                            itemCount: controller.afterScrollOneModelObj.value
                                .afterScroll1ItemList.length,
                            itemBuilder: (context, index) {
                              AfterScroll1ItemModel model = controller
                                  .afterScrollOneModelObj
                                  .value
                                  .afterScroll1ItemList[index];
                              return AfterScroll1ItemWidget(
                                model,
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: getPadding(
                  top: 12,
                ),
                child: Text(
                  "msg_bother_us_all_yoy".tr,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: AppStyle.txtRobotoMedium13.copyWith(
                    letterSpacing: getHorizontalSize(
                      0.26,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: getPadding(
                  top: 4,
                ),
                child: Text(
                  "msg_we_get_s_thrill".tr,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: AppStyle.txtRobotoRegular10Purple700.copyWith(
                    letterSpacing: getHorizontalSize(
                      0.2,
                    ),
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: getPadding(
                  left: 16,
                  top: 12,
                ),
                child: IntrinsicWidth(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgImage11,
                        height: getSize(
                          176,
                        ),
                        width: getSize(
                          176,
                        ),
                      ),
                      CustomImageView(
                        imagePath: ImageConstant.imgImage11,
                        height: getSize(
                          176,
                        ),
                        width: getSize(
                          176,
                        ),
                        margin: getMargin(
                          left: 10,
                        ),
                      ),
                      CustomImageView(
                        imagePath: ImageConstant.imgImage11,
                        height: getSize(
                          176,
                        ),
                        width: getSize(
                          176,
                        ),
                        margin: getMargin(
                          left: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: getVerticalSize(
                  266,
                ),
                width: double.maxFinite,
                margin: getMargin(
                  top: 18,
                ),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        padding: getPadding(
                          left: 59,
                          top: 49,
                          right: 59,
                          bottom: 49,
                        ),
                        decoration: AppDecoration.fillGray5001,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: getPadding(
                                top: 84,
                              ),
                              child: Text(
                                "msg_like_what_you_see".tr,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: AppStyle.txtRobotoRegular14Gray50001,
                              ),
                            ),
                            CustomImageView(
                              imagePath: ImageConstant.imgGroup12,
                              height: getVerticalSize(
                                37,
                              ),
                              width: getHorizontalSize(
                                177,
                              ),
                              margin: getMargin(
                                top: 28,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                        width: double.maxFinite,
                        child: Divider(
                          height: getVerticalSize(
                            1,
                          ),
                          thickness: getVerticalSize(
                            1,
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
    );
  }
}
