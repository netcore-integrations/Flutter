import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:keshav_s_application2/presentation/cart_screen/Aftercartscreen.dart';
import 'package:keshav_s_application2/presentation/cart_screen/models/RemovecartItem.dart';
import 'package:keshav_s_application2/presentation/cart_screen/models/cart_model.dart'
    as carts;
import 'package:keshav_s_application2/presentation/cart_screen/models/movetowishlist.dart';
import 'package:keshav_s_application2/presentation/otp_screen/models/otp_model.dart';
import 'package:keshav_s_application2/presentation/select_product_screen/models/CheckPincode.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:smartech_base/smartech_base.dart';

import 'controller/cart_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:keshav_s_application2/core/app_export.dart';
import 'package:keshav_s_application2/core/utils/validation_functions.dart';
import 'package:keshav_s_application2/widgets/app_bar/appbar_image.dart';
import 'package:keshav_s_application2/widgets/app_bar/appbar_subtitle_3.dart';
import 'package:keshav_s_application2/widgets/app_bar/appbar_subtitle_4.dart';
import 'package:keshav_s_application2/widgets/app_bar/custom_app_bar.dart';
import 'package:keshav_s_application2/widgets/custom_text_form_field.dart';
import 'package:sizer/sizer.dart';
import 'dart:convert';

import 'package:dio/dio.dart' as dio;

// ignore_for_file: must_be_immutable
class CartScreen extends StatefulWidget {
  Data data;
  CartScreen(this.data);
  static int? count;
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController pincodeController = TextEditingController();

  Future<carts.CartModel>? mycart;
  List<carts.CartData> cartlist = [];
  int? count1;
  int? total;
  List<carts.ProductDetails> cart = [];
  String? message;

  Future<carts.CartModel> getCartList() async {
    Map data = {
      'user_id': widget.data.id,
    };
    //encode Map to JSON
    var body = json.encode(data);
    var response =
        await dio.Dio().post("https://fabfurni.com/api/Webservice/listCart",
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

      if (carts.CartModel.fromJson(jsonObject).status == "true") {
        // print(orders.MyOrdersModel.fromJson(jsonObject).data.first.products.first.image);

        return carts.CartModel.fromJson(jsonObject);

        // inviteList.sort((a, b) => a.id.compareTo(b.id));
      } else if (carts.CartModel.fromJson(jsonObject).status == "false") {
        message = carts.CartModel.fromJson(jsonObject).message;
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //     duration: Duration(seconds: 1),
        //     behavior: SnackBarBehavior.floating,
        //     margin: EdgeInsets.only(bottom: 25.0),
        //     content: Text(carts.CartModel.fromJson(jsonObject).message),
        //     backgroundColor: Colors.redAccent));
      } else if (carts.CartModel.fromJson(jsonObject).data == null) {
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

  Future<CheckPincode> checkPincode() async {
    Map data = {
      'user_id': widget.data.id,
      'pincode': pincodeController.text,
    };
    //encode Map to JSON
    var body = json.encode(data);
    var response =
        await dio.Dio().post("https://fabfurni.com/api/Webservice/checkPincode",
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

      if (CheckPincode.fromJson(jsonObject).data == "Yes") {
        // print(orders.MyOrdersModel.fromJson(jsonObject).data.first.products.first.image);
        // showDialog(
        //   context: context,
        //   builder: (context) {
        //     return Dialog(
        //       backgroundColor: Colors.white,
        //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
        //       elevation: 16,
        //       insetPadding: EdgeInsets.fromLTRB(10,0,10,10),
        //       child: Container(
        //         width: double.infinity,
        //         height: 200,
        //         // decoration: BoxDecoration (
        //         //   gradient: LinearGradient (
        //         //     begin: Alignment(0.184, 1),
        //         //     end: Alignment(0.184, -1),
        //         //     colors: <Color>[Color(0xff000000), Color(0x00000000)],
        //         //     stops: <double>[0, 1],
        //         //   ),
        //         // ),
        //         padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
        //         child:
        //             // Text(
        //             //   announcelist[index]
        //             //       .name,
        //             //   style: SafeGoogleFont(
        //             //     'Poppins Medium',
        //             //     fontSize: 27 * ffem,
        //             //     fontWeight:
        //             //     FontWeight.w400,
        //             //     height: 1.4 *
        //             //         ffem /
        //             //         fem,
        //             //     letterSpacing:
        //             //     0.2 * fem,
        //             //     color: Color(
        //             //         0xffcccccc),
        //             //   ),
        //             // ),
        //             Text(
        //               CheckPincode.fromJson(jsonObject).message,
        //               style: SafeGoogleFont(
        //                 'Poppins',
        //                 fontSize: 20,
        //                 fontWeight:
        //                 FontWeight.w400,
        //                 height: 20,
        //
        //                 letterSpacing:
        //                 1,
        //                 color:
        //                 Colors.black,
        //               ),
        //             ),
        //
        //       ),
        //     );
        //   },
        // );
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(bottom: 25.0),
            content: Text(
              "Delivery Available at given pincode ",
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.greenAccent));

        return CheckPincode.fromJson(jsonObject);

        // inviteList.sort((a, b) => a.id.compareTo(b.id));
      } else if (CheckPincode.fromJson(jsonObject).data == "No") {
        // showDialog(
        //   context: context,
        //   builder: (context) {
        //     return Dialog(
        //       backgroundColor: Color(0xff45536A),
        //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
        //       elevation: 16,
        //       insetPadding: EdgeInsets.fromLTRB(10,0,10,10),
        //       child: Container(
        //         width: double.infinity,
        //         height: 200,
        //         // decoration: BoxDecoration (
        //         //   gradient: LinearGradient (
        //         //     begin: Alignment(0.184, 1),
        //         //     end: Alignment(0.184, -1),
        //         //     colors: <Color>[Color(0xff000000), Color(0x00000000)],
        //         //     stops: <double>[0, 1],
        //         //   ),
        //         // ),
        //         padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
        //         child: ListView(
        //           shrinkWrap: true,
        //           children: <Widget>[
        //             // Center(child: Text('Leaderboard')),
        //             SizedBox(height: 20),
        //             // Text(
        //             //   announcelist[index]
        //             //       .name,
        //             //   style: SafeGoogleFont(
        //             //     'Poppins Medium',
        //             //     fontSize: 27 * ffem,
        //             //     fontWeight:
        //             //     FontWeight.w400,
        //             //     height: 1.4 *
        //             //         ffem /
        //             //         fem,
        //             //     letterSpacing:
        //             //     0.2 * fem,
        //             //     color: Color(
        //             //         0xffcccccc),
        //             //   ),
        //             // ),
        //             Text(
        //               "Delivery not Available",
        //               style: SafeGoogleFont(
        //                 'Poppins',
        //                 fontSize: 20,
        //                 fontWeight:
        //                 FontWeight.w400,
        //                 height: 20,
        //
        //                 letterSpacing:
        //                 1,
        //                 color:
        //                 Colors.black,
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //     );
        //   },
        // );
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(bottom: 25.0),
            content: Text("Delivery Not Available"),
            backgroundColor: Colors.redAccent));
      } else if (CheckPincode.fromJson(jsonObject).data == null) {
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

  Future<Removefromcart> removecart(String cart_id) async {
    Map data = {
      'user_id': widget.data.id,
      "cart_id": cart_id,
    };
    //encode Map to JSON
    var body = json.encode(data);
    var response =
        await dio.Dio().post("https://fabfurni.com/api/Webservice/removeCart",
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

      if (Removefromcart.fromJson(jsonObject).status == "true") {
        buildLoading(context);
        Timer(Duration(seconds: 1), () {
          Navigator.of(context).pop();
        });
        setState(() {});
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(bottom: 25.0),
            content: Text(
              "Product removed Successfully ",
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.greenAccent));
        // Navigator.of(context).pop();

        return Removefromcart.fromJson(jsonObject);

        // inviteList.sort((a, b) => a.id.compareTo(b.id));
      } else if (Removefromcart.fromJson(jsonObject).status == "false") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(bottom: 25.0),
            content: Text("Product not available in cart"),
            backgroundColor: Colors.redAccent));
      } else {
        throw Exception('Failed to load');
      }
    } else {
      throw Exception('Failed to load');
    }
    return jsonObject;
  }

  Future<MovetoWishlist> movetowishlist(
      String cart_id, String product_id) async {
    Map data = {
      'user_id': widget.data.id,
      "product_id": product_id,
      "cart_id": cart_id,
    };
    //encode Map to JSON
    var body = json.encode(data);
    var response =
        await dio.Dio().post("https://fabfurni.com/api/Webservice/moveWishlist",
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

      if (MovetoWishlist.fromJson(jsonObject).status == "true") {
        buildLoading(context);
        Timer(Duration(seconds: 1), () {
          Navigator.of(context).pop();
        });
        setState(() {});
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(bottom: 25.0),
            content: Text(
              "Product moved to wishlist successfully ",
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.greenAccent));
        // Navigator.of(context).pop();

        return MovetoWishlist.fromJson(jsonObject);

        // inviteList.sort((a, b) => a.id.compareTo(b.id));
      } else if (MovetoWishlist.fromJson(jsonObject).status == "false") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(bottom: 25.0),
            content: Text(MovetoWishlist.fromJson(jsonObject).message!),
            backgroundColor: Colors.redAccent));
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
    mycart = getCartList();
    mycart!.then((value) {
      setState(() {
        cartlist = value.data!;
        CartScreen.count = value.count;
        count1 = value.count;
        total = value.total;

        // products=value.data;
        // recentuserslist = value.recentusers;
        // onetoonelist = value.onetoonemeeting;
        // interchapterlist = value.interchepter;
        // topuserslist=value.topUsers; //to be omitted
      });
    });

    super.initState();
  }

  @override
  void didUpdateWidget(CartScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget != widget) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    pincodeController.dispose();
    super.dispose();
  }

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
              margin: getMargin(left: 25, top: 34, bottom: 42),
              onTap: onTapArrowleft8),
          title: Padding(
              padding: getPadding(left: 19, top: 10, bottom: 18),
              child: Row(children: [
                Text("CART",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtRobotoRomanMedium18
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
                    color: Colors.grey,
                    imagePath: "assets/images/arrow.png",
                    margin: getMargin(left: 13, top: 6, bottom: 5)),
                Padding(
                    padding: getPadding(left: 23),
                    child: Text("PAYMENT",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: AppStyle.txtRobotoRomanRegular18
                            .copyWith(letterSpacing: getHorizontalSize(1.62))))
              ])),
          styleType: Style.bgShadowBlack90033),
      body: RefreshIndicator(
        color: Colors.purple,
        onRefresh: () async {
          mycart = getCartList();
          mycart!.then((value) {
            setState(() {
              cartlist = value.data!;
              CartScreen.count = value.count;
              total = value.total;
            });
          });
        },
        child: FutureBuilder(
          future: mycart,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Form(
                  key: _formKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                            alignment: Alignment.topCenter,
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                      margin: getMargin(
                                          left: 30, top: 0, right: 29),
                                      padding: getPadding(
                                          left: 17,
                                          top: 10,
                                          right: 17,
                                          bottom: 10),
                                      decoration: AppDecoration.outlineGray500
                                          .copyWith(
                                              borderRadius: BorderRadiusStyle
                                                  .customBorderBR51),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Expanded(
                                                child: CustomTextFormField(
                                                    focusNode: FocusNode(),
                                                    controller:
                                                        pincodeController,
                                                    hintText:
                                                        "msg_enter_your_pincode"
                                                            .tr,
                                                    margin:
                                                        getMargin(bottom: 1),
                                                    variant:
                                                        TextFormFieldVariant
                                                            .None,
                                                    fontStyle:
                                                        TextFormFieldFontStyle
                                                            .RobotoMedium11,
                                                    textInputAction:
                                                        TextInputAction.done,
                                                    textInputType:
                                                        TextInputType.number,
                                                    validator: (value) {
                                                      if (!isNumeric(value!)) {
                                                        return "Please enter valid number";
                                                      }
                                                      return null;
                                                    })),
                                            InkWell(
                                              onTap: () {
                                                SystemChannels.textInput
                                                    .invokeMethod(
                                                        'TextInput.hide');
                                                checkPincode();
                                                pincodeController.clear();
                                              },
                                              child: Padding(
                                                  padding: getPadding(
                                                      left: 12, right: 1),
                                                  child: Text("lbl_check".tr,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign: TextAlign.left,
                                                      style: AppStyle
                                                          .txtRobotoMedium11)),
                                            )
                                          ])),
                                ])),
                        Flexible(
                          child: Container(
                            // height: 100.h,
                            child: SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              child: Column(
                                children: [
                                  Padding(
                                      padding: getPadding(top: 11),
                                      child: Divider(
                                          height: getVerticalSize(3),
                                          thickness: getVerticalSize(3),
                                          color: ColorConstant.purple5001)),
                                  Padding(
                                      padding: getPadding(
                                          left: 30, top: 11, right: 13),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                                padding: getPadding(bottom: 4),
                                                child: Text(
                                                    count1.toString() != 'null'
                                                        ? count1.toString() +
                                                            " ITEM"
                                                        : "0 ITEM",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.left,
                                                    style: AppStyle
                                                        .txtRobotoMedium11Black900)),
                                            Spacer(),
                                            CustomImageView(
                                                svgPath: ImageConstant.imgCut,
                                                height: getVerticalSize(14),
                                                width: getHorizontalSize(9),
                                                margin: getMargin(bottom: 3)),
                                            Padding(
                                                padding: getPadding(
                                                    left: 2, right: 10),
                                                child: Text(
                                                    total.toString() != 'null'
                                                        ? total.toString()
                                                        : "0",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.left,
                                                    style: AppStyle
                                                        .txtRobotoMedium14Purple900)),
                                            // CustomImageView(
                                            //     svgPath:
                                            //     ImageConstant.imgCall,
                                            //     height: getVerticalSize(11),
                                            //     width: getHorizontalSize(7),
                                            //     margin: getMargin(
                                            //         left: 11,
                                            //         top: 2,
                                            //         bottom: 4)),
                                            // Container(
                                            //     height: getVerticalSize(15),
                                            //     width: getHorizontalSize(37),
                                            //     margin: getMargin(
                                            //         left: 3, top: 2),
                                            //     child: Stack(
                                            //         alignment:
                                            //         Alignment.topCenter,
                                            //         children: [
                                            //           Align(
                                            //               alignment: Alignment
                                            //                   .center,
                                            //               child: Text(
                                            //                   "lbl_19_999".tr,
                                            //                   overflow:
                                            //                   TextOverflow
                                            //                       .ellipsis,
                                            //                   textAlign:
                                            //                   TextAlign
                                            //                       .left,
                                            //                   style: AppStyle
                                            //                       .txtRobotoMedium12Gray500)),
                                            //           Align(
                                            //               alignment: Alignment
                                            //                   .topCenter,
                                            //               child: Padding(
                                            //                   padding:
                                            //                   getPadding(
                                            //                       top: 6),
                                            //                   child: SizedBox(
                                            //                       width:
                                            //                       getHorizontalSize(
                                            //                           37),
                                            //                       child: Divider(
                                            //                           height:
                                            //                           getVerticalSize(
                                            //                               1),
                                            //                           thickness:
                                            //                           getVerticalSize(
                                            //                               1),
                                            //                           color: ColorConstant
                                            //                               .gray500))))
                                            //         ]))
                                          ])),
                                  ListView.builder(
                                      shrinkWrap: true,
                                      physics: ClampingScrollPhysics(),
                                      itemCount: cartlist.length,
                                      itemBuilder: (context, index) {
                                        carts.ProductDetails product =
                                            cartlist[index].productDetails!;
                                        Smartech()
                                            .trackEvent("Cart Screen Viewed", {
                                          "items": {
                                            "item_name": product.name!,
                                            "item_id": product.id,
                                            "item_price": product.salePrice
                                          }
                                        });
                                        return Column(
                                          children: [
                                            Padding(
                                                padding: getPadding(top: 9),
                                                child: Divider(
                                                    height: getVerticalSize(3),
                                                    thickness:
                                                        getVerticalSize(3),
                                                    color: ColorConstant
                                                        .purple5001)),
                                            Container(
                                                padding: getPadding(
                                                    left: 29,
                                                    top: 14,
                                                    right: 0),
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 18.0),
                                                        child: CustomImageView(
                                                            url: product.image!,
                                                            // imagePath:
                                                            // ImageConstant
                                                            //     .imgImage17,
                                                            height: getSize(82),
                                                            width: getSize(82),
                                                            margin: getMargin(
                                                                top: 1,
                                                                bottom: 12)),
                                                      ),
                                                      Padding(
                                                          padding: getPadding(
                                                              left: 17,
                                                              top: 3,
                                                              bottom: 17),
                                                          child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    SizedBox(
                                                                      width:
                                                                          60.w,
                                                                    ),
                                                                    Text(
                                                                        "Qty: " +
                                                                            cartlist[index]
                                                                                .qty!,
                                                                        overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                        textAlign:
                                                                            TextAlign
                                                                                .right,
                                                                        style: AppStyle
                                                                            .txtRobotoMedium12Purple900),
                                                                  ],
                                                                ),
                                                                Container(
                                                                  width: 250,
                                                                  child: Text(
                                                                      product
                                                                          .name!,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style: AppStyle
                                                                          .txtRobotoRegular18),
                                                                ),
                                                                // SizedBox(width: 10.w,),
                                                                SizedBox(
                                                                  height: 0.5.h,
                                                                ),
                                                                Text(
                                                                    product.categoryName! +
                                                                        " by " +
                                                                        product
                                                                            .brandName!,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style: AppStyle
                                                                        .txtRobotoRegular14Purple400),
                                                                SizedBox(
                                                                  height: 1.h,
                                                                ),
                                                                // product.description.isNotEmpty?
                                                                // Container(
                                                                //   constraints: const BoxConstraints(
                                                                //     maxWidth: 230,
                                                                //   ),
                                                                //   child: FittedBox(
                                                                //     fit:BoxFit.fill,
                                                                //     child: Text(
                                                                //         product.description,
                                                                //         overflow:
                                                                //         TextOverflow
                                                                //             .ellipsis,
                                                                //         textAlign:
                                                                //         TextAlign
                                                                //             .left,
                                                                //         style: AppStyle
                                                                //             .txtRobotoRegular9),
                                                                //   ),
                                                                // ):Container(),
                                                                Padding(
                                                                    padding:
                                                                        getPadding(
                                                                            top:
                                                                                9),
                                                                    child: Row(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          CustomImageView(
                                                                              svgPath: ImageConstant.imgCut,
                                                                              height: getVerticalSize(14),
                                                                              width: getHorizontalSize(9),
                                                                              margin: getMargin(bottom: 3)),
                                                                          Padding(
                                                                              padding: getPadding(left: 2),
                                                                              child: Text(product.salePrice!, overflow: TextOverflow.ellipsis, textAlign: TextAlign.left, style: AppStyle.txtRobotoMedium14Purple900)),
                                                                          CustomImageView(
                                                                              svgPath: ImageConstant.imgCall,
                                                                              height: getVerticalSize(11),
                                                                              width: getHorizontalSize(7),
                                                                              margin: getMargin(left: 11, top: 2, bottom: 4)),
                                                                          Container(
                                                                              height: getVerticalSize(15),
                                                                              width: getHorizontalSize(37),
                                                                              margin: getMargin(left: 3, top: 2),
                                                                              child: Stack(alignment: Alignment.topCenter, children: [
                                                                                Align(alignment: Alignment.center, child: Text(product.mrpPrice!, overflow: TextOverflow.ellipsis, textAlign: TextAlign.left, style: AppStyle.txtRobotoMedium12Gray500)),
                                                                                Align(alignment: Alignment.topCenter, child: Padding(padding: getPadding(top: 6), child: SizedBox(width: getHorizontalSize(37), child: Divider(height: getVerticalSize(1), thickness: getVerticalSize(1), color: ColorConstant.gray500))))
                                                                              ]))
                                                                        ])),
                                                                Row(
                                                                  children: [
                                                                    SizedBox(
                                                                      width:
                                                                          41.w,
                                                                    ),
                                                                    Text(
                                                                        "msg_delivery_15_nov_2021"
                                                                            .tr,
                                                                        overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                        textAlign:
                                                                            TextAlign
                                                                                .right,
                                                                        style: AppStyle
                                                                            .txtRobotoMedium12Teal700),
                                                                  ],
                                                                ),
                                                              ])),
                                                    ])),
                                            Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                margin: getMargin(top: 5),
                                                // padding: getPadding(
                                                //     left: 41, right: 41),
                                                decoration: AppDecoration
                                                    .outlineGray400,
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      InkWell(
                                                        onTap: () async {
                                                          // print(cartlist[index].id);
                                                          await removecart(
                                                              cartlist[index]
                                                                  .id!);
                                                          setState(() {
                                                            initState();
                                                          });
                                                        },
                                                        child: Container(
                                                            // color:Colors.black,
                                                            //width:180,
                                                            padding: getPadding(
                                                                left: 90,
                                                                top: 11,
                                                                bottom: 9),
                                                            child: Text(
                                                                "lbl_remove".tr,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: AppStyle
                                                                    .txtRobotoRegular12Black900
                                                                    .copyWith(
                                                                        letterSpacing:
                                                                            getHorizontalSize(1.2)))),
                                                      ),
                                                      //Spacer(),
                                                      SizedBox(
                                                          height:
                                                              getVerticalSize(
                                                                  36),
                                                          child: VerticalDivider(
                                                              width:
                                                                  getHorizontalSize(
                                                                      1),
                                                              thickness:
                                                                  getVerticalSize(
                                                                      1),
                                                              color: ColorConstant
                                                                  .gray40001)),
                                                      InkWell(
                                                        onTap: () async {
                                                          await movetowishlist(
                                                              cartlist[index]
                                                                  .id!,
                                                              cartlist[index]
                                                                  .productId!);
                                                          setState(() {
                                                            initState();
                                                          });
                                                        },
                                                        child: Container(
                                                            // color:Colors.black,
                                                            //width:200,
                                                            padding: getPadding(
                                                                left: 0,
                                                                top: 11,
                                                                bottom: 9,
                                                                right: 45),
                                                            child: Text(
                                                                "msg_move_to_wishlist"
                                                                    .tr,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: AppStyle
                                                                    .txtRobotoRegular12Black900
                                                                    .copyWith(
                                                                        letterSpacing:
                                                                            getHorizontalSize(1.2)))),
                                                      )
                                                    ])),
                                          ],
                                        );
                                      }),
                                  // InkWell(
                                  //   onTap: (){
                                  //     Get.toNamed(AppRoutes.clickGstinScreen);
                                  //   },
                                  //   child: Container(
                                  //     child: Column(children: [
                                  //       Padding(
                                  //           padding: getPadding(top: 14),
                                  //           child: Divider(
                                  //               height: getVerticalSize(3),
                                  //               thickness:
                                  //               getVerticalSize(3),
                                  //               color: ColorConstant
                                  //                   .purple5001)),
                                  //       Align(
                                  //           alignment: Alignment.centerLeft,
                                  //           child: Padding(
                                  //               padding: getPadding(
                                  //                   left: 34, top: 15),
                                  //               child: Row(
                                  //                 children: [
                                  //                   Text(
                                  //                       "Use GSTIN For Business Purchase (Optional)",
                                  //                       overflow:
                                  //                       TextOverflow
                                  //                           .ellipsis,
                                  //                       textAlign:
                                  //                       TextAlign.left,
                                  //                       style: AppStyle
                                  //                           .txtRobotoMedium14
                                  //                           .copyWith(
                                  //                           letterSpacing:
                                  //                           getHorizontalSize(
                                  //                               0.7))),
                                  //                   Spacer(),
                                  //                   CustomImageView(
                                  //                       svgPath: ImageConstant
                                  //                           .imgArrowrightGray50015x9,
                                  //                       height:
                                  //                       getVerticalSize(
                                  //                           15),
                                  //                       width:
                                  //                       getHorizontalSize(
                                  //                           9),
                                  //                       alignment: Alignment
                                  //                           .topRight,
                                  //                       margin: getMargin(
                                  //                           top: 0,
                                  //                           right: 27)),
                                  //                 ],
                                  //               ))),
                                  //       Padding(
                                  //           padding: getPadding(top: 12),
                                  //           child: Divider(
                                  //               height: getVerticalSize(3),
                                  //               thickness:
                                  //               getVerticalSize(3),
                                  //               color: ColorConstant
                                  //                   .purple5001)),
                                  //     ],),
                                  //   ),
                                  // ),
                                  // SizedBox(height: 5.h,)
                                ],
                              ),
                            ),
                            // FutureBuilder(
                            //     future:mycart,
                            //     builder: (context, snapshot){
                            //       if(snapshot.hasData){
                            //         if(snapshot.data.data.length==0){
                            //           return Center(
                            //               child: Text('No data available.',
                            //                   style: TextStyle(
                            //                     fontFamily: 'poppins',
                            //                     fontSize: 16.0,
                            //                     fontWeight: FontWeight.bold,
                            //                     color: const Color(0xff45536A),
                            //                   )));
                            //         }
                            //         else{
                            //           return SingleChildScrollView(
                            //             physics: const AlwaysScrollableScrollPhysics(),
                            //             child: Column(
                            //               children: [
                            //                 Padding(
                            //                     padding: getPadding(top: 11),
                            //                     child: Divider(
                            //                         height: getVerticalSize(3),
                            //                         thickness: getVerticalSize(3),
                            //                         color: ColorConstant.purple5001)),
                            //                 Padding(
                            //                     padding: getPadding(
                            //                         left: 30, top: 11, right: 13),
                            //                     child: Row(
                            //                         mainAxisAlignment:
                            //                         MainAxisAlignment.center,
                            //                         crossAxisAlignment:
                            //                         CrossAxisAlignment.start,
                            //                         children: [
                            //                           Padding(
                            //                               padding:
                            //                               getPadding(bottom: 4),
                            //                               child: Text(count.toString()+" ITEM",
                            //                                   overflow:
                            //                                   TextOverflow.ellipsis,
                            //                                   textAlign: TextAlign.left,
                            //                                   style: AppStyle
                            //                                       .txtRobotoMedium11Black900)),
                            //                           Spacer(),
                            //                           CustomImageView(
                            //                               svgPath: ImageConstant.imgCut,
                            //                               height: getVerticalSize(14),
                            //                               width: getHorizontalSize(9),
                            //                               margin: getMargin(bottom: 3)),
                            //                           Padding(
                            //                               padding: getPadding(left: 2,right: 10),
                            //                               child: Text(total.toString(),
                            //                                   overflow:
                            //                                   TextOverflow.ellipsis,
                            //                                   textAlign: TextAlign.left,
                            //                                   style: AppStyle
                            //                                       .txtRobotoMedium14Purple900)),
                            //                           // CustomImageView(
                            //                           //     svgPath:
                            //                           //     ImageConstant.imgCall,
                            //                           //     height: getVerticalSize(11),
                            //                           //     width: getHorizontalSize(7),
                            //                           //     margin: getMargin(
                            //                           //         left: 11,
                            //                           //         top: 2,
                            //                           //         bottom: 4)),
                            //                           // Container(
                            //                           //     height: getVerticalSize(15),
                            //                           //     width: getHorizontalSize(37),
                            //                           //     margin: getMargin(
                            //                           //         left: 3, top: 2),
                            //                           //     child: Stack(
                            //                           //         alignment:
                            //                           //         Alignment.topCenter,
                            //                           //         children: [
                            //                           //           Align(
                            //                           //               alignment: Alignment
                            //                           //                   .center,
                            //                           //               child: Text(
                            //                           //                   "lbl_19_999".tr,
                            //                           //                   overflow:
                            //                           //                   TextOverflow
                            //                           //                       .ellipsis,
                            //                           //                   textAlign:
                            //                           //                   TextAlign
                            //                           //                       .left,
                            //                           //                   style: AppStyle
                            //                           //                       .txtRobotoMedium12Gray500)),
                            //                           //           Align(
                            //                           //               alignment: Alignment
                            //                           //                   .topCenter,
                            //                           //               child: Padding(
                            //                           //                   padding:
                            //                           //                   getPadding(
                            //                           //                       top: 6),
                            //                           //                   child: SizedBox(
                            //                           //                       width:
                            //                           //                       getHorizontalSize(
                            //                           //                           37),
                            //                           //                       child: Divider(
                            //                           //                           height:
                            //                           //                           getVerticalSize(
                            //                           //                               1),
                            //                           //                           thickness:
                            //                           //                           getVerticalSize(
                            //                           //                               1),
                            //                           //                           color: ColorConstant
                            //                           //                               .gray500))))
                            //                           //         ]))
                            //                         ])),
                            //                 ListView.builder(
                            //                     shrinkWrap: true,
                            //                     physics: ClampingScrollPhysics(),
                            //                     itemCount: cartlist.length,
                            //                     itemBuilder: (context, index) {
                            //                       carts.ProductDetails product=cartlist[index].productDetails;
                            //                       return Column(
                            //                         children: [
                            //                           Padding(
                            //                               padding: getPadding(top: 9),
                            //                               child: Divider(
                            //                                   height: getVerticalSize(3),
                            //                                   thickness:
                            //                                   getVerticalSize(3),
                            //                                   color: ColorConstant
                            //                                       .purple5001)),
                            //                           Container(
                            //                               padding: getPadding(
                            //                                   left: 29,
                            //                                   top: 14,
                            //                                   right: 0),
                            //                               child: Row(
                            //                                   mainAxisAlignment:
                            //                                   MainAxisAlignment
                            //                                       .start,
                            //                                   crossAxisAlignment:
                            //                                   CrossAxisAlignment
                            //                                       .start,
                            //                                   children: [
                            //                                     Padding(
                            //                                       padding: const EdgeInsets.only(top: 18.0),
                            //                                       child: CustomImageView(
                            //                                         url:product.image,
                            //                                           // imagePath:
                            //                                           // ImageConstant
                            //                                           //     .imgImage17,
                            //                                           height: getSize(82),
                            //                                           width: getSize(82),
                            //                                           margin: getMargin(
                            //                                               top: 1,
                            //                                               bottom: 12)),
                            //                                     ),
                            //                                     Padding(
                            //                                         padding: getPadding(
                            //                                             left: 17,
                            //                                             top: 3,
                            //                                             bottom: 17),
                            //                                         child: Column(
                            //                                             crossAxisAlignment:
                            //                                             CrossAxisAlignment
                            //                                                 .start,
                            //                                             mainAxisAlignment:
                            //                                             MainAxisAlignment
                            //                                                 .start,
                            //                                             children: [
                            //                                               Row(
                            //                                                 children: [
                            //                                                   SizedBox(width: 60.w,),
                            //                                                   Text(
                            //                                                       "Qty: "+cartlist[index].qty,
                            //                                                       overflow:
                            //                                                       TextOverflow
                            //                                                           .ellipsis,
                            //                                                       textAlign:
                            //                                                       TextAlign
                            //                                                           .right,
                            //                                                       style: AppStyle
                            //                                                           .txtRobotoMedium12Purple900),
                            //                                                 ],
                            //                                               ),
                            //                                               Text(
                            //                                                   product.name,
                            //                                                   overflow:
                            //                                                   TextOverflow
                            //                                                       .ellipsis,
                            //                                                   textAlign:
                            //                                                   TextAlign
                            //                                                       .left,
                            //                                                   style: AppStyle
                            //                                                       .txtRobotoRegular18),
                            //                                               SizedBox(width: 10.w,),
                            //                                               SizedBox(height: 0.5.h,),
                            //                                               Text(
                            //                                                  product.categoryName+" by "+product.brandName,
                            //                                                   overflow:
                            //                                                   TextOverflow
                            //                                                       .ellipsis,
                            //                                                   textAlign:
                            //                                                   TextAlign
                            //                                                       .left,
                            //                                                   style: AppStyle
                            //                                                       .txtRobotoRegular14Purple400),
                            //                                               SizedBox(height: 1.h,),
                            //                                               Text(
                            //                                                   product.description,
                            //                                                   overflow:
                            //                                                   TextOverflow
                            //                                                       .ellipsis,
                            //                                                   textAlign:
                            //                                                   TextAlign
                            //                                                       .left,
                            //                                                   style: AppStyle
                            //                                                       .txtRobotoRegular9),
                            //                                               Padding(
                            //                                                   padding:
                            //                                                   getPadding(
                            //                                                       top:
                            //                                                       9),
                            //                                                   child: Row(
                            //                                                       crossAxisAlignment:
                            //                                                       CrossAxisAlignment.start,
                            //                                                       children: [
                            //                                                         CustomImageView(
                            //                                                             svgPath: ImageConstant.imgCut,
                            //                                                             height: getVerticalSize(14),
                            //                                                             width: getHorizontalSize(9),
                            //                                                             margin: getMargin(bottom: 3)),
                            //                                                         Padding(
                            //                                                             padding: getPadding(left: 2),
                            //                                                             child: Text(product.salePrice, overflow: TextOverflow.ellipsis, textAlign: TextAlign.left, style: AppStyle.txtRobotoMedium14Purple900)),
                            //                                                         CustomImageView(
                            //                                                             svgPath: ImageConstant.imgCall,
                            //                                                             height: getVerticalSize(11),
                            //                                                             width: getHorizontalSize(7),
                            //                                                             margin: getMargin(left: 11, top: 2, bottom: 4)),
                            //                                                         Container(
                            //                                                             height: getVerticalSize(15),
                            //                                                             width: getHorizontalSize(37),
                            //                                                             margin: getMargin(left: 3, top: 2),
                            //                                                             child: Stack(alignment: Alignment.topCenter, children: [
                            //                                                               Align(alignment: Alignment.center, child: Text(product.mrpPrice, overflow: TextOverflow.ellipsis, textAlign: TextAlign.left, style: AppStyle.txtRobotoMedium12Gray500)),
                            //                                                               Align(alignment: Alignment.topCenter, child: Padding(padding: getPadding(top: 6), child: SizedBox(width: getHorizontalSize(37), child: Divider(height: getVerticalSize(1), thickness: getVerticalSize(1), color: ColorConstant.gray500))))
                            //                                                             ]))
                            //                                                       ])),
                            //                                               Row(
                            //                                                 children: [
                            //                                                   SizedBox(width: 41.w,),
                            //                                                   Text(
                            //                                                   "msg_delivery_15_nov_2021"
                            //                                                       .tr,
                            //                                                   overflow:
                            //                                                   TextOverflow
                            //                                                       .ellipsis,
                            //                                                   textAlign:
                            //                                                   TextAlign
                            //                                                       .right,
                            //                                                   style: AppStyle
                            //                                                       .txtRobotoMedium12Teal700),
                            //                                                 ],
                            //                                               ),
                            //
                            //                                             ])),
                            //                                   ])),
                            //                           Container(
                            //                               width: double.maxFinite,
                            //                               margin: getMargin(top: 5),
                            //                               padding: getPadding(
                            //                                   left: 41, right: 41),
                            //                               decoration: AppDecoration
                            //                                   .outlineGray400,
                            //                               child: Row(
                            //                                   mainAxisAlignment:
                            //                                   MainAxisAlignment.end,
                            //                                   children: [
                            //                                     Padding(
                            //                                         padding: getPadding(
                            //                                             left: 37,
                            //                                             top: 11,
                            //                                             bottom: 9),
                            //                                         child: Text(
                            //                                             "lbl_remove".tr,
                            //                                             overflow:
                            //                                             TextOverflow
                            //                                                 .ellipsis,
                            //                                             textAlign:
                            //                                             TextAlign
                            //                                                 .left,
                            //                                             style: AppStyle
                            //                                                 .txtRobotoRegular12Black900
                            //                                                 .copyWith(
                            //                                                 letterSpacing:
                            //                                                 getHorizontalSize(
                            //                                                     1.2)))),
                            //                                     Spacer(),
                            //                                     SizedBox(
                            //                                         height:
                            //                                         getVerticalSize(
                            //                                             36),
                            //                                         child: VerticalDivider(
                            //                                             width:
                            //                                             getHorizontalSize(
                            //                                                 1),
                            //                                             thickness:
                            //                                             getVerticalSize(
                            //                                                 1),
                            //                                             color: ColorConstant
                            //                                                 .gray40001)),
                            //                                     Padding(
                            //                                         padding: getPadding(
                            //                                             left: 46,
                            //                                             top: 11,
                            //                                             bottom: 9),
                            //                                         child: Text(
                            //                                             "msg_move_to_wishlist"
                            //                                                 .tr,
                            //                                             overflow:
                            //                                             TextOverflow
                            //                                                 .ellipsis,
                            //                                             textAlign:
                            //                                             TextAlign
                            //                                                 .left,
                            //                                             style: AppStyle
                            //                                                 .txtRobotoRegular12Black900
                            //                                                 .copyWith(
                            //                                                 letterSpacing:
                            //                                                 getHorizontalSize(
                            //                                                     1.2))))
                            //                                   ])),
                            //
                            //
                            //
                            //
                            //
                            //
                            //
                            //                         ],
                            //                       );
                            //                     }),
                            //                 InkWell(
                            //                   onTap: (){
                            //                     Get.toNamed(AppRoutes.clickGstinScreen);
                            //                   },
                            //                   child: Container(
                            //                     child: Column(children: [
                            //                       Padding(
                            //                           padding: getPadding(top: 14),
                            //                           child: Divider(
                            //                               height: getVerticalSize(3),
                            //                               thickness:
                            //                               getVerticalSize(3),
                            //                               color: ColorConstant
                            //                                   .purple5001)),
                            //                       Align(
                            //                           alignment: Alignment.centerLeft,
                            //                           child: Padding(
                            //                               padding: getPadding(
                            //                                   left: 34, top: 15),
                            //                               child: Row(
                            //                                 children: [
                            //                                   Text(
                            //                                       "Use GSTIN For Business Purchase (Optional)",
                            //                                       overflow:
                            //                                       TextOverflow
                            //                                           .ellipsis,
                            //                                       textAlign:
                            //                                       TextAlign.left,
                            //                                       style: AppStyle
                            //                                           .txtRobotoMedium14
                            //                                           .copyWith(
                            //                                           letterSpacing:
                            //                                           getHorizontalSize(
                            //                                               0.7))),
                            //                                   Spacer(),
                            //                                   CustomImageView(
                            //                                       svgPath: ImageConstant
                            //                                           .imgArrowrightGray50015x9,
                            //                                       height:
                            //                                       getVerticalSize(
                            //                                           15),
                            //                                       width:
                            //                                       getHorizontalSize(
                            //                                           9),
                            //                                       alignment: Alignment
                            //                                           .topRight,
                            //                                       margin: getMargin(
                            //                                           top: 0,
                            //                                           right: 27)),
                            //                                 ],
                            //                               ))),
                            //                       Padding(
                            //                           padding: getPadding(top: 12),
                            //                           child: Divider(
                            //                               height: getVerticalSize(3),
                            //                               thickness:
                            //                               getVerticalSize(3),
                            //                               color: ColorConstant
                            //                                   .purple5001)),
                            //                     ],),
                            //                   ),
                            //                 ),
                            //                 SizedBox(height: 5.h,)
                            //               ],
                            //             ),
                            //           );
                            //         }
                            //       }else{
                            //         return const Center(
                            //           heightFactor: 15,
                            //           child: CircularProgressIndicator(
                            //             color: Colors.purple,
                            //           ),
                            //         );
                            //       }
                            //     }),
                          ),
                        ),
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
                        // Padding(
                        //     padding: getPadding(top: 17),
                        //     child: Divider(
                        //         height: getVerticalSize(5),
                        //         thickness: getVerticalSize(5),
                        //         color: ColorConstant.purple50))
                      ]));
            } else if (!snapshot.hasData) {
              return Center(
                  child: Image(
                image: AssetImage("assets/images/cart_empty.png"),
                filterQuality: FilterQuality.high,
                width: 200,
                height: 200,
              ));
            } else {
              return const Center(
                heightFactor: 15,
                child: CircularProgressIndicator(
                  color: Colors.purple,
                ),
              );
            }
          },
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          if (message == "Your Cart is Empty.") {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Please select atleast 1 product to continue"),
                backgroundColor: Colors.redAccent));
          } else {
            pushScreen(
              context,
              screen: AfterCartScreen(widget.data),
              withNavBar: false, // OPTIONAL VALUE. True by default.
              pageTransitionAnimation: PageTransitionAnimation.cupertino,
            );
          }
        },
        child: Container(
            width: double.maxFinite,
            child: Container(
                height: 6.5.h,
                // padding: getPadding(left: 158, top: 20, right: 158, bottom: 20),
                decoration: AppDecoration.fillPurple900
                    .copyWith(borderRadius: BorderRadiusStyle.customBorderLR60),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                          padding: getPadding(top: 3),
                          child: Text("lbl_place_order".tr,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtRobotoMedium16.copyWith(
                                  letterSpacing: getHorizontalSize(0.8))))
                    ]))),
      ),
    ));
  }

  buildLoading(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
            ),
          );
        });
  }

  onTapArrowleft8() {
    Get.back();
  }
}
