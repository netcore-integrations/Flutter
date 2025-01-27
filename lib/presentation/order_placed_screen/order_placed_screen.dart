import 'package:keshav_s_application2/landingpage.dart';
import 'package:keshav_s_application2/presentation/my_orders_screen/my_orders_screen.dart';
import 'package:keshav_s_application2/presentation/order_placed_screen/models/order_placed_model.dart';

import '../otp_screen/models/otp_model.dart';
import 'controller/order_placed_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as fs;
import 'package:keshav_s_application2/core/app_export.dart';
import 'package:keshav_s_application2/widgets/app_bar/appbar_image.dart';
import 'package:keshav_s_application2/widgets/app_bar/custom_app_bar.dart';
import 'package:keshav_s_application2/widgets/custom_button.dart';

import 'dart:convert';
import 'package:dio/dio.dart' as dio;

class OrderPlacedScreen extends StatefulWidget {
  String total_amount;
  String address_id;
  String address1;
  String address2;
  String product_id;
  String userid;
  String transaction_id;
  String discount_price;
  String mrp_price;
  String paymentType;
  Data data;
  OrderPlacedScreen(
      this.total_amount,
      this.address_id,
      this.address1,
      this.address2,
      this.product_id,
      this.userid,
      this.transaction_id,
      this.discount_price,
      this.mrp_price,
      this.data,
      this.paymentType);
  @override
  State<OrderPlacedScreen> createState() => _OrderPlacedScreenState();
}

class _OrderPlacedScreenState extends State<OrderPlacedScreen> {
  String? message;

  Future<OrderPlaced> orderPlaced() async {
    Map data = {
      'user_id': widget.userid,
      "address_id": widget.address_id,
      "total": widget.total_amount
    };
    //encode Map to JSON
    var body = json.encode(data);
    var response =
        await dio.Dio().post("https://fabfurni.com/api/Webservice/orderAddCod",
            options: dio.Options(
              headers: {
                "Content-Type": "application/json",
                "Accept": "*/*",
              },
            ),
            data: body);
    var jsonObject = jsonDecode(response.toString());
    if (response.statusCode == 200) {
      print(jsonObject);

      if (OrderPlaced.fromJson(jsonObject).status == "true") {
        // print(orders.MyOrdersModel.fromJson(jsonObject).data.first.products.first.image);

        return OrderPlaced.fromJson(jsonObject);

        // inviteList.sort((a, b) => a.id.compareTo(b.id));
      } else if (OrderPlaced.fromJson(jsonObject).status == "false") {
        message = OrderPlaced.fromJson(jsonObject).message;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: Duration(seconds: 1),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(bottom: 25.0),
            content: Text(OrderPlaced.fromJson(jsonObject).message!),
            backgroundColor: Colors.redAccent));
      } else if (OrderPlaced.fromJson(jsonObject).data == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(bottom: 25.0),
          content: Text(
            jsonObject['message'] + ' Please check after sometime.',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.redAccent,
        ));
      } else {
        throw Exception('Failed to load');
      }
    } else {
      throw Exception('Failed to load');
    }
    return jsonObject;
  }

  Future<OrderPlaced> orderPlacedOnline() async {
    Map data = {
      'user_id': widget.userid,
      'tranjection_id': widget.transaction_id,
      "address_id": widget.address_id,
      "total": widget.total_amount,
    };
    //encode Map to JSON
    var body = json.encode(data);
    var response =
        await dio.Dio().post("https://fabfurni.com/api/Webservice/orderAdd",
            options: dio.Options(
              headers: {
                "Content-Type": "application/json",
                "Accept": "*/*",
              },
            ),
            data: body);
    var jsonObject = jsonDecode(response.toString());
    if (response.statusCode == 200) {
      print(jsonObject);

      if (OrderPlaced.fromJson(jsonObject).status == "true") {
        // print(orders.MyOrdersModel.fromJson(jsonObject).data.first.products.first.image);

        return OrderPlaced.fromJson(jsonObject);

        // inviteList.sort((a, b) => a.id.compareTo(b.id));
      } else if (OrderPlaced.fromJson(jsonObject).status == "false") {
        message = OrderPlaced.fromJson(jsonObject).message;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: Duration(seconds: 1),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(bottom: 25.0),
            content: Text(OrderPlaced.fromJson(jsonObject).message!),
            backgroundColor: Colors.redAccent));
      } else if (OrderPlaced.fromJson(jsonObject).data == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(bottom: 25.0),
          content: Text(
            jsonObject['message'] + ' Please check after sometime.',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.redAccent,
        ));
      } else {
        throw Exception('Failed to load');
      }
    } else {
      throw Exception('Failed to load');
    }
    return jsonObject;
  }

  @override
  void initState() {
    if (widget.paymentType == '0') {
      print('P_TYPE: COD');
      orderPlaced();
    } else {
      print('P_TYPE: Online');
      orderPlacedOnline();
    }
    // mycart.then((value) {
    //   setState(() {
    //     cartlist = value.data;
    //     CartScreen.count=value.count;
    //     count1=value.count;
    //     total=value.total;
    //
    //     // products=value.data;
    //     // recentuserslist = value.recentusers;
    //     // onetoonelist = value.onetoonemeeting;
    //     // interchapterlist = value.interchepter;
    //     // topuserslist=value.topUsers; //to be omitted
    //   });
    // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConstant.whiteA700,
            body: WillPopScope(
              onWillPop: () async {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => landingPage(widget.data)),
                    (Route<dynamic> route) => false);
                return false;
              },
              child: SingleChildScrollView(
                child: Container(
                    width: double.maxFinite,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              height: getVerticalSize(70),
                              width: double.maxFinite,
                              child: Stack(
                                  alignment: Alignment.bottomLeft,
                                  children: [
                                    CustomAppBar(
                                        height: getVerticalSize(70),
                                        leadingWidth: 41,
                                        leading: AppbarImage(
                                            onTap: () {
                                              Navigator.of(context)
                                                  .pushAndRemoveUntil(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              landingPage(
                                                                  widget.data)),
                                                      (Route<dynamic> route) =>
                                                          false);
                                            },
                                            height: getVerticalSize(15),
                                            width: getHorizontalSize(9),
                                            svgPath: ImageConstant.imgArrowleft,
                                            margin: getMargin(
                                                left: 20, top: 32, bottom: 22)),
                                        title: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              8.0, 10, 0, 0),
                                          child: Text("ORDER PLACED",
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: AppStyle.txtRobotoMedium18
                                                  .copyWith(
                                                      letterSpacing:
                                                          getHorizontalSize(
                                                              1.62))),
                                        ),
                                        // AppbarImage(
                                        //     height: getVerticalSize(32),
                                        //     width: getHorizontalSize(106),
                                        //     imagePath: ImageConstant.imgFinallogo03,
                                        //     margin: getMargin(left: 13, top: 44, bottom: 15)),
                                        styleType: Style.bgShadowBlack90033),
                                  ])),
                          Container(
                              height: getVerticalSize(835),
                              width: double.maxFinite,
                              child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Align(
                                        alignment: Alignment.topCenter,
                                        child: SizedBox(
                                            width: double.maxFinite,
                                            child: Divider(
                                                height: getVerticalSize(3),
                                                thickness: getVerticalSize(3),
                                                color:
                                                    ColorConstant.purple5001))),
                                    Align(
                                        alignment: Alignment.center,
                                        child: Container(
                                            padding: getPadding(
                                                left: 14,
                                                top: 12,
                                                right: 14,
                                                bottom: 12),
                                            decoration:
                                                AppDecoration.fillPurple5001,
                                            child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  CustomImageView(
                                                      svgPath: ImageConstant
                                                          .imgCheckmarkGreen600,
                                                      height: getSize(30),
                                                      width: getSize(30),
                                                      margin:
                                                          getMargin(top: 19)),
                                                  Padding(
                                                      padding:
                                                          getPadding(top: 15),
                                                      child: Text(
                                                          "msg_your_order_is_placed"
                                                              .tr,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: AppStyle
                                                              .txtRobotoBold18
                                                              .copyWith(
                                                                  letterSpacing:
                                                                      getHorizontalSize(
                                                                          0.9)))),
                                                  Padding(
                                                      padding:
                                                          getPadding(top: 9),
                                                      child: Text(
                                                          "msg_thank_you_for_shopping"
                                                              .tr,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: AppStyle
                                                              .txtRobotoRegular10Black900
                                                              .copyWith(
                                                                  letterSpacing:
                                                                      getHorizontalSize(
                                                                          0.5)))),
                                                  Container(
                                                      // height: getVerticalSize(109),
                                                      // width: getHorizontalSize(400),
                                                      decoration: AppDecoration
                                                          .outlineBlack900191
                                                          .copyWith(
                                                              borderRadius:
                                                                  BorderRadiusStyle
                                                                      .customBorderBR51),
                                                      margin:
                                                          getMargin(top: 26),
                                                      child: Stack(
                                                          alignment: Alignment
                                                              .topRight,
                                                          children: [
                                                            Align(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child:
                                                                    Container(
                                                                        padding: getPadding(
                                                                            left:
                                                                                17,
                                                                            top:
                                                                                26,
                                                                            right:
                                                                                17,
                                                                            bottom:
                                                                                26),
                                                                        child: Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Text(widget.address1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.left, style: AppStyle.txtRobotoMedium14),
                                                                              Container(width: getHorizontalSize(227), margin: getMargin(top: 4, bottom: 2), child: Text(widget.address2, maxLines: null, textAlign: TextAlign.left, style: AppStyle.txtRobotoRegular12Black9001)),
                                                                              // Text(
                                                                              //     "Mo. " +
                                                                              //         widget.order.addressDetails.mobileNumber,
                                                                              //     overflow: TextOverflow.ellipsis,
                                                                              //     textAlign: TextAlign.left,
                                                                              //     style: AppStyle.txtRobotoRegular14Black900),
                                                                            ]))),
                                                            Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topRight,
                                                                child: Container(
                                                                    width:
                                                                        getHorizontalSize(
                                                                            149),
                                                                    padding: getPadding(
                                                                        left:
                                                                            13,
                                                                        top: 2,
                                                                        right:
                                                                            13,
                                                                        bottom:
                                                                            2),
                                                                    decoration: AppDecoration
                                                                        .txtFillPurple900
                                                                        .copyWith(
                                                                            borderRadius: BorderRadiusStyle
                                                                                .txtCustomBorderBL25),
                                                                    child: Text(
                                                                        "msg_shipping_address2"
                                                                            .tr,
                                                                        overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                        textAlign:
                                                                            TextAlign
                                                                                .left,
                                                                        style: AppStyle
                                                                            .txtRobotoMedium12WhiteA700)))
                                                          ])),
                                                  Container(
                                                      margin: getMargin(
                                                          left: 11,
                                                          top: 42,
                                                          right: 11),
                                                      decoration: AppDecoration
                                                          .outlineBlack900191
                                                          .copyWith(
                                                              borderRadius:
                                                                  BorderRadiusStyle
                                                                      .customBorderBR51),
                                                      child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Align(
                                                                alignment: Alignment
                                                                    .centerRight,
                                                                child: Container(
                                                                    width:
                                                                        getHorizontalSize(
                                                                            135),
                                                                    padding: getPadding(
                                                                        left:
                                                                            19,
                                                                        top: 1,
                                                                        right:
                                                                            19,
                                                                        bottom:
                                                                            1),
                                                                    decoration: AppDecoration
                                                                        .txtFillPurple900
                                                                        .copyWith(
                                                                            borderRadius: BorderRadiusStyle
                                                                                .txtCustomBorderBL25),
                                                                    child: Text(
                                                                        "lbl_payment_details"
                                                                            .tr,
                                                                        overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                        textAlign:
                                                                            TextAlign
                                                                                .left,
                                                                        style: AppStyle
                                                                            .txtRobotoMedium12WhiteA700))),
                                                            Padding(
                                                                padding:
                                                                    getPadding(
                                                                        left:
                                                                            18,
                                                                        top: 11,
                                                                        right:
                                                                            25),
                                                                child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .end,
                                                                    children: [
                                                                      Padding(
                                                                          padding: getPadding(
                                                                              bottom:
                                                                                  5),
                                                                          child: Text(
                                                                              "lbl_total2".tr,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              textAlign: TextAlign.left,
                                                                              style: AppStyle.txtRobotoMedium12Black900)),
                                                                      Spacer(),
                                                                      CustomImageView(
                                                                          svgPath: ImageConstant
                                                                              .imgCut,
                                                                          height: getVerticalSize(
                                                                              10),
                                                                          width: getHorizontalSize(
                                                                              6),
                                                                          margin: getMargin(
                                                                              top: 5,
                                                                              bottom: 4)),
                                                                      Padding(
                                                                          padding: getPadding(
                                                                              left:
                                                                                  5,
                                                                              top:
                                                                                  5),
                                                                          child: Text(
                                                                              widget.mrp_price,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              textAlign: TextAlign.left,
                                                                              style: AppStyle.txtRobotoMedium12Purple900))
                                                                    ])),
                                                            Padding(
                                                                padding:
                                                                    getPadding(
                                                                        left:
                                                                            18,
                                                                        top: 5,
                                                                        right:
                                                                            25),
                                                                child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Padding(
                                                                          padding: getPadding(
                                                                              bottom:
                                                                                  3),
                                                                          child: Text(
                                                                              "lbl_discount".tr,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              textAlign: TextAlign.left,
                                                                              style: AppStyle.txtRobotoMedium12Black900)),
                                                                      Container(
                                                                          height: getVerticalSize(
                                                                              15),
                                                                          width: getHorizontalSize(
                                                                              47),
                                                                          margin: getMargin(
                                                                              top:
                                                                                  3),
                                                                          child: Stack(
                                                                              alignment: Alignment.topCenter,
                                                                              children: [
                                                                                CustomImageView(svgPath: ImageConstant.imgCut, height: getVerticalSize(10), width: getHorizontalSize(6), alignment: Alignment.topLeft, margin: getMargin(left: 11)),
                                                                                Padding(
                                                                                  padding: const EdgeInsets.only(left: 10.0),
                                                                                  child: Align(alignment: Alignment.center, child: Text(widget.discount_price, overflow: TextOverflow.ellipsis, textAlign: TextAlign.left, style: AppStyle.txtRobotoMedium12Purple900)),
                                                                                )
                                                                              ]))
                                                                    ])),
                                                            Padding(
                                                                padding:
                                                                    getPadding(
                                                                        top: 5),
                                                                child: Divider(
                                                                    height:
                                                                        getVerticalSize(
                                                                            1),
                                                                    thickness:
                                                                        getVerticalSize(
                                                                            1),
                                                                    color: ColorConstant
                                                                        .purple5001)),
                                                            Padding(
                                                                padding:
                                                                    getPadding(
                                                                        left:
                                                                            18,
                                                                        top: 8,
                                                                        right:
                                                                            25,
                                                                        bottom:
                                                                            22),
                                                                child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Padding(
                                                                          padding: getPadding(
                                                                              bottom:
                                                                                  2),
                                                                          child: Text(
                                                                              "lbl_total_amount".tr,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              textAlign: TextAlign.left,
                                                                              style: AppStyle.txtRobotoMedium12Black900)),
                                                                      Spacer(),
                                                                      CustomImageView(
                                                                          svgPath: ImageConstant
                                                                              .imgCut,
                                                                          height: getVerticalSize(
                                                                              10),
                                                                          width: getHorizontalSize(
                                                                              6),
                                                                          margin: getMargin(
                                                                              top: 2,
                                                                              bottom: 4)),
                                                                      Padding(
                                                                          padding: getPadding(
                                                                              left:
                                                                                  5,
                                                                              top:
                                                                                  2),
                                                                          child: Text(
                                                                              widget.total_amount,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              textAlign: TextAlign.left,
                                                                              style: AppStyle.txtRobotoMedium12Purple900))
                                                                    ]))
                                                          ])),
                                                  CustomButton(
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .pushReplacement(
                                                                MaterialPageRoute(
                                                          builder: (context) =>
                                                              MyOrdersScreen(
                                                                  widget.data),
                                                        ));
                                                      },
                                                      height:
                                                          getVerticalSize(50),
                                                      width: getHorizontalSize(
                                                          250),
                                                      text:
                                                          "msg_view_or_manage_order"
                                                              .tr,
                                                      margin:
                                                          getMargin(top: 51),
                                                      variant: ButtonVariant
                                                          .FillPurple900,
                                                      padding: ButtonPadding
                                                          .PaddingAll15,
                                                      fontStyle: ButtonFontStyle
                                                          .RobotoMedium16),
                                                  Spacer(),
                                                ])))
                                  ])),
                          Padding(
                              padding: getPadding(top: 17),
                              child: Divider(
                                  height: getVerticalSize(5),
                                  thickness: getVerticalSize(5),
                                  color: ColorConstant.purple50))
                        ])),
              ),
            )));
  }

  onTapArrowleft11() {
    Get.back();
  }
}
