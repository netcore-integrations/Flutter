import '../product_detail_scroll_screen/widgets/listprice1_item_widget.dart';
import 'controller/product_detail_scroll_controller.dart';
import 'models/listprice1_item_model.dart';
import 'package:flutter/material.dart';
import 'package:keshav_s_application2/core/app_export.dart';
import 'package:keshav_s_application2/widgets/app_bar/appbar_image.dart';
import 'package:keshav_s_application2/widgets/app_bar/appbar_subtitle_6.dart';
import 'package:keshav_s_application2/widgets/app_bar/custom_app_bar.dart';
import 'package:keshav_s_application2/widgets/custom_button.dart';

class ProductDetailScrollScreen
    extends GetWidget<ProductDetailScrollController> {
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
                          height: getVerticalSize(488),
                          width: double.maxFinite,
                          child:
                              Stack(alignment: Alignment.topCenter, children: [
                            Align(
                                alignment: Alignment.topCenter,
                                child: Padding(
                                    padding: getPadding(top: 79),
                                    child: SizedBox(
                                        width: getHorizontalSize(371),
                                        child: Divider(
                                            height: getVerticalSize(1),
                                            thickness: getVerticalSize(1),
                                            color: ColorConstant.gray40002)))),
                            Align(
                                alignment: Alignment.topCenter,
                                child: Padding(
                                    padding: getPadding(top: 54),
                                    child: Text("msg_delivery_services".tr,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: AppStyle
                                            .txtRobotoRegular14Black900))),
                            Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                    margin: getMargin(left: 10, right: 10),
                                    padding: getPadding(left: 26, right: 26),
                                    decoration: AppDecoration.fillPurple5001,
                                    child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Row(children: [
                                            Text("lbl_room_type".tr,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style: AppStyle
                                                    .txtRobotoRegular10Bluegray900),
                                            Padding(
                                                padding: getPadding(left: 60),
                                                child: Text(
                                                    "lbl_living_room".tr,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.left,
                                                    style: AppStyle
                                                        .txtRobotoRegular10Bluegray900))
                                          ]),
                                          Padding(
                                              padding: getPadding(top: 3),
                                              child: Row(children: [
                                                Text("lbl_seating_height".tr,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.left,
                                                    style: AppStyle
                                                        .txtRobotoRegular10Bluegray900),
                                                Padding(
                                                    padding:
                                                        getPadding(left: 45),
                                                    child: Text("lbl_18".tr,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: AppStyle
                                                            .txtRobotoRegular10Bluegray900))
                                              ])),
                                          Padding(
                                              padding: getPadding(top: 8),
                                              child: Row(children: [
                                                Text("lbl_color".tr,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.left,
                                                    style: AppStyle
                                                        .txtRobotoRegular10Bluegray900),
                                                Padding(
                                                    padding:
                                                        getPadding(left: 86),
                                                    child: Text("lbl_black".tr,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: AppStyle
                                                            .txtRobotoRegular10Bluegray900))
                                              ])),
                                          Padding(
                                              padding: getPadding(
                                                  top: 9, bottom: 13),
                                              child: Row(children: [
                                                Text("lbl_sku".tr,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.left,
                                                    style: AppStyle
                                                        .txtRobotoRegular10Bluegray900),
                                                Padding(
                                                    padding:
                                                        getPadding(left: 94),
                                                    child: Text(
                                                        "msg_fn1824225_s_skm4568"
                                                            .tr,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: AppStyle
                                                            .txtRobotoRegular10Bluegray900))
                                              ]))
                                        ]))),
                            CustomAppBar(
                                height: getVerticalSize(92),
                                leadingWidth: 34,
                                leading: AppbarImage(
                                    height: getVerticalSize(15),
                                    width: getHorizontalSize(9),
                                    svgPath: ImageConstant.imgArrowleft,
                                    margin: getMargin(
                                        left: 25, top: 53, bottom: 23),
                                    onTap: onTapArrowleft19),
                                actions: [
                                  AppbarImage(
                                      height: getSize(21),
                                      width: getSize(21),
                                      svgPath: ImageConstant.imgSearch,
                                      margin: getMargin(
                                          left: 12, top: 51, right: 19)),
                                  Container(
                                      height: getVerticalSize(23),
                                      width: getHorizontalSize(27),
                                      margin: getMargin(
                                          left: 20,
                                          top: 48,
                                          right: 19,
                                          bottom: 1),
                                      child: Stack(
                                          alignment: Alignment.topRight,
                                          children: [
                                            AppbarImage(
                                                height: getVerticalSize(18),
                                                width: getHorizontalSize(21),
                                                svgPath:
                                                    ImageConstant.imgLocation,
                                                margin: getMargin(
                                                    top: 5, right: 6)),
                                            AppbarSubtitle6(
                                                text: "lbl_2".tr,
                                                margin: getMargin(
                                                    left: 17, bottom: 13))
                                          ])),
                                  Container(
                                      height: getVerticalSize(24),
                                      width: getHorizontalSize(29),
                                      margin: getMargin(
                                          left: 14, top: 48, right: 31),
                                      child: Stack(
                                          alignment: Alignment.topRight,
                                          children: [
                                            AppbarImage(
                                                height: getVerticalSize(20),
                                                width: getHorizontalSize(23),
                                                svgPath: ImageConstant.imgCart,
                                                margin: getMargin(
                                                    top: 4, right: 6)),
                                            AppbarSubtitle6(
                                                text: "lbl_3".tr,
                                                margin: getMargin(
                                                    left: 19, bottom: 14))
                                          ]))
                                ],
                                styleType: Style.bgShadowBlack90033),
                            Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                    padding: getPadding(top: 9, bottom: 9),
                                    decoration: AppDecoration.fillPurple50,
                                    child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text("lbl_similar_prodcut".tr,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: AppStyle.txtRobotoMedium13
                                                  .copyWith(
                                                      letterSpacing:
                                                          getHorizontalSize(
                                                              0.26))),
                                          Container(
                                              height: getVerticalSize(154),
                                              child: Obx(() =>
                                                  ListView.separated(
                                                      padding: getPadding(
                                                          left: 16, top: 11),
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      separatorBuilder:
                                                          (context, index) {
                                                        return SizedBox(
                                                            height:
                                                                getVerticalSize(
                                                                    10));
                                                      },
                                                      itemCount: controller
                                                          .productDetailScrollModelObj
                                                          .value
                                                          .listprice1ItemList
                                                          .length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        Listprice1ItemModel
                                                            model = controller
                                                                .productDetailScrollModelObj
                                                                .value
                                                                .listprice1ItemList[index];
                                                        return Listprice1ItemWidget(
                                                            model);
                                                      }))),
                                          CustomButton(
                                              height: getVerticalSize(30),
                                              text: "lbl_additional_info".tr,
                                              margin: getMargin(
                                                  left: 15, top: 15, right: 14),
                                              shape: ButtonShape.Square),
                                          CustomButton(
                                              height: getVerticalSize(30),
                                              text: "msg_customer_redressal".tr,
                                              margin: getMargin(
                                                  left: 15, top: 10, right: 14),
                                              shape: ButtonShape.Square),
                                          CustomButton(
                                              height: getVerticalSize(30),
                                              text: "lbl_mechant_info".tr,
                                              margin: getMargin(
                                                  left: 15, top: 10, right: 14),
                                              shape: ButtonShape.Square),
                                          CustomButton(
                                              height: getVerticalSize(30),
                                              text:
                                                  "msg_returns_cancellation".tr,
                                              margin: getMargin(
                                                  left: 15, top: 10, right: 14),
                                              shape: ButtonShape.Square),
                                          CustomButton(
                                              height: getVerticalSize(30),
                                              text: "msg_warrenty_installation"
                                                  .tr,
                                              margin: getMargin(
                                                  left: 15,
                                                  top: 10,
                                                  right: 14,
                                                  bottom: 5),
                                              shape: ButtonShape.Square)
                                        ])))
                          ])),
                      Padding(
                          padding: getPadding(top: 11),
                          child: Text("msg_more_from_brand".tr,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtRobotoMedium13.copyWith(
                                  letterSpacing: getHorizontalSize(0.26)))),
                      SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          padding: getPadding(left: 15, top: 9),
                          child: IntrinsicWidth(
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                Column(
                                  children: [
                                    CustomImageView(
                                        imagePath: ImageConstant.imgImage3,
                                        height: getVerticalSize(124),
                                        width: getHorizontalSize(249)),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              width: getHorizontalSize(154),
                                              child: Text(
                                                  "msg_fabiola_2_seater3".tr,
                                                  maxLines: null,
                                                  textAlign: TextAlign.left,
                                                  style: AppStyle
                                                      .txtRobotoRegular12Black9001)),
                                          CustomImageView(
                                              svgPath: ImageConstant.imgCut,
                                              height: getVerticalSize(11),
                                              width: getHorizontalSize(7),
                                              margin: getMargin(
                                                  left: 47,
                                                  top: 3,
                                                  bottom: 16)),
                                          Padding(
                                              padding: getPadding(
                                                  left: 4, top: 3, bottom: 12),
                                              child: Text("lbl_49_999".tr,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: AppStyle
                                                      .txtRobotoMedium12Purple900)),
                                          Container(
                                              width: getHorizontalSize(154),
                                              margin: getMargin(left: 10),
                                              child: Text(
                                                  "msg_fabiola_2_seater3".tr,
                                                  maxLines: null,
                                                  textAlign: TextAlign.left,
                                                  style: AppStyle
                                                      .txtRobotoRegular12Black9001))
                                        ])
                                  ],
                                ),
                                CustomImageView(
                                    imagePath: ImageConstant.imgImage3,
                                    height: getVerticalSize(124),
                                    width: getHorizontalSize(249),
                                    margin: getMargin(left: 10))
                              ]))),
                      Padding(
                          padding: getPadding(left: 15, top: 5),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    width: getHorizontalSize(154),
                                    child: Text("msg_fabiola_2_seater3".tr,
                                        maxLines: null,
                                        textAlign: TextAlign.left,
                                        style: AppStyle
                                            .txtRobotoRegular12Black9001)),
                                CustomImageView(
                                    svgPath: ImageConstant.imgCut,
                                    height: getVerticalSize(11),
                                    width: getHorizontalSize(7),
                                    margin: getMargin(
                                        left: 47, top: 3, bottom: 16)),
                                Padding(
                                    padding:
                                        getPadding(left: 4, top: 3, bottom: 12),
                                    child: Text("lbl_49_999".tr,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: AppStyle
                                            .txtRobotoMedium12Purple900)),
                                Container(
                                    width: getHorizontalSize(154),
                                    margin: getMargin(left: 10),
                                    child: Text("msg_fabiola_2_seater3".tr,
                                        maxLines: null,
                                        textAlign: TextAlign.left,
                                        style: AppStyle
                                            .txtRobotoRegular12Black9001))
                              ])),
                      Container(
                          height: getVerticalSize(166),
                          width: double.maxFinite,
                          margin: getMargin(top: 31),
                          child:
                              Stack(alignment: Alignment.topCenter, children: [
                            Align(
                                alignment: Alignment.center,
                                child: Container(
                                    padding: getPadding(
                                        left: 57,
                                        top: 30,
                                        right: 57,
                                        bottom: 30),
                                    decoration: AppDecoration.fillPurple50,
                                    child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Padding(
                                              padding: getPadding(top: 21),
                                              child: Text(
                                                  "msg_like_what_you_see".tr,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: AppStyle
                                                      .txtRobotoRegular14Gray50001)),
                                          CustomImageView(
                                              imagePath:
                                                  ImageConstant.imgGroup12,
                                              height: getVerticalSize(37),
                                              width: getHorizontalSize(177),
                                              margin: getMargin(top: 29))
                                        ]))),
                            Align(
                                alignment: Alignment.topCenter,
                                child: SizedBox(
                                    width: double.maxFinite,
                                    child: Divider(
                                        height: getVerticalSize(1),
                                        thickness: getVerticalSize(1))))
                          ]))
                    ])),
            bottomNavigationBar: Container(
                height: getVerticalSize(43),
                width: double.maxFinite,
                child: Stack(alignment: Alignment.centerLeft, children: [
                  Align(
                      alignment: Alignment.center,
                      child: Container(
                          height: getVerticalSize(42),
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                              color: ColorConstant.whiteA700,
                              boxShadow: [
                                BoxShadow(
                                    color: ColorConstant.black90033,
                                    spreadRadius: getHorizontalSize(2),
                                    blurRadius: getHorizontalSize(2),
                                    offset: Offset(0, 0))
                              ]))),
                  CustomButton(
                      height: getVerticalSize(43),
                      width: getHorizontalSize(215),
                      text: "lbl_add_to_cart".tr,
                      variant: ButtonVariant.FillBluegray100,
                      shape: ButtonShape.Square,
                      padding: ButtonPadding.PaddingAll15,
                      fontStyle: ButtonFontStyle.RobotoMedium12,
                      alignment: Alignment.centerLeft),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                          width: getHorizontalSize(214),
                          padding: getPadding(
                              left: 30, top: 13, right: 74, bottom: 13),
                          decoration: AppDecoration.txtFillPurple900,
                          child: Text("lbl_buy_now".tr,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtRobotoMedium12WhiteA700)))
                ]))));
  }

  onTapArrowleft19() {
    Get.back();
  }
}
