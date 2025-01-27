import 'controller/after_swipe_header_menu_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as fs;
import 'package:keshav_s_application2/core/app_export.dart';
import 'package:keshav_s_application2/widgets/app_bar/appbar_image.dart';
import 'package:keshav_s_application2/widgets/app_bar/appbar_subtitle_6.dart';
import 'package:keshav_s_application2/widgets/app_bar/custom_app_bar.dart';

class AfterSwipeHeaderMenuScreen
    extends GetWidget<AfterSwipeHeaderMenuController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConstant.whiteA700,
            appBar: CustomAppBar(
                height: getVerticalSize(92),
                leadingWidth: 41,
                leading: AppbarImage(
                    height: getVerticalSize(19),
                    width: getHorizontalSize(21),
                    svgPath: ImageConstant.imgMenu,
                    margin: getMargin(left: 20, top: 51, bottom: 21)),
                title: AppbarImage(
                    height: getVerticalSize(32),
                    width: getHorizontalSize(106),
                    imagePath: ImageConstant.imgFinallogo03,
                    margin: getMargin(left: 13, top: 44, bottom: 15)),
                actions: [
                  AppbarImage(
                      height: getSize(21),
                      width: getSize(21),
                      svgPath: ImageConstant.imgSearch,
                      margin: getMargin(left: 12, top: 51, right: 19)),
                  Container(
                      height: getVerticalSize(23),
                      width: getHorizontalSize(27),
                      margin:
                          getMargin(left: 20, top: 48, right: 19, bottom: 1),
                      child: Stack(alignment: Alignment.topRight, children: [
                        AppbarImage(
                            height: getVerticalSize(18),
                            width: getHorizontalSize(21),
                            svgPath: ImageConstant.imgLocation,
                            margin: getMargin(top: 5, right: 6)),
                        AppbarSubtitle6(
                            text: "lbl_2".tr,
                            margin: getMargin(left: 17, bottom: 13))
                      ])),
                  Container(
                      height: getVerticalSize(24),
                      width: getHorizontalSize(29),
                      margin: getMargin(left: 14, top: 48, right: 31),
                      child: Stack(alignment: Alignment.topRight, children: [
                        AppbarImage(
                            height: getVerticalSize(20),
                            width: getHorizontalSize(23),
                            svgPath: ImageConstant.imgCart,
                            margin: getMargin(top: 4, right: 6)),
                        AppbarSubtitle6(
                            text: "lbl_3".tr,
                            margin: getMargin(left: 19, bottom: 14))
                      ]))
                ],
                styleType: Style.bgShadowBlack90033),
            body: Container(
                width: double.maxFinite,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: IntrinsicWidth(
                                  child: Container(
                                      height: getVerticalSize(125),
                                      width: getHorizontalSize(802),
                                      child: Stack(
                                          alignment: Alignment.topLeft,
                                          children: [
                                            Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: GestureDetector(
                                                    onTap: () {
                                                      onTapColumnfurnishin();
                                                    },
                                                    child: Container(
                                                        padding: getPadding(
                                                            left: 20,
                                                            top: 14,
                                                            right: 20,
                                                            bottom: 14),
                                                        decoration:
                                                            AppDecoration
                                                                .fillPurple50,
                                                        child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              Padding(
                                                                  padding:
                                                                      getPadding(
                                                                          top:
                                                                              54,
                                                                          right:
                                                                              9),
                                                                  child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Padding(
                                                                            padding:
                                                                                getPadding(top: 3, bottom: 10),
                                                                            child: Text("lbl_furnishings2".tr, overflow: TextOverflow.ellipsis, textAlign: TextAlign.left, style: AppStyle.txtRobotoRegular12Black900)),
                                                                        Padding(
                                                                            padding: getPadding(
                                                                                left: 35,
                                                                                top: 2,
                                                                                bottom: 11),
                                                                            child: Text("lbl_decor".tr, overflow: TextOverflow.ellipsis, textAlign: TextAlign.left, style: AppStyle.txtRobotoRegular12Black900)),
                                                                        Padding(
                                                                            padding: getPadding(
                                                                                left: 43,
                                                                                top: 3,
                                                                                bottom: 10),
                                                                            child: Text("lbl_lighting2".tr, overflow: TextOverflow.ellipsis, textAlign: TextAlign.left, style: AppStyle.txtRobotoRegular12Black900)),
                                                                        Padding(
                                                                            padding: getPadding(
                                                                                left: 30,
                                                                                top: 3,
                                                                                bottom: 10),
                                                                            child: Text("lbl_appliances2".tr, overflow: TextOverflow.ellipsis, textAlign: TextAlign.left, style: AppStyle.txtRobotoRegular12Black900)),
                                                                        Container(
                                                                            width:
                                                                                getHorizontalSize(48),
                                                                            margin: getMargin(left: 26),
                                                                            child: Text("msg_modular_furniture2".tr, maxLines: null, textAlign: TextAlign.center, style: AppStyle.txtRobotoRegular12Black9001))
                                                                      ])),
                                                              Padding(
                                                                  padding:
                                                                      getPadding(
                                                                          top:
                                                                              4),
                                                                  child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Container(
                                                                            height:
                                                                                getSize(9),
                                                                            width: getSize(9),
                                                                            decoration: BoxDecoration(color: ColorConstant.gray50002, borderRadius: BorderRadius.circular(getHorizontalSize(4)))),
                                                                        Container(
                                                                            height:
                                                                                getSize(9),
                                                                            width: getSize(9),
                                                                            margin: getMargin(left: 10),
                                                                            decoration: BoxDecoration(color: ColorConstant.purple900, borderRadius: BorderRadius.circular(getHorizontalSize(4))))
                                                                      ]))
                                                            ])))),
                                            Align(
                                                alignment: Alignment.topLeft,
                                                child: Padding(
                                                    padding: getPadding(
                                                        top: 20,
                                                        right: 33,
                                                        bottom: 62),
                                                    child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Expanded(
                                                              child: CustomImageView(
                                                                  imagePath:
                                                                      ImageConstant
                                                                          .imgSofa,
                                                                  height:
                                                                      getSize(
                                                                          40),
                                                                  width:
                                                                      getSize(
                                                                          40),
                                                                  margin: getMargin(
                                                                      top: 3,
                                                                      right:
                                                                          20))),
                                                          Expanded(
                                                              child: CustomImageView(
                                                                  imagePath:
                                                                      ImageConstant
                                                                          .imgTvstand,
                                                                  height:
                                                                      getSize(
                                                                          40),
                                                                  width:
                                                                      getSize(
                                                                          40),
                                                                  margin: getMargin(
                                                                      left: 20,
                                                                      top: 1,
                                                                      right: 20,
                                                                      bottom:
                                                                          2))),
                                                          Expanded(
                                                              child: CustomImageView(
                                                                  imagePath:
                                                                      ImageConstant
                                                                          .imgBed,
                                                                  height:
                                                                      getSize(
                                                                          40),
                                                                  width:
                                                                      getSize(
                                                                          40),
                                                                  margin: getMargin(
                                                                      left: 20,
                                                                      top: 2,
                                                                      right: 20,
                                                                      bottom:
                                                                          1))),
                                                          Expanded(
                                                              child: CustomImageView(
                                                                  imagePath:
                                                                      ImageConstant
                                                                          .imgBabybed,
                                                                  height:
                                                                      getSize(
                                                                          40),
                                                                  width:
                                                                      getSize(
                                                                          40),
                                                                  margin: getMargin(
                                                                      left: 20,
                                                                      right: 20,
                                                                      bottom:
                                                                          3))),
                                                          Expanded(
                                                              child: CustomImageView(
                                                                  imagePath:
                                                                      ImageConstant
                                                                          .imgMattress,
                                                                  height:
                                                                      getSize(
                                                                          40),
                                                                  width:
                                                                      getSize(
                                                                          40),
                                                                  margin: getMargin(
                                                                      left: 20,
                                                                      right: 20,
                                                                      bottom:
                                                                          3))),
                                                          Expanded(
                                                              child: CustomImageView(
                                                                  imagePath:
                                                                      ImageConstant
                                                                          .imgCurtain,
                                                                  height:
                                                                      getSize(
                                                                          40),
                                                                  width:
                                                                      getSize(
                                                                          40),
                                                                  margin: getMargin(
                                                                      left: 20,
                                                                      right: 20,
                                                                      bottom:
                                                                          3))),
                                                          Expanded(
                                                              child: CustomImageView(
                                                                  imagePath:
                                                                      ImageConstant
                                                                          .imgSpiderplant,
                                                                  height:
                                                                      getSize(
                                                                          40),
                                                                  width:
                                                                      getSize(
                                                                          40),
                                                                  margin: getMargin(
                                                                      left: 20,
                                                                      right: 20,
                                                                      bottom:
                                                                          3))),
                                                          Expanded(
                                                              child: CustomImageView(
                                                                  svgPath:
                                                                      ImageConstant
                                                                          .imgUser,
                                                                  height:
                                                                      getSize(
                                                                          40),
                                                                  width:
                                                                      getSize(
                                                                          40),
                                                                  margin: getMargin(
                                                                      left: 20,
                                                                      right: 20,
                                                                      bottom:
                                                                          3))),
                                                          Expanded(
                                                              child: CustomImageView(
                                                                  imagePath:
                                                                      ImageConstant
                                                                          .imgMicrowave,
                                                                  height:
                                                                      getSize(
                                                                          40),
                                                                  width:
                                                                      getSize(
                                                                          40),
                                                                  margin: getMargin(
                                                                      left: 20,
                                                                      top: 3,
                                                                      right:
                                                                          20))),
                                                          Expanded(
                                                              child: CustomImageView(
                                                                  imagePath:
                                                                      ImageConstant
                                                                          .imgWardrobe,
                                                                  height:
                                                                      getSize(
                                                                          40),
                                                                  width:
                                                                      getSize(
                                                                          40),
                                                                  margin: getMargin(
                                                                      left: 20,
                                                                      bottom:
                                                                          3)))
                                                        ])))
                                          ]))))),
                      CustomImageView(
                          imagePath:
                              ImageConstant.imgFurnituresocialmediabanner,
                          height: getVerticalSize(206),
                          width: getHorizontalSize(396),
                          margin: getMargin(top: 10)),
                      Padding(
                          padding: getPadding(left: 15, top: 22, right: 18),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomImageView(
                                    imagePath: ImageConstant.imgDks3bvbvsaaus9p,
                                    height: getSize(190),
                                    width: getSize(190)),
                                CustomImageView(
                                    imagePath: ImageConstant.imgDks3bvbvsaaus9p,
                                    height: getSize(190),
                                    width: getSize(190),
                                    margin: getMargin(left: 15))
                              ])),
                      Container(
                          height: getVerticalSize(268),
                          width: double.maxFinite,
                          margin: getMargin(top: 13),
                          child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                        padding:
                                            getPadding(top: 10, bottom: 10),
                                        decoration: AppDecoration.fillPurple50,
                                        child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text("msg_we_re_our_favorite".tr,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: AppStyle
                                                      .txtRobotoMedium13
                                                      .copyWith(
                                                          letterSpacing:
                                                              getHorizontalSize(
                                                                  0.26))),
                                              Padding(
                                                  padding: getPadding(top: 5),
                                                  child: Text(
                                                      "msg_produdly_presenting"
                                                          .tr,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign: TextAlign.left,
                                                      style: AppStyle
                                                          .txtRobotoRegular10Purple700
                                                          .copyWith(
                                                              letterSpacing:
                                                                  getHorizontalSize(
                                                                      0.2)))),
                                              SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  padding: getPadding(
                                                      left: 16, top: 8),
                                                  child: IntrinsicWidth(
                                                      child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                        Container(
                                                            height:
                                                                getVerticalSize(
                                                                    206),
                                                            width:
                                                                getHorizontalSize(
                                                                    238),
                                                            padding: getPadding(
                                                                all: 11),
                                                            decoration:
                                                                AppDecoration
                                                                    .fillWhiteA700,
                                                            child: Stack(
                                                                children: [
                                                                  CustomImageView(
                                                                      imagePath:
                                                                          ImageConstant
                                                                              .imgImage1,
                                                                      height:
                                                                          getVerticalSize(
                                                                              149),
                                                                      width: getHorizontalSize(
                                                                          216),
                                                                      alignment:
                                                                          Alignment
                                                                              .topCenter)
                                                                ])),
                                                        Container(
                                                            height:
                                                                getVerticalSize(
                                                                    206),
                                                            width:
                                                                getHorizontalSize(
                                                                    238),
                                                            margin: getMargin(
                                                                left: 10),
                                                            padding: getPadding(
                                                                all: 11),
                                                            decoration:
                                                                AppDecoration
                                                                    .fillWhiteA700,
                                                            child: Stack(
                                                                children: [
                                                                  CustomImageView(
                                                                      imagePath:
                                                                          ImageConstant
                                                                              .imgImage1,
                                                                      height:
                                                                          getVerticalSize(
                                                                              149),
                                                                      width: getHorizontalSize(
                                                                          216),
                                                                      alignment:
                                                                          Alignment
                                                                              .topCenter)
                                                                ]))
                                                      ])))
                                            ]))),
                                Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                        margin: getMargin(
                                            left: 22, right: 6, bottom: 15),
                                        padding: getPadding(
                                            left: 41,
                                            top: 6,
                                            right: 41,
                                            bottom: 6),
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: fs.Svg(
                                                    ImageConstant.imgGroup203),
                                                fit: BoxFit.cover)),
                                        child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              CustomImageView(
                                                  svgPath:
                                                      ImageConstant.imgGroup2,
                                                  height: getVerticalSize(47),
                                                  width: getHorizontalSize(315),
                                                  margin: getMargin(top: 11)),
                                              Padding(
                                                  padding: getPadding(
                                                      left: 7,
                                                      top: 4,
                                                      right: 4),
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text("lbl_home".tr,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: AppStyle
                                                                .txtRobotoMedium8Purple900),
                                                        Text("lbl_store".tr,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: AppStyle
                                                                .txtRobotoMedium8),
                                                        Text("lbl_profile".tr,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: AppStyle
                                                                .txtRobotoMedium8)
                                                      ]))
                                            ])))
                              ]))
                    ]))));
  }

  onTapColumnfurnishin() {
    Get.toNamed(AppRoutes.homeScreen);
  }
}
