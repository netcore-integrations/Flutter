import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as fs;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keshav_s_application2/core/app_export.dart';
import 'package:keshav_s_application2/widgets/app_bar/appbar_image.dart';
import 'package:keshav_s_application2/widgets/app_bar/appbar_subtitle_5.dart';
import 'package:keshav_s_application2/widgets/app_bar/appbar_subtitle_6.dart';
import 'package:keshav_s_application2/widgets/app_bar/custom_app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../filter_screen/filter_screen.dart';
import '../otp_screen/models/otp_model.dart';
import '../search_screen/search_screen.dart';
import '../sort_by_bottomsheet/sort_by_bottomsheet.dart';
import 'controller/select_product_one_controller.dart';

class SelectProductOneScreen extends GetWidget<SelectProductOneController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConstant.whiteA700,
            appBar: CustomAppBar(
                height: getVerticalSize(92),
                leadingWidth: 34,
                leading: AppbarImage(
                    height: getVerticalSize(15),
                    width: getHorizontalSize(9),
                    svgPath: ImageConstant.imgArrowleft,
                    margin: getMargin(left: 25, top: 53, bottom: 23),
                    onTap: onTapArrowleft3),
                title: AppbarSubtitle5(
                    text: "lbl_rocking_chairs".tr,
                    margin: getMargin(left: 19, top: 50, bottom: 18)),
                actions: [
                  InkWell(
                    onTap: () async {
                      //Get.toNamed(AppRoutes.searchScreen);
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      Map<String, dynamic> json1 =
                          jsonDecode(prefs.getString('userData')!);
                      var user1 = OtpModel.fromJson(json1);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SearchScreen(user1.data!, '')));
                    },
                    child: AppbarImage(
                        height: getSize(21),
                        width: getSize(21),
                        svgPath: ImageConstant.imgSearch,
                        margin: getMargin(left: 12, top: 51, right: 19)),
                  ),
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
                      Container(
                          width: Get.width,
                          decoration: AppDecoration.outlineBlack9003f,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    _showsortbyBottomSheet(context);
                                  },
                                  child: Container(
                                    width: Get.width / 2.1,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CustomImageView(
                                            svgPath:
                                                ImageConstant.imgVectorBlack900,
                                            height: getVerticalSize(16),
                                            width: getHorizontalSize(12),
                                            margin: getMargin(
                                                left: 2, top: 13, bottom: 12)),
                                        Padding(
                                            padding: getPadding(
                                                left: 17, top: 12, bottom: 11),
                                            child: Text("lbl_sort".tr,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style: AppStyle
                                                    .txtRobotoMedium14)),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    height: getVerticalSize(41),
                                    child: VerticalDivider(
                                        width: getHorizontalSize(1),
                                        thickness: getVerticalSize(1),
                                        color: ColorConstant.gray40002)),
                                InkWell(
                                  onTap: () {
                                    //Get.toNamed(AppRoutes.filterScreen);
                                    //dialogFilter();
                                    _showFilterBottomSheet(context);
                                  },
                                  child: Container(
                                    width: Get.width / 2.1,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CustomImageView(
                                            svgPath: ImageConstant.imgFilter,
                                            height: getSize(16),
                                            width: getSize(16),
                                            margin:
                                                getMargin(top: 13, bottom: 12)),
                                        Padding(
                                            padding: getPadding(
                                                left: 17, top: 12, bottom: 11),
                                            child: Text("lbl_filter".tr,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style:
                                                    AppStyle.txtRobotoMedium14))
                                      ],
                                    ),
                                  ),
                                )
                              ])),
                      Container(
                          height: getVerticalSize(1000),
                          width: double.maxFinite,
                          child: Stack(alignment: Alignment.topLeft, children: [
                            Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                    margin: getMargin(
                                        left: 14, right: 14, bottom: 225),
                                    padding: getPadding(
                                        left: 41, top: 6, right: 41, bottom: 6),
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
                                              svgPath: ImageConstant.imgGroup2,
                                              height: getVerticalSize(47),
                                              width: getHorizontalSize(315),
                                              margin: getMargin(top: 11)),
                                          Padding(
                                              padding: getPadding(
                                                  left: 7, top: 4, right: 4),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text("lbl_home".tr,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: AppStyle
                                                            .txtRobotoMedium8Purple900),
                                                    Text("lbl_store".tr,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: AppStyle
                                                            .txtRobotoMedium8),
                                                    Text("lbl_profile".tr,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: AppStyle
                                                            .txtRobotoMedium8)
                                                  ]))
                                        ]))),
                            Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                    padding: getPadding(left: 10, top: 272),
                                    child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text("msg_limited_time_offer".tr,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: AppStyle
                                                  .txtRobotoRegular10Black900),
                                          Padding(
                                              padding: getPadding(top: 6),
                                              child: Row(children: [
                                                Text("lbl_ships_in_1_day".tr,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.left,
                                                    style: AppStyle
                                                        .txtRobotoMedium10Black900),
                                                CustomImageView(
                                                    svgPath:
                                                        ImageConstant.imgCar,
                                                    height: getVerticalSize(10),
                                                    width:
                                                        getHorizontalSize(13),
                                                    margin: getMargin(
                                                        left: 9, bottom: 1))
                                              ])),
                                          Padding(
                                              padding: getPadding(top: 6),
                                              child: SizedBox(
                                                  width: getHorizontalSize(127),
                                                  child: Divider(
                                                      height:
                                                          getVerticalSize(1),
                                                      thickness:
                                                          getVerticalSize(1)))),
                                          Padding(
                                              padding:
                                                  getPadding(left: 5, top: 7),
                                              child: Row(children: [
                                                CustomImageView(
                                                    svgPath: ImageConstant
                                                        .imgLocation,
                                                    height: getVerticalSize(14),
                                                    width:
                                                        getHorizontalSize(17),
                                                    margin: getMargin(
                                                        top: 1, bottom: 1)),
                                                CustomImageView(
                                                    svgPath: ImageConstant
                                                        .imgCartPurple900,
                                                    height: getVerticalSize(16),
                                                    width:
                                                        getHorizontalSize(18),
                                                    margin: getMargin(left: 33))
                                              ]))
                                        ]))),
                            Align(
                                alignment: Alignment.bottomLeft,
                                child: Padding(
                                    padding: getPadding(left: 10, bottom: 319),
                                    child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text("msg_limited_time_offer".tr,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: AppStyle
                                                  .txtRobotoRegular10Black900),
                                          Padding(
                                              padding: getPadding(top: 6),
                                              child: Row(children: [
                                                Text("lbl_ships_in_1_day".tr,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.left,
                                                    style: AppStyle
                                                        .txtRobotoMedium10Black900),
                                                CustomImageView(
                                                    svgPath:
                                                        ImageConstant.imgCar,
                                                    height: getVerticalSize(10),
                                                    width:
                                                        getHorizontalSize(13),
                                                    margin: getMargin(
                                                        left: 9, bottom: 1))
                                              ])),
                                          Padding(
                                              padding: getPadding(top: 6),
                                              child: SizedBox(
                                                  width: getHorizontalSize(127),
                                                  child: Divider(
                                                      height:
                                                          getVerticalSize(1),
                                                      thickness:
                                                          getVerticalSize(1)))),
                                          Padding(
                                              padding:
                                                  getPadding(left: 5, top: 7),
                                              child: Row(children: [
                                                CustomImageView(
                                                    svgPath: ImageConstant
                                                        .imgLocation,
                                                    height: getVerticalSize(14),
                                                    width:
                                                        getHorizontalSize(17),
                                                    margin: getMargin(
                                                        top: 1, bottom: 1)),
                                                CustomImageView(
                                                    svgPath: ImageConstant
                                                        .imgCartPurple900,
                                                    height: getVerticalSize(16),
                                                    width:
                                                        getHorizontalSize(18),
                                                    margin: getMargin(left: 33))
                                              ]))
                                        ]))),
                            Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                    padding: getPadding(top: 272, right: 78),
                                    child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text("msg_limited_time_offer".tr,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: AppStyle
                                                  .txtRobotoRegular10Black900),
                                          Padding(
                                              padding: getPadding(top: 6),
                                              child: Row(children: [
                                                Text("lbl_ships_in_1_day".tr,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.left,
                                                    style: AppStyle
                                                        .txtRobotoMedium10Black900),
                                                CustomImageView(
                                                    svgPath:
                                                        ImageConstant.imgCar,
                                                    height: getVerticalSize(10),
                                                    width:
                                                        getHorizontalSize(13),
                                                    margin: getMargin(
                                                        left: 9, bottom: 1))
                                              ])),
                                          Padding(
                                              padding: getPadding(top: 6),
                                              child: SizedBox(
                                                  width: getHorizontalSize(127),
                                                  child: Divider(
                                                      height:
                                                          getVerticalSize(1),
                                                      thickness:
                                                          getVerticalSize(1)))),
                                          Padding(
                                              padding:
                                                  getPadding(left: 5, top: 7),
                                              child: Row(children: [
                                                CustomImageView(
                                                    svgPath: ImageConstant
                                                        .imgLocation,
                                                    height: getVerticalSize(14),
                                                    width:
                                                        getHorizontalSize(17),
                                                    margin: getMargin(
                                                        top: 1, bottom: 1)),
                                                CustomImageView(
                                                    svgPath: ImageConstant
                                                        .imgCartPurple900,
                                                    height: getVerticalSize(16),
                                                    width:
                                                        getHorizontalSize(18),
                                                    margin: getMargin(left: 33))
                                              ]))
                                        ]))),
                            Align(
                                alignment: Alignment.bottomRight,
                                child: Padding(
                                    padding: getPadding(right: 78, bottom: 319),
                                    child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text("msg_limited_time_offer".tr,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: AppStyle
                                                  .txtRobotoRegular10Black900),
                                          Padding(
                                              padding: getPadding(top: 6),
                                              child: Row(children: [
                                                Text("lbl_ships_in_1_day".tr,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.left,
                                                    style: AppStyle
                                                        .txtRobotoMedium10Black900),
                                                CustomImageView(
                                                    svgPath:
                                                        ImageConstant.imgCar,
                                                    height: getVerticalSize(10),
                                                    width:
                                                        getHorizontalSize(13),
                                                    margin: getMargin(
                                                        left: 9, bottom: 1))
                                              ])),
                                          Padding(
                                              padding: getPadding(top: 6),
                                              child: SizedBox(
                                                  width: getHorizontalSize(127),
                                                  child: Divider(
                                                      height:
                                                          getVerticalSize(1),
                                                      thickness:
                                                          getVerticalSize(1)))),
                                          Padding(
                                              padding:
                                                  getPadding(left: 5, top: 7),
                                              child: Row(children: [
                                                CustomImageView(
                                                    svgPath: ImageConstant
                                                        .imgLocation,
                                                    height: getVerticalSize(14),
                                                    width:
                                                        getHorizontalSize(17),
                                                    margin: getMargin(
                                                        top: 1, bottom: 1)),
                                                CustomImageView(
                                                    svgPath: ImageConstant
                                                        .imgCartPurple900,
                                                    height: getVerticalSize(16),
                                                    width:
                                                        getHorizontalSize(18),
                                                    margin: getMargin(left: 33))
                                              ]))
                                        ]))),
                            Align(
                                alignment: Alignment.bottomRight,
                                child: Padding(
                                    padding: getPadding(right: 12, bottom: 67),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          CustomImageView(
                                              svgPath:
                                                  ImageConstant.imgLocation,
                                              height: getVerticalSize(18),
                                              width: getHorizontalSize(21),
                                              margin:
                                                  getMargin(top: 1, bottom: 1)),
                                          CustomImageView(
                                              svgPath: ImageConstant.imgCart,
                                              height: getVerticalSize(20),
                                              width: getHorizontalSize(23),
                                              margin: getMargin(left: 35))
                                        ]))),
                            Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                    padding: getPadding(left: 10, top: 7),
                                    child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                              height: getSize(195),
                                              width: getSize(195),
                                              child: Stack(
                                                  alignment:
                                                      Alignment.topCenter,
                                                  children: [
                                                    CustomImageView(
                                                        imagePath: ImageConstant
                                                            .imgImage17,
                                                        height: getSize(195),
                                                        width: getSize(195),
                                                        alignment:
                                                            Alignment.center),
                                                    Align(
                                                        alignment:
                                                            Alignment.topCenter,
                                                        child: Padding(
                                                            padding: getPadding(
                                                                bottom: 179),
                                                            child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Container(
                                                                      width:
                                                                          getHorizontalSize(
                                                                              60),
                                                                      margin: getMargin(
                                                                          bottom:
                                                                              1),
                                                                      padding: getPadding(
                                                                          left:
                                                                              17,
                                                                          top:
                                                                              1,
                                                                          right:
                                                                              17,
                                                                          bottom:
                                                                              1),
                                                                      decoration: AppDecoration
                                                                          .txtOutlineBlack9003f
                                                                          .copyWith(
                                                                              borderRadius: BorderRadiusStyle
                                                                                  .txtCustomBorderBR20),
                                                                      child: Text(
                                                                          "lbl_new"
                                                                              .tr,
                                                                          overflow: TextOverflow
                                                                              .ellipsis,
                                                                          textAlign: TextAlign
                                                                              .left,
                                                                          style:
                                                                              AppStyle.txtRobotoMedium9)),
                                                                  Container(
                                                                      width:
                                                                          getHorizontalSize(
                                                                              60),
                                                                      padding: getPadding(
                                                                          left:
                                                                              9,
                                                                          top:
                                                                              2,
                                                                          right:
                                                                              9,
                                                                          bottom:
                                                                              2),
                                                                      decoration: AppDecoration
                                                                          .txtOutlineBlack9003f1
                                                                          .copyWith(
                                                                              borderRadius: BorderRadiusStyle
                                                                                  .txtCustomBorderBL20),
                                                                      child: Text(
                                                                          "lbl_30_off2"
                                                                              .tr,
                                                                          overflow: TextOverflow
                                                                              .ellipsis,
                                                                          textAlign: TextAlign
                                                                              .left,
                                                                          style:
                                                                              AppStyle.txtRobotoMedium9))
                                                                ])))
                                                  ])),
                                          Padding(
                                              padding: getPadding(top: 9),
                                              child: Text(
                                                  "msg_moscow_rocking_chair".tr,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: AppStyle
                                                      .txtRobotoRegular12Black900)),
                                          Padding(
                                              padding: getPadding(top: 4),
                                              child: Text(
                                                  "msg_casacraft_by_fabfurni"
                                                      .tr,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: AppStyle
                                                      .txtRobotoRegular10Purple9001))
                                        ]))),
                            Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                    padding: getPadding(left: 10, top: 355),
                                    child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                              height: getSize(195),
                                              width: getSize(195),
                                              child: Stack(
                                                  alignment:
                                                      Alignment.topCenter,
                                                  children: [
                                                    CustomImageView(
                                                        imagePath: ImageConstant
                                                            .imgImage17,
                                                        height: getSize(195),
                                                        width: getSize(195),
                                                        alignment:
                                                            Alignment.center),
                                                    Align(
                                                        alignment:
                                                            Alignment.topCenter,
                                                        child: Padding(
                                                            padding: getPadding(
                                                                bottom: 179),
                                                            child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Container(
                                                                      width:
                                                                          getHorizontalSize(
                                                                              60),
                                                                      margin: getMargin(
                                                                          bottom:
                                                                              1),
                                                                      padding: getPadding(
                                                                          left:
                                                                              17,
                                                                          top:
                                                                              1,
                                                                          right:
                                                                              17,
                                                                          bottom:
                                                                              1),
                                                                      decoration: AppDecoration
                                                                          .txtOutlineBlack9003f
                                                                          .copyWith(
                                                                              borderRadius: BorderRadiusStyle
                                                                                  .txtCustomBorderBR20),
                                                                      child: Text(
                                                                          "lbl_new"
                                                                              .tr,
                                                                          overflow: TextOverflow
                                                                              .ellipsis,
                                                                          textAlign: TextAlign
                                                                              .left,
                                                                          style:
                                                                              AppStyle.txtRobotoMedium9)),
                                                                  Container(
                                                                      width:
                                                                          getHorizontalSize(
                                                                              60),
                                                                      padding: getPadding(
                                                                          left:
                                                                              9,
                                                                          top:
                                                                              2,
                                                                          right:
                                                                              9,
                                                                          bottom:
                                                                              2),
                                                                      decoration: AppDecoration
                                                                          .txtOutlineBlack9003f1
                                                                          .copyWith(
                                                                              borderRadius: BorderRadiusStyle
                                                                                  .txtCustomBorderBL20),
                                                                      child: Text(
                                                                          "lbl_30_off2"
                                                                              .tr,
                                                                          overflow: TextOverflow
                                                                              .ellipsis,
                                                                          textAlign: TextAlign
                                                                              .left,
                                                                          style:
                                                                              AppStyle.txtRobotoMedium9))
                                                                ])))
                                                  ])),
                                          Padding(
                                              padding: getPadding(top: 9),
                                              child: Text(
                                                  "msg_moscow_rocking_chair".tr,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: AppStyle
                                                      .txtRobotoRegular12Black900)),
                                          Padding(
                                              padding: getPadding(top: 4),
                                              child: Text(
                                                  "msg_casacraft_by_fabfurni"
                                                      .tr,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: AppStyle
                                                      .txtRobotoRegular10Purple9001))
                                        ]))),
                            Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                    padding: getPadding(top: 7, right: 9),
                                    child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          CustomImageView(
                                              imagePath:
                                                  ImageConstant.imgImage17,
                                              height: getSize(195),
                                              width: getSize(195),
                                              margin: getMargin(left: 1)),
                                          Padding(
                                              padding: getPadding(top: 9),
                                              child: Text(
                                                  "msg_moscow_rocking_chair".tr,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: AppStyle
                                                      .txtRobotoRegular12Black900)),
                                          Padding(
                                              padding: getPadding(top: 4),
                                              child: Text(
                                                  "msg_casacraft_by_fabfurni"
                                                      .tr,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: AppStyle
                                                      .txtRobotoRegular10Purple9001))
                                        ]))),
                            Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                    padding: getPadding(top: 355, right: 9),
                                    child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          CustomImageView(
                                              imagePath:
                                                  ImageConstant.imgImage17,
                                              height: getSize(195),
                                              width: getSize(195),
                                              margin: getMargin(left: 1)),
                                          Padding(
                                              padding: getPadding(top: 9),
                                              child: Text(
                                                  "msg_moscow_rocking_chair".tr,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: AppStyle
                                                      .txtRobotoRegular12Black900)),
                                          Padding(
                                              padding: getPadding(top: 4),
                                              child: Text(
                                                  "msg_casacraft_by_fabfurni"
                                                      .tr,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: AppStyle
                                                      .txtRobotoRegular10Purple9001))
                                        ]))),
                            Align(
                                alignment: Alignment.bottomLeft,
                                child: Padding(
                                    padding: getPadding(left: 8, bottom: 65),
                                    child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text("msg_fabiola_2_seater2".tr,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: AppStyle
                                                  .txtRobotoRegular12Black9001),
                                          Padding(
                                              padding: getPadding(top: 7),
                                              child: Text(
                                                  "msg_casacraft_by_fabfurni"
                                                      .tr,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: AppStyle
                                                      .txtRobotoRegular10Purple900)),
                                          Padding(
                                              padding: getPadding(top: 13),
                                              child: Text(
                                                  "msg_limited_time_offer".tr,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: AppStyle
                                                      .txtRobotoRegular10Black9001)),
                                          Padding(
                                              padding: getPadding(top: 7),
                                              child: Row(children: [
                                                Text("lbl_ships_in_1_day".tr,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.left,
                                                    style: AppStyle
                                                        .txtRobotoMedium10Black9001),
                                                CustomImageView(
                                                    svgPath:
                                                        ImageConstant.imgCar,
                                                    height: getVerticalSize(10),
                                                    width:
                                                        getHorizontalSize(13),
                                                    margin: getMargin(
                                                        left: 9,
                                                        top: 1,
                                                        bottom: 1))
                                              ]))
                                        ]))),
                            Align(
                                alignment: Alignment.center,
                                child: SizedBox(
                                    height: getVerticalSize(1000),
                                    child: VerticalDivider(
                                        width: getHorizontalSize(5),
                                        thickness: getVerticalSize(5),
                                        color: ColorConstant.purple50))),
                            Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                    padding: getPadding(left: 10, top: 251),
                                    child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomImageView(
                                              svgPath: ImageConstant.imgCut,
                                              height: getVerticalSize(11),
                                              width: getHorizontalSize(7),
                                              margin: getMargin(bottom: 4)),
                                          Padding(
                                              padding: getPadding(left: 4),
                                              child: Text("lbl_49_999".tr,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: AppStyle
                                                      .txtRobotoMedium12Purple900)),
                                          CustomImageView(
                                              svgPath: ImageConstant
                                                  .imgVectorGray500,
                                              height: getVerticalSize(8),
                                              width: getHorizontalSize(5),
                                              margin: getMargin(
                                                  left: 7, top: 3, bottom: 4))
                                        ]))),
                            Align(
                                alignment: Alignment.bottomLeft,
                                child: Padding(
                                    padding: getPadding(left: 10, bottom: 385),
                                    child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomImageView(
                                              svgPath: ImageConstant.imgCut,
                                              height: getVerticalSize(11),
                                              width: getHorizontalSize(7),
                                              margin: getMargin(bottom: 4)),
                                          Padding(
                                              padding: getPadding(left: 4),
                                              child: Text("lbl_49_999".tr,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: AppStyle
                                                      .txtRobotoMedium12Purple900)),
                                          CustomImageView(
                                              svgPath: ImageConstant
                                                  .imgVectorGray500,
                                              height: getVerticalSize(8),
                                              width: getHorizontalSize(5),
                                              margin: getMargin(
                                                  left: 7, top: 3, bottom: 4))
                                        ]))),
                            Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                    padding: getPadding(top: 251, right: 145),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          CustomImageView(
                                              svgPath: ImageConstant.imgCut,
                                              height: getVerticalSize(11),
                                              width: getHorizontalSize(7),
                                              margin: getMargin(bottom: 4)),
                                          Padding(
                                              padding: getPadding(left: 4),
                                              child: Text("lbl_49_999".tr,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: AppStyle
                                                      .txtRobotoMedium12Purple900)),
                                          CustomImageView(
                                              svgPath: ImageConstant
                                                  .imgVectorGray500,
                                              height: getVerticalSize(8),
                                              width: getHorizontalSize(5),
                                              margin: getMargin(
                                                  left: 7, top: 3, bottom: 4))
                                        ]))),
                            Align(
                                alignment: Alignment.bottomRight,
                                child: Padding(
                                    padding: getPadding(right: 8, bottom: 124),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          CustomImageView(
                                              svgPath: ImageConstant.imgCut,
                                              height: getVerticalSize(11),
                                              width: getHorizontalSize(7),
                                              margin: getMargin(bottom: 3)),
                                          Padding(
                                              padding: getPadding(left: 4),
                                              child: Text("lbl_49_999".tr,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: AppStyle
                                                      .txtRobotoMedium12Purple9001))
                                        ]))),
                            Align(
                                alignment: Alignment.bottomRight,
                                child: Padding(
                                    padding:
                                        getPadding(right: 145, bottom: 385),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text("lbl_49_999".tr,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: AppStyle
                                                  .txtRobotoMedium12Purple900),
                                          CustomImageView(
                                              svgPath: ImageConstant
                                                  .imgVectorGray500,
                                              height: getVerticalSize(8),
                                              width: getHorizontalSize(5),
                                              margin: getMargin(
                                                  left: 7, top: 2, bottom: 4))
                                        ]))),
                            CustomImageView(
                                svgPath: ImageConstant.imgVectorGray500,
                                height: getVerticalSize(8),
                                width: getHorizontalSize(5),
                                alignment: Alignment.bottomRight,
                                margin: getMargin(right: 43, bottom: 111)),
                            Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                    padding: getPadding(left: 74, top: 253),
                                    child: Text("lbl_99_999".tr,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: AppStyle
                                            .txtRobotoMedium10Gray500))),
                            Align(
                                alignment: Alignment.bottomLeft,
                                child: Padding(
                                    padding: getPadding(left: 74, bottom: 386),
                                    child: Text("lbl_99_999".tr,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: AppStyle
                                            .txtRobotoMedium10Gray500))),
                            Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                    padding: getPadding(top: 253, right: 110),
                                    child: Text("lbl_99_999".tr,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: AppStyle
                                            .txtRobotoMedium10Gray500))),
                            Align(
                                alignment: Alignment.bottomRight,
                                child: Padding(
                                    padding:
                                        getPadding(right: 110, bottom: 386),
                                    child: Text("lbl_99_999".tr,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: AppStyle
                                            .txtRobotoMedium10Gray500))),
                            Align(
                                alignment: Alignment.bottomRight,
                                child: Padding(
                                    padding: getPadding(right: 8, bottom: 108),
                                    child: Text("lbl_99_999".tr,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: AppStyle
                                            .txtRobotoMedium10Gray5001))),
                            Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                    padding: getPadding(top: 259),
                                    child: SizedBox(
                                        width: getHorizontalSize(105),
                                        child: Divider(
                                            height: getVerticalSize(1),
                                            thickness: getVerticalSize(1),
                                            color: ColorConstant.gray500,
                                            indent: getHorizontalSize(73))))),
                            Align(
                                alignment: Alignment.bottomLeft,
                                child: Padding(
                                    padding: getPadding(bottom: 392),
                                    child: SizedBox(
                                        width: getHorizontalSize(105),
                                        child: Divider(
                                            height: getVerticalSize(1),
                                            thickness: getVerticalSize(1),
                                            color: ColorConstant.gray500,
                                            indent: getHorizontalSize(73))))),
                            Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                    padding: getPadding(top: 259),
                                    child: SizedBox(
                                        width: getHorizontalSize(142),
                                        child: Divider(
                                            height: getVerticalSize(1),
                                            thickness: getVerticalSize(1),
                                            color: ColorConstant.gray500,
                                            endIndent:
                                                getHorizontalSize(110))))),
                            Align(
                                alignment: Alignment.bottomRight,
                                child: Padding(
                                    padding: getPadding(bottom: 392),
                                    child: SizedBox(
                                        width: getHorizontalSize(142),
                                        child: Divider(
                                            height: getVerticalSize(1),
                                            thickness: getVerticalSize(1),
                                            color: ColorConstant.gray500,
                                            endIndent:
                                                getHorizontalSize(110))))),
                            Align(
                                alignment: Alignment.bottomRight,
                                child: Padding(
                                    padding: getPadding(bottom: 113),
                                    child: SizedBox(
                                        width: getHorizontalSize(40),
                                        child: Divider(
                                            height: getVerticalSize(1),
                                            thickness: getVerticalSize(1),
                                            color: ColorConstant.gray500,
                                            endIndent: getHorizontalSize(8))))),
                            Align(
                                alignment: Alignment.topCenter,
                                child: Padding(
                                    padding: getPadding(top: 347),
                                    child: SizedBox(
                                        width: double.maxFinite,
                                        child: Divider(
                                            height: getVerticalSize(5),
                                            thickness: getVerticalSize(5),
                                            color: ColorConstant.purple50)))),
                            Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                    padding: getPadding(bottom: 298),
                                    child: SizedBox(
                                        width: double.maxFinite,
                                        child: Divider(
                                            height: getVerticalSize(5),
                                            thickness: getVerticalSize(5),
                                            color: ColorConstant.purple50)))),
                            Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                    padding: getPadding(bottom: 43),
                                    child: SizedBox(
                                        width: double.maxFinite,
                                        child: Divider(
                                            height: getVerticalSize(5),
                                            thickness: getVerticalSize(5),
                                            color: ColorConstant.purple50)))),
                            Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                    margin: getMargin(
                                        left: 14, right: 14, bottom: 225),
                                    padding: getPadding(
                                        left: 41, top: 6, right: 41, bottom: 6),
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
                                              svgPath: ImageConstant
                                                  .imgGroup2Purple900,
                                              height: getVerticalSize(47),
                                              width: getHorizontalSize(315),
                                              margin: getMargin(top: 11)),
                                          Padding(
                                              padding: getPadding(
                                                  left: 7, top: 4, right: 4),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text("lbl_home".tr,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: AppStyle
                                                            .txtRobotoMedium8),
                                                    Text("lbl_store".tr,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: AppStyle
                                                            .txtRobotoMedium8Purple900),
                                                    Text("lbl_profile".tr,
                                                        overflow: TextOverflow
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

  void _showsortbyBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(25.0),
                topRight: const Radius.circular(25.0),
              ),
            ),
            child: SortByBottomsheet());
      },
    ).then((value) {
      if (value != null) {
        // Handle the selected quantity returned from the bottom sheet
        // addtocart(value.toString(),product_id);
        print('Selected quantity: ' + value);
        Fluttertoast.showToast(
            msg: value,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.cyan,
            textColor: Colors.white,
            fontSize: 14.0);
        /*sortBy = value;
        product = getProduct();
        product.then((value) {
          setState(() {
            productlist = value.data;
          });
        });*/
      }
    });
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(25.0),
                topRight: const Radius.circular(25.0),
              ),
            ),
            child: FilterScreen());
      },
    ).then((value) {
      if (value != null) {
        //print('Selected quantity: '+ value);
        /*widget.categoryId = value[0];
        widget.subCategoryId = value[1];
        widget.keyword_id = value[2];
        widget.brandId = value[3];
        product = getProduct();
        product.then((value) {
          setState(() {
            productlist = value.data;
          });
        });*/
      }
    });
  }

  onTapArrowleft3() {
    Get.back();
  }
}
