import '../after_scroll_screen/widgets/after_scroll_item_widget.dart';
import 'controller/after_scroll_controller.dart';
import 'models/after_scroll_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as fs;
import 'package:keshav_s_application2/core/app_export.dart';
import 'package:keshav_s_application2/widgets/app_bar/appbar_image.dart';
import 'package:keshav_s_application2/widgets/app_bar/appbar_subtitle_6.dart';
import 'package:keshav_s_application2/widgets/app_bar/custom_app_bar.dart';

class AfterScrollScreen extends GetWidget<AfterScrollController> {
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
                  190,
                ),
                width: double.maxFinite,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomImageView(
                            imagePath: ImageConstant.imgDks3bvbvsaaus9p,
                            height: getSize(
                              190,
                            ),
                            width: getSize(
                              190,
                            ),
                          ),
                          CustomImageView(
                            imagePath: ImageConstant.imgDks3bvbvsaaus9p,
                            height: getSize(
                              190,
                            ),
                            width: getSize(
                              190,
                            ),
                            margin: getMargin(
                              left: 15,
                            ),
                          ),
                        ],
                      ),
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
                    top: 10,
                    bottom: 10,
                  ),
                  decoration: AppDecoration.fillPurple50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "msg_we_re_our_favorite".tr,
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
                          top: 5,
                        ),
                        child: Text(
                          "msg_produdly_presenting".tr,
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
                          top: 8,
                          bottom: 4,
                        ),
                        child: IntrinsicWidth(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: getPadding(
                                  left: 11,
                                  top: 3,
                                  right: 11,
                                  bottom: 3,
                                ),
                                decoration: AppDecoration.fillWhiteA700,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    CustomImageView(
                                      imagePath: ImageConstant.imgImage1,
                                      height: getVerticalSize(
                                        149,
                                      ),
                                      width: getHorizontalSize(
                                        216,
                                      ),
                                      margin: getMargin(
                                        top: 7,
                                      ),
                                    ),
                                    Container(
                                      width: getHorizontalSize(
                                        207,
                                      ),
                                      margin: getMargin(
                                        top: 5,
                                      ),
                                      child: Text(
                                        "msg_in_publishing_and".tr,
                                        maxLines: null,
                                        textAlign: TextAlign.left,
                                        style:
                                            AppStyle.txtRobotoRegular8Black900,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: getMargin(
                                  left: 10,
                                ),
                                padding: getPadding(
                                  left: 11,
                                  top: 9,
                                  right: 11,
                                  bottom: 9,
                                ),
                                decoration: AppDecoration.fillWhiteA700,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomImageView(
                                      imagePath: ImageConstant.imgImage1,
                                      height: getVerticalSize(
                                        149,
                                      ),
                                      width: getHorizontalSize(
                                        216,
                                      ),
                                      margin: getMargin(
                                        top: 2,
                                      ),
                                    ),
                                    Container(
                                      width: getHorizontalSize(
                                        210,
                                      ),
                                      margin: getMargin(
                                        top: 5,
                                      ),
                                      child: Text(
                                        "msg_in_publishing_and".tr,
                                        maxLines: null,
                                        textAlign: TextAlign.left,
                                        style:
                                            AppStyle.txtRobotoRegular8Black900,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
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
                  "msg_make_everyone_go".tr,
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
                  "msg_jaw_dropping_gorgeous".tr,
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
                  top: 11,
                ),
                child: IntrinsicWidth(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgImage3,
                        height: getVerticalSize(
                          124,
                        ),
                        width: getHorizontalSize(
                          249,
                        ),
                      ),
                      CustomImageView(
                        imagePath: ImageConstant.imgImage3,
                        height: getVerticalSize(
                          124,
                        ),
                        width: getHorizontalSize(
                          249,
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
                  396,
                ),
                width: double.maxFinite,
                margin: getMargin(
                  top: 13,
                ),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        padding: getPadding(
                          top: 12,
                          bottom: 12,
                        ),
                        decoration: AppDecoration.fillPurple50,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
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
                                style: AppStyle.txtRobotoRegular10Purple700
                                    .copyWith(
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
                                  itemCount: controller.afterScrollModelObj
                                      .value.afterScrollItemList.length,
                                  itemBuilder: (context, index) {
                                    AfterScrollItemModel model = controller
                                        .afterScrollModelObj
                                        .value
                                        .afterScrollItemList[index];
                                    return AfterScrollItemWidget(
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
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: getPadding(
                          left: 131,
                          right: 131,
                          bottom: 135,
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
                      imagePath: ImageConstant.imgImage3,
                      height: getVerticalSize(
                        124,
                      ),
                      width: getHorizontalSize(
                        249,
                      ),
                      alignment: Alignment.bottomLeft,
                      margin: getMargin(
                        left: 16,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: getMargin(
                          left: 14,
                          right: 14,
                          bottom: 102,
                        ),
                        padding: getPadding(
                          left: 41,
                          top: 6,
                          right: 41,
                          bottom: 6,
                        ),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: fs.Svg(
                              ImageConstant.imgGroup203,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CustomImageView(
                              svgPath: ImageConstant.imgGroup2,
                              height: getVerticalSize(
                                47,
                              ),
                              width: getHorizontalSize(
                                315,
                              ),
                              margin: getMargin(
                                top: 11,
                              ),
                            ),
                            Padding(
                              padding: getPadding(
                                left: 7,
                                top: 4,
                                right: 4,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "lbl_home".tr,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: AppStyle.txtRobotoMedium8Purple900,
                                  ),
                                  Text(
                                    "lbl_store".tr,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: AppStyle.txtRobotoMedium8,
                                  ),
                                  Text(
                                    "lbl_profile".tr,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: AppStyle.txtRobotoMedium8,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    CustomImageView(
                      imagePath: ImageConstant.imgImage3,
                      height: getVerticalSize(
                        124,
                      ),
                      width: getHorizontalSize(
                        249,
                      ),
                      alignment: Alignment.bottomRight,
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
