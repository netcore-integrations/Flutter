import 'package:keshav_s_application2/presentation/click_after_slect_tab_furniture_screen/click_after_slect_tab_furniture_screen.dart';
import 'package:keshav_s_application2/presentation/otp_screen/models/otp_model.dart';
import 'package:keshav_s_application2/presentation/search_screen/search_screen.dart';
import 'package:keshav_s_application2/presentation/select_product_screen/newproductlist.dart';
import 'package:keshav_s_application2/presentation/select_product_screen/select_product_screen.dart';
import 'package:keshav_s_application2/presentation/sidebar_menu_draweritem/sidebar_menu_draweritem.dart';
import 'package:keshav_s_application2/presentation/store_screen/models/StoreModel.dart'
    as stores;
import 'package:keshav_s_application2/presentation/whislist_screen/whislist_screen.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

import '../cart_screen/cart_screen.dart';
import 'controller/store_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as fs;
import 'package:keshav_s_application2/core/app_export.dart';
import 'package:keshav_s_application2/widgets/app_bar/appbar_image.dart';
import 'package:keshav_s_application2/widgets/app_bar/appbar_subtitle_6.dart';
import 'package:keshav_s_application2/widgets/app_bar/custom_app_bar.dart';

import 'dart:convert';

import 'package:dio/dio.dart' as dio;

class StoreScreen extends StatefulWidget {
  Data data;
  StoreScreen(this.data);
  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Future<stores.StoreModel>? category;
  List<stores.StoreData> categorylist = [];

  Future<stores.StoreModel> getCategory() async {
    Map data = {
      'user_id': widget.data.id,
    };
    //encode Map to JSON
    var body = json.encode(data);
    var response =
        await dio.Dio().post("https://fabfurni.com/api/Webservice/category",
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

      if (stores.StoreModel.fromJson(jsonObject).status == "true") {
        // print(orders.MyOrdersModel.fromJson(jsonObject).data.first.products.first.image);

        return stores.StoreModel.fromJson(jsonObject);

        // inviteList.sort((a, b) => a.id.compareTo(b.id));
      } else if (stores.StoreModel.fromJson(jsonObject).status == "false") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(stores.StoreModel.fromJson(jsonObject).message!),
            backgroundColor: Colors.redAccent));
      } else if (stores.StoreModel.fromJson(jsonObject).data == null) {
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
    category = getCategory();
    category!.then((value) {
      setState(() {
        categorylist = value.data!;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            key: _scaffoldKey,
            backgroundColor: ColorConstant.whiteA700,
            drawer: SidebarMenuDraweritem(widget.data),
            appBar: CustomAppBar(
                height: getVerticalSize(90),
                leadingWidth: 41,
                leading: AppbarImage(
                    onTap: () {
                      _scaffoldKey.currentState!.openDrawer();
                    },
                    height: getVerticalSize(15),
                    width: getHorizontalSize(15),
                    svgPath: ImageConstant.imgMenu,
                    margin: getMargin(left: 20, top: 10, bottom: 17)),
                title: CustomAppbarTitle(
                    height: getVerticalSize(32),
                    width: getHorizontalSize(106),
                    imagePath: ImageConstant.imgFinallogo03,
                    margin: getMargin(left: 13, top: 0, bottom: 15)),
                actions: [
                  AppbarImage(
                      height: getSize(21),
                      width: getSize(21),
                      svgPath: ImageConstant.imgSearch,
                      margin:
                          getMargin(left: 12, top: 0, right: 10, bottom: 10),
                      onTap: onTapSearch),
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
                                screen: WhislistScreen(widget.data),
                                withNavBar:
                                    false, // OPTIONAL VALUE. True by default.
                                pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino,
                              );
                            }),
                        // AppbarSubtitle6(
                        //     text: widget.cart_count,
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
                                screen: CartScreen(widget.data),
                                withNavBar:
                                    false, // OPTIONAL VALUE. True by default.
                                pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino,
                              );
                              // Navigator.of(context).push(MaterialPageRoute(
                              //   builder: (context) => CartScreen(widget.data),
                              // ));
                            },
                            height: getVerticalSize(20),
                            width: getHorizontalSize(23),
                            svgPath: ImageConstant.imgCart,
                            margin: getMargin(top: 4, right: 6)),
                        AppbarSubtitle6(
                            text: CartScreen.count.toString(),
                            margin: getMargin(left: 17, bottom: 13))
                      ]))
                ],
                styleType: Style.bgShadowBlack90033),
            body: ListView.builder(
                itemCount: categorylist.length,
                itemBuilder: (context, index) {
                  return Container(
                      width: double.maxFinite,
                      padding: getPadding(bottom: 21),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                // Navigator.pushNamed(context, AppRoutes.clickAfterSlectTabFurnitureScreen);
                                categorylist[index].subCategory!.length == 0
                                    ? pushScreen(
                                        context,
                                        screen: NewProductScreen(
                                          widget.data,
                                          categorylist[index],
                                        ),
                                        withNavBar:
                                            true, // OPTIONAL VALUE. True by default.
                                        pageTransitionAnimation:
                                            PageTransitionAnimation.cupertino,
                                      )
                                    : pushScreen(
                                        context,
                                        screen:
                                            ClickAfterSlectTabFurnitureScreen(
                                          widget.data,
                                          categorylist[index],
                                          categorylist[index].name!,
                                        ),
                                        withNavBar:
                                            true, // OPTIONAL VALUE. True by default.
                                        pageTransitionAnimation:
                                            PageTransitionAnimation.cupertino,
                                      );
                                // if(categorylist[index].subCategory.length!=0){
                                //   pushScreen(
                                //     context,
                                //     screen: SelectProductScreen(),
                                //     withNavBar: true, // OPTIONAL VALUE. True by default.
                                //     pageTransitionAnimation: PageTransitionAnimation.cupertino,
                                //   );
                                // }else{
                                //   pushScreen(
                                //     context,
                                //     screen: ClickAfterSlectTabFurnitureScreen(widget.data,categorylist[index].id,categorylist[index].name),
                                //     withNavBar: true, // OPTIONAL VALUE. True by default.
                                //     pageTransitionAnimation: PageTransitionAnimation.cupertino,
                                //   );
                                // }
                                // pushScreen(
                                //   context,
                                //   screen: ClickAfterSlectTabFurnitureScreen(widget.data,categorylist[index].id,categorylist[index].name),
                                //   withNavBar: true, // OPTIONAL VALUE. True by default.
                                //   pageTransitionAnimation: PageTransitionAnimation.cupertino,
                                // );
                                // onTapTxtFurniture();
                              },
                              child: Container(
                                child: Padding(
                                    padding: getPadding(left: 31, right: 40),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(categorylist[index].name!,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: AppStyle
                                                  .txtRobotoRegular12Black900
                                                  .copyWith(
                                                      letterSpacing:
                                                          getHorizontalSize(
                                                              1.8))),
                                          GestureDetector(
                                            onTap: () {
                                              categorylist[index]
                                                          .subCategory!
                                                          .length ==
                                                      0
                                                  ? pushScreen(
                                                      context,
                                                      screen: NewProductScreen(
                                                        widget.data,
                                                        categorylist[index],
                                                      ),
                                                      withNavBar:
                                                          true, // OPTIONAL VALUE. True by default.
                                                      pageTransitionAnimation:
                                                          PageTransitionAnimation
                                                              .cupertino,
                                                    )
                                                  : pushScreen(
                                                      context,
                                                      screen:
                                                          ClickAfterSlectTabFurnitureScreen(
                                                        widget.data,
                                                        categorylist[index],
                                                        categorylist[index]
                                                            .name!,
                                                      ),
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
                                                  width: getHorizontalSize(20),
                                                  margin: getMargin(
                                                      top: 2, bottom: 2)),
                                            ),
                                          )
                                        ])),
                              ),
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
                })));
  }

  onTapSearch() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => SearchScreen(widget.data, ''),
    ));
  }

  onTapLocation() {
    Get.toNamed(AppRoutes.whislistScreen);
  }

  onTapTxtFurniture() {
    Get.toNamed(AppRoutes.clickAfterSlectTabFurnitureScreen);
  }
}
