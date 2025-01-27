import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:keshav_s_application2/landingpage.dart';
import 'package:keshav_s_application2/paytm_config.dart';
import 'package:keshav_s_application2/presentation/order_placed_screen/order_placed_screen.dart';
// import 'package:paytm_allinonesdk/paytm_allinonesdk.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/custom_button.dart';
import '../cart_screen/ChooseAddress.dart';
import '../otp_screen/models/otp_model.dart';
import 'applycoupon.dart';
import 'controller/payment_method_controller.dart';
import 'package:flutter/material.dart';
import 'package:keshav_s_application2/core/app_export.dart';
import 'package:keshav_s_application2/widgets/app_bar/appbar_image.dart';
import 'package:keshav_s_application2/widgets/app_bar/appbar_subtitle_2.dart';
import 'package:keshav_s_application2/widgets/app_bar/appbar_subtitle_4.dart';
import 'package:keshav_s_application2/widgets/app_bar/custom_app_bar.dart';
import 'package:dio/dio.dart' as dio;

class PaymentMethodScreen extends StatefulWidget {
  String count;
  String total_amount;
  String address_id;
  String address1;
  String address2;
  String product_id;
  String userid;
  String discount_price;
  String mrp_price;
  Data data;
  PaymentMethodScreen(
      this.count,
      this.total_amount,
      this.address_id,
      this.address1,
      this.address2,
      this.product_id,
      this.userid,
      this.discount_price,
      this.mrp_price,
      this.data);
  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  String item1 = "";
  String item2 = "";
  String item3 = "";
  String item4 = "";
  Razorpay? _razorpay;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _razorpay = Razorpay();
    _razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    //_razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: ColorConstant.whiteA700,
      appBar: CustomAppBar(
          height: getVerticalSize(91),
          leadingWidth: 34,
          leading: AppbarImage(
              height: getVerticalSize(15),
              width: getHorizontalSize(9),
              svgPath: ImageConstant.imgArrowleft,
              margin: getMargin(left: 25, top: 34, bottom: 42),
              onTap: () {
                Navigator.of(context).pop();
              }),
          title: Padding(
              padding: getPadding(left: 19, top: 10, bottom: 18),
              child: Row(children: [
                Text("CART",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtRobotoRomanRegular18
                        .copyWith(letterSpacing: getHorizontalSize(1.62))),
                AppbarImage(
                    height: getVerticalSize(10),
                    width: getHorizontalSize(6),
                    imagePath: "assets/images/arrow.png",
                    margin: getMargin(left: 13, top: 6, bottom: 5)),
                Padding(
                    padding: getPadding(left: 23),
                    child: Text("ADDRESS",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: AppStyle.txtRobotoRomanRegular18
                            .copyWith(letterSpacing: getHorizontalSize(1.62)))),
                AppbarImage(
                    height: getVerticalSize(10),
                    width: getHorizontalSize(6),
                    imagePath: "assets/images/arrow.png",
                    margin: getMargin(left: 13, top: 6, bottom: 5)),
                Padding(
                    padding: getPadding(left: 23),
                    child: Text("PAYMENT",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: AppStyle.txtRobotoRomanMedium18
                            .copyWith(letterSpacing: getHorizontalSize(1.62))))
              ])),
          styleType: Style.bgShadowBlack90033),
      body: Container(
          width: double.maxFinite,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                    padding: getPadding(top: 0, bottom: 9),
                    child: Divider(
                        height: getVerticalSize(3),
                        thickness: getVerticalSize(3),
                        color: ColorConstant.purple5001)),
                SizedBox(
                  height: 4,
                ),
                Container(
                    width: double.maxFinite,
                    child: Row(children: [
                      // Align(
                      //     alignment: Alignment.topCenter,
                      //     child: Column(
                      //         mainAxisSize: MainAxisSize.min,
                      //         crossAxisAlignment: CrossAxisAlignment.end,
                      //         mainAxisAlignment: MainAxisAlignment.start,
                      //         children: [
                      //           CustomAppBar(
                      //               height: getVerticalSize(91),
                      //               leadingWidth: 34,
                      //               leading: AppbarImage(
                      //                   height: getVerticalSize(15),
                      //                   width: getHorizontalSize(9),
                      //                   svgPath:
                      //                       ImageConstant.imgArrowleft,
                      //                   margin: getMargin(
                      //                       left: 25,
                      //                       top: 53,
                      //                       bottom: 23),
                      //                   onTap: onTapArrowleft10),
                      //               title: Padding(
                      //                   padding: getPadding(left: 19, top: 50, bottom: 18),
                      //                   child: Row(children: [
                      //                     Text("CART",
                      //                         overflow: TextOverflow.ellipsis,
                      //                         textAlign: TextAlign.left,
                      //                         style: AppStyle.txtRobotoRomanRegular18.copyWith(
                      //                             letterSpacing: getHorizontalSize(1.62))
                      //                     ),
                      //                     AppbarImage(
                      //                         height: getVerticalSize(10),
                      //                         width: getHorizontalSize(6),
                      //                         imagePath: "assets/images/arrow.png",
                      //                         margin: getMargin(left: 13, top: 6, bottom: 5)),
                      //                     Padding(
                      //                         padding: getPadding(left: 23),
                      //                         child: Text("ADDRESS",
                      //                             overflow: TextOverflow.ellipsis,
                      //                             textAlign: TextAlign.left,
                      //                             style: AppStyle.txtRobotoRomanRegular18.copyWith(
                      //                                 letterSpacing: getHorizontalSize(1.62)))),
                      //                     AppbarImage(
                      //                         height: getVerticalSize(10),
                      //                         width: getHorizontalSize(6),
                      //                         color:Colors.grey,
                      //                         imagePath: "assets/images/arrow.png",
                      //                         margin: getMargin(left: 13, top: 6, bottom: 5)),
                      //                     Padding(
                      //                         padding: getPadding(left: 23),
                      //                         child: Text("PAYMENT",
                      //                             overflow: TextOverflow.ellipsis,
                      //                             textAlign: TextAlign.left,
                      //                             style: AppStyle.txtRobotoRomanMedium18.copyWith(
                      //                                 letterSpacing: getHorizontalSize(1.62))))
                      //                   ])),
                      //               actions: [
                      //                 AppbarImage(
                      //                     height: getVerticalSize(10),
                      //                     width: getHorizontalSize(6),
                      //                     svgPath: ImageConstant
                      //                         .imgVectorPurple90010x6,
                      //                     margin: getMargin(
                      //                         left: 15,
                      //                         top: 55,
                      //                         right: 18,
                      //                         bottom: 6)),
                      //                 AppbarSubtitle4(
                      //                     text: "lbl_payment".tr,
                      //                     margin: getMargin(
                      //                         left: 23,
                      //                         top: 50,
                      //                         right: 78))
                      //               ],
                      //               styleType: Style.bgShadowBlack90033),
                      //           Divider(
                      //               height: getVerticalSize(3),
                      //               thickness: getVerticalSize(3),
                      //               color: ColorConstant.purple5001),
                      //           CustomImageView(
                      //               svgPath:
                      //                   ImageConstant.imgVectorGray5005x9,
                      //               height: getVerticalSize(5),
                      //               width: getHorizontalSize(9),
                      //               margin: getMargin(top: 18, right: 22))
                      //         ])),SizedBox(width: 30.w,),
                      SizedBox(
                        width: 7.w,
                      ),
                      Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                              padding: getPadding(bottom: 4),
                              child: Text(widget.count + "  ITEM",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: AppStyle.txtRobotoMedium11Black900))),
                      SizedBox(
                        width: 57.w,
                      ),
                      Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                              padding: getPadding(bottom: 1),
                              child: Text("lbl_total".tr,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: AppStyle.txtRobotoMedium15))),
                      SizedBox(
                        width: 3.w,
                      ),
                      CustomImageView(
                          svgPath: ImageConstant.imgCut,
                          height: getVerticalSize(14),
                          width: getHorizontalSize(9),
                          alignment: Alignment.bottomRight,
                          margin: getMargin(bottom: 3)),
                      // CustomImageView(
                      //     svgPath: ImageConstant.imgCall,
                      //     height: getVerticalSize(11),
                      //     width: getHorizontalSize(7),
                      //     alignment: Alignment.bottomRight,
                      //     margin: getMargin(right: 79, bottom: 4)),
                      SizedBox(
                        width: 2.w,
                      ),
                      Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                              padding: getPadding(right: 20),
                              child: Text(widget.total_amount,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: AppStyle.txtRobotoMedium14Purple900))),
                      // Align(
                      //     alignment: Alignment.bottomRight,
                      //     child: Container(
                      //         height: getVerticalSize(15),
                      //         width: getHorizontalSize(37),
                      //         margin: getMargin(right: 39),
                      //         child: Stack(
                      //             alignment: Alignment.topCenter,
                      //             children: [
                      //               Align(
                      //                   alignment: Alignment.center,
                      //                   child: Text("lbl_19_999".tr,
                      //                       overflow:
                      //                           TextOverflow.ellipsis,
                      //                       textAlign: TextAlign.left,
                      //                       style: AppStyle
                      //                           .txtRobotoMedium12Gray500)),
                      //               Align(
                      //                   alignment: Alignment.topCenter,
                      //                   child: Padding(
                      //                       padding: getPadding(top: 6),
                      //                       child: SizedBox(
                      //                           width:
                      //                               getHorizontalSize(37),
                      //                           child: Divider(
                      //                               height:
                      //                                   getVerticalSize(
                      //                                       1),
                      //                               thickness:
                      //                                   getVerticalSize(
                      //                                       1),
                      //                               color: ColorConstant
                      //                                   .gray500))))
                      //             ]))),
                    ])),
                Padding(
                    padding: getPadding(top: 9),
                    child: Divider(
                        height: getVerticalSize(3),
                        thickness: getVerticalSize(3),
                        color: ColorConstant.purple5001)),
                Align(
                    alignment: Alignment.center,
                    child: Padding(
                        padding: getPadding(left: 25, top: 9, right: 22),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("msg_shipping_address".tr,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: AppStyle.txtRobotoLight10),
                              // Text("lbl_change".tr,
                              //     overflow: TextOverflow.ellipsis,
                              //     textAlign: TextAlign.left,
                              //     style: AppStyle.txtRobotoMedium11)
                            ]))),
                Padding(
                    padding: getPadding(left: 25, top: 6),
                    child: Text(widget.address1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: AppStyle.txtRobotoMedium15)),
                Container(
                    width: getHorizontalSize(126),
                    margin: getMargin(left: 25, top: 9),
                    child: Text(widget.address2!.capitalize!,
                        maxLines: 4,
                        textAlign: TextAlign.left,
                        style: AppStyle.txtRobotoRegular12Black900)),
                Padding(
                    padding: getPadding(top: 9),
                    child: Divider(
                        height: getVerticalSize(3),
                        thickness: getVerticalSize(3),
                        color: ColorConstant.purple5001)),
                Align(
                    alignment: Alignment.center,
                    child: Padding(
                        padding: getPadding(left: 25, top: 13, right: 22),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                  padding: getPadding(bottom: 1),
                                  child: Text("lbl_billing_address".tr,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: AppStyle.txtRobotoLight10)),
                              // Text("lbl_change".tr,
                              //     overflow: TextOverflow.ellipsis,
                              //     textAlign: TextAlign.left,
                              //     style: AppStyle.txtRobotoMedium11)
                            ]))),
                Padding(
                    padding: getPadding(left: 25, top: 8),
                    child: Text("msg_same_as_a_shipping".tr,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: AppStyle.txtRobotoMedium14)),
                Padding(
                    padding: getPadding(top: 13),
                    child: Divider(
                        height: getVerticalSize(3),
                        thickness: getVerticalSize(3),
                        color: ColorConstant.purple5001)),
                // CustomButton(
                //   onTap: () async{
                //     List<String> resultList = await Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (context) => ApplyCoupon(widget.data)),
                //     );
                //
                //     // Check if the resultList is not null before accessing its elements
                //     setState(() {
                //       if (resultList != null) {
                //         // Access the elements of the resultList
                //         item1 = resultList[0];
                //         item4=resultList[1];
                //         item2 = resultList[2];
                //         item3 = resultList[3];
                //         print(item1+item4+item2+item3);
                //       }
                //     });
                //
                //   },
                //   height: getVerticalSize(21),
                //   width: getHorizontalSize(250),
                //   margin: getMargin(left: 85, right: 13,top: 10),
                //   variant: ButtonVariant.OutlinePurple700,
                //   shape: ButtonShape.RoundedBorder5,
                //   padding: ButtonPadding.PaddingT10,
                //   fontStyle: ButtonFontStyle.RobotoMedium15Black900,
                //   text: item1.isEmpty?"Apply Coupon":"Change Coupon",
                //   // margin: getMargin(bottom: 8)
                // ),
                // item1.isNotEmpty?
                // Container(child: Column(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //   Align(
                //       alignment: Alignment.center,
                //       child: Padding(
                //           padding: getPadding(left: 25, top: 13, right: 22),
                //           child: Row(
                //               mainAxisAlignment:
                //               MainAxisAlignment.spaceBetween,
                //               children: [
                //                 Padding(
                //                     padding: getPadding(bottom: 1),
                //                     child: Text("Coupon Code:",
                //                         overflow: TextOverflow.ellipsis,
                //                         textAlign: TextAlign.left,
                //                         style: AppStyle.txtRobotoLight10)),
                //                 // Text("lbl_change".tr,
                //                 //     overflow: TextOverflow.ellipsis,
                //                 //     textAlign: TextAlign.left,
                //                 //     style: AppStyle.txtRobotoMedium11)
                //               ]))),
                //   Padding(
                //       padding: getPadding(left: 25, top: 8),
                //       child: Text(item4,
                //           overflow: TextOverflow.ellipsis,
                //           textAlign: TextAlign.left,
                //           style: AppStyle.txtRobotoMedium14)),
                // ],),):Container(),
                // Padding(
                //     padding: getPadding(top: 13),
                //     child: Divider(
                //         height: getVerticalSize(3),
                //         thickness: getVerticalSize(3),
                //         color: ColorConstant.purple5001)),
                Padding(
                    padding: getPadding(left: 25, top: 16),
                    child: Row(children: [
                      Container(
                          height: getSize(12),
                          width: getSize(12),
                          margin: getMargin(bottom: 3),
                          decoration: BoxDecoration(
                              color: ColorConstant.purple900,
                              borderRadius: BorderRadius.only(
                                  bottomRight:
                                      Radius.circular(getHorizontalSize(21))))),
                      Padding(
                          padding: getPadding(left: 15),
                          child: Text("msg_choose_payment_method".tr,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtRobotoMedium12Purple900
                                  .copyWith(
                                      letterSpacing: getHorizontalSize(0.6))))
                    ])),
                Padding(
                    padding: getPadding(top: 14),
                    child: Divider(
                        height: getVerticalSize(1),
                        thickness: getVerticalSize(1),
                        color: ColorConstant.purple5001)),
                InkWell(
                  onTap: () async {
                    _startPayment();
                  },
                  child: Row(
                    children: [
                      Padding(
                          padding: getPadding(left: 25, top: 13),
                          child: Text("Debit Card".tr,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtRobotoMedium14.copyWith(
                                  letterSpacing: getHorizontalSize(0.7)))),
                    ],
                  ),
                ),
                Container(
                    height: getVerticalSize(1),
                    width: double.maxFinite,
                    margin: getMargin(top: 13),
                    child: Stack(alignment: Alignment.center, children: [
                      Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                              width: double.maxFinite,
                              child: Divider(
                                  height: getVerticalSize(1),
                                  thickness: getVerticalSize(1),
                                  color: ColorConstant.purple5001))),
                      Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                              width: double.maxFinite,
                              child: Divider(
                                  height: getVerticalSize(1),
                                  thickness: getVerticalSize(1),
                                  color: ColorConstant.purple5001)))
                    ])),
                InkWell(
                  onTap: () async {
                    _startPayment();
                  },
                  child: Row(
                    children: [
                      Padding(
                          padding: getPadding(left: 25, top: 13),
                          child: Text("Credit Card".tr,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtRobotoMedium14.copyWith(
                                  letterSpacing: getHorizontalSize(0.7)))),
                    ],
                  ),
                ),
                // Container(
                //     height: getVerticalSize(1),
                //     width: double.maxFinite,
                //     margin: getMargin(top: 13),
                //     child: Stack(alignment: Alignment.center, children: [
                //       // Align(
                //       //     alignment: Alignment.center,
                //       //     child: SizedBox(
                //       //         width: double.maxFinite,
                //       //         child: Divider(
                //       //             height: getVerticalSize(1),
                //       //             thickness: getVerticalSize(1),
                //       //             color: ColorConstant.purple5001))),
                //       Align(
                //           alignment: Alignment.center,
                //           child: SizedBox(
                //               width: double.maxFinite,
                //               child: Divider(
                //                   height: getVerticalSize(1),
                //                   thickness: getVerticalSize(1),
                //                   color: ColorConstant.purple5001)))
                //     ])),
                // Padding(
                //     padding: getPadding(left: 25, top: 13),
                //     child: Text("lbl_emi".tr,
                //         overflow: TextOverflow.ellipsis,
                //         textAlign: TextAlign.left,
                //         style: AppStyle.txtRobotoMedium14.copyWith(
                //             letterSpacing: getHorizontalSize(0.7)))),
                Container(
                    height: getVerticalSize(1),
                    width: double.maxFinite,
                    margin: getMargin(top: 13),
                    child: Stack(alignment: Alignment.center, children: [
                      Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                              width: double.maxFinite,
                              child: Divider(
                                  height: getVerticalSize(1),
                                  thickness: getVerticalSize(1),
                                  color: ColorConstant.purple5001))),
                      Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                              width: double.maxFinite,
                              child: Divider(
                                  height: getVerticalSize(1),
                                  thickness: getVerticalSize(1),
                                  color: ColorConstant.purple5001)))
                    ])),
                InkWell(
                  onTap: () async {
                    _startPayment();
                  },
                  child: Row(
                    children: [
                      Padding(
                          padding: getPadding(left: 25, top: 14),
                          child: Text("msg_internet_banking".tr,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtRobotoMedium14.copyWith(
                                  letterSpacing: getHorizontalSize(0.7)))),
                    ],
                  ),
                ),
                // Container(
                //     height: getVerticalSize(1),
                //     width: double.maxFinite,
                //     margin: getMargin(top: 12),
                //     child: Stack(alignment: Alignment.center, children: [
                //       Align(
                //           alignment: Alignment.center,
                //           child: SizedBox(
                //               width: double.maxFinite,
                //               child: Divider(
                //                   height: getVerticalSize(1),
                //                   thickness: getVerticalSize(1),
                //                   color: ColorConstant.purple5001))),
                //       Align(
                //           alignment: Alignment.center,
                //           child: SizedBox(
                //               width: double.maxFinite,
                //               child: Divider(
                //                   height: getVerticalSize(1),
                //                   thickness: getVerticalSize(1),
                //                   color: ColorConstant.purple5001)))
                //     ])),
                // Padding(
                //     padding: getPadding(left: 25, top: 13),
                //     child: Text("msg_fabfurni_gift_card".tr,
                //         overflow: TextOverflow.ellipsis,
                //         textAlign: TextAlign.left,
                //         style: AppStyle.txtRobotoMedium14.copyWith(
                //             letterSpacing: getHorizontalSize(0.7)))),
                Container(
                    height: getVerticalSize(1),
                    width: double.maxFinite,
                    margin: getMargin(top: 13),
                    child: Stack(alignment: Alignment.center, children: [
                      Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                              width: double.maxFinite,
                              child: Divider(
                                  height: getVerticalSize(1),
                                  thickness: getVerticalSize(1),
                                  color: ColorConstant.purple5001))),
                      Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                              width: double.maxFinite,
                              child: Divider(
                                  height: getVerticalSize(1),
                                  thickness: getVerticalSize(1),
                                  color: ColorConstant.purple5001)))
                    ])),
                InkWell(
                  onTap: () async {
                    _startPayment();
                  },
                  child: Row(
                    children: [
                      Padding(
                          padding: getPadding(left: 25, top: 14),
                          child: Text("UPI",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtRobotoMedium14.copyWith(
                                  letterSpacing: getHorizontalSize(0.7)))),
                    ],
                  ),
                ),
                Container(
                    height: getVerticalSize(1),
                    width: double.maxFinite,
                    margin: getMargin(top: 12),
                    child: Stack(alignment: Alignment.center, children: [
                      Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                              width: double.maxFinite,
                              child: Divider(
                                  height: getVerticalSize(1),
                                  thickness: getVerticalSize(1),
                                  color: ColorConstant.purple5001))),
                      Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                              width: double.maxFinite,
                              child: Divider(
                                  height: getVerticalSize(1),
                                  thickness: getVerticalSize(1),
                                  color: ColorConstant.purple5001)))
                    ])),
                InkWell(
                  onTap: () async {
                    _startPayment();
                  },
                  child: Row(
                    children: [
                      Padding(
                          padding: getPadding(left: 25, top: 13),
                          child: Text("lbl_wallet".tr,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtRobotoMedium14.copyWith(
                                  letterSpacing: getHorizontalSize(0.7)))),
                    ],
                  ),
                ),
                Container(
                    height: getVerticalSize(1),
                    width: double.maxFinite,
                    margin: getMargin(top: 12),
                    child: Stack(alignment: Alignment.center, children: [
                      Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                              width: double.maxFinite,
                              child: Divider(
                                  height: getVerticalSize(1),
                                  thickness: getVerticalSize(1),
                                  color: ColorConstant.purple5001))),
                      Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                              width: double.maxFinite,
                              child: Divider(
                                  height: getVerticalSize(1),
                                  thickness: getVerticalSize(1),
                                  color: ColorConstant.purple5001)))
                    ])),
                // InkWell(
                //   onTap: ()async{
                //     _startPayment();
                //   },
                //   child: Row(
                //     children: [
                //       Padding(
                //           padding: getPadding(left: 25, top: 13),
                //           child: Text("Online",
                //               overflow: TextOverflow.ellipsis,
                //               textAlign: TextAlign.left,
                //               style: AppStyle.txtRobotoMedium14.copyWith(
                //                   letterSpacing: getHorizontalSize(0.7)))),
                //     ],
                //   ),
                // ),
                /* Container(
                          height: getVerticalSize(1),
                          width: double.maxFinite,
                          margin: getMargin(top: 12),
                          child: Stack(alignment: Alignment.center, children: [
                            Align(
                                alignment: Alignment.center,
                                child: SizedBox(
                                    width: double.maxFinite,
                                    child: Divider(
                                        height: getVerticalSize(1),
                                        thickness: getVerticalSize(1),
                                        color: ColorConstant.purple5001))),
                            Align(
                                alignment: Alignment.center,
                                child: SizedBox(
                                    width: double.maxFinite,
                                    child: Divider(
                                        height: getVerticalSize(1),
                                        thickness: getVerticalSize(1),
                                        color: ColorConstant.purple5001)))
                          ])),*/
                // InkWell(
                //   onTap: ()async{
                //     // String orderId=getRandomString(10);
                //     // await generateTxnToken(widget.total_amount, orderId,widget.userid);
                //     var number ="";
                //     var randomnumber=  Random();
                //     //chnage i < 15 on your digits need
                //     for (var i = 0; i < 10; i++) {
                //       number = number + randomnumber.nextInt(9).toString();
                //     }
                //
                //     String transactionId=number.toString();
                //     print(transactionId);
                //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => OrderPlacedScreen(widget.total_amount,widget.address_id,widget.address1,widget.address2,widget.product_id,widget.userid,transactionId,widget.discount_price,widget.mrp_price,widget.data,'0')));
                //
                //   },
                //   child: Row(
                //     children: [
                //       Padding(
                //           padding: getPadding(left: 25, top: 13),
                //           child: Text("Cash On Delivery".tr,
                //               overflow: TextOverflow.ellipsis,
                //               textAlign: TextAlign.left,
                //               style: AppStyle.txtRobotoMedium14.copyWith(
                //                   letterSpacing: getHorizontalSize(0.7)))),
                //     ],
                //   ),
                // ),
                Padding(
                    padding: getPadding(top: 10),
                    child: Divider(
                        height: getVerticalSize(3),
                        thickness: getVerticalSize(3),
                        color: ColorConstant.purple5001)),
                Divider(
                    height: getVerticalSize(1),
                    thickness: getVerticalSize(1),
                    color: ColorConstant.purple5001),
                Spacer(),
                Padding(
                    padding: getPadding(top: 17),
                    child: Divider(
                        height: getVerticalSize(5),
                        thickness: getVerticalSize(5),
                        color: ColorConstant.purple50))
              ])),
      //     bottomNavigationBar: GestureDetector(
      //         onTap: (){
      //               // if(message=="Your Cart is Empty."){
      //               // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //               // content: Text("Please select atleast 1 product to continue"),
      //               // backgroundColor: Colors.redAccent));
      //               // }else{
      //               // pushNewScreen(
      //               // context,
      //               // screen: AfterCartScreen(widget.data),
      //               // withNavBar:
      //               // false, // OPTIONAL VALUE. True by default.
      //               // pageTransitionAnimation:
      //               // PageTransitionAnimation.cupertino,
      //               // );}
      // },
      //   child: GestureDetector(
      //     onTap: ()async{
      //       print("tapped");
      //       String orderId=getRandomString(10);
      //       await generateTxnToken(widget.total_amount, orderId,widget.userid);
      //     },
      //     child: Container(
      //         width: double.maxFinite,
      //         child: Container(
      //             height: 6.5.h,
      //             // padding: getPadding(left: 158, top: 20, right: 158, bottom: 20),
      //             decoration: AppDecoration.fillPurple900
      //                 .copyWith(borderRadius: BorderRadiusStyle.customBorderLR60),
      //             child: Column(
      //                 mainAxisSize: MainAxisSize.min,
      //                 mainAxisAlignment: MainAxisAlignment.center,
      //                 children: [
      //                   Padding(
      //                       padding: getPadding(top: 3),
      //                       child: Text("Make Payment",
      //                           overflow: TextOverflow.ellipsis,
      //                           textAlign: TextAlign.left,
      //                           style: AppStyle.txtRobotoMedium16.copyWith(
      //                               letterSpacing: getHorizontalSize(0.8))))
      //                 ]))),
      //   ),
      // ),
    ));
  }

  void _startPayment() {
    int amountInPaise = (int.parse(widget.total_amount) * 100).toInt();
    var options = {
      'key': 'rzp_test_pKH5rt8ScPh9Qo',
      'amount': amountInPaise, // amount in paise (example: 10000 paise = ₹100)
      'name': 'FabFurni',
      'description': 'Order Payment',
      'prefill': {'contact': '', 'email': ''},
      /*'external': {
        'wallets': ['paytm'] // List of supported wallets
      }*/
    };

    try {
      _razorpay!.open(options);
    } catch (e) {
      debugPrint('Error: ${e.toString()}');
    }
  }

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    // Handle payment success
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 1),
        content: Text('Payment Successfully!!'
            // '\n Transaction Id: '+response.paymentId.toString()
            ),
        backgroundColor: Colors.green));
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => OrderPlacedScreen(
                widget.total_amount,
                widget.address_id,
                widget.address1,
                widget.address2,
                widget.product_id,
                widget.userid,
                response.paymentId.toString(),
                widget.discount_price,
                widget.mrp_price,
                widget.data,
                '1')));

    /*Future.delayed(const Duration(milliseconds: 3000), () {
      Map json1 = jsonDecode(prefs.getString('userData'));
      var user1 = OtpModel.fromJson(json1);
      print(user1.data);
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => HomeScreen(user1.data),
      ));
      // Get.offNamed(AppRoutes.logInScreen);
    });*/
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Handle payment failure
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 3),
        content: Text('Payment Failed'
            // '\n'+response.error.toString()
            ),
        backgroundColor: Colors.redAccent));
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Handle external wallet payment
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 1),
        content: Text(response.toString()),
        backgroundColor: Colors.green));
  }
  // Future<void> generateTxnToken(String amount, String orderId,String userid) async {
  //   final callBackUrl =
  //       'https://securegw-stage.paytm.in/theia/paytmCallback?ORDER_ID=$orderId';
  //   final body = json.encode({
  //     "MID": "zTJIdC64240043931357",
  //     "key_secret": "eZJzbfkZwL56y3ac",
  //     "CHANNEL_ID":"WEB",
  //     "WEBSITE": "WEBSTAGING",
  //     "ORDER_ID": orderId,
  //     "TXN_AMOUNT": amount,
  //     "CALLBACK_URL": callBackUrl,
  //     "CUST_ID": userid,
  //   });
  //
  //   try {
  //     var response =
  //     await dio.Dio().post("https://fabfurni.com/api/Webservice/get_Paytm_Tranjection_Token",
  //         options: dio.Options(
  //           headers: {
  //             "Content-Type": "application/json",
  //             "Accept": "*/*",
  //           },
  //         ),
  //         data: body);
  //     // final response = await http.post(
  //     //   Uri.parse(url),
  //     //   body: body,
  //     //   headers: {'Content-type': "application/json"},
  //     // );
  //     var jsonObject = jsonDecode(response.toString());
  //     // if(response.statusCode==200){
  //     //   return TxnToken.fromJson(jsonObject);
  //     // }
  //     String txnToken = jsonObject["txnToken"];
  //     print("txntoken:"+txnToken);
  //
  //     await initiateTransaction(orderId, amount, txnToken, callBackUrl,userid);
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // Future<void> initiateTransaction(String orderId, String amount,
  //     String txnToken, String callBackUrl,String userid) async {
  //   String result = '';
  //   try {
  //     var response = AllInOneSdk.startTransaction(
  //       "zTJIdC64240043931357",
  //       orderId,
  //       amount.toString(),
  //       txnToken,
  //       callBackUrl,
  //       true,
  //       false,
  //     );
  //     response.then((value) {
  //       // Transaction successfull
  //       print(value);
  //     }).catchError((onError) {
  //       if (onError is PlatformException) {
  //         result = onError.message + " \n  " + onError.details.toString();
  //         print(result);
  //       } else {
  //         result = onError.toString();
  //         print(result);
  //       }
  //     });
  //   } catch (err) {
  //     // Transaction failed
  //     result = err.toString();
  //     print(result);
  //   }
  // }
}

final _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random.secure();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
