import '../product_detail_scroll_one_screen/widgets/listprice_item_widget.dart';
import 'controller/product_detail_scroll_one_controller.dart';
import 'models/listprice_item_model.dart';
import 'package:flutter/material.dart';
import 'package:keshav_s_application2/core/app_export.dart';
import 'package:keshav_s_application2/widgets/app_bar/appbar_image.dart';
import 'package:keshav_s_application2/widgets/app_bar/appbar_subtitle_6.dart';
import 'package:keshav_s_application2/widgets/app_bar/custom_app_bar.dart';
import 'package:keshav_s_application2/widgets/custom_button.dart';

class ProductDetailScrollOneScreen
    extends GetWidget<ProductDetailScrollOneController> {
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
                          height: getVerticalSize(193),
                          width: double.maxFinite,
                          margin: getMargin(top: 1),
                          child:
                              Stack(alignment: Alignment.topCenter, children: [
                            Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                    margin: getMargin(left: 10, right: 10),
                                    padding: getPadding(
                                        left: 18, top: 6, right: 18, bottom: 6),
                                    decoration: AppDecoration.fillPurple5001,
                                    child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Padding(
                                              padding: getPadding(top: 8),
                                              child: Text(
                                                  "msg_delivery_services".tr,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: AppStyle
                                                      .txtRobotoRegular14Black900)),
                                          Padding(
                                              padding: getPadding(top: 7),
                                              child: Divider(
                                                  height: getVerticalSize(1),
                                                  thickness: getVerticalSize(1),
                                                  color:
                                                      ColorConstant.gray40002)),
                                          Container(
                                              margin: getMargin(
                                                  left: 2, top: 3, right: 2),
                                              padding: getPadding(
                                                  left: 11,
                                                  top: 8,
                                                  right: 11,
                                                  bottom: 8),
                                              decoration: AppDecoration
                                                  .outlineBlack90019,
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Padding(
                                                        padding: getPadding(
                                                            left: 1, top: 2),
                                                        child: Text(
                                                            "lbl_pincode".tr,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: AppStyle
                                                                .txtRobotoRegular12Gray600)),
                                                    Padding(
                                                        padding:
                                                            getPadding(top: 2),
                                                        child: Text(
                                                            "lbl_apply".tr,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: AppStyle
                                                                .txtRobotoMedium12Purple900))
                                                  ])),
                                          Container(
                                              width: getHorizontalSize(194),
                                              margin: getMargin(top: 12),
                                              child: Text(
                                                  "msg_enter_pincode_to".tr,
                                                  maxLines: null,
                                                  textAlign: TextAlign.center,
                                                  style: AppStyle
                                                      .txtRobotoRegular10Gray600
                                                      .copyWith(
                                                          letterSpacing:
                                                              getHorizontalSize(
                                                                  0.5)))),
                                          Container(
                                              width: getHorizontalSize(174),
                                              margin: getMargin(top: 4),
                                              child: Text(
                                                  "msg_delivery_assembly".tr,
                                                  maxLines: null,
                                                  textAlign: TextAlign.center,
                                                  style: AppStyle
                                                      .txtRobotoRegular10Gray800
                                                      .copyWith(
                                                          letterSpacing:
                                                              getHorizontalSize(
                                                                  0.5))))
                                        ]))),
                            CustomAppBar(
                                height: getVerticalSize(91),
                                leadingWidth: 34,
                                leading: AppbarImage(
                                    height: getVerticalSize(15),
                                    width: getHorizontalSize(9),
                                    svgPath: ImageConstant.imgArrowleft,
                                    margin: getMargin(
                                        left: 25, top: 53, bottom: 23),
                                    onTap: onTapArrowleft14),
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
                                styleType: Style.bgShadowBlack90033)
                          ])),
                      Container(
                          margin: getMargin(left: 10, top: 10, right: 10),
                          padding: getPadding(
                              left: 18, top: 8, right: 18, bottom: 8),
                          decoration: AppDecoration.fillPurple5001,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Align(
                                    alignment: Alignment.center,
                                    child: Text("msg_delivery_services".tr,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: AppStyle
                                            .txtRobotoRegular14Black900)),
                                Padding(
                                    padding: getPadding(top: 7),
                                    child: Divider(
                                        height: getVerticalSize(1),
                                        thickness: getVerticalSize(1),
                                        color: ColorConstant.gray40002,
                                        indent: getHorizontalSize(1))),
                                Padding(
                                    padding: getPadding(left: 8, top: 8),
                                    child: Row(children: [
                                      Text("lbl_brand".tr,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style: AppStyle
                                              .txtRobotoRegular10Bluegray900),
                                      Padding(
                                          padding: getPadding(left: 84),
                                          child: Text("lbl_arra".tr,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: AppStyle
                                                  .txtRobotoRegular10Bluegray900))
                                    ])),
                                Padding(
                                    padding:
                                        getPadding(left: 8, top: 8, right: 92),
                                    child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                              padding: getPadding(bottom: 15),
                                              child: Text("lbl_dimension".tr,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: AppStyle
                                                      .txtRobotoRegular10Bluegray900)),
                                          Container(
                                              width: getHorizontalSize(159),
                                              margin: getMargin(left: 63),
                                              child: Text("msg_h_37_5_w_62".tr,
                                                  maxLines: null,
                                                  textAlign: TextAlign.left,
                                                  style: AppStyle
                                                      .txtRobotoRegular10Bluegray9001))
                                        ])),
                                Padding(
                                    padding: getPadding(left: 8, top: 6),
                                    child: Row(children: [
                                      Text("lbl_weight".tr,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style: AppStyle
                                              .txtRobotoRegular10Bluegray900),
                                      Padding(
                                          padding: getPadding(left: 79),
                                          child: Text("lbl_46_2_kg".tr,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: AppStyle
                                                  .txtRobotoRegular10Bluegray900))
                                    ])),
                                Padding(
                                    padding: getPadding(left: 8, top: 9),
                                    child: Row(children: [
                                      Text("lbl_warrenty".tr,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style: AppStyle
                                              .txtRobotoRegular10Bluegray900),
                                      Padding(
                                          padding: getPadding(left: 70),
                                          child: Text(
                                              "msg_12_months_warrenty2".tr,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: AppStyle
                                                  .txtRobotoRegular10Bluegray900))
                                    ])),
                                Padding(
                                    padding: getPadding(left: 8, top: 8),
                                    child: Row(children: [
                                      Text("lbl_assembly".tr,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style: AppStyle
                                              .txtRobotoRegular10Bluegray900),
                                      Padding(
                                          padding: getPadding(left: 66),
                                          child: Text(
                                              "msg_carpenter_assembly".tr,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: AppStyle
                                                  .txtRobotoRegular10Bluegray900))
                                    ])),
                                Padding(
                                    padding: getPadding(left: 8, top: 7),
                                    child: Row(children: [
                                      Padding(
                                          padding: getPadding(top: 1),
                                          child: Text("msg_primary_material".tr,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: AppStyle
                                                  .txtRobotoRegular10Bluegray900)),
                                      Padding(
                                          padding:
                                              getPadding(left: 37, bottom: 1),
                                          child: Text("lbl_fabric".tr,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: AppStyle
                                                  .txtRobotoRegular10Bluegray900))
                                    ])),
                                Padding(
                                    padding: getPadding(left: 8, top: 9),
                                    child: Row(children: [
                                      Text("lbl_room_type".tr,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style: AppStyle
                                              .txtRobotoRegular10Bluegray900),
                                      Padding(
                                          padding: getPadding(left: 60),
                                          child: Text("lbl_living_room".tr,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: AppStyle
                                                  .txtRobotoRegular10Bluegray900))
                                    ])),
                                Padding(
                                    padding: getPadding(left: 8, top: 7),
                                    child: Row(children: [
                                      Text("lbl_seating_height".tr,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style: AppStyle
                                              .txtRobotoRegular10Bluegray900),
                                      Padding(
                                          padding: getPadding(left: 45),
                                          child: Text("lbl_18".tr,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: AppStyle
                                                  .txtRobotoRegular10Bluegray900))
                                    ])),
                                Padding(
                                    padding: getPadding(left: 8, top: 8),
                                    child: Row(children: [
                                      Text("lbl_color".tr,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style: AppStyle
                                              .txtRobotoRegular10Bluegray900),
                                      Padding(
                                          padding: getPadding(left: 86),
                                          child: Text("lbl_black".tr,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: AppStyle
                                                  .txtRobotoRegular10Bluegray900))
                                    ])),
                                Padding(
                                    padding:
                                        getPadding(left: 8, top: 9, bottom: 5),
                                    child: Text("lbl_sku".tr,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: AppStyle
                                            .txtRobotoRegular10Bluegray900))
                              ])),
                      Container(
                          height: getVerticalSize(442),
                          width: double.maxFinite,
                          margin: getMargin(top: 10),
                          child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                Align(
                                    alignment: Alignment.topCenter,
                                    child: Container(
                                        padding: getPadding(top: 9, bottom: 9),
                                        decoration: AppDecoration.fillPurple50,
                                        child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text("lbl_similar_prodcut".tr,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: AppStyle
                                                      .txtRobotoMedium13
                                                      .copyWith(
                                                          letterSpacing:
                                                              getHorizontalSize(
                                                                  0.26))),
                                              Container(
                                                  height: getVerticalSize(154),
                                                  child: Obx(() =>
                                                      ListView.separated(
                                                          padding: getPadding(
                                                              left: 16,
                                                              top: 11),
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
                                                              .productDetailScrollOneModelObj
                                                              .value
                                                              .listpriceItemList
                                                              .length,
                                                          itemBuilder:
                                                              (context, index) {
                                                            ListpriceItemModel
                                                                model =
                                                                controller
                                                                    .productDetailScrollOneModelObj
                                                                    .value
                                                                    .listpriceItemList[index];
                                                            return ListpriceItemWidget(
                                                                model);
                                                          }))),
                                              CustomButton(
                                                  height: getVerticalSize(30),
                                                  text:
                                                      "lbl_additional_info".tr,
                                                  margin: getMargin(
                                                      left: 15,
                                                      top: 15,
                                                      right: 14),
                                                  shape: ButtonShape.Square),
                                              CustomButton(
                                                  height: getVerticalSize(30),
                                                  text: "msg_customer_redressal"
                                                      .tr,
                                                  margin: getMargin(
                                                      left: 15,
                                                      top: 10,
                                                      right: 14),
                                                  shape: ButtonShape.Square),
                                              CustomButton(
                                                  height: getVerticalSize(30),
                                                  text: "lbl_mechant_info".tr,
                                                  margin: getMargin(
                                                      left: 15,
                                                      top: 10,
                                                      right: 14),
                                                  shape: ButtonShape.Square),
                                              CustomButton(
                                                  height: getVerticalSize(30),
                                                  text:
                                                      "msg_returns_cancellation"
                                                          .tr,
                                                  margin: getMargin(
                                                      left: 15,
                                                      top: 10,
                                                      right: 14),
                                                  shape: ButtonShape.Square),
                                              CustomButton(
                                                  height: getVerticalSize(30),
                                                  text:
                                                      "msg_warrenty_installation"
                                                          .tr,
                                                  margin: getMargin(
                                                      left: 15,
                                                      top: 10,
                                                      right: 14,
                                                      bottom: 5),
                                                  shape: ButtonShape.Square)
                                            ]))),
                                Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                        height: getVerticalSize(42),
                                        width: double.maxFinite,
                                        decoration: BoxDecoration(
                                            color: ColorConstant.whiteA700,
                                            boxShadow: [
                                              BoxShadow(
                                                  color:
                                                      ColorConstant.black90033,
                                                  spreadRadius:
                                                      getHorizontalSize(2),
                                                  blurRadius:
                                                      getHorizontalSize(2),
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
                                    alignment: Alignment.bottomLeft),
                                Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                        width: getHorizontalSize(214),
                                        padding: getPadding(
                                            left: 30,
                                            top: 13,
                                            right: 74,
                                            bottom: 13),
                                        decoration:
                                            AppDecoration.txtFillPurple900,
                                        child: Text("lbl_buy_now".tr,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: AppStyle
                                                .txtRobotoMedium12WhiteA700)))
                              ]))
                    ]))));
  }

  onTapArrowleft14() {
    Get.back();
  }
}
