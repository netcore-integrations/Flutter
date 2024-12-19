import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:sizer/sizer.dart';

import '../cart_screen/cart_screen.dart';
import '../product_detail_screen/QuantityBottomSheet.dart';
import '../product_detail_screen/models/AddtoCart.dart';
import 'controller/order_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as fs;
import 'package:keshav_s_application2/core/app_export.dart';
import 'package:keshav_s_application2/widgets/app_bar/appbar_image.dart';
import 'package:keshav_s_application2/widgets/app_bar/custom_app_bar.dart';
import 'package:keshav_s_application2/widgets/custom_button.dart';
import 'package:keshav_s_application2/presentation/my_orders_screen/models/my_orders_model.dart'
    as orders;
import 'dart:convert';

import 'package:dio/dio.dart' as dio;
import 'package:keshav_s_application2/presentation/otp_screen/models/otp_model.dart'
    as otp;

class OrderDetailScreen extends StatefulWidget {
  otp.Data data;
  orders.ProductDetails productdetails;
  orders.Products product;
  String Status;
  String order_number;
  String order_date;
  String order_total;
  orders.OrdersData order;
  OrderDetailScreen(this.data, this.productdetails, this.product, this.Status,
      this.order_number, this.order_date, this.order_total, this.order);
  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  String? _selectedQty;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConstant.whiteA700,
            body: SingleChildScrollView(
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
                                            Navigator.pop(context);
                                          },
                                          height: getVerticalSize(15),
                                          width: getHorizontalSize(9),
                                          svgPath: ImageConstant.imgArrowleft,
                                          margin: getMargin(
                                              left: 20, top: 32, bottom: 22)),
                                      title: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            8.0, 10, 0, 0),
                                        child: Text("lbl_order_detail".tr,
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
                                  // CustomAppBar(
                                  //     height: getVerticalSize(91),
                                  //     leadingWidth: 428,
                                  //     leading: AppbarImage(
                                  //         height: getVerticalSize(15),
                                  //         width: getHorizontalSize(9),
                                  //         svgPath: ImageConstant.imgArrowleft,
                                  //         margin: getMargin(
                                  //             left: 25,
                                  //             top: 53,
                                  //             right: 394,
                                  //             bottom: 23),
                                  //         onTap: onTapArrowleft12),
                                  //     styleType: Style.bgShadowBlack90033),
                                  // Align(
                                  //     alignment: Alignment.bottomLeft,
                                  //     child: Padding(
                                  //         padding: getPadding(left: 52, bottom: 18),
                                  //         child: Text("lbl_order_detail".tr,
                                  //             overflow: TextOverflow.ellipsis,
                                  //             textAlign: TextAlign.left,
                                  //             style: AppStyle.txtRobotoMedium18
                                  //                 .copyWith(
                                  //                     letterSpacing:
                                  //                         getHorizontalSize(1.62)))))
                                ])),
                        Container(
                            height: getVerticalSize(840),
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
                                              bottom: 0),
                                          decoration:
                                              AppDecoration.fillPurple5001,
                                          child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Padding(
                                                        padding: getPadding(
                                                            left: 11, top: 5),
                                                        child: Row(children: [
                                                          Container(
                                                              height:
                                                                  getSize(17),
                                                              width:
                                                                  getSize(17),
                                                              margin: getMargin(
                                                                  bottom: 1),
                                                              decoration: BoxDecoration(
                                                                  color: ColorConstant
                                                                      .purple900,
                                                                  borderRadius:
                                                                      BorderRadius.only(
                                                                          bottomRight:
                                                                              Radius.circular(getHorizontalSize(21))))),
                                                          Padding(
                                                              padding:
                                                                  getPadding(
                                                                      left: 12,
                                                                      top: 1),
                                                              child: Text(
                                                                  widget.Status,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style: AppStyle
                                                                      .txtRobotoMedium14Purple900
                                                                      .copyWith(
                                                                          letterSpacing:
                                                                              getHorizontalSize(0.7))))
                                                        ]))),
                                                Container(
                                                    width:
                                                        getHorizontalSize(378),
                                                    margin: getMargin(
                                                        left: 11,
                                                        top: 17,
                                                        right: 11),
                                                    padding: getPadding(
                                                        left: 17,
                                                        top: 9,
                                                        right: 17,
                                                        bottom: 9),
                                                    decoration: AppDecoration
                                                        .outlineBlack900191
                                                        .copyWith(
                                                            borderRadius:
                                                                BorderRadiusStyle
                                                                    .customBorderBR51),
                                                    child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(children: [
                                                            Text(
                                                                "lbl_order_no"
                                                                    .tr,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style: AppStyle
                                                                    .txtRobotoMedium14
                                                                    .copyWith(
                                                                        letterSpacing:
                                                                            getHorizontalSize(0.7))),
                                                            Padding(
                                                                padding:
                                                                    getPadding(
                                                                        left:
                                                                            35),
                                                                child: Text(
                                                                    widget
                                                                        .order_number,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style: AppStyle
                                                                        .txtRobotoRegular14Black900
                                                                        .copyWith(
                                                                            letterSpacing:
                                                                                getHorizontalSize(0.7))))
                                                          ]),
                                                          Padding(
                                                              padding:
                                                                  getPadding(
                                                                      top: 17),
                                                              child: Row(
                                                                  children: [
                                                                    Text(
                                                                        "lbl_order_date"
                                                                            .tr,
                                                                        overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                        textAlign:
                                                                            TextAlign
                                                                                .left,
                                                                        style: AppStyle
                                                                            .txtRobotoMedium14
                                                                            .copyWith(letterSpacing: getHorizontalSize(0.7))),
                                                                    Padding(
                                                                        padding: getPadding(
                                                                            left:
                                                                                23),
                                                                        child: Text(
                                                                            widget
                                                                                .order_date,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            textAlign: TextAlign.left,
                                                                            style: AppStyle.txtRobotoRegular14Black900.copyWith(letterSpacing: getHorizontalSize(0.7))))
                                                                  ])),
                                                          Padding(
                                                              padding:
                                                                  getPadding(
                                                                      top: 17),
                                                              child: Row(
                                                                  children: [
                                                                    Padding(
                                                                        padding: getPadding(
                                                                            bottom:
                                                                                1),
                                                                        child: Text(
                                                                            "lbl_order_total"
                                                                                .tr,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            textAlign: TextAlign.left,
                                                                            style: AppStyle.txtRobotoMedium14.copyWith(letterSpacing: getHorizontalSize(0.7)))),
                                                                    CustomImageView(
                                                                        svgPath:
                                                                            ImageConstant
                                                                                .imgCut,
                                                                        height: getVerticalSize(
                                                                            14),
                                                                        width: getHorizontalSize(
                                                                            9),
                                                                        margin: getMargin(
                                                                            left:
                                                                                23,
                                                                            bottom:
                                                                                3)),
                                                                    Padding(
                                                                        padding: getPadding(
                                                                            left:
                                                                                5,
                                                                            top:
                                                                                1),
                                                                        child: Text(
                                                                            widget
                                                                                .productdetails.salePrice!,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            textAlign: TextAlign.left,
                                                                            style: AppStyle.txtRobotoMedium14Purple900))
                                                                  ]))
                                                        ])),
                                                Container(
                                                    // height:
                                                    //     getVerticalSize(215),
                                                    width:
                                                        getHorizontalSize(379),
                                                    margin: getMargin(top: 30),
                                                    child: Stack(
                                                        alignment:
                                                            Alignment.topRight,
                                                        children: [
                                                          Align(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Container(
                                                                  margin:
                                                                      getMargin(
                                                                          right:
                                                                              1),
                                                                  padding: getPadding(
                                                                      left: 17,
                                                                      top: 23,
                                                                      right: 17,
                                                                      bottom:
                                                                          23),
                                                                  decoration: AppDecoration
                                                                      .outlineBlack900191
                                                                      .copyWith(
                                                                          borderRadius: BorderRadiusStyle
                                                                              .customBorderBR51),
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
                                                                                getPadding(top: 6, right: 2),
                                                                            child: Row(
                                                                                // mainAxisAlignment:
                                                                                //     MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  CustomImageView(url: widget.productdetails.image!, imagePath: ImageConstant.imgImage17, height: getSize(82), width: getSize(82), margin: getMargin(bottom: 1)),
                                                                                  SizedBox(
                                                                                    width: 4.w,
                                                                                  ),
                                                                                  Padding(
                                                                                      padding: getPadding(top: 1),
                                                                                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, children: [
                                                                                        //Text("msg_sku_id_sku541ku29".tr, overflow: TextOverflow.ellipsis, textAlign: TextAlign.left, style: AppStyle.txtRobotoRegular12Black900),
                                                                                        Padding(
                                                                                            padding: getPadding(top: 2),
                                                                                            child: Container(
                                                                                              width: 56.w,
                                                                                              // color: Colors.black,
                                                                                              child: Row(children: [
                                                                                                FittedBox(fit: BoxFit.fill, child: Container(width: 35.w, padding: getPadding(top: 5), child: Text(widget.productdetails.name!, overflow: TextOverflow.ellipsis, maxLines: 2, textAlign: TextAlign.left, style: AppStyle.txtRobotoRegular14Black900))),
                                                                                                Padding(padding: getPadding(left: 15.w, bottom: 4, top: 4, right: 2), child: Text("Qty: " + widget.product.qty!, overflow: TextOverflow.ellipsis, textAlign: TextAlign.right, style: AppStyle.txtRobotoMedium12Purple900))
                                                                                              ]),
                                                                                            )),
                                                                                        Padding(padding: getPadding(top: 2), child: Text(widget.productdetails.categoryName! + " by " + widget.productdetails.brandName!, overflow: TextOverflow.ellipsis, textAlign: TextAlign.left, style: AppStyle.txtRobotoRegular12Purple700)),
                                                                                        Padding(
                                                                                            padding: getPadding(top: 12),
                                                                                            child: Row(children: [
                                                                                              CustomImageView(svgPath: ImageConstant.imgCut, height: getVerticalSize(14), width: getHorizontalSize(9), margin: getMargin(bottom: 3)),
                                                                                              Padding(padding: getPadding(left: 5), child: Text(widget.productdetails.salePrice!, overflow: TextOverflow.ellipsis, textAlign: TextAlign.left, style: AppStyle.txtRobotoMedium14Purple900))
                                                                                            ]))
                                                                                      ]))
                                                                                ])),
                                                                        Padding(
                                                                            padding:
                                                                                getPadding(top: 23),
                                                                            child: Divider(height: getVerticalSize(2), thickness: getVerticalSize(2), color: ColorConstant.purple5001)),
                                                                        // Padding(
                                                                        //     padding: getPadding(
                                                                        //         left: 21,
                                                                        //         top: 11,
                                                                        //         right: 30),
                                                                        //     child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                                                        //       CustomImageView(svgPath: ImageConstant.imgMapBlack900, height: getVerticalSize(22), width: getHorizontalSize(25)),
                                                                        //       CustomImageView(svgPath: ImageConstant.imgArrowleftBlack900, height: getVerticalSize(10), width: getHorizontalSize(21), margin: getMargin(top: 9, bottom: 2)),
                                                                        //       CustomImageView(svgPath: ImageConstant.imgStar, height: getVerticalSize(22), width: getHorizontalSize(23))
                                                                        //     ])),
                                                                        // Padding(
                                                                        //     padding: getPadding(
                                                                        //         left: 21,
                                                                        //         top: 7,
                                                                        //         right: 20),
                                                                        //     child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                                                        //       Text("lbl_track".tr, overflow: TextOverflow.ellipsis, textAlign: TextAlign.left, style: AppStyle.txtRobotoRegular10Black900),
                                                                        //       Spacer(flex: 53),
                                                                        //       Text("lbl_return".tr, overflow: TextOverflow.ellipsis, textAlign: TextAlign.left, style: AppStyle.txtRobotoRegular10Black900),
                                                                        //       Spacer(flex: 46),
                                                                        //       Text("lbl_feedback".tr, overflow: TextOverflow.ellipsis, textAlign: TextAlign.left, style: AppStyle.txtRobotoRegular10Black900)
                                                                        //     ]))
                                                                      ]))),
                                                          Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topRight,
                                                              child: Container(
                                                                  width:
                                                                      getHorizontalSize(
                                                                          92),
                                                                  padding:
                                                                      getPadding(
                                                                          left:
                                                                              18,
                                                                          top:
                                                                              2,
                                                                          right:
                                                                              15,
                                                                          bottom:
                                                                              2),
                                                                  decoration: AppDecoration
                                                                      .txtFillPurple900
                                                                      .copyWith(
                                                                          borderRadius: BorderRadiusStyle
                                                                              .txtCustomBorderBL25),
                                                                  child:
                                                                      FittedBox(
                                                                    fit: BoxFit
                                                                        .fill,
                                                                    child: Text(
                                                                        widget
                                                                            .Status,
                                                                        overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                        textAlign:
                                                                            TextAlign
                                                                                .left,
                                                                        style: AppStyle
                                                                            .txtRobotoMedium12WhiteA700),
                                                                  )))
                                                        ])),
                                                CustomButton(
                                                    onTap: () {
                                                      _showQuantityBottomSheet(
                                                          context,
                                                          widget.product
                                                              .productId!);
                                                      // if(_selectedQty==null){
                                                      //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                      //       duration: Duration(seconds: 1),
                                                      //       behavior: SnackBarBehavior.floating,
                                                      //       margin: EdgeInsets.only(bottom: 30.0),
                                                      //       dismissDirection: DismissDirection.none,
                                                      //       content: Text("Please select quantity"),
                                                      //       backgroundColor: Colors.redAccent));
                                                      // }else{
                                                      //   addtocart(_selectedQty);
                                                      // }
                                                    },
                                                    height: getVerticalSize(50),
                                                    width:
                                                        getHorizontalSize(217),
                                                    text: "lbl_order_again".tr,
                                                    margin: getMargin(top: 25),
                                                    variant: ButtonVariant
                                                        .OutlinePurple900_1,
                                                    padding: ButtonPadding
                                                        .PaddingAll15,
                                                    fontStyle: ButtonFontStyle
                                                        .RobotoMedium16Black900),
                                                Container(
                                                    // height: getVerticalSize(109),
                                                    // width: getHorizontalSize(400),
                                                    decoration: AppDecoration
                                                        .outlineBlack900191
                                                        .copyWith(
                                                            borderRadius:
                                                                BorderRadiusStyle
                                                                    .customBorderBR51),
                                                    margin: getMargin(top: 26),
                                                    child: Stack(
                                                        alignment:
                                                            Alignment.topRight,
                                                        children: [
                                                          Align(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Container(
                                                                  padding: getPadding(
                                                                      left: 17,
                                                                      top: 26,
                                                                      right: 17,
                                                                      bottom:
                                                                          26),
                                                                  child: Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                            widget
                                                                                .order.addressDetails!.name!,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            textAlign: TextAlign.left,
                                                                            style: AppStyle.txtRobotoMedium14),
                                                                        Container(
                                                                            width:
                                                                                getHorizontalSize(227),
                                                                            margin: getMargin(top: 4, bottom: 2),
                                                                            child: Text(widget.order.addressDetails!.addressTwo! + " " + widget.order.addressDetails!.addressTwo! + " , " + widget.order.addressDetails!.city! + " , " + widget.order.addressDetails!.state! + " - " + widget.order.addressDetails!.pincode!, maxLines: null, textAlign: TextAlign.left, style: AppStyle.txtRobotoRegular12Black9001)),
                                                                        Text(
                                                                            "Mo. " +
                                                                                widget.order.addressDetails!.mobileNumber!,
                                                                            overflow: TextOverflow.ellipsis,
                                                                            textAlign: TextAlign.left,
                                                                            style: AppStyle.txtRobotoRegular14Black900),
                                                                      ]))),
                                                          Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topRight,
                                                              child: Container(
                                                                  width:
                                                                      getHorizontalSize(
                                                                          149),
                                                                  padding:
                                                                      getPadding(
                                                                          left:
                                                                              13,
                                                                          top:
                                                                              2,
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
                                                Spacer(),
                                              ])))
                                ])),
                      ])),
            )));
  }

  Future<AddtoCart> addtocart(String qty, String product_id) async {
    Map data = {
      'user_id': widget.data.id,
      'product_id': product_id,
      'qty': qty,
    };
    //encode Map to JSON
    var body = json.encode(data);
    var response =
        await dio.Dio().post("https://fabfurni.com/api/Webservice/addtoCart",
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

      if (AddtoCart.fromJson(jsonObject).status == "true") {
        // print(orders.MyOrdersModel.fromJson(jsonObject).data.first.products.first.image);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(bottom: 20.0),
            content: Text(
              "Added to Cart " + AddtoCart.fromJson(jsonObject).message! + "ly",
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.greenAccent));

        Future.delayed(const Duration(seconds: 2), () {
          pushScreen(
            context,
            screen: CartScreen(widget.data),
            withNavBar: false, // OPTIONAL VALUE. True by default.
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );
        });

        return AddtoCart.fromJson(jsonObject);

        // inviteList.sort((a, b) => a.id.compareTo(b.id));
      } else if (AddtoCart.fromJson(jsonObject).status == "false") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(bottom: 10.0),
            content:
                Text(AddtoCart.fromJson(jsonObject).message!.capitalizeFirst!),
            backgroundColor: Colors.redAccent));
      } else if (AddtoCart.fromJson(jsonObject).data == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(bottom: 10.0),
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

  void _showQuantityBottomSheet(BuildContext context, String product_id) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return QuantityBottomSheet();
      },
    ).then((value) {
      if (value != null) {
        // Handle the selected quantity returned from the bottom sheet
        addtocart(value.toString(), product_id);
        print('Selected quantity: $value');
      }
    });
  }

  onTapArrowleft12() {
    Navigator.of(context).pop();
  }
}
