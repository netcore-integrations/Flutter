import 'dart:convert';

import 'package:animated_shimmer/animated_shimmer.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keshav_s_application2/presentation/cart_screen/cart_screen.dart';
import 'package:keshav_s_application2/presentation/click_after_slect_tab_furniture_screen/click_after_slect_tab_furniture_screen.dart';
import 'package:keshav_s_application2/presentation/home_screen/models/HomeModel.dart'
    as homes;
import 'package:keshav_s_application2/presentation/otp_screen/models/otp_model.dart';
import 'package:keshav_s_application2/presentation/product_detail_screen/product_detail_screen.dart';
import 'package:keshav_s_application2/presentation/select_product_screen/productlistafterclickionbanner.dart';
import 'package:keshav_s_application2/presentation/sidebar_menu_draweritem/sidebar_menu_draweritem.dart';
import 'package:keshav_s_application2/presentation/store_screen/store_screen.dart';
import 'package:keshav_s_application2/presentation/whislist_screen/whislist_screen.dart';
import 'package:keshav_s_application2/screenwithoutlogin/productdetailscreen1.dart';
import 'package:keshav_s_application2/screenwithoutlogin/productlistafterclickonbanner1.dart';
import 'package:keshav_s_application2/screenwithoutlogin/searchscreen1.dart';
import 'package:keshav_s_application2/screenwithoutlogin/sidebarmenu.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:carousel_slider/carousel_slider.dart' as carousel;

import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as fs;
import 'package:keshav_s_application2/core/app_export.dart';
import 'package:keshav_s_application2/widgets/app_bar/appbar_image.dart';
import 'package:keshav_s_application2/widgets/app_bar/appbar_subtitle_6.dart';
import 'package:keshav_s_application2/widgets/app_bar/custom_app_bar.dart';
import 'dart:convert';
import 'package:keshav_s_application2/presentation/store_screen/models/StoreModel.dart'
    as stores;

import 'package:dio/dio.dart' as dio;
import 'package:smartech_base/smartech_base.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../presentation/log_in_screen/log_in_screen.dart';
import '../widgets/app_bar/appbar_title.dart';
import 'ClickAfterSlectTabFurnitureScreen1.dart';
import 'NewProductScreen1.dart';

class HomeScreen1 extends StatefulWidget {
  @override
  State<HomeScreen1> createState() => _HomeScreen1State();
}

class _HomeScreen1State extends State<HomeScreen1> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Future<homes.HomeModel>? home;
  List<homes.HomeData> homelist = [];
  List<homes.Banners> banners = [];
  List<homes.BannersResPortrait> bannersresportrait = [];
  List<homes.FavouriteProduct> favouriteProduct = [];
  List<homes.Bannerswow> bannerswow = [];
  List<homes.BannersgoodLooks> bannersgoodLooks = [];
  List<homes.BannersBrothers> bannersBrothers = [];
  String? facebook;
  String? instagram;
  String? twitter;
  Future<stores.StoreModel>? category;
  List<stores.StoreData> categorylist = [];

  Future<stores.StoreModel> getCategory() async {
    Map data = {
      // 'user_id': widget.data.id,
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

  Future<homes.HomeModel> getdashboard() async {
    Map data = {
      // 'user_id': widget.data.id,
    };
    //encode Map to JSON
    var body = json.encode(data);
    var response =
        await dio.Dio().post("https://fabfurni.com/api/Webservice/dashboard",
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

      if (homes.HomeModel.fromJson(jsonObject).status == "true") {
        // print(orders.MyOrdersModel.fromJson(jsonObject).data.first.products.first.image);

        return homes.HomeModel.fromJson(jsonObject);

        // inviteList.sort((a, b) => a.id.compareTo(b.id));
      } else if (homes.HomeModel.fromJson(jsonObject).status == "false") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(homes.HomeModel.fromJson(jsonObject).message!),
            backgroundColor: Colors.redAccent));
      } else if (homes.HomeModel.fromJson(jsonObject).data == null) {
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
    home = getdashboard();
    category = getCategory();
    category!.then((value) {
      setState(() {
        categorylist = value.data!;
      });
    });
    home!.then((value) {
      setState(() {
        homelist = value.data!;
        banners = value.banners!;
        bannersresportrait = value.bannersResPortrait!;
        favouriteProduct = value.favouriteProduct!;
        bannerswow = value.bannerswow!;
        bannersgoodLooks = value.bannersgoodLooks!;
        bannersBrothers = value.bannersBrothers!;
        facebook = value.links!.facebook!;
        instagram = value.links!.instagram!;
        twitter = value.links!.tweeter!;
      });
    });

    super.initState();
  }

  List images = [
    ImageConstant.imgSofa,
    ImageConstant.imgTvstand,
    ImageConstant.imgBed,
    ImageConstant.imgBabybed,
    ImageConstant.imgMattress,
    ImageConstant.imgCurtain,
    ImageConstant.imgSpiderplant,
    ImageConstant.imgMicrowave,
    ImageConstant.imgWardrobe
  ];
  List imagesName = [
    "Sofa",
    "TV",
    "Bed",
    "Baby Bed",
    "Mattress",
    "Curtain",
    "Plant",
    "Microwave",
    "Wardrobe"
  ];

  int silderIndex = 0;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool? isLoggedIn = prefs.getBool("isLoggedIn");
      print(isLoggedIn);
      Smartech().trackEvent("home_page", {"login":isLoggedIn});
    });
    double baseWidth = 428;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
            backgroundColor: ColorConstant.purple50,
            drawer: SidebarMenu(),
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
            body: RefreshIndicator(
               key: ValueKey("anything_hsl_ignore"),
              color: Colors.purple,
              onRefresh: () async {
                home = getdashboard();
                category = getCategory();
                category!.then((value) {
                  setState(() {
                    categorylist = value.data!;
                  });
                });
                home!.then((value) {
                  setState(() {
                    homelist = value.data!;
                    banners = value.banners!;
                    bannersresportrait = value.bannersResPortrait!;
                    favouriteProduct = value.favouriteProduct!;
                    bannerswow = value.bannerswow!;
                    bannersgoodLooks = value.bannersgoodLooks!;
                    bannersBrothers = value.bannersBrothers!;
                    facebook = value.links!.facebook;
                    instagram = value.links!.instagram;
                    twitter = value.links!.tweeter;
                  });
                });
              },
              child: SingleChildScrollView(
                  child: Column(
                    children: [
                Container(
                  // change your height based on preference
                  height: 60,
                  padding: EdgeInsets.only(right: 10),
                  width: double.infinity,
                  child: ListView.separated(
                      // set the scroll direction to horizontal
                      itemCount: images.length,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, int) {
                        return SizedBox(
                          width: 15,
                        );
                      },
                      itemBuilder: (context, index) {
                        return CategoryCard(
                            title: imagesName[index],
                            previewImageAsset: images[index],
                            onTap: () {
                              // print(homelist[index].id);
                              categorylist[index].subCategory!.length != 0
                                  ? pushScreen(
                                      context,
                                      screen: NewProductScreen1(
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
                                          ClickAfterSlectTabFurnitureScreen1(
                                        categorylist[index],
                                        categorylist[index].name!,
                                      ),
                                      withNavBar:
                                          true, // OPTIONAL VALUE. True by default.
                                      pageTransitionAnimation:
                                          PageTransitionAnimation.cupertino,
                                    );
                              // categorylist[index].subCategory.length == 0
                              //     ? pushScreen(
                              //   context,
                              //   screen: NewProductScreen1(
                              //     categorylist[index],
                              //   ),
                              //   withNavBar:
                              //   true, // OPTIONAL VALUE. True by default.
                              //   pageTransitionAnimation:
                              //   PageTransitionAnimation.cupertino,
                              // )
                              //     : pushScreen(
                              //   context,
                              //   screen: ClickAfterSlectTabFurnitureScreen1(
                              //     categorylist[index],
                              //     categorylist[index].name,
                              //     // categorylist[index].subCategory[index]
                              //   ),
                              //   withNavBar:
                              //   true, // OPTIONAL VALUE. True by default.
                              //   pageTransitionAnimation:
                              //   PageTransitionAnimation.cupertino,
                              // );
                              // pushScreen(
                              //   context,
                              //   screen: ClickAfterSlectTabFurnitureScreen(widget.data),
                              //   withNavBar: true, // OPTIONAL VALUE. True by default.
                              //   pageTransitionAnimation: PageTransitionAnimation.cupertino,
                              // );
                              // Get.toNamed(AppRoutes.clickAfterSlectTabFurnitureScreen);
                            });
                      }
                      // CategoryCard(
                      //     title: 'Furniture',
                      //     previewImageAsset: ImageConstant.imgSofa,
                      //     onTap: () {
                      //       pushScreen(
                      //         context,
                      //         screen: ClickAfterSlectTabFurnitureScreen(widget.data),
                      //         withNavBar: true, // OPTIONAL VALUE. True by default.
                      //         pageTransitionAnimation: PageTransitionAnimation.cupertino,
                      //       );
                      //       // Get.toNamed(AppRoutes.clickAfterSlectTabFurnitureScreen);
                      //     }),
                      // // space them using a sized box
                      // SizedBox(
                      //   width: 15,
                      // ),
                      // CategoryCard(
                      //     title: 'Living',
                      //     previewImageAsset: ImageConstant.imgTvstand,
                      //     onTap: () {}),
                      // SizedBox(
                      //   width: 15,
                      // ),
                      // CategoryCard(
                      //     title: 'Bedroom',
                      //     previewImageAsset: ImageConstant.imgBed,
                      //     onTap: () {}),
                      // SizedBox(
                      //   width: 15,
                      // ),
                      // CategoryCard(
                      //     title: 'Kids Room',
                      //     previewImageAsset: ImageConstant.imgBabybed,
                      //     onTap: () {}),
                      // SizedBox(
                      //   width: 15,
                      // ),
                      // CategoryCard(
                      //     title: 'Mattresses',
                      //     previewImageAsset: ImageConstant.imgMattress,
                      //     onTap: () {}),
                      // SizedBox(
                      //   width: 15,
                      // ),
                      // CategoryCard(
                      //     title: 'Furnishings',
                      //     previewImageAsset: ImageConstant.imgCurtain,
                      //     onTap: () {}),
                      // SizedBox(
                      //   width: 15,
                      // ),
                      // CategoryCard(
                      //     title: 'Decor',
                      //     previewImageAsset: ImageConstant.imgSpiderplant,
                      //     onTap: () {}),
                      // SizedBox(
                      //   width: 15,
                      // ),
                      // CategoryCard(
                      //     title: 'Lighting',
                      //     previewImageAsset: 'assets/images/vector-cH4.png',
                      //     onTap: () {}),
                      // SizedBox(
                      //   width: 15,
                      // ),
                      // CategoryCard(
                      //     title: 'Appliances',
                      //     previewImageAsset: ImageConstant.imgMicrowave,
                      //     onTap: () {}),
                      // SizedBox(
                      //   width: 15,
                      // ),
                      // CategoryCard(
                      //     title: 'Modular Furniture',
                      //     previewImageAsset: ImageConstant.imgWardrobe,
                      //     onTap: () {}),
                      // SizedBox(
                      //   width: 15,
                      // ),

                      ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    color: ColorConstant.whiteA700,
                    width: double.maxFinite,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // SingleChildScrollView(
                          //     scrollDirection: Axis.horizontal,
                          //     child: IntrinsicWidth(
                          //         child: Container(
                          //             height: getVerticalSize(125),
                          //             width: double.maxFinite,
                          //             child: Stack(
                          //                 alignment: Alignment.topRight,
                          //                 children: [
                          //                   Align(
                          //                       alignment: Alignment.center,
                          //                       child: Container(
                          //                           padding: getPadding(
                          //                               left: 21,
                          //                               top: 14,
                          //                               right: 21,
                          //                               bottom: 14),
                          //                           decoration: AppDecoration
                          //                               .fillPurple5001,
                          //                           child: Column(
                          //                               mainAxisSize:
                          //                                   MainAxisSize.min,
                          //                               mainAxisAlignment:
                          //                                   MainAxisAlignment.end,
                          //                               children: [
                          //                                 Padding(
                          //                                     padding: getPadding(
                          //                                         left: 6, top: 56),
                          //                                     child: Row(
                          //                                         mainAxisAlignment:
                          //                                             MainAxisAlignment
                          //                                                 .center,
                          //                                         children: [
                          //                                           Padding(
                          //                                               padding: getPadding(
                          //                                                   bottom:
                          //                                                       1),
                          //                                               child: Text(
                          //                                                   "lbl_furniture"
                          //                                                       .tr,
                          //                                                   overflow:
                          //                                                       TextOverflow
                          //                                                           .ellipsis,
                          //                                                   textAlign:
                          //                                                       TextAlign
                          //                                                           .left,
                          //                                                   style: AppStyle
                          //                                                       .txtRobotoRegular12Black900)),
                          //                                           Padding(
                          //                                               padding: getPadding(
                          //                                                   left:
                          //                                                       41,
                          //                                                   top: 1),
                          //                                               child: Text(
                          //                                                   "lbl_living"
                          //                                                       .tr,
                          //                                                   overflow:
                          //                                                       TextOverflow
                          //                                                           .ellipsis,
                          //                                                   textAlign:
                          //                                                       TextAlign
                          //                                                           .left,
                          //                                                   style: AppStyle
                          //                                                       .txtRobotoRegular12Black900)),
                          //                                           Padding(
                          //                                               padding: getPadding(
                          //                                                   left:
                          //                                                       40,
                          //                                                   bottom:
                          //                                                       1),
                          //                                               child: Text(
                          //                                                   "lbl_bedroom"
                          //                                                       .tr,
                          //                                                   overflow:
                          //                                                       TextOverflow
                          //                                                           .ellipsis,
                          //                                                   textAlign:
                          //                                                       TextAlign
                          //                                                           .left,
                          //                                                   style: AppStyle
                          //                                                       .txtRobotoRegular12Black900)),
                          //                                           Padding(
                          //                                               padding: getPadding(
                          //                                                   left:
                          //                                                       28,
                          //                                                   bottom:
                          //                                                       1),
                          //                                               child: Text(
                          //                                                   "lbl_kids_room"
                          //                                                       .tr,
                          //                                                   overflow:
                          //                                                       TextOverflow
                          //                                                           .ellipsis,
                          //                                                   textAlign:
                          //                                                       TextAlign
                          //                                                           .left,
                          //                                                   style: AppStyle
                          //                                                       .txtRobotoRegular12Black900)),
                          //                                           Padding(
                          //                                               padding: getPadding(
                          //                                                   left:
                          //                                                       23,
                          //                                                   bottom:
                          //                                                       1),
                          //                                               child: Text(
                          //                                                   "lbl_mattresses"
                          //                                                       .tr,
                          //                                                   overflow:
                          //                                                       TextOverflow
                          //                                                           .ellipsis,
                          //                                                   textAlign:
                          //                                                       TextAlign
                          //                                                           .left,
                          //                                                   style: AppStyle
                          //                                                       .txtRobotoRegular12Black900))
                          //                                         ])),
                          //                                 Padding(
                          //                                     padding: getPadding(
                          //                                         top: 15),
                          //                                     child: Row(
                          //                                         mainAxisAlignment:
                          //                                             MainAxisAlignment
                          //                                                 .center,
                          //                                         children: [
                          //                                           Container(
                          //                                               height:
                          //                                                   getSize(
                          //                                                       9),
                          //                                               width:
                          //                                                   getSize(
                          //                                                       9),
                          //                                               decoration: BoxDecoration(
                          //                                                   color: ColorConstant
                          //                                                       .purple900,
                          //                                                   borderRadius:
                          //                                                       BorderRadius.circular(getHorizontalSize(4)))),
                          //                                           Container(
                          //                                               height:
                          //                                                   getSize(
                          //                                                       9),
                          //                                               width:
                          //                                                   getSize(
                          //                                                       9),
                          //                                               margin: getMargin(
                          //                                                   left:
                          //                                                       10),
                          //                                               decoration: BoxDecoration(
                          //                                                   color: ColorConstant
                          //                                                       .gray50001,
                          //                                                   borderRadius:
                          //                                                       BorderRadius.circular(getHorizontalSize(4))))
                          //                                         ]))
                          //                               ]))),
                          //                   Align(
                          //                       alignment: Alignment.topRight,
                          //                       child: Padding(
                          //                           padding: getPadding(top: 20),
                          //                           child: Row(
                          //                               mainAxisAlignment:
                          //                                   MainAxisAlignment.end,
                          //                               mainAxisSize:
                          //                                   MainAxisSize.min,
                          //                               children: [
                          //                                 CustomImageView(
                          //                                     imagePath:
                          //                                         ImageConstant
                          //                                             .imgSofa,
                          //                                     height: getSize(40),
                          //                                     width: getSize(40),
                          //                                     margin:
                          //                                         getMargin(top: 3),
                          //                                     onTap: () {
                          //                                       onTapImgSofa();
                          //                                     }),
                          //                                 CustomImageView(
                          //                                     imagePath:
                          //                                         ImageConstant
                          //                                             .imgTvstand,
                          //                                     height: getSize(40),
                          //                                     width: getSize(40),
                          //                                     margin: getMargin(
                          //                                         left: 41,
                          //                                         top: 1,
                          //                                         bottom: 2)),
                          //                                 CustomImageView(
                          //                                     imagePath:
                          //                                         ImageConstant
                          //                                             .imgBed,
                          //                                     height: getSize(40),
                          //                                     width: getSize(40),
                          //                                     margin: getMargin(
                          //                                         left: 41,
                          //                                         top: 2,
                          //                                         bottom: 1)),
                          //                                 CustomImageView(
                          //                                     imagePath:
                          //                                         ImageConstant
                          //                                             .imgBabybed,
                          //                                     height: getSize(40),
                          //                                     width: getSize(40),
                          //                                     margin: getMargin(
                          //                                         left: 41,
                          //                                         bottom: 3)),
                          //                                 CustomImageView(
                          //                                     imagePath:
                          //                                         ImageConstant
                          //                                             .imgMattress,
                          //                                     height: getSize(40),
                          //                                     width: getSize(40),
                          //                                     margin: getMargin(
                          //                                         left: 41,
                          //                                         bottom: 3)),
                          //                                 CustomImageView(
                          //                                     imagePath:
                          //                                         ImageConstant
                          //                                             .imgCurtain,
                          //                                     height: getSize(40),
                          //                                     width: getSize(40),
                          //                                     margin: getMargin(
                          //                                         left: 41,
                          //                                         bottom: 3)),
                          //                                 CustomImageView(
                          //                                     imagePath: ImageConstant
                          //                                         .imgSpiderplant,
                          //                                     height: getSize(40),
                          //                                     width: getSize(40),
                          //                                     margin: getMargin(
                          //                                         left: 41,
                          //                                         bottom: 3)),
                          //                                 CustomImageView(
                          //                                     svgPath: ImageConstant
                          //                                         .imgUser,
                          //                                     height: getSize(40),
                          //                                     width: getSize(40),
                          //                                     margin: getMargin(
                          //                                         left: 41,
                          //                                         bottom: 3)),
                          //                                 CustomImageView(
                          //                                     imagePath:
                          //                                         ImageConstant
                          //                                             .imgMicrowave,
                          //                                     height: getSize(40),
                          //                                     width: getSize(40),
                          //                                     margin: getMargin(
                          //                                         left: 41,
                          //                                         top: 3)),
                          //                                 CustomImageView(
                          //                                     imagePath:
                          //                                         ImageConstant
                          //                                             .imgWardrobe,
                          //                                     height: getSize(40),
                          //                                     width: getSize(40),
                          //                                     margin: getMargin(
                          //                                         left: 41,
                          //                                         bottom: 3))
                          //                               ])))
                          //                 ])))),
                          SizedBox(
                            height: 8,
                          ),
                         // banners.length != 0
                              //?
                    Container(
                                  //height: 100,
                                  // width: 200.w,
                                  padding: getPadding(left: 10, right: 10),
                                  // color: Colors.black,
                                  child: carousel.CarouselSlider.builder(
                                      options: carousel.CarouselOptions(
                                        //height: getVerticalSize(215),
                                        initialPage: 0,
                                        autoPlay: true,
                                        viewportFraction: 1.0,
                                        enableInfiniteScroll: true,
                                        autoPlayCurve: Curves.fastOutSlowIn,
                                        scrollDirection: Axis.horizontal,
                                        onPageChanged: (index, reason) {
                                          silderIndex = index;
                                        },
                                        // onScrolled: (index) {
                                        //   controller.silderIndex.value =
                                        //       index as int;
                                        // }
                                      ),
                                      itemCount: 3,
                                      //banners.length,
                                      itemBuilder: (context, index, realIndex) {
                                        // SliderItemModel model = controller
                                        //     .productDetailModelObj
                                        //     .value
                                        //     .sliderItemList[index];
                                        return GestureDetector(
                                          onTap: () {
                                            if (banners[index].keywordId ==
                                                    '0' ||
                                                banners[index].keywordId ==
                                                    null) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      content: Text("No Data"),
                                                      backgroundColor:
                                                          Colors.redAccent));
                                            } else {
                                              Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                                builder: (context) =>
                                                    productlisrafterclickonbanner1(
                                                        banners[index]
                                                            .keywordId!,
                                                        '',
                                                        '',
                                                        ''),
                                              ));
                                            }
                                          },
                                          child: Image.asset(
                                            //banners[index].image!,
                                            "assets/images/img_image14_215x428.png",
                                            fit: BoxFit.cover,
                                            width: 95.w,
                                            alignment: Alignment(1.2, 1.2),
                                            filterQuality: FilterQuality.high,
                                            // loadingBuilder: (context, child,
                                            //         loadingProgress) =>
                                            //     (loadingProgress == null)
                                            //         ? child
                                            //         : AnimatedShimmer(
                                            //             height: 206,
                                            //             width: 100.w,
                                            //             borderRadius:
                                            //                 const BorderRadius
                                            //                     .all(
                                            //                     Radius.circular(
                                            //                         10)),
                                            //             delayInMilliSeconds:
                                            //                 Duration(
                                            //                     milliseconds:
                                            //                         index * 5),
                                            //           ),
                                            // CircularProgressIndicator(
                                            //         color: Color(0xff9BA6BF),
                                            //         strokeWidth: 2,
                                            //       ),
                                            errorBuilder: (context, error,
                                                    stackTrace) =>
                                                Image.asset(
                                                    "assets/images/image_not_found.png"),
                                          ),
                                        );
                                        // SliderItemWidget(model);
                                      })
                                  // ListView.separated(
                                  //   // set the scroll direction to horizontal
                                  //     itemCount: banners.length,
                                  //     scrollDirection: Axis.horizontal,
                                  //     separatorBuilder: (context, int) {
                                  //       return Padding(
                                  //         padding: EdgeInsets.fromLTRB(5,0, 5, 0),
                                  //       );
                                  //     },
                                  //     itemBuilder: (context, index) {
                                  //       // return
                                  //       //   SvgPicture.network(banners[index].image);
                                  //       return GestureDetector(
                                  //         onTap: (){
                                  //           if(banners[index].keywordId=='0' || banners[index].keywordId==null){
                                  //             ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  //                 content: Text("No Data"),
                                  //                 backgroundColor: Colors.redAccent));
                                  //           }else{
                                  //             Navigator.of(context).push(MaterialPageRoute(
                                  //               builder: (context) => productlisrafterclickonbanner1(banners[index].keywordId,'','',''),
                                  //             ));}
                                  //         },
                                  //         child: Image.network(
                                  //           banners[index].image,
                                  //           fit: BoxFit.cover,
                                  //           width: 95.w,
                                  //           alignment: Alignment(1.2, 1.2),
                                  //           filterQuality: FilterQuality.high,
                                  //           loadingBuilder:
                                  //               (context, child, loadingProgress) =>
                                  //           (loadingProgress == null)
                                  //               ? child
                                  //               : AnimatedShimmer(
                                  //             height: 206,
                                  //             width: 100.w,
                                  //             borderRadius: const BorderRadius.all(Radius.circular(10)),
                                  //             delayInMilliSeconds: Duration(milliseconds: index * 500),
                                  //           ),
                                  //           // CircularProgressIndicator(
                                  //           //         color: Color(0xff9BA6BF),
                                  //           //         strokeWidth: 2,
                                  //           //       ),
                                  //           errorBuilder: (context, error, stackTrace) =>
                                  //               Image.asset(
                                  //                   "assets/images/image_not_found.png"),
                                  //         ),
                                  //       );
                                  //       // return CustomImageView(
                                  //       //     onTap: (){
                                  //       //       pushScreen(
                                  //       //         context,
                                  //       //         screen: StoreScreen(widget.data),
                                  //       //         withNavBar: true, // OPTIONAL VALUE. True by default.
                                  //       //         pageTransitionAnimation: PageTransitionAnimation.cupertino,
                                  //       //       );
                                  //       //     },
                                  //       //     url:"https://fabfurni.com/assets/uploads/1682784086decore-icon_2_.svg",
                                  //       //     // ImageConstant.imgFurnituresocialmediabanner,
                                  //       //     // height: getVerticalSize(206),
                                  //       //     // width: getHorizontalSize(396),
                                  //       //     margin: getMargin(top: 13,left: 10));
                                  //     }
                                  //   // CategoryCard(
                                  //   //     title: 'Furniture',
                                  //   //     previewImageAsset: ImageConstant.imgSofa,
                                  //   //     onTap: () {
                                  //   //       pushScreen(
                                  //   //         context,
                                  //   //         screen: ClickAfterSlectTabFurnitureScreen(widget.data),
                                  //   //         withNavBar: true, // OPTIONAL VALUE. True by default.
                                  //   //         pageTransitionAnimation: PageTransitionAnimation.cupertino,
                                  //   //       );
                                  //   //       // Get.toNamed(AppRoutes.clickAfterSlectTabFurnitureScreen);
                                  //   //     }),
                                  //   // // space them using a sized box
                                  //   // SizedBox(
                                  //   //   width: 15,
                                  //   // ),
                                  //   // CategoryCard(
                                  //   //     title: 'Living',
                                  //   //     previewImageAsset: ImageConstant.imgTvstand,
                                  //   //     onTap: () {}),
                                  //   // SizedBox(
                                  //   //   width: 15,
                                  //   // ),
                                  //   // CategoryCard(
                                  //   //     title: 'Bedroom',
                                  //   //     previewImageAsset: ImageConstant.imgBed,
                                  //   //     onTap: () {}),
                                  //   // SizedBox(
                                  //   //   width: 15,
                                  //   // ),
                                  //   // CategoryCard(
                                  //   //     title: 'Kids Room',
                                  //   //     previewImageAsset: ImageConstant.imgBabybed,
                                  //   //     onTap: () {}),
                                  //   // SizedBox(
                                  //   //   width: 15,
                                  //   // ),
                                  //   // CategoryCard(
                                  //   //     title: 'Mattresses',
                                  //   //     previewImageAsset: ImageConstant.imgMattress,
                                  //   //     onTap: () {}),
                                  //   // SizedBox(
                                  //   //   width: 15,
                                  //   // ),
                                  //   // CategoryCard(
                                  //   //     title: 'Furnishings',
                                  //   //     previewImageAsset: ImageConstant.imgCurtain,
                                  //   //     onTap: () {}),
                                  //   // SizedBox(
                                  //   //   width: 15,
                                  //   // ),
                                  //   // CategoryCard(
                                  //   //     title: 'Decor',
                                  //   //     previewImageAsset: ImageConstant.imgSpiderplant,
                                  //   //     onTap: () {}),
                                  //   // SizedBox(
                                  //   //   width: 15,
                                  //   // ),
                                  //   // CategoryCard(
                                  //   //     title: 'Lighting',
                                  //   //     previewImageAsset: 'assets/images/vector-cH4.png',
                                  //   //     onTap: () {}),
                                  //   // SizedBox(
                                  //   //   width: 15,
                                  //   // ),
                                  //   // CategoryCard(
                                  //   //     title: 'Appliances',
                                  //   //     previewImageAsset: ImageConstant.imgMicrowave,
                                  //   //     onTap: () {}),
                                  //   // SizedBox(
                                  //   //   width: 15,
                                  //   // ),
                                  //   // CategoryCard(
                                  //   //     title: 'Modular Furniture',
                                  //   //     previewImageAsset: ImageConstant.imgWardrobe,
                                  //   //     onTap: () {}),
                                  //   // SizedBox(
                                  //   //   width: 15,
                                  //   // ),
                                  //
                                  // ),
                                  ),
                             // : Container(),
                          SizedBox(
                            height: 2.h,
                          ),
                          Container(
                            height: 206,
                            // width: 200.w,
                            // color: Colors.black,
                            padding: getPadding(left: 10, right: 10),
                            child: ListView.separated(
                                // set the scroll direction to horizontal
                                itemCount:3,
                               // bannersresportrait.length,
                                scrollDirection: Axis.horizontal,
                                separatorBuilder: (context, int) {
                                  return Padding(
                                    padding: getPadding(left: 10, right: 10),
                                  );
                                },
                                itemBuilder: (context, index) {
                                  // return
                                  //   SvgPicture.network(banners[index].image);
                                  return GestureDetector(
                                    onTap: () {
                                      if (bannersresportrait[index].keywordId ==
                                              '0' ||
                                          bannersresportrait[index].keywordId ==
                                              null) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text("No Data"),
                                                backgroundColor:
                                                    Colors.redAccent));
                                      } else {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) =>
                                              productlisrafterclickonbanner1(
                                                  bannersresportrait[index]
                                                      .keywordId!,
                                                  '',
                                                  '',
                                                  ''),
                                        ));
                                      }
                                      // print("tapped");
                                      // Navigator.of(context).push(MaterialPageRoute(
                                      //   builder: (context) => ProductDetailScreen(widget.data,bannersresportrait[index].id),
                                      // ));
                                    },
                                    child: Container(
                                      width: 250,
                                      // height: 200,
                                      // color: Colors.black,
                                      child: Image.asset(
                                        "assets/images/img_image1.png",
                                        //bannersresportrait[index].image!,
                                        fit: BoxFit.cover,
                                        // width: 100.w,
                                        // height: 100.h,
                                        alignment: Alignment(0.8, 0.8),
                                        filterQuality: FilterQuality.high,
                                        // loadingBuilder: (context, child,
                                        //         loadingProgress) =>
                                        //     (loadingProgress == null)
                                        //         ? child
                                        //         : AnimatedShimmer(
                                        //             height: 206,
                                        //             width: 250,
                                        //             borderRadius:
                                        //                 const BorderRadius.all(
                                        //                     Radius.circular(
                                        //                         10)),
                                        //             delayInMilliSeconds:
                                        //                 Duration(
                                        //                     milliseconds:
                                        //                         index * 5),
                                        //           ),
                                        errorBuilder: (context, error,
                                                stackTrace) =>
                                            Image.asset(
                                                "assets/images/image_not_found.png"),
                                      ),
                                    ),
                                  );
                                  // return CustomImageView(
                                  //     onTap: (){
                                  //       pushScreen(
                                  //         context,
                                  //         screen: StoreScreen(widget.data),
                                  //         withNavBar: true, // OPTIONAL VALUE. True by default.
                                  //         pageTransitionAnimation: PageTransitionAnimation.cupertino,
                                  //       );
                                  //     },
                                  //     url:"https://fabfurni.com/assets/uploads/1682784086decore-icon_2_.svg",
                                  //     // ImageConstant.imgFurnituresocialmediabanner,
                                  //     // height: getVerticalSize(206),
                                  //     // width: getHorizontalSize(396),
                                  //     margin: getMargin(top: 13,left: 10));
                                }
                                // CategoryCard(
                                //     title: 'Furniture',
                                //     previewImageAsset: ImageConstant.imgSofa,
                                //     onTap: () {
                                //       pushScreen(
                                //         context,
                                //         screen: ClickAfterSlectTabFurnitureScreen(widget.data),
                                //         withNavBar: true, // OPTIONAL VALUE. True by default.
                                //         pageTransitionAnimation: PageTransitionAnimation.cupertino,
                                //       );
                                //       // Get.toNamed(AppRoutes.clickAfterSlectTabFurnitureScreen);
                                //     }),
                                // // space them using a sized box
                                // SizedBox(
                                //   width: 15,
                                // ),
                                // CategoryCard(
                                //     title: 'Living',
                                //     previewImageAsset: ImageConstant.imgTvstand,
                                //     onTap: () {}),
                                // SizedBox(
                                //   width: 15,
                                // ),
                                // CategoryCard(
                                //     title: 'Bedroom',
                                //     previewImageAsset: ImageConstant.imgBed,
                                //     onTap: () {}),
                                // SizedBox(
                                //   width: 15,
                                // ),
                                // CategoryCard(
                                //     title: 'Kids Room',
                                //     previewImageAsset: ImageConstant.imgBabybed,
                                //     onTap: () {}),
                                // SizedBox(
                                //   width: 15,
                                // ),
                                // CategoryCard(
                                //     title: 'Mattresses',
                                //     previewImageAsset: ImageConstant.imgMattress,
                                //     onTap: () {}),
                                // SizedBox(
                                //   width: 15,
                                // ),
                                // CategoryCard(
                                //     title: 'Furnishings',
                                //     previewImageAsset: ImageConstant.imgCurtain,
                                //     onTap: () {}),
                                // SizedBox(
                                //   width: 15,
                                // ),
                                // CategoryCard(
                                //     title: 'Decor',
                                //     previewImageAsset: ImageConstant.imgSpiderplant,
                                //     onTap: () {}),
                                // SizedBox(
                                //   width: 15,
                                // ),
                                // CategoryCard(
                                //     title: 'Lighting',
                                //     previewImageAsset: 'assets/images/vector-cH4.png',
                                //     onTap: () {}),
                                // SizedBox(
                                //   width: 15,
                                // ),
                                // CategoryCard(
                                //     title: 'Appliances',
                                //     previewImageAsset: ImageConstant.imgMicrowave,
                                //     onTap: () {}),
                                // SizedBox(
                                //   width: 15,
                                // ),
                                // CategoryCard(
                                //     title: 'Modular Furniture',
                                //     previewImageAsset: ImageConstant.imgWardrobe,
                                //     onTap: () {}),
                                // SizedBox(
                                //   width: 15,
                                // ),

                                ),
                          ),
                          // Padding(
                          //     padding: getPadding(left: 15, top: 22, right: 18),
                          //     child: Row(
                          //         mainAxisAlignment: MainAxisAlignment.center,
                          //         children: [
                          //           CustomImageView(
                          //               onTap: (){
                          //                 pushScreen(
                          //                   context,
                          //                   screen: ClickAfterSlectTabFurnitureScreen(widget.data),
                          //                   withNavBar: true, // OPTIONAL VALUE. True by default.
                          //                   pageTransitionAnimation: PageTransitionAnimation.cupertino,
                          //                 );
                          //               },
                          //               imagePath:
                          //                   ImageConstant.imgDks3bvbvsaaus9p,
                          //               height: getSize(190),
                          //               width: getSize(190)),
                          //           CustomImageView(
                          //               onTap: (){
                          //                 pushScreen(
                          //                   context,
                          //                   screen: ClickAfterSlectTabFurnitureScreen(widget.data),
                          //                   withNavBar: true, // OPTIONAL VALUE. True by default.
                          //                   pageTransitionAnimation: PageTransitionAnimation.cupertino,
                          //                 );
                          //               },
                          //               imagePath:
                          //                   ImageConstant.imgDks3bvbvsaaus9p,
                          //               height: getSize(190),
                          //               width: getSize(190),
                          //               margin: getMargin(left: 15))
                          //         ])),
                          SizedBox(
                            height: 20,
                          ),
                        ])),
                Container(
                    height: getVerticalSize(300),
                    width: double.maxFinite,
                    // margin: getMargin(top: 12),
                    child: Stack(alignment: Alignment.center, children: [
                      // Align(
                      //     alignment: Alignment.bottomCenter,
                      //     child: Container(
                      //         margin: getMargin(
                      //             left: 14, right: 14, bottom: 14),
                      //         padding: getPadding(
                      //             left: 41, top: 6, right: 41, bottom: 6),
                      //         decoration: BoxDecoration(
                      //             image: DecorationImage(
                      //                 image: fs.Svg(
                      //                     ImageConstant.imgGroup203),
                      //                 fit: BoxFit.cover)),
                      //         child: Column(
                      //             mainAxisSize: MainAxisSize.min,
                      //             mainAxisAlignment:
                      //                 MainAxisAlignment.end,
                      //             children: [
                      //               CustomImageView(
                      //                   svgPath: ImageConstant.imgGroup2,
                      //                   height: getVerticalSize(47),
                      //                   width: getHorizontalSize(315),
                      //                   margin: getMargin(top: 11)),
                      //               Padding(
                      //                   padding: getPadding(
                      //                       left: 7, top: 4, right: 4),
                      //                   child: Row(
                      //                       mainAxisAlignment:
                      //                           MainAxisAlignment
                      //                               .spaceBetween,
                      //                       children: [
                      //                         Text("lbl_home".tr,
                      //                             overflow: TextOverflow
                      //                                 .ellipsis,
                      //                             textAlign:
                      //                                 TextAlign.left,
                      //                             style: AppStyle
                      //                                 .txtRobotoMedium8Purple900),
                      //                         Text("lbl_store".tr,
                      //                             overflow: TextOverflow
                      //                                 .ellipsis,
                      //                             textAlign:
                      //                                 TextAlign.left,
                      //                             style: AppStyle
                      //                                 .txtRobotoMedium8),
                      //                         Text("lbl_profile".tr,
                      //                             overflow: TextOverflow
                      //                                 .ellipsis,
                      //                             textAlign:
                      //                                 TextAlign.left,
                      //                             style: AppStyle
                      //                                 .txtRobotoMedium8)
                      //                       ]))
                      //             ]))),
                      // Align(
                      //     alignment: Alignment.center,
                      //     child: Container(
                      //         padding: getPadding(top: 9, bottom: 9),
                      //         decoration: AppDecoration.fillPurple5001,
                      //         child: Column(
                      //             mainAxisSize: MainAxisSize.min,
                      //             mainAxisAlignment:
                      //                 MainAxisAlignment.center,
                      //             children: [
                      //               Padding(
                      //                   padding: getPadding(top: 2),
                      //                   child: Text(
                      //                       "msg_we_re_our_favorite".tr,
                      //                       overflow:
                      //                           TextOverflow.ellipsis,
                      //                       textAlign: TextAlign.left,
                      //                       style: AppStyle
                      //                           .txtRobotoMedium13
                      //                           .copyWith(
                      //                               letterSpacing:
                      //                                   getHorizontalSize(
                      //                                       0.26)))),
                      //               Padding(
                      //                   padding: getPadding(top: 5),
                      //                   child: Text(
                      //                       "msg_produdly_presenting".tr,
                      //                       overflow:
                      //                           TextOverflow.ellipsis,
                      //                       textAlign: TextAlign.left,
                      //                       style: AppStyle
                      //                           .txtRobotoRegular10Purple700
                      //                           .copyWith(
                      //                               letterSpacing:
                      //                                   getHorizontalSize(
                      //                                       0.2)))),
                      //               SingleChildScrollView(
                      //                   scrollDirection: Axis.horizontal,
                      //                   padding:
                      //                       getPadding(left: 16, top: 8),
                      //                   child: IntrinsicWidth(
                      //                       child: Row(
                      //                           mainAxisAlignment:
                      //                               MainAxisAlignment
                      //                                   .center,
                      //                           children: [
                      //                         Container(
                      //                             height: getVerticalSize(
                      //                                 206),
                      //                             width:
                      //                                 getHorizontalSize(
                      //                                     238),
                      //                             padding:
                      //                                 getPadding(all: 11),
                      //                             decoration:
                      //                                 AppDecoration
                      //                                     .fillWhiteA700,
                      //                             child: Stack(children: [
                      //                               CustomImageView(
                      //                                   imagePath:
                      //                                       ImageConstant
                      //                                           .imgImage1,
                      //                                   height:
                      //                                       getVerticalSize(
                      //                                           149),
                      //                                   width:
                      //                                       getHorizontalSize(
                      //                                           216),
                      //                                   alignment:
                      //                                       Alignment
                      //                                           .topCenter)
                      //                             ])),
                      //                         Container(
                      //                             height: getVerticalSize(
                      //                                 206),
                      //                             width:
                      //                                 getHorizontalSize(
                      //                                     238),
                      //                             margin:
                      //                                 getMargin(left: 10),
                      //                             padding:
                      //                                 getPadding(all: 11),
                      //                             decoration:
                      //                                 AppDecoration
                      //                                     .fillWhiteA700,
                      //                             child: Stack(children: [
                      //                               CustomImageView(
                      //                                   imagePath:
                      //                                       ImageConstant
                      //                                           .imgImage1,
                      //                                   height:
                      //                                       getVerticalSize(
                      //                                           149),
                      //                                   width:
                      //                                       getHorizontalSize(
                      //                                           216),
                      //                                   alignment:
                      //                                       Alignment
                      //                                           .topCenter)
                      //                             ]))
                      //                       ])))
                      //             ]))),
                      // Align(
                      //     alignment: Alignment.bottomCenter,
                      //     child: Container(
                      //         margin: getMargin(
                      //             left: 22, right: 6, bottom: 14),
                      //         padding: getPadding(
                      //             left: 41, top: 6, right: 41, bottom: 6),
                      //         decoration: BoxDecoration(
                      //             image: DecorationImage(
                      //                 image: fs.Svg(
                      //                     ImageConstant.imgGroup203),
                      //                 fit: BoxFit.cover)),
                      //         child: Column(
                      //             mainAxisSize: MainAxisSize.min,
                      //             mainAxisAlignment:
                      //                 MainAxisAlignment.end,
                      //             children: [
                      //               CustomImageView(
                      //                   svgPath: ImageConstant.imgGroup2,
                      //                   height: getVerticalSize(47),
                      //                   width: getHorizontalSize(315),
                      //                   margin: getMargin(top: 11)),
                      //               Padding(
                      //                   padding: getPadding(
                      //                       left: 7, top: 4, right: 4),
                      //                   child: Row(
                      //                       mainAxisAlignment:
                      //                           MainAxisAlignment
                      //                               .spaceBetween,
                      //                       children: [
                      //                         Text("lbl_home".tr,
                      //                             overflow: TextOverflow
                      //                                 .ellipsis,
                      //                             textAlign:
                      //                                 TextAlign.left,
                      //                             style: AppStyle
                      //                                 .txtRobotoMedium8Purple900),
                      //                         Text("lbl_store".tr,
                      //                             overflow: TextOverflow
                      //                                 .ellipsis,
                      //                             textAlign:
                      //                                 TextAlign.left,
                      //                             style: AppStyle
                      //                                 .txtRobotoMedium8),
                      //                         Text("lbl_profile".tr,
                      //                             overflow: TextOverflow
                      //                                 .ellipsis,
                      //                             textAlign:
                      //                                 TextAlign.left,
                      //                             style: AppStyle
                      //                                 .txtRobotoMedium8)
                      //                       ]))
                      //             ])))
                      Container(
                        width: double.maxFinite,
                        child: Container(
                          margin: getMargin(
                            top: 8,
                          ),
                          padding: getPadding(
                            top: 10,
                            bottom: 10,
                          ),
                          decoration: AppDecoration.fillPurple50,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "WE'RE OUR FAVORITE",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: AppStyle.txtRobotoMedium13.copyWith(
                                  letterSpacing: getHorizontalSize(
                                    0.26,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: getPadding(
                                  top: 5,
                                ),
                                child: Text(
                                  "msg_produdly_presenting".tr,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: AppStyle.txtRobotoRegular10Purple700
                                      .copyWith(
                                    letterSpacing: getHorizontalSize(
                                      0.2,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: favouriteProduct.length,
                                    itemBuilder: (context, index) {
                                      return SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        padding: getPadding(
                                          left: 10,
                                          top: 8,
                                          bottom: 4,
                                          right: 10,
                                        ),
                                        child: GestureDetector(
                                          onTap: () {
                                            debugPrint("tapped");
                                            Navigator.of(context)
                                                .push(MaterialPageRoute(
                                              builder: (context) =>
                                                  ProductDetailScreen1(
                                                      favouriteProduct[index]
                                                          .id!),
                                            ));
                                          },
                                          child: Container(
                                            width: 300,
                                            padding: getPadding(
                                              left: 11,
                                              top: 0,
                                              right: 11,
                                              bottom: 0,
                                            ),
                                            decoration:
                                                AppDecoration.fillWhiteA700,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Flexible(
                                                  flex: 1,
                                                  child: Container(
                                                    width: 280,
                                                    //height: 150,
                                                    child: Image.network(
                                                      favouriteProduct[index]
                                                          .image!,
                                                      fit: BoxFit.cover,
                                                      // width: 100.w,
                                                      alignment: Alignment(
                                                          -0.15, -0.15),
                                                      filterQuality:
                                                          FilterQuality.high,
                                                      loadingBuilder: (context,
                                                              child,
                                                              loadingProgress) =>
                                                          (loadingProgress ==
                                                                  null)
                                                              ? child
                                                              : AnimatedShimmer(
                                                                  height: 280,
                                                                  width: 150,
                                                                  borderRadius:
                                                                      const BorderRadius
                                                                          .all(
                                                                          Radius.circular(
                                                                              10)),
                                                                  delayInMilliSeconds: Duration(
                                                                      milliseconds:
                                                                          index *
                                                                              5),
                                                                ),
                                                      errorBuilder: (context,
                                                              error,
                                                              stackTrace) =>
                                                          Image.asset(
                                                              "assets/images/image_not_found.png"),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: getHorizontalSize(
                                                    420,
                                                  ),
                                                  margin: getMargin(
                                                    top: 5,
                                                    left: 5,
                                                  ),
                                                  child: Text(
                                                    favouriteProduct[index]
                                                        .description!,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: ColorConstant
                                                            .black900,
                                                        fontFamily: 'Roboto'),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ])),
                Container(
                  height: 25.h,
                  width: 100.w,
                  color: ColorConstant.whiteA700,
                  margin: getMargin(
                    top: 8,
                  ),
                  padding: getPadding(
                    top: 10,
                    bottom: 10,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: getPadding(
                          top: 12,
                        ),
                        child: Text(
                          "msg_make_everyone_go".tr,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtRobotoMedium13.copyWith(
                            letterSpacing: getHorizontalSize(
                              0.26,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: getPadding(top: 4, bottom: 6),
                        child: Text(
                          "msg_jaw_dropping_gorgeous".tr,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtRobotoRegular10Purple700.copyWith(
                            letterSpacing: getHorizontalSize(
                              0.2,
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: SizedBox(
                          height: 150,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: bannerswow.length,
                              itemBuilder: (context, index) {
                                return SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  padding: getPadding(
                                    left: 10,
                                    top: 0,
                                    bottom: 4,
                                    right: 10,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      if (bannerswow[index].keywordId == '0' ||
                                          bannerswow[index].keywordId == null) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text("No Data"),
                                                backgroundColor:
                                                    Colors.redAccent));
                                      } else {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) =>
                                              productlisrafterclickonbanner1(
                                                  bannerswow[index].keywordId!,
                                                  '',
                                                  '',
                                                  ''),
                                        ));
                                      }
                                      // Navigator.of(context).push(MaterialPageRoute(
                                      //   builder: (context) => ProductDetailScreen(widget.data,bannerswow[index].id),
                                      // ));
                                    },
                                    child: Container(
                                      width: 200,
                                      // color: Colors.black,
                                      padding: getPadding(
                                        left: 0.5,
                                        top: 0,
                                        right: 0.5,
                                        bottom: 0,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Flexible(
                                            flex: 1,
                                            child: Container(
                                              // width: 400,
                                              //height: 145,
                                              child: Image.network(
                                                bannerswow[index].image!,
                                                fit: BoxFit.cover,
                                                alignment: Alignment(1, 1),
                                                filterQuality:
                                                    FilterQuality.high,
                                                loadingBuilder:
                                                    (context, child,
                                                            loadingProgress) =>
                                                        (loadingProgress ==
                                                                null)
                                                            ? child
                                                            : AnimatedShimmer(
                                                                height: 145,
                                                                width: 200,
                                                                borderRadius:
                                                                    const BorderRadius
                                                                        .all(
                                                                        Radius.circular(
                                                                            10)),
                                                                delayInMilliSeconds: Duration(
                                                                    milliseconds:
                                                                        index *
                                                                            5),
                                                              ),
                                                errorBuilder: (context, error,
                                                        stackTrace) =>
                                                    Image.asset(
                                                        "assets/images/image_not_found.png"),
                                              ),
                                            ),
                                          ),
                                          // Container(
                                          //   // width: getHorizontalSize(
                                          //   //   250,
                                          //   // ),
                                          //   margin: getMargin(
                                          //     top: 5,
                                          //     left: 5,
                                          //   ),
                                          //   child: Text(
                                          //     bannerswow[index].metaDescription,
                                          //     // maxLines: null,
                                          //     textAlign: TextAlign.left,
                                          //     style: TextStyle(
                                          //         fontSize: 25,
                                          //         fontWeight: FontWeight.w400,
                                          //         color: ColorConstant.black900,
                                          //         fontFamily: 'Roboto'),
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  // height: getVerticalSize(
                  //   396,
                  // ),
                  width: double.maxFinite,
                  margin: getMargin(
                    top: 13,
                  ),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          padding: getPadding(
                            top: 12,
                            bottom: 12,
                          ),
                          decoration: AppDecoration.fillPurple50,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "msg_not_just_good_looks".tr,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: AppStyle.txtRobotoMedium13.copyWith(
                                  letterSpacing: getHorizontalSize(
                                    0.26,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: getPadding(
                                  top: 4,
                                ),
                                child: Text(
                                  "msg_excellent_quality".tr,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: AppStyle.txtRobotoRegular10Purple700
                                      .copyWith(
                                    letterSpacing: getHorizontalSize(
                                      0.2,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: getVerticalSize(
                                  200,
                                ),
                                child: ListView.separated(
                                  padding: getPadding(
                                    left: 16,
                                    top: 10,
                                    bottom: 3,
                                  ),
                                  scrollDirection: Axis.horizontal,
                                  separatorBuilder: (context, index) {
                                    return SizedBox(
                                      height: getVerticalSize(
                                        10,
                                      ),
                                    );
                                  },
                                  itemCount: bannersgoodLooks.length,
                                  // controller.afterScrollModelObj
                                  //     .value.afterScrollItemList.length,
                                  itemBuilder: (context, index) {
                                    // AfterScrollItemModel model = controller
                                    //     .afterScrollModelObj
                                    //     .value
                                    //     .afterScrollItemList[index];
                                    return GestureDetector(
                                      onTap: () {
                                        if (bannersgoodLooks[index].keywordId ==
                                                '0' ||
                                            bannersgoodLooks[index].keywordId ==
                                                null) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text("No Data"),
                                                  backgroundColor:
                                                      Colors.redAccent));
                                        } else {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) =>
                                                productlisrafterclickonbanner1(
                                                    bannersgoodLooks[index]
                                                        .keywordId!,
                                                    '',
                                                    '',
                                                    ''),
                                          ));
                                        }
                                        // Navigator.of(context).push(MaterialPageRoute(
                                        //   builder: (context) => ProductDetailScreen(widget.data,bannersgoodLooks[index].id),
                                        // ));
                                      },
                                      child: Container(
                                        width: 170,
                                        //height: 130,
                                        margin: getMargin(
                                          right: 10,
                                        ),
                                        padding: getPadding(
                                          left: 5,
                                          top: 0,
                                          right: 5,
                                          bottom: 0,
                                        ),
                                        decoration: AppDecoration.fillWhiteA700,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Flexible(
                                              flex: 1,
                                              child: Container(
                                                width: 150,
                                                //height: 140,
                                                padding: getPadding(
                                                    top: 0, bottom: 0),
                                                child: Image.network(
                                                  bannersgoodLooks[index]
                                                      .image!,
                                                  fit: BoxFit.cover,
                                                  alignment:
                                                      Alignment(0.7, 0.7),
                                                  filterQuality:
                                                      FilterQuality.high,
                                                  loadingBuilder: (context,
                                                          child,
                                                          loadingProgress) =>
                                                      (loadingProgress == null)
                                                          ? child
                                                          : AnimatedShimmer(
                                                              height: 140,
                                                              width: 150,
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .all(
                                                                      Radius.circular(
                                                                          10)),
                                                              delayInMilliSeconds:
                                                                  Duration(
                                                                      milliseconds:
                                                                          index *
                                                                              5),
                                                            ),
                                                  errorBuilder: (context, error,
                                                          stackTrace) =>
                                                      Image.asset(
                                                          "assets/images/image_not_found.png"),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: getHorizontalSize(400),
                                              child: Padding(
                                                padding: getPadding(
                                                  top: 2,
                                                ),
                                                child: Text(
                                                  bannersgoodLooks[index].name!,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: ColorConstant
                                                          .black900,
                                                      fontFamily: 'Roboto'),
                                                ),
                                              ),
                                            ),
                                            // Padding(
                                            //   padding: getPadding(
                                            //     top: 5,
                                            //   ),
                                            //   child: Text(
                                            //     bannersgoodLooks[index]
                                            //         .metaDescription,
                                            //     overflow: TextOverflow.ellipsis,
                                            //     textAlign: TextAlign.left,
                                            //     style: TextStyle(
                                            //         fontSize: 25,
                                            //         fontWeight: FontWeight.w400,
                                            //         color: ColorConstant.black900,
                                            //         fontFamily: 'Roboto'),
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                      ),
                                    );
                                    //   AfterScrollItemWidget(
                                    //   model,
                                    // );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  //height: 27.h,
                  color: ColorConstant.whiteA700,
                  child: Column(
                    children: [
                      Padding(
                        padding: getPadding(
                          top: 12,
                        ),
                        child: Text(
                          "BOTHER US ALL YOU WANT!",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtRobotoMedium13.copyWith(
                            letterSpacing: getHorizontalSize(
                              0.26,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: getPadding(
                          top: 4,
                        ),
                        child: Text(
                          "We Get Thrill From Helping People",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtRobotoRegular10Purple700.copyWith(
                            letterSpacing: getHorizontalSize(
                              0.2,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: getVerticalSize(
                          210,
                        ),
                        child: ListView.separated(
                          padding: getPadding(
                              left: 0, top: 10, bottom: 3, right: 10),
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: getVerticalSize(
                                10,
                              ),
                            );
                          },
                          itemCount: bannersBrothers.length,
                          // controller.afterScrollModelObj
                          //     .value.afterScrollItemList.length,
                          itemBuilder: (context, index) {
                            // AfterScrollItemModel model = controller
                            //     .afterScrollModelObj
                            //     .value
                            //     .afterScrollItemList[index];
                            return GestureDetector(
                              onTap: () {
                                if (bannersBrothers[index].keywordId == '0' ||
                                    bannersBrothers[index].keywordId == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text("No Data"),
                                          backgroundColor: Colors.redAccent));
                                } else {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        productlisrafterclickonbanner1(
                                            bannersBrothers[index].keywordId!,
                                            '',
                                            '',
                                            ''),
                                  ));
                                }
                                // Navigator.of(context).push(MaterialPageRoute(
                                //   builder: (context) => ProductDetailScreen(widget.data,bannersBrothers[index].id),
                                // ));
                              },
                              child: Container(
                                width: 200,
                                height: 150,
                                margin: getMargin(
                                  right: 0,
                                ),
                                padding: getPadding(
                                  left: 10,
                                  top: 0,
                                  right: 10,
                                  bottom: 4,
                                ),
                                decoration: AppDecoration.fillWhiteA700,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      child: Container(
                                        width: 150,
                                        height: 140,
                                        child: Image.network(
                                          bannersBrothers[index].image!,
                                          fit: BoxFit.cover,
                                          alignment: Alignment(0.7, 0.7),
                                          filterQuality: FilterQuality.high,
                                          loadingBuilder: (context, child,
                                                  loadingProgress) =>
                                              (loadingProgress == null)
                                                  ? child
                                                  : AnimatedShimmer(
                                                      height: 140,
                                                      width: 150,
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                              Radius.circular(
                                                                  10)),
                                                      delayInMilliSeconds:
                                                          Duration(
                                                              milliseconds:
                                                                  index * 5),
                                                    ),
                                          errorBuilder: (context, error,
                                                  stackTrace) =>
                                              Image.asset(
                                                  "assets/images/image_not_found.png"),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: getHorizontalSize(400),
                                      padding: getPadding(
                                        top: 5,
                                      ),
                                      child: Text(
                                        bannersBrothers[index].name!,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: ColorConstant.black900,
                                            fontFamily: 'Roboto'),
                                      ),
                                    ),
                                    // Padding(
                                    //   padding: getPadding(
                                    //     top: 5,
                                    //   ),
                                    //   child: Text(
                                    //     bannersBrothers[index].metaDescription,
                                    //     overflow: TextOverflow.ellipsis,
                                    //     textAlign: TextAlign.left,
                                    //     style: TextStyle(
                                    //         fontSize: 25,
                                    //         fontWeight: FontWeight.w400,
                                    //         color: ColorConstant.black900,
                                    //         fontFamily: 'Roboto'),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                            );
                            //   AfterScrollItemWidget(
                            //   model,
                            // );
                          },
                        ),
                      ),
                      // SingleChildScrollView(
                      //   scrollDirection: Axis.horizontal,
                      //   padding: getPadding(
                      //     left: 16,
                      //     top: 12,
                      //   ),
                      //   child: IntrinsicWidth(
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       children: [
                      //         CustomImageView(
                      //           imagePath: ImageConstant.imgImage11,
                      //           height: getSize(
                      //             176,
                      //           ),
                      //           width: getSize(
                      //             176,
                      //           ),
                      //         ),
                      //         CustomImageView(
                      //           imagePath: ImageConstant.imgImage11,
                      //           height: getSize(
                      //             176,
                      //           ),
                      //           width: getSize(
                      //             176,
                      //           ),
                      //           margin: getMargin(
                      //             left: 10,
                      //           ),
                      //         ),
                      //         CustomImageView(
                      //           imagePath: ImageConstant.imgImage11,
                      //           height: getSize(
                      //             176,
                      //           ),
                      //           width: getSize(
                      //             176,
                      //           ),
                      //           margin: getMargin(
                      //             left: 10,
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                Container(
                  height: getVerticalSize(
                    160,
                  ),
                  width: double.maxFinite,
                  margin: getMargin(
                    top: 0,
                  ),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          padding: getPadding(
                            left: 59,
                            top: 45,
                            right: 59,
                            bottom: 0,
                          ),
                          // decoration: AppDecoration.fillGray5001,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: getPadding(
                                  top: 0,
                                ),
                                child: Text(
                                  "msg_like_what_you_see".tr,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: AppStyle.txtRobotoRegular14Gray50001,
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                // color: Colors.black,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    //SizedBox(
                                    //width: 13.w,
                                    //),
                                    IconButton(
                                        onPressed: () {
                                          Get.to(_LinkWebView(
                                            text: 'Facebook',
                                            conts: facebook!,
                                          ));
                                          // _launchInBrowser(Uri.parse(facebook));
                                        },
                                        icon: Image.asset(
                                            "assets/images/facebook.png")),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          Get.to(_LinkWebView(
                                            text: 'Instagram',
                                            conts: instagram!,
                                          ));
                                          // _launchInBrowser(Uri.parse(instagram));
                                        },
                                        icon: Image.asset(
                                            "assets/images/instagram.png")),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          Get.to(_LinkWebView(
                                            text: 'Twitter',
                                            conts: twitter!,
                                          ));
                                          // _launchInBrowser(Uri.parse(twitter));
                                        },
                                        icon: Image.asset(
                                            "assets/images/twitter.png")),
                                  ],
                                ),
                              ),

                              // CustomImageView(
                              //   imagePath: ImageConstant.imgGroup12,
                              //   height: getVerticalSize(
                              //     37,
                              //   ),
                              //   width: getHorizontalSize(
                              //     177,
                              //   ),
                              //   margin: getMargin(
                              //     top: 28,
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: SizedBox(
                          width: double.maxFinite,
                          child: Divider(
                            height: getVerticalSize(
                              1,
                            ),
                            thickness: getVerticalSize(
                              1,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ])),
            )));
  }

  onTapImgSofa() {
    Get.toNamed(AppRoutes.storeScreen);
  }

  onTapSearch() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => SearchScreen1(''),
    ));
  }

  onTapWishlist() {
    Get.toNamed(AppRoutes.whislistScreen);
  }

  // Future<void> _launchInBrowser(Uri url) async {
  //   if (!await launchUrl(
  //     url,
  //     mode: LaunchMode.inAppWebView,
  //   )) {
  //     throw 'Could not launch $url';
  //   }
  // }

  CategoryCard(
      {String? title, String? previewImageAsset, VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, top: 5),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            SizedBox(
              height: 0,
            ),
            Flexible(
              flex: 1,
              child: CustomImageView(
                imagePath: previewImageAsset!,
                height: getSize(40),
                width: getSize(40),
                margin: getMargin(top: 3),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            //Spacer(),
            Text(
              title!,
              style: TextStyle(fontSize: 12, color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}

class _LinkWebView extends StatefulWidget {
  _LinkWebView({
    this.conts,
    this.text,
  });
  final String? conts;
  final String? text;
  @override
  State<_LinkWebView> createState() => __LinkWebViewState();
}

class __LinkWebViewState extends State<_LinkWebView> {
  // InAppWebViewController _webViewController;
  // double progress = 0;
  // String url='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              margin: getMargin(left: 20, top: 22, bottom: 32)),
          title: AppbarTitle(
              text: widget.text!,
              margin: getMargin(left: 19, top: 30, bottom: 42)),
          styleType: Style.bgOutlineGray40003),
      body: SafeArea(
        child:
            // InAppWebView(
            //   initialUrlRequest: URLRequest(url: Uri.parse('${widget.conts}')),
            //   initialOptions: InAppWebViewGroupOptions(
            //       crossPlatform: InAppWebViewOptions(
            //           useShouldOverrideUrlLoading: true,
            //           mediaPlaybackRequiresUserGesture: true,
            //           useOnDownloadStart: true,
            //           cacheEnabled: true,
            //           userAgent:
            //           "Mozilla/5.0 (Linux; Android 9; LG-H870 Build/PKQ1.190522.001) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/83.0.4103.106 Mobile Safari/537.36",
            //           javaScriptEnabled: true,
            //           transparentBackground: true),
            //       android: AndroidInAppWebViewOptions(
            //           useHybridComposition: true, defaultFontSize: 32),
            //       ios: IOSInAppWebViewOptions(
            //         allowsInlineMediaPlayback: true,
            //       )),
            //   onWebViewCreated: (InAppWebViewController controller) {
            //     _webViewController = controller;
            //   },
            //   // onLoadStart: (InAppWebViewController controller, String url) {
            //   //   setState(() {
            //   //     this.url = url;
            //   //   });
            //   // },
            //   // onLoadStop: (InAppWebViewController controller, String url) async {
            //   //   setState(() {
            //   //     this.url = url;
            //   //   });
            //   // },
            //   onProgressChanged: (InAppWebViewController controller, int progress) {
            //     setState(() {
            //       this.progress = progress / 100;
            //     });
            //   },
            // ),
            WebViewWidget(
          controller: WebViewController()
            ..setJavaScriptMode(JavaScriptMode.unrestricted)
            ..setBackgroundColor(const Color(0x00000000))
            ..setNavigationDelegate(
              NavigationDelegate(
                onProgress: (int progress) {
                  // Update loading bar.
                },
                onPageStarted: (String url) {},
                onPageFinished: (String url) {},
                onWebResourceError: (WebResourceError error) {},
                onNavigationRequest: (NavigationRequest request) {
                  if (request.url.startsWith('${widget.conts}')) {
                    return NavigationDecision.prevent;
                  }
                  return NavigationDecision.navigate;
                },
              ),
            )
            ..loadRequest(Uri.parse('${widget.conts}')),
        ),
      ),
    );
  }
}
