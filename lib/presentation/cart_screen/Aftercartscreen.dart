import 'dart:convert';

import 'package:keshav_s_application2/presentation/cart_screen/ChooseAddress.dart';
import 'package:keshav_s_application2/presentation/cart_screen/models/cart_model.dart'
    as carts;
import 'package:keshav_s_application2/presentation/home_screen/home_screen.dart';
import 'package:keshav_s_application2/presentation/otp_screen/models/otp_model.dart';
import 'package:keshav_s_application2/presentation/payment_method_screen/payment_method_screen.dart';
import 'package:keshav_s_application2/widgets/custom_button.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../add_address_screen_click_on_manage_address_screen/ManageAddressModel.dart';
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
class AfterCartScreen extends StatefulWidget {
  Data data;
  AfterCartScreen(this.data);
  @override
  State<AfterCartScreen> createState() => _AfterCartScreenState();
}

class _AfterCartScreenState extends State<AfterCartScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController pincodeController = TextEditingController();

  Future<carts.CartModel>? mycart;
  List<carts.CartData> cartlist = [];
  int? count;
  int? total;
  List<carts.ProductDetails> cart = [];
  Razorpay? _razorpay;
  Future<AddressList>? manageAddress;
  List<AddressData> addresslist = [];

  Future<AddressList> getAddressList() async {
    Map data = {
      'user_id': widget.data.id,
    };
    //encode Map to JSON
    var body = json.encode(data);
    var response =
        await dio.Dio().post("https://fabfurni.com/api/Auth/addressList",
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
      if (AddressList.fromJson(jsonObject).status == "true") {
        return AddressList.fromJson(jsonObject);
        // inviteList.sort((a, b) => a.id.compareTo(b.id));
      } else if (AddressList.fromJson(jsonObject).status == "false") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(AddressList.fromJson(jsonObject).message!),
            backgroundColor: Colors.redAccent));
      } else if (AddressList.fromJson(jsonObject).data == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(carts.CartModel.fromJson(jsonObject).message!),
            backgroundColor: Colors.redAccent));
      } else if (carts.CartModel.fromJson(jsonObject).data == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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
    mycart = getCartList();
    mycart!.then((value) {
      setState(() {
        cartlist = value.data!;
        count = value.count;
        total = value.total;

        // products=value.data;
        // recentuserslist = value.recentusers;
        // onetoonelist = value.onetoonemeeting;
        // interchapterlist = value.interchepter;
        // topuserslist=value.topUsers; //to be omitted
      });
    });
    _razorpay = Razorpay();
    _razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    // manageAddress = getAddressList();
    // for(int i)
    // manageAddress.then((value) {
    //   setState(() {
    //     addresslist = value.data;
    //   });
    // });

    super.initState();
  }

  String item1 = "";
  String item2 = "";
  String item3 = "";
  String item4 = "";
  String? product_id;
  String? discount_price;
  String? mrp_price;

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
                        style: AppStyle.txtRobotoRomanMedium18
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
              count = value.count;
              total = value.total;
            });
          });
        },
        child: Form(
            key: _formKey,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                      padding: getPadding(left: 25, top: 0),
                      child: Row(children: [
                        Container(
                            height: getSize(12),
                            width: getSize(12),
                            margin: getMargin(bottom: 3),
                            decoration: BoxDecoration(
                                color: ColorConstant.purple900,
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(
                                        getHorizontalSize(21))))),
                        Padding(
                            padding: getPadding(left: 10),
                            child: Text("ADDRESS/SUMMARY",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: AppStyle.txtRobotoMedium12.copyWith(
                                    letterSpacing: getHorizontalSize(0.36))))
                      ]))),
              CustomButton(
                onTap: () async {
                  List<String> resultList = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ChooseAddressToOrderProduct(widget.data)),
                  );

                  // Check if the resultList is not null before accessing its elements
                  setState(() {
                    if (resultList != null) {
                      // Access the elements of the resultList
                      item1 = resultList[0];
                      item4 = resultList[1];
                      item2 = resultList[2];
                      item3 = resultList[3];
                      print(item1 + item2 + item3);
                    }
                  });
                },
                height: getVerticalSize(21),
                width: getHorizontalSize(250),
                margin: getMargin(left: 13, right: 13),
                variant: ButtonVariant.OutlinePurple700,
                shape: ButtonShape.RoundedBorder5,
                padding: ButtonPadding.PaddingT10,
                fontStyle: ButtonFontStyle.RobotoMedium15Black900,
                text: "+ Change Address",
                // margin: getMargin(bottom: 8)
              ),
              item1.isNotEmpty
                  ? Container(
                      margin: getMargin(left: 25, top: 11, right: 25),
                      decoration: AppDecoration.outlineBlack90019.copyWith(
                          borderRadius: BorderRadiusStyle.customBorderBR50),
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                                padding: getPadding(right: 15),
                                child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      CustomButton(
                                        variant: ButtonVariant.FillPurple900,
                                        height: getVerticalSize(
                                          21,
                                        ),
                                        width: getHorizontalSize(
                                          62,
                                        ),
                                        text: item4 == "0" ? "Home" : "Office",
                                        fontStyle:
                                            ButtonFontStyle.RobotoMedium12,
                                        margin: getMargin(
                                          bottom: 8,
                                        ),
                                      ),
                                      Spacer(),
                                    ])),
                            Padding(
                                padding: getPadding(left: 15, top: 6),
                                child: Text(item2!.capitalizeFirst!,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: AppStyle.txtRobotoMedium14)),
                            // Padding(
                            //     padding: getPadding(left: 16, top: 3),
                            //     child: Text("87887 87887",
                            //         overflow: TextOverflow.ellipsis,
                            //         textAlign: TextAlign.left,
                            //         style: AppStyle.txtRobotoRegular9)),
                            Container(
                                width: getHorizontalSize(281),
                                margin: getMargin(
                                    left: 16, top: 3, right: 81, bottom: 15),
                                child: Text(item3.capitalizeFirst!,
                                    maxLines: null,
                                    textAlign: TextAlign.left,
                                    style: AppStyle.txtRobotoRegular12))
                          ]))
                  : Container(),
              // FutureBuilder(
              //         future:manageAddress,
              //     builder:(context,snapshot){
              //           if(snapshot.hasData){
              //             addresslist.iterator.current.defaulted=='1';
              //             if(snapshot.data.data.length==0){
              //               return Center(
              //                   child: Text('No data available.',
              //                       style: TextStyle(
              //                         fontFamily: 'poppins',
              //                         fontSize: 16.0,
              //                         fontWeight: FontWeight.bold,
              //                         color: const Color(0xff45536A),
              //                       )));
              //             }
              //             else{
              //               return Container(
              //                   margin: getMargin(left: 25, top: 11, right: 25),
              //                   decoration: AppDecoration.outlineBlack90019
              //                       .copyWith(
              //                       borderRadius:
              //                       BorderRadiusStyle.customBorderBR50),
              //                   child: Column(
              //                       mainAxisSize: MainAxisSize.min,
              //                       crossAxisAlignment: CrossAxisAlignment.start,
              //                       mainAxisAlignment: MainAxisAlignment.start,
              //                       children: [
              //                         Padding(
              //                             padding: getPadding(right: 15),
              //                             child: Row(
              //                                 crossAxisAlignment:
              //                                 CrossAxisAlignment.end,
              //                                 children: [
              //                                   CustomButton(
              //                                     variant: ButtonVariant.FillPurple900,
              //                                     height: getVerticalSize(
              //                                       21,
              //                                     ),
              //                                     width: getHorizontalSize(
              //                                       62,
              //                                     ),
              //                                     text:item4=="0"?"Home":"Office",
              //                                     fontStyle: ButtonFontStyle.RobotoMedium12,
              //                                     margin: getMargin(
              //                                       bottom: 8,
              //                                     ),
              //                                   ),
              //                                   Spacer(),
              //                                 ])),
              //                         Padding(
              //                             padding: getPadding(left: 15, top: 6),
              //                             child: Text(item2.capitalizeFirst,
              //                                 overflow: TextOverflow.ellipsis,
              //                                 textAlign: TextAlign.left,
              //                                 style: AppStyle.txtRobotoMedium14)),
              //                         // Padding(
              //                         //     padding: getPadding(left: 16, top: 3),
              //                         //     child: Text("87887 87887",
              //                         //         overflow: TextOverflow.ellipsis,
              //                         //         textAlign: TextAlign.left,
              //                         //         style: AppStyle.txtRobotoRegular9)),
              //                         Container(
              //                             width: getHorizontalSize(281),
              //                             margin: getMargin(
              //                                 left: 16,
              //                                 top: 3,
              //                                 right: 81,
              //                                 bottom: 15),
              //                             child: Text(item3.capitalizeFirst,
              //                                 maxLines: null,
              //                                 textAlign: TextAlign.left,
              //                                 style: AppStyle.txtRobotoRegular12))
              //                       ]));
              //             }
              //           }
              //           else{
              //             return const Center(
              //               heightFactor: 15,
              //               child: CircularProgressIndicator(
              //                 color: Colors.purple,
              //               ),
              //             );
              //
              //           }
              //
              // } ),
              Flexible(
                child: Container(
                  // height: 100.h,
                  child: FutureBuilder(
                      future: mycart,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (!snapshot.hasData) {
                            return Center(
                                child: Text('No data available.',
                                    style: TextStyle(
                                      fontFamily: 'poppins',
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xff45536A),
                                    )));
                          } else {
                            return SingleChildScrollView(
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
                                                    count.toString() + " ITEM",
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
                                                child: Text(total.toString(),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.left,
                                                    style: AppStyle
                                                        .txtRobotoMedium14Purple900)),
                                          ])),
                                  ListView.builder(
                                      shrinkWrap: true,
                                      physics: ClampingScrollPhysics(),
                                      itemCount: cartlist.length,
                                      itemBuilder: (context, index) {
                                        product_id = cartlist[index].productId;
                                        carts.ProductDetails product =
                                            cartlist[index].productDetails!;
                                        discount_price = product.discountPrice;
                                        mrp_price = product.mrpPrice;
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
                                                                SizedBox(
                                                                  width: 10.w,
                                                                ),
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
                                                                Container(
                                                                  constraints:
                                                                      const BoxConstraints(
                                                                    maxWidth:
                                                                        230,
                                                                  ),
                                                                  child:
                                                                      FittedBox(
                                                                    fit: BoxFit
                                                                        .fill,
                                                                    child: Text(
                                                                        product
                                                                            .description!,
                                                                        overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                        textAlign:
                                                                            TextAlign
                                                                                .left,
                                                                        style: AppStyle
                                                                            .txtRobotoRegular9),
                                                                  ),
                                                                ),
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
                                            // Container(
                                            //     width: double.maxFinite,
                                            //     margin: getMargin(top: 5),
                                            //     padding: getPadding(
                                            //         left: 41, right: 41),
                                            //     decoration: AppDecoration
                                            //         .outlineGray400,
                                            //     child: Row(
                                            //         mainAxisAlignment:
                                            //         MainAxisAlignment.end,
                                            //         children: [
                                            //           Padding(
                                            //               padding: getPadding(
                                            //                   left: 37,
                                            //                   top: 11,
                                            //                   bottom: 9),
                                            //               child: Text(
                                            //                   "lbl_remove".tr,
                                            //                   overflow:
                                            //                   TextOverflow
                                            //                       .ellipsis,
                                            //                   textAlign:
                                            //                   TextAlign
                                            //                       .left,
                                            //                   style: AppStyle
                                            //                       .txtRobotoRegular12Black900
                                            //                       .copyWith(
                                            //                       letterSpacing:
                                            //                       getHorizontalSize(
                                            //                           1.2)))),
                                            //           Spacer(),
                                            //           SizedBox(
                                            //               height:
                                            //               getVerticalSize(
                                            //                   36),
                                            //               child: VerticalDivider(
                                            //                   width:
                                            //                   getHorizontalSize(
                                            //                       1),
                                            //                   thickness:
                                            //                   getVerticalSize(
                                            //                       1),
                                            //                   color: ColorConstant
                                            //                       .gray40001)),
                                            //           Padding(
                                            //               padding: getPadding(
                                            //                   left: 46,
                                            //                   top: 11,
                                            //                   bottom: 9),
                                            //               child: Text(
                                            //                   "msg_move_to_wishlist"
                                            //                       .tr,
                                            //                   overflow:
                                            //                   TextOverflow
                                            //                       .ellipsis,
                                            //                   textAlign:
                                            //                   TextAlign
                                            //                       .left,
                                            //                   style: AppStyle
                                            //                       .txtRobotoRegular12Black900
                                            //                       .copyWith(
                                            //                       letterSpacing:
                                            //                       getHorizontalSize(
                                            //                           1.2))))
                                            //         ])),
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
                                  SizedBox(
                                    height: 5.h,
                                  )
                                ],
                              ),
                            );
                          }
                        } else {
                          return const Center(
                            heightFactor: 15,
                            child: CircularProgressIndicator(
                              color: Colors.purple,
                            ),
                          );
                        }
                      }),
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
            ])),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          if (item1.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                duration: Duration(seconds: 1),
                content: Text("Please Choose One Address"),
                backgroundColor: Colors.redAccent));
          } else {
            //_startPayment();
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => PaymentMethodScreen(
                  count.toString(),
                  total.toString(),
                  item1,
                  item2,
                  item3,
                  product_id!,
                  widget.data.id!,
                  discount_price!,
                  mrp_price!,
                  widget.data),
            ));
          }
        },
        child: Container(
            width: double.maxFinite,
            child: Container(
                height: 6.5.h,
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

  void _startPayment() {
    int amountInPaise = (total! * 100).toInt();
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
        duration: Duration(seconds: 3),
        content: Text('Payment Successfully!!\n Transaction Id: ' +
            response.paymentId.toString()),
        backgroundColor: Colors.green));
    SharedPreferences prefs = await SharedPreferences.getInstance();
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
        content: Text('Payment Failed\n' + response.toString()),
        backgroundColor: Colors.redAccent));
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Handle external wallet payment
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 1),
        content: Text(response.toString()),
        backgroundColor: Colors.green));
  }

  void _showQuantityBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ChooseAddressToOrderProduct(widget.data);
      },
    ).then((value) {
      if (value != null) {
        // Handle the selected quantity returned from the bottom sheet
        // addtocart(value.toString(),product_id);
        print('Selected quantity: ' + value);
      }
    });
  }

  onTapArrowleft8() {
    Navigator.of(context).pop();
  }
}
