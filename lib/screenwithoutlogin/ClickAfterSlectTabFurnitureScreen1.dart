import 'dart:convert';

import 'package:keshav_s_application2/presentation/click_after_slect_tab_furniture_screen/models/Category_subcategory.dart'
    as sub;
import 'package:keshav_s_application2/presentation/otp_screen/models/otp_model.dart';
import 'package:keshav_s_application2/presentation/search_screen/search_screen.dart';
import 'package:keshav_s_application2/presentation/select_product_screen/select_product_screen.dart';
import 'package:keshav_s_application2/presentation/store_screen/models/StoreModel.dart';
import 'package:keshav_s_application2/presentation/whislist_screen/whislist_screen.dart';
import 'package:keshav_s_application2/screenwithoutlogin/searchscreen1.dart';
import 'package:keshav_s_application2/screenwithoutlogin/selectproductscreen1.dart';
import 'package:keshav_s_application2/widgets/app_bar/appbar_subtitle_2.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';


import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as fs;
import 'package:keshav_s_application2/core/app_export.dart';
import 'package:keshav_s_application2/widgets/app_bar/appbar_image.dart';
import 'package:keshav_s_application2/widgets/app_bar/appbar_subtitle_5.dart';
import 'package:keshav_s_application2/widgets/app_bar/appbar_subtitle_6.dart';
import 'package:keshav_s_application2/widgets/app_bar/custom_app_bar.dart';
import 'dart:convert';

import 'package:dio/dio.dart' as dio;

import '../presentation/log_in_screen/log_in_screen.dart';

class ClickAfterSlectTabFurnitureScreen1 extends StatefulWidget {
  StoreData category;
  String category_name;
  // SubCategory subcategory;
  ClickAfterSlectTabFurnitureScreen1(this.category, this.category_name);
  @override
  State<ClickAfterSlectTabFurnitureScreen1> createState() =>
      _ClickAfterSlectTabFurnitureScreen1State();
}

class _ClickAfterSlectTabFurnitureScreen1State
    extends State<ClickAfterSlectTabFurnitureScreen1> {
  Future<sub.CategorySubcategory>? subcategories;
  sub.Data? subcategorieslist;
  List<sub.SubCategory> subcategore = [];

  Future<sub.CategorySubcategory> getSubCategory() async {
    Map data = {
      // 'user_id': widget.data.id,
      "category_id": widget.category.id,
    };
    //encode Map to JSON
    var body = json.encode(data);
    var response = await dio.Dio()
        .post("https://fabfurni.com/api/Webservice/category_subcategory",
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

      if (sub.CategorySubcategory.fromJson(jsonObject).status == "true") {
        // print(orders.MyOrdersModel.fromJson(jsonObject).data.first.products.first.image);

        return sub.CategorySubcategory.fromJson(jsonObject);

        // inviteList.sort((a, b) => a.id.compareTo(b.id));
      } else if (sub.CategorySubcategory.fromJson(jsonObject).status ==
          "false") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:
                Text(sub.CategorySubcategory.fromJson(jsonObject).message!),
            backgroundColor: Colors.redAccent));
      } else if (sub.CategorySubcategory.fromJson(jsonObject).data == null) {
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
    subcategories = getSubCategory();
    subcategories!.then((value) {
      setState(() {
        subcategorieslist = value.data;
        subcategore = value.data!.subCategory!;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConstant.whiteA700,
            appBar: CustomAppBar(
                height: getVerticalSize(90),
                leadingWidth: 41,
                leading: AppbarImage(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    height: getVerticalSize(15),
                    width: getHorizontalSize(9),
                    svgPath: ImageConstant.imgArrowleft,
                    margin: getMargin(left: 20, top: 34, bottom: 42)),
                title: AppbarSubtitle2(
                    text: widget.category_name,
                    margin: getMargin(left: 19, top: 34, bottom: 42)),
                // AppbarImage(
                //     height: getVerticalSize(32),
                //     width: getHorizontalSize(106),
                //     imagePath: ImageConstant.imgFinallogo03,
                //     margin: getMargin(left: 13, top: 44, bottom: 15)),
                actions: [
                  AppbarImage(
                      height: getSize(21),
                      width: getSize(21),
                      svgPath: ImageConstant.imgSearch,
                      margin:
                          getMargin(left: 12, top: 0, right: 10, bottom: 10),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SearchScreen1(''),
                        ));
                      }),
                  Container(
                      height: getVerticalSize(23),
                      width: getHorizontalSize(27),
                      margin:
                          getMargin(left: 20, top: 0, right: 10, bottom: 15),
                      child: Stack(alignment: Alignment.topRight, children: [
                        AppbarImage(
                            height: getVerticalSize(21),
                            width: getHorizontalSize(21),
                            svgPath: ImageConstant.imgLocation,
                            margin: getMargin(top: 5, right: 6),
                            onTap: () {
                              pushScreen(
                                context,
                                screen: LogInScreen(),
                                withNavBar:
                                    false, // OPTIONAL VALUE. True by default.
                                pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino,
                              );
                              // Navigator.of(context).pushReplacement(MaterialPageRoute(
                              //   builder: (context) => LogInScreen(),
                              // ));
                              // pushScreen(
                              //   context,
                              //   screen: WhislistScreen(widget.data),
                              //   withNavBar:
                              //   false, // OPTIONAL VALUE. True by default.
                              //   pageTransitionAnimation:
                              //   PageTransitionAnimation.cupertino,
                              // );
                            }),
                        // AppbarSubtitle6(
                        //     text: "lbl_2".tr,
                        //     margin: getMargin(left: 17, bottom: 13))
                      ])),
                  Container(
                      height: getVerticalSize(24),
                      width: getHorizontalSize(29),
                      margin:
                          getMargin(left: 14, top: 0, right: 31, bottom: 15),
                      child: Stack(alignment: Alignment.topRight, children: [
                        AppbarImage(
                            onTap: () {
                              pushScreen(
                                context,
                                screen: LogInScreen(),
                                withNavBar:
                                    false, // OPTIONAL VALUE. True by default.
                                pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino,
                              );
                              // Navigator.of(context).pushReplacement(MaterialPageRoute(
                              //   builder: (context) => LogInScreen(),
                              // ));
                              // pushScreen(
                              //   context,
                              //   screen: CartScreen(widget.data),
                              //   withNavBar:
                              //   false, // OPTIONAL VALUE. True by default.
                              //   pageTransitionAnimation:
                              //   PageTransitionAnimation.cupertino,
                              // );
                              // Navigator.of(context).push(MaterialPageRoute(
                              //   builder: (context) => CartScreen(widget.data),
                              // ));
                            },
                            height: getVerticalSize(20),
                            width: getHorizontalSize(23),
                            svgPath: ImageConstant.imgCart,
                            margin: getMargin(top: 4, right: 6)),
                        // AppbarSubtitle6(
                        //     text: CartScreen.count.toString(),
                        //     margin: getMargin(left: 17, bottom: 13))
                      ]))
                ],
                styleType: Style.bgShadowBlack90033),
            body: subcategore.length != 0
                ? ListView.builder(
                    itemCount: subcategore.length,
                    itemBuilder: (context, index) {
                      // List <subcategory.SubCategories> subcategore=subcategorieslist[index].subCategory;
                      print(subcategore.length);
                      return Container(
                          width: double.maxFinite,
                          padding: getPadding(
                            top: 21,
                          ),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    print(subcategore[index].id);
                                    pushScreen(
                                      context,
                                      screen: SelectProductScreen1(
                                          widget.category,
                                          subcategore[index].id!),
                                      withNavBar:
                                          true, // OPTIONAL VALUE. True by default.
                                      pageTransitionAnimation:
                                          PageTransitionAnimation.cupertino,
                                    );
                                    // Navigator.pushNamed(context, AppRoutes.ClickAfterSlectTabFurnitureScreen1);
                                    // pushScreen(
                                    //   context,
                                    //   screen: ClickAfterSlectTabFurnitureScreen1(widget.data,categorylist[index].id,categorylist[index].name),
                                    //   withNavBar: true, // OPTIONAL VALUE. True by default.
                                    //   pageTransitionAnimation: PageTransitionAnimation.cupertino,
                                    // );
                                    // onTapTxtFurniture();
                                  },
                                  child: Padding(
                                      padding: getPadding(left: 31, right: 40),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(subcategore[index].name!,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style: AppStyle
                                                    .txtRobotoRegular12Black900
                                                    .copyWith(
                                                        letterSpacing:
                                                            getHorizontalSize(
                                                                1.8))),
                                            InkWell(
                                              onTap: () {
                                                pushScreen(
                                                  context,
                                                  screen: SelectProductScreen1(
                                                      widget.category,
                                                      subcategore[index].id!),
                                                  withNavBar:
                                                      true, // OPTIONAL VALUE. True by default.
                                                  pageTransitionAnimation:
                                                      PageTransitionAnimation
                                                          .cupertino,
                                                );
                                              },
                                              child: Container(
                                                // width: 20,
                                                // height: 15,
                                                child: CustomImageView(
                                                    svgPath: ImageConstant
                                                        .imgArrowrightGray500,
                                                    height: getVerticalSize(15),
                                                    width:
                                                        getHorizontalSize(20),
                                                    margin: getMargin(
                                                        top: 2, bottom: 2)),
                                              ),
                                            )
                                          ])),
                                ),
                                Padding(
                                    padding: getPadding(top: 14),
                                    child: Divider(
                                        height: getVerticalSize(1),
                                        thickness: getVerticalSize(1))),
                                // GestureDetector(
                                //   onTap: (){
                                //
                                //   },
                                //   child: Padding(
                                //       padding: getPadding(left: 31, top: 20, right: 40),
                                //       child: Row(
                                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //           children: [
                                //             Text("lbl_living2".tr,
                                //                 overflow: TextOverflow.ellipsis,
                                //                 textAlign: TextAlign.left,
                                //                 style: AppStyle.txtRobotoRegular12Black900
                                //                     .copyWith(
                                //                     letterSpacing:
                                //                     getHorizontalSize(1.8))),
                                //             CustomImageView(
                                //                 svgPath: ImageConstant.imgArrowrightGray500,
                                //                 height: getVerticalSize(10),
                                //                 width: getHorizontalSize(6),
                                //                 margin: getMargin(top: 2, bottom: 2))
                                //           ])),
                                // ),
                                // Padding(
                                //     padding: getPadding(top: 14),
                                //     child: Divider(
                                //         height: getVerticalSize(1),
                                //         thickness: getVerticalSize(1))),
                                // GestureDetector(
                                //   onTap: (){
                                //
                                //   },
                                //   child: Padding(
                                //       padding: getPadding(left: 31, top: 20, right: 40),
                                //       child: Row(
                                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //           children: [
                                //             Text("lbl_bedroom2".tr,
                                //                 overflow: TextOverflow.ellipsis,
                                //                 textAlign: TextAlign.left,
                                //                 style: AppStyle.txtRobotoRegular12Black900
                                //                     .copyWith(
                                //                     letterSpacing:
                                //                     getHorizontalSize(1.8))),
                                //             CustomImageView(
                                //                 svgPath: ImageConstant.imgArrowrightGray500,
                                //                 height: getVerticalSize(10),
                                //                 width: getHorizontalSize(6),
                                //                 margin: getMargin(top: 2, bottom: 2))
                                //           ])),
                                // ),
                                // Padding(
                                //     padding: getPadding(top: 14),
                                //     child: Divider(
                                //         height: getVerticalSize(1),
                                //         thickness: getVerticalSize(1))),
                                // GestureDetector(
                                //   onTap: (){
                                //
                                //   },
                                //   child: Padding(
                                //       padding: getPadding(left: 31, top: 20, right: 40),
                                //       child: Row(
                                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //           children: [
                                //             Text("lbl_kids_room2".tr,
                                //                 overflow: TextOverflow.ellipsis,
                                //                 textAlign: TextAlign.left,
                                //                 style: AppStyle.txtRobotoRegular12Black900
                                //                     .copyWith(
                                //                     letterSpacing:
                                //                     getHorizontalSize(1.8))),
                                //             CustomImageView(
                                //                 svgPath: ImageConstant.imgArrowrightGray500,
                                //                 height: getVerticalSize(10),
                                //                 width: getHorizontalSize(6),
                                //                 margin: getMargin(top: 2, bottom: 2))
                                //           ])),
                                // ),
                                // Padding(
                                //     padding: getPadding(top: 14),
                                //     child: Divider(
                                //         height: getVerticalSize(1),
                                //         thickness: getVerticalSize(1))),
                                // GestureDetector(
                                //   onTap: (){
                                //
                                //   },
                                //   child: Padding(
                                //       padding: getPadding(left: 31, top: 20, right: 40),
                                //       child: Row(
                                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //           children: [
                                //             Text("lbl_mattresses2".tr,
                                //                 overflow: TextOverflow.ellipsis,
                                //                 textAlign: TextAlign.left,
                                //                 style: AppStyle.txtRobotoRegular12Black900
                                //                     .copyWith(
                                //                     letterSpacing:
                                //                     getHorizontalSize(1.8))),
                                //             CustomImageView(
                                //                 svgPath: ImageConstant.imgArrowrightGray500,
                                //                 height: getVerticalSize(10),
                                //                 width: getHorizontalSize(6),
                                //                 margin: getMargin(top: 2, bottom: 2))
                                //           ])),
                                // ),
                                // Padding(
                                //     padding: getPadding(top: 14),
                                //     child: Divider(
                                //         height: getVerticalSize(1),
                                //         thickness: getVerticalSize(1))),
                                // GestureDetector(
                                //   onTap: (){
                                //
                                //   },
                                //   child: Padding(
                                //       padding: getPadding(left: 31, top: 20, right: 40),
                                //       child: Row(
                                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //           children: [
                                //             Text("lbl_furnishings".tr,
                                //                 overflow: TextOverflow.ellipsis,
                                //                 textAlign: TextAlign.left,
                                //                 style: AppStyle.txtRobotoRegular12Black900
                                //                     .copyWith(
                                //                     letterSpacing:
                                //                     getHorizontalSize(1.8))),
                                //             CustomImageView(
                                //                 svgPath: ImageConstant.imgArrowrightGray500,
                                //                 height: getVerticalSize(10),
                                //                 width: getHorizontalSize(6),
                                //                 margin: getMargin(top: 2, bottom: 2))
                                //           ])),
                                // ),
                                // Padding(
                                //     padding: getPadding(top: 14),
                                //     child: Divider(
                                //         height: getVerticalSize(1),
                                //         thickness: getVerticalSize(1))),
                                // GestureDetector(
                                //   onTap: (){
                                //
                                //   },
                                //   child: Padding(
                                //       padding: getPadding(left: 31, top: 20, right: 40),
                                //       child: Row(
                                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //           children: [
                                //             Text("lbl_lighting".tr,
                                //                 overflow: TextOverflow.ellipsis,
                                //                 textAlign: TextAlign.left,
                                //                 style: AppStyle.txtRobotoRegular12Black900
                                //                     .copyWith(
                                //                     letterSpacing:
                                //                     getHorizontalSize(1.8))),
                                //             CustomImageView(
                                //                 svgPath: ImageConstant.imgArrowrightGray500,
                                //                 height: getVerticalSize(10),
                                //                 width: getHorizontalSize(6),
                                //                 margin: getMargin(top: 2, bottom: 2))
                                //           ])),
                                // ),
                                // Padding(
                                //     padding: getPadding(top: 14),
                                //     child: Divider(
                                //         height: getVerticalSize(1),
                                //         thickness: getVerticalSize(1))),
                                // GestureDetector(
                                //   onTap: (){
                                //
                                //   },
                                //   child: Padding(
                                //       padding: getPadding(left: 31, top: 20, right: 40),
                                //       child: Row(
                                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //           children: [
                                //             Text("lbl_appliances".tr,
                                //                 overflow: TextOverflow.ellipsis,
                                //                 textAlign: TextAlign.left,
                                //                 style: AppStyle.txtRobotoRegular12Black900
                                //                     .copyWith(
                                //                     letterSpacing:
                                //                     getHorizontalSize(1.8))),
                                //             CustomImageView(
                                //                 svgPath: ImageConstant.imgArrowrightGray500,
                                //                 height: getVerticalSize(10),
                                //                 width: getHorizontalSize(6),
                                //                 margin: getMargin(top: 2, bottom: 2))
                                //           ])),
                                // ),
                                // Padding(
                                //     padding: getPadding(top: 14),
                                //     child: Divider(
                                //         height: getVerticalSize(1),
                                //         thickness: getVerticalSize(1))),
                                // GestureDetector(
                                //   onTap: (){
                                //
                                //   },
                                //   child: Padding(
                                //       padding: getPadding(left: 31, top: 20, right: 40),
                                //       child: Row(
                                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //           children: [
                                //             Text("msg_modular_furniture".tr,
                                //                 overflow: TextOverflow.ellipsis,
                                //                 textAlign: TextAlign.left,
                                //                 style: AppStyle.txtRobotoRegular12Black900
                                //                     .copyWith(
                                //                     letterSpacing:
                                //                     getHorizontalSize(1.8))),
                                //             CustomImageView(
                                //                 svgPath: ImageConstant.imgArrowrightGray500,
                                //                 height: getVerticalSize(10),
                                //                 width: getHorizontalSize(6),
                                //                 margin: getMargin(top: 2, bottom: 2))
                                //           ])),
                                // ),
                                // Padding(
                                //     padding: getPadding(top: 14, bottom: 5),
                                //     child: Divider(
                                //         height: getVerticalSize(1),
                                //         thickness: getVerticalSize(1)))
                              ]));
                    })
                : Center(
                    child: Text('No data available.',
                        style: TextStyle(
                          fontFamily: 'poppins',
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xff45536A),
                        )))));
  }
}
