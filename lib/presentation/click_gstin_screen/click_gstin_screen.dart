import 'controller/click_gstin_controller.dart';
import 'package:flutter/material.dart';
import 'package:keshav_s_application2/core/app_export.dart';
import 'package:keshav_s_application2/core/utils/validation_functions.dart';
import 'package:keshav_s_application2/widgets/app_bar/appbar_image.dart';
import 'package:keshav_s_application2/widgets/app_bar/custom_app_bar.dart';
import 'package:keshav_s_application2/widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class ClickGstinScreen extends GetWidget<ClickGstinController> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorConstant.whiteA700,
      appBar: CustomAppBar(
          height: getVerticalSize(91),
          leadingWidth: 34,
          leading: AppbarImage(
              height: getVerticalSize(15),
              width: getHorizontalSize(9),
              svgPath: ImageConstant.imgArrowleft,
              margin: getMargin(left: 25, top: 53, bottom: 23),
              onTap: onTapArrowleft16),
          title: Padding(
              padding: getPadding(left: 19, top: 50, bottom: 18),
              child: Text("lbl_cart".tr,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: AppStyle.txtRobotoMedium18Gray50001
                      .copyWith(letterSpacing: getHorizontalSize(1.62)))),
          styleType: Style.bgShadowBlack90033),
      body: Form(
          key: _formKey,
          child: Container(
              width: double.maxFinite,
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                CustomTextFormField(
                    focusNode: FocusNode(),
                    controller: controller.priceController,
                    hintText: "msg_gstin_registration".tr,
                    margin: getMargin(left: 27, top: 44, right: 26),
                    textInputType: TextInputType.name,
                    validator: (value) {
                      if (value!.isEmpty && value.length != 15) {
                        return "Please enter valid gst number";
                      }
                      return null;
                    }),
                CustomTextFormField(
                    focusNode: FocusNode(),
                    controller: controller.nameController,
                    hintText: "msg_register_company".tr,
                    margin: getMargin(left: 27, top: 105, right: 26),
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if (!isText(value!)) {
                        return "Please enter valid text";
                      }
                      return null;
                    }),
                Container(
                    width: getHorizontalSize(355),
                    margin: getMargin(left: 30, top: 113, right: 42),
                    child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: "lbl_please_note".tr,
                              style: TextStyle(
                                  color: ColorConstant.gray500,
                                  fontSize: getFontSize(12),
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: getHorizontalSize(0.6))),
                          TextSpan(
                              text: "msg_enter_the_registerd".tr,
                              style: TextStyle(
                                  color: ColorConstant.gray500,
                                  fontSize: getFontSize(10),
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: getHorizontalSize(0.6)))
                        ]),
                        textAlign: TextAlign.left)),
                Spacer(),
                // Padding(
                //     padding: getPadding(left: 8, top: 71, right: 8),
                //     child: Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         crossAxisAlignment: CrossAxisAlignment.end,
                //         children: [
                //           Padding(
                //               padding: getPadding(bottom: 4),
                //               child: Text("msg_fabiola_2_seater2".tr,
                //                   overflow: TextOverflow.ellipsis,
                //                   textAlign: TextAlign.left,
                //                   style: AppStyle
                //                       .txtRobotoRegular12Black9001)),
                //           Spacer(),
                //           CustomImageView(
                //               svgPath: ImageConstant.imgCut,
                //               height: getVerticalSize(11),
                //               width: getHorizontalSize(7),
                //               margin: getMargin(top: 4, bottom: 3)),
                //           Padding(
                //               padding: getPadding(left: 4, top: 4),
                //               child: Text("lbl_49_999".tr,
                //                   overflow: TextOverflow.ellipsis,
                //                   textAlign: TextAlign.left,
                //                   style: AppStyle
                //                       .txtRobotoMedium12Purple9001))
                //         ])),
                // Padding(
                //     padding: getPadding(left: 8, top: 3, right: 8),
                //     child: Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           Padding(
                //               padding: getPadding(bottom: 1),
                //               child: Text(
                //                   "msg_casacraft_by_fabfurni".tr,
                //                   overflow: TextOverflow.ellipsis,
                //                   textAlign: TextAlign.left,
                //                   style: AppStyle
                //                       .txtRobotoRegular10Purple900)),
                //           Spacer(),
                //           CustomImageView(
                //               svgPath: ImageConstant.imgVectorGray500,
                //               height: getVerticalSize(8),
                //               width: getHorizontalSize(5),
                //               margin: getMargin(top: 2, bottom: 3)),
                //           Container(
                //               height: getVerticalSize(12),
                //               width: getHorizontalSize(32),
                //               margin: getMargin(left: 3, top: 1),
                //               child: Stack(
                //                   alignment: Alignment.bottomCenter,
                //                   children: [
                //                     Align(
                //                         alignment: Alignment.center,
                //                         child: Text("lbl_99_999".tr,
                //                             overflow:
                //                                 TextOverflow.ellipsis,
                //                             textAlign: TextAlign.left,
                //                             style: AppStyle
                //                                 .txtRobotoMedium10Gray5001)),
                //                     Align(
                //                         alignment:
                //                             Alignment.bottomCenter,
                //                         child: Padding(
                //                             padding:
                //                                 getPadding(bottom: 5),
                //                             child: SizedBox(
                //                                 width:
                //                                     getHorizontalSize(
                //                                         32),
                //                                 child: Divider(
                //                                     height:
                //                                         getVerticalSize(
                //                                             1),
                //                                     thickness:
                //                                         getVerticalSize(
                //                                             1),
                //                                     color: ColorConstant
                //                                         .gray500))))
                //                   ]))
                //         ])),
                // Padding(
                //     padding: getPadding(left: 8, top: 12, right: 12),
                //     child: Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         crossAxisAlignment: CrossAxisAlignment.end,
                //         children: [
                //           Column(
                //               mainAxisAlignment:
                //                   MainAxisAlignment.start,
                //               children: [
                //                 Text("msg_limited_time_offer".tr,
                //                     overflow: TextOverflow.ellipsis,
                //                     textAlign: TextAlign.left,
                //                     style: AppStyle
                //                         .txtRobotoRegular10Black9001),
                //                 Padding(
                //                     padding: getPadding(top: 7),
                //                     child: Row(
                //                         mainAxisAlignment:
                //                             MainAxisAlignment.center,
                //                         children: [
                //                           Text(
                //                               "lbl_ships_in_1_day".tr,
                //                               overflow: TextOverflow
                //                                   .ellipsis,
                //                               textAlign:
                //                                   TextAlign.left,
                //                               style: AppStyle
                //                                   .txtRobotoMedium10Black9001),
                //                           CustomImageView(
                //                               svgPath: ImageConstant
                //                                   .imgCar,
                //                               height:
                //                                   getVerticalSize(10),
                //                               width:
                //                                   getHorizontalSize(
                //                                       13),
                //                               margin: getMargin(
                //                                   left: 9,
                //                                   top: 1,
                //                                   bottom: 1))
                //                         ]))
                //               ]),
                //           Spacer(),
                //           CustomImageView(
                //               svgPath: ImageConstant.imgLocation,
                //               height: getVerticalSize(18),
                //               width: getHorizontalSize(21),
                //               margin: getMargin(top: 10, bottom: 3)),
                //           CustomImageView(
                //               svgPath: ImageConstant.imgCart,
                //               height: getVerticalSize(20),
                //               width: getHorizontalSize(23),
                //               margin: getMargin(
                //                   left: 35, top: 9, bottom: 2))
                //         ])),
              ]))),
      bottomNavigationBar: Container(
          width: double.maxFinite,
          child: Container(
              padding: getPadding(left: 193, top: 20, right: 193, bottom: 20),
              decoration: AppDecoration.fillPurple900
                  .copyWith(borderRadius: BorderRadiusStyle.customBorderLR60),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                        padding: getPadding(top: 3),
                        child: Text("lbl_save".tr,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtRobotoMedium16.copyWith(
                                letterSpacing: getHorizontalSize(0.8))))
                  ]))),
    ));
  }

  onTapArrowleft16() {
    Get.back();
  }
}
