import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:keshav_s_application2/presentation/my_orders_screen/models/my_orders_model.dart'
    as orders;
import 'package:keshav_s_application2/presentation/order_detail_screen/order_detail_screen.dart';
import 'package:keshav_s_application2/presentation/otp_screen/models/otp_model.dart';
import 'package:keshav_s_application2/widgets/app_bar/appbar_subtitle_5.dart';
import 'package:sizer/sizer.dart';
import 'package:smartech_base/smartech_base.dart';

import 'controller/my_orders_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as fs;
import 'package:keshav_s_application2/core/app_export.dart';
import 'package:keshav_s_application2/widgets/app_bar/appbar_image.dart';
import 'package:keshav_s_application2/widgets/app_bar/custom_app_bar.dart';
import 'package:keshav_s_application2/widgets/custom_drop_down.dart';
import 'package:keshav_s_application2/widgets/custom_text_form_field.dart';

import 'dart:convert';

import 'package:dio/dio.dart' as dio;

class MyOrdersScreen extends StatefulWidget {
  Data data;
  MyOrdersScreen(this.data);
  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  Future<orders.MyOrdersModel>? myorders;
  List<orders.OrdersData> orderslist = [];
  List<orders.Products> products = [];

  Future<orders.MyOrdersModel> getOrdersList() async {
    Map data = {
      'user_id': widget.data.id,
    };
    //encode Map to JSON
    var body = json.encode(data);
    var response =
        await dio.Dio().post("https://fabfurni.com/api/Webservice/orderList",
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

      if (orders.MyOrdersModel.fromJson(jsonObject).status == "true") {
        // print(orders.MyOrdersModel.fromJson(jsonObject).data.first.products.first.image);

        return orders.MyOrdersModel.fromJson(jsonObject);

        // inviteList.sort((a, b) => a.id.compareTo(b.id));
      } else if (orders.MyOrdersModel.fromJson(jsonObject).status == "false") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(orders.MyOrdersModel.fromJson(jsonObject).message!),
            backgroundColor: Colors.redAccent));
      } else if (orders.MyOrdersModel.fromJson(jsonObject).data == null) {
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
    Smartech().trackEvent("screen_viewed", {});
    myorders = getOrdersList();
    myorders!.then((value) {
      setState(() {
        orderslist = value.data!;
        // products=value.data;
        // recentuserslist = value.recentusers;
        // onetoonelist = value.onetoonemeeting;
        // interchapterlist = value.interchepter;
        // topuserslist=value.topUsers; //to be omitted
      });
    });

    super.initState();
  }

  final DateFormat _dateFormat = DateFormat('dd-MM-yyyy');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: ColorConstant.whiteA700,
            appBar: CustomAppBar(
                height: getVerticalSize(70),
                leadingWidth: 41,
                leading: AppbarImage(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    height: getVerticalSize(15),
                    width: getHorizontalSize(9),
                    svgPath: ImageConstant.imgArrowleft,
                    margin: getMargin(left: 20, top: 32, bottom: 22)),
                title: AppbarSubtitle5(
                    text: "MY ORDER",
                    margin: getMargin(left: 19, top: 50, bottom: 40)),
                // AppbarImage(
                //     height: getVerticalSize(32),
                //     width: getHorizontalSize(106),
                //     imagePath: ImageConstant.imgFinallogo03,
                //     margin: getMargin(left: 13, top: 44, bottom: 15)),
                styleType: Style.bgShadowBlack90033),
            body: Container(
              color: ColorConstant.purple50,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                        padding: getPadding(left: 10, right: 11),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                  padding:
                                      getPadding(top: 20, left: 15, bottom: 8),
                                  child: Text(
                                      "You've placed " +
                                          orderslist.length.toString() +
                                          " orders",
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: AppStyle
                                          .txtRobotoRegular14Purple30001
                                          .copyWith(
                                              letterSpacing:
                                                  getHorizontalSize(0.7)))),
                              // CustomDropDown(
                              //     width:
                              //         getHorizontalSize(
                              //             92),
                              //     focusNode: FocusNode(),
                              //     icon: Container(
                              //         margin: getMargin(
                              //             left: 6,
                              //             right: 13),
                              //         // decoration: BoxDecoration(
                              //         //     color: ColorConstant
                              //         //         .whiteA700),
                              //         child: CustomImageView(
                              //             svgPath:
                              //                 ImageConstant
                              //                     .imgArrowdownWhiteA700)),
                              //     hintText:
                              //         "lbl_all_orders".tr,
                              //     margin:
                              //         getMargin(top: 2),
                              //     variant: DropDownVariant
                              //         .FillPurple900,
                              //     fontStyle:
                              //         DropDownFontStyle
                              //             .RobotoMedium12,
                              //     items: controller
                              //         .myOrdersModelObj
                              //         .value
                              //         .dropdownItemList,
                              //     onChanged: (value) {
                              //       controller.onSelected(
                              //           value);
                              //     })
                            ])),
                    Flexible(
                      child: Container(
                        height: 100.h,
                        child: FutureBuilder(
                          future: myorders,
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
                                return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: orderslist.length,
                                    physics: ClampingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      //List <orders.Products> product=orderslist[index].products;
                                      // print(product[index].image);
                                      // print(product.toList().iterator.current.productId);
                                      return SingleChildScrollView(
                                        child: Container(
                                            margin: getMargin(
                                                left: 11, top: 23, right: 11),
                                            decoration: AppDecoration
                                                .outlineBlack900191
                                                .copyWith(
                                                    borderRadius:
                                                        BorderRadiusStyle
                                                            .customBorderBR51),
                                            child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Row(children: [
                                                    Container(
                                                        height: getSize(17),
                                                        width: getSize(17),
                                                        margin: getMargin(
                                                            bottom: 4),
                                                        decoration: BoxDecoration(
                                                            color: ColorConstant
                                                                .purple900,
                                                            borderRadius: BorderRadius.only(
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        getHorizontalSize(
                                                                            21))))),
                                                    Padding(
                                                        padding: getPadding(
                                                            left: 8, top: 4),
                                                        child: Text(
                                                            orderslist[index]
                                                                .status!
                                                                .capitalizeFirst!,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: AppStyle
                                                                .txtRobotoMedium14Purple900
                                                                .copyWith(
                                                                    letterSpacing:
                                                                        getHorizontalSize(
                                                                            0.7))))
                                                  ]),
                                                  Padding(
                                                      padding: getPadding(
                                                          left: 26, top: 7),
                                                      child: Text(
                                                          "Order ID: " +
                                                              orderslist[index]
                                                                  .orderNumber!,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: AppStyle
                                                              .txtRobotoMedium14
                                                              .copyWith(
                                                                  letterSpacing:
                                                                      getHorizontalSize(
                                                                          0.7)))),
                                                  Padding(
                                                      padding: getPadding(
                                                          left: 26, top: 7),
                                                      child: Text(
                                                          _dateFormat.format(
                                                              DateTime.parse(
                                                                  orderslist[
                                                                          index]
                                                                      .orderDate!)),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: AppStyle
                                                              .txtRobotoMedium12Black900
                                                              .copyWith(
                                                                  letterSpacing:
                                                                      getHorizontalSize(
                                                                          0.7)))),
                                                  orderslist[index]
                                                          .products!
                                                          .isNotEmpty
                                                      ? Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .fromLTRB(
                                                                  10.0,
                                                                  0,
                                                                  10,
                                                                  0),
                                                          child: Divider(
                                                            thickness: 2,
                                                            color: ColorConstant
                                                                .purple50,
                                                          ),
                                                        )
                                                      : SizedBox(
                                                          height: 10,
                                                        ),
                                                  // CustomTextFormField(
                                                  //     focusNode:
                                                  //         FocusNode(),
                                                  //     controller:
                                                  //         controller
                                                  //             .deliverydateController,
                                                  //     hintText:
                                                  //         "lbl_15_nov_2021"
                                                  //             .tr,
                                                  //     margin: getMargin(
                                                  //         left:
                                                  //             17,
                                                  //         top:
                                                  //             8,
                                                  //         right:
                                                  //             17),
                                                  //     variant:
                                                  //         TextFormFieldVariant
                                                  //             .UnderLinePurple5001,
                                                  //     fontStyle:
                                                  //         TextFormFieldFontStyle
                                                  //             .RobotoRegular14,
                                                  //     alignment:
                                                  //         Alignment
                                                  //             .center),
                                                  orderslist[index]
                                                          .products!
                                                          .isNotEmpty
                                                      ? Align(
                                                          alignment: Alignment
                                                              .center,
                                                          child: Padding(
                                                              padding:
                                                                  getPadding(
                                                                      left: 17,
                                                                      top: 14,
                                                                      right: 22,
                                                                      bottom:
                                                                          18),
                                                              child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    CustomImageView(
                                                                        onTap:
                                                                            () {
                                                                          Navigator.of(context)
                                                                              .push(MaterialPageRoute(
                                                                            builder: (context) => OrderDetailScreen(
                                                                                widget.data,
                                                                                orderslist[index].products![0].productDetails!,
                                                                                orderslist[index].products![0],
                                                                                orderslist[index].status!.capitalizeFirst!,
                                                                                orderslist[index].orderNumber!,
                                                                                _dateFormat.format(DateTime.parse(orderslist[index].orderDate!)),
                                                                                orderslist[index].total!,
                                                                                orderslist[index]),
                                                                          ));
                                                                          // Get.toNamed(AppRoutes.orderDetailScreen);
                                                                        },
                                                                        url: orderslist[index]
                                                                            .products![
                                                                                0]
                                                                            .image!,
                                                                        // imagePath: ImageConstant
                                                                        //     .imgImage17,
                                                                        height: getSize(
                                                                            82),
                                                                        width: getSize(
                                                                            82)),
                                                                    Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        InkWell(
                                                                          onTap:
                                                                              () {
                                                                            Navigator.of(context).push(MaterialPageRoute(
                                                                              builder: (context) => OrderDetailScreen(widget.data, orderslist[index].products![0].productDetails!, orderslist[index].products![0], orderslist[index].status!.capitalizeFirst!, orderslist[index].orderNumber!, _dateFormat.format(DateTime.parse(orderslist[index].orderDate!)), orderslist[index].total!, orderslist[index]),
                                                                            ));
                                                                            // Get.toNamed(AppRoutes.orderDetailScreen);
                                                                          },
                                                                          child: Padding(
                                                                              padding: getPadding(left: 9, top: 2, bottom: 0),
                                                                              child: Text('SKU ID : ' + orderslist[index].products![0].code!, overflow: TextOverflow.ellipsis, textAlign: TextAlign.left, style: AppStyle.txtRobotoRegular12Black900)),
                                                                        ),
                                                                        InkWell(
                                                                          onTap:
                                                                              () {
                                                                            Navigator.of(context).push(MaterialPageRoute(
                                                                              builder: (context) => OrderDetailScreen(widget.data, orderslist[index].products![0].productDetails!, orderslist[index].products![0], orderslist[index].status!.capitalizeFirst!, orderslist[index].orderNumber!, _dateFormat.format(DateTime.parse(orderslist[index].orderDate!)), orderslist[index].total!, orderslist[index]),
                                                                            ));
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                58.w,
                                                                            padding: getPadding(
                                                                                left: 9,
                                                                                top: 11,
                                                                                bottom: 0),
                                                                            child:
                                                                                Text(
                                                                              orderslist[index].products![0].name!,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              maxLines: 2,
                                                                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        // InkWell(
                                                                        //   onTap:(){
                                                                        //     Get.toNamed(AppRoutes.trackOrderOneScreen);
                                                                        //   },
                                                                        //   child: Padding(
                                                                        //     padding: getPadding(
                                                                        //         left: 9,
                                                                        //         top: 14,
                                                                        //         bottom: 0),
                                                                        //     child: Text(
                                                                        //       "Track Item",
                                                                        //       style: TextStyle(
                                                                        //           fontWeight:
                                                                        //           FontWeight
                                                                        //               .w500,
                                                                        //           fontSize: 15,
                                                                        //           color: ColorConstant
                                                                        //               .purple700),
                                                                        //     ),
                                                                        //   ),
                                                                        // )
                                                                      ],
                                                                    ),
                                                                    Spacer(),
                                                                    CustomImageView(
                                                                        onTap:
                                                                            () {
                                                                          Navigator.of(context)
                                                                              .push(MaterialPageRoute(
                                                                            builder: (context) => OrderDetailScreen(
                                                                                widget.data,
                                                                                orderslist[index].products![0].productDetails!,
                                                                                orderslist[index].products![0],
                                                                                orderslist[index].status!.capitalizeFirst!,
                                                                                orderslist[index].orderNumber!,
                                                                                _dateFormat.format(DateTime.parse(orderslist[index].orderDate!)),
                                                                                orderslist[index].total!,
                                                                                orderslist[index]),
                                                                          ));
                                                                          // Get.toNamed(AppRoutes.orderDetailScreen);
                                                                        },
                                                                        svgPath:
                                                                            ImageConstant
                                                                                .imgArrowright,
                                                                        height: getVerticalSize(
                                                                            12),
                                                                        width: getHorizontalSize(
                                                                            7),
                                                                        margin: getMargin(
                                                                            top:
                                                                                32,
                                                                            bottom:
                                                                                38))
                                                                  ])))
                                                      : Container(),
                                                ])),
                                      );
                                    });
                              }
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
                    ),
                    Padding(
                        padding: getPadding(top: 17),
                        child: Divider(
                            height: getVerticalSize(5),
                            thickness: getVerticalSize(5),
                            color: ColorConstant.purple50))
                  ]),
            )));
  }

  onTapArrowleft13() {
    Navigator.of(context).pop();
  }
}
