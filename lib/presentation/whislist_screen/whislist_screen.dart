import 'dart:async';

import 'package:keshav_s_application2/presentation/cart_screen/cart_screen.dart';
import 'package:keshav_s_application2/presentation/home_screen/home_screen.dart';
import 'package:keshav_s_application2/presentation/product_detail_screen/models/addtocartfromwishlist.dart';
import 'package:keshav_s_application2/presentation/profile_screen/profile_screen.dart';
import 'package:keshav_s_application2/presentation/store_screen/store_screen.dart';
import 'package:keshav_s_application2/presentation/whislist_screen/models/removewishlist.dart';
import 'package:keshav_s_application2/presentation/whislist_screen/models/wishlist_model.dart'
    as wishlist;
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:smartech_base/smartech_base.dart';

import '../otp_screen/models/otp_model.dart';
import '../whislist_screen/widgets/whislist_item_widget.dart';
import 'controller/whislist_controller.dart';
import 'models/whislist_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as fs;
import 'package:keshav_s_application2/core/app_export.dart';
import 'package:keshav_s_application2/widgets/app_bar/appbar_image.dart';
import 'package:keshav_s_application2/widgets/app_bar/appbar_subtitle_5.dart';
import 'package:keshav_s_application2/widgets/app_bar/appbar_subtitle_6.dart';
import 'package:keshav_s_application2/widgets/app_bar/custom_app_bar.dart';
import 'package:keshav_s_application2/widgets/custom_button.dart';

import 'dart:convert';

import 'package:dio/dio.dart' as dio;

class WhislistScreen extends StatefulWidget {
  Data data;
  WhislistScreen(this.data);

  @override
  State<WhislistScreen> createState() => _WhislistScreenState();
}

class _WhislistScreenState extends State<WhislistScreen> {
  Future<wishlist.WishlistScreenModel>? mywishlist;
  List<wishlist.WishListData> wishlistdata = [];
  String? message;
  //Use the deep config you created on the dashboard
  Future<wishlist.WishlistScreenModel> getWishlist() async {
    Map data = {
      'user_id': widget.data.id,
    };
    //encode Map to JSON
    var body = json.encode(data);
    var response =
        await dio.Dio().post("https://fabfurni.com/api/Webservice/wishlist",
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

      if (wishlist.WishlistScreenModel.fromJson(jsonObject).status == "true") {
        // print(orders.MyOrdersModel.fromJson(jsonObject).data.first.products.first.image);

        return wishlist.WishlistScreenModel.fromJson(jsonObject);

        // inviteList.sort((a, b) => a.id.compareTo(b.id));
      } else if (wishlist.WishlistScreenModel.fromJson(jsonObject).status ==
          "false") {
        message = wishlist.WishlistScreenModel.fromJson(jsonObject).message;
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //     duration: Duration(seconds: 1),
        //     behavior: SnackBarBehavior.floating,
        //     margin: EdgeInsets.only(bottom: 10.0),
        //     content: Text(wishlist.WishlistScreenModel.fromJson(jsonObject).message),
        //     backgroundColor: Colors.redAccent));
      } else if (wishlist.WishlistScreenModel.fromJson(jsonObject).data ==
          null) {
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

  Future<AddtoCartfromwishlist> addtocart(String product_id) async {
    Map data = {
      'user_id': widget.data.id,
      'product_id': product_id,
      'qty': "1",
      "add_wishlist_cart": "1",
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

      if (AddtoCartfromwishlist.fromJson(jsonObject).status == "true") {
        // print(orders.MyOrdersModel.fromJson(jsonObject).data.first.products.first.image);
        buildLoading(context);
        Timer(Duration(seconds: 1), () {
          Navigator.of(context).pop();
        });
        setState(() {});
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: Duration(seconds: 1),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(bottom: 10.0),
            content: Text(
              "Added to Cart " +
                  AddtoCartfromwishlist.fromJson(jsonObject).message! +
                  "ly",
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.greenAccent));

        return AddtoCartfromwishlist.fromJson(jsonObject);

        // inviteList.sort((a, b) => a.id.compareTo(b.id));
      } else if (AddtoCartfromwishlist.fromJson(jsonObject).status == "false") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: Duration(seconds: 1),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(bottom: 10.0),
            content: Text(AddtoCartfromwishlist.fromJson(jsonObject)
                .message!
                .capitalizeFirst!),
            backgroundColor: Colors.redAccent));
      } else if (AddtoCartfromwishlist.fromJson(jsonObject).data == null) {
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

  Future<RemoveWishlist> removefromwishlist(String product_id) async {
    Map data = {
      'user_id': widget.data.id,
      'product_id': product_id,
    };
    //encode Map to JSON
    var body = json.encode(data);
    var response =
        await dio.Dio().post("https://fabfurni.com/api/Webservice/addWishlist",
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

      if (RemoveWishlist.fromJson(jsonObject).status == "true") {
        // print(orders.MyOrdersModel.fromJson(jsonObject).data.first.products.first.image);
        if (RemoveWishlist.fromJson(jsonObject).data == true) {
          buildLoading(context);
          Timer(Duration(seconds: 1), () {
            Navigator.of(context).pop();
          });
          setState(() {});

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              duration: Duration(seconds: 1),
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.only(bottom: 10.0),
              content: Text(
                "Removed from Wishlist ",
                style: TextStyle(color: Colors.black),
              ),
              backgroundColor: Colors.greenAccent));
        }
        return RemoveWishlist.fromJson(jsonObject);

        // inviteList.sort((a, b) => a.id.compareTo(b.id));
      } else if (RemoveWishlist.fromJson(jsonObject).status == "false") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: Duration(seconds: 1),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(bottom: 10.0),
            content: Text(
                RemoveWishlist.fromJson(jsonObject).message!.capitalizeFirst!),
            backgroundColor: Colors.redAccent));
      } else if (RemoveWishlist.fromJson(jsonObject).data == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 1),
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

  @override
  void initState() {
    Smartech().trackEvent("screen_viewed", {});
    mywishlist = getWishlist();
    mywishlist!.then((value) {
      setState(() {
        wishlistdata = value.data!;
        // count=value.count;
        // total=value.total;

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
  void didUpdateWidget(WhislistScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget != widget) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final viewPadding = MediaQuery.of(context).viewPadding;
    double barHeight;
    double barHeightWithNotch = 67;
    double arcHeightWithNotch = 67;

    if (size.height > 700) {
      barHeight = 70;
    } else {
      barHeight = size.height * 0.1;
    }

    if (viewPadding.bottom > 0) {
      barHeightWithNotch = (size.height * 0.07) + viewPadding.bottom;
      arcHeightWithNotch = (size.height * 0.075) + viewPadding.bottom;
    }

    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
          height: getVerticalSize(70),
          leadingWidth: 34,
          leading: AppbarImage(
              height: getVerticalSize(15),
              width: getHorizontalSize(9),
              svgPath: ImageConstant.imgArrowleft,
              margin: getMargin(left: 25, top: 33, bottom: 20),
              onTap: onTapArrowleft2),
          title: AppbarSubtitle5(
              text: "lbl_wishlist".tr,
              margin: getMargin(left: 19, top: 30, bottom: 18)),
          actions: [
            Container(
                height: getVerticalSize(24),
                width: getHorizontalSize(29),
                margin: getMargin(left: 12, top: 30, right: 12, bottom: 10),
                child: Stack(alignment: Alignment.topRight, children: [
                  AppbarImage(
                      onTap: () {
                        pushScreen(
                          context,
                          screen: CartScreen(widget.data),
                          withNavBar: false, // OPTIONAL VALUE. True by default.
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                        );
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
      body: RefreshIndicator(
        color: Colors.purple,
        onRefresh: () async {
          mywishlist = getWishlist();
          mywishlist!.then((value) {
            setState(() {
              wishlistdata = value.data!;
            });
          });
        },
        child: FutureBuilder(
          future: mywishlist,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Stack(
                children: [
                  ListView(),
                  Container(
                      width: double.maxFinite,
                      padding: getPadding(top: 12, bottom: 12),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CustomButton(
                                height: getVerticalSize(29),
                                width: getHorizontalSize(156),
                                text: "lbl_recently_viewed".tr,
                                variant: ButtonVariant.FillPurple50,
                                shape: ButtonShape.Square,
                                fontStyle: ButtonFontStyle.RobotoRegular14,
                                alignment: Alignment.centerRight),
                            Padding(
                                padding: getPadding(left: 21, top: 17),
                                child: Row(children: [
                                  Container(
                                      height: getSize(12),
                                      width: getSize(12),
                                      margin: getMargin(top: 2, bottom: 2),
                                      decoration: BoxDecoration(
                                          color: ColorConstant.purple900,
                                          borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(
                                                  getHorizontalSize(21))))),
                                  Padding(
                                      padding: getPadding(left: 16),
                                      child: Text(
                                          wishlistdata.length.toString() +
                                              " PRODUCTS",
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style: AppStyle.txtRobotoRegular14
                                              .copyWith(
                                                  letterSpacing:
                                                      getHorizontalSize(0.7))))
                                ])),
                            Align(
                                alignment: Alignment.center,
                                child: Padding(
                                    padding: getPadding(
                                        left: 21, top: 19, right: 20),
                                    child: ListView.separated(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        separatorBuilder: (context, index) {
                                          return SizedBox(
                                              height: getVerticalSize(15));
                                        },
                                        itemCount: wishlistdata.length,
                                        // controller.whislistModelObj.value
                                        //     .whislistItemList.length,
                                        itemBuilder: (context, index) {
                                          // WhislistItemModel model =
                                          // controller
                                          //     .whislistModelObj
                                          //     .value
                                          //     .whislistItemList[index];
                                          return Align(
                                            alignment: Alignment.center,
                                            child: Container(
                                              key: ValueKey(
                                                  (index + 1).toString()),
                                              width: double.maxFinite,
                                              child: Container(
                                                padding: getPadding(
                                                  left: 8,
                                                  top: 6,
                                                  right: 8,
                                                  bottom: 6,
                                                ),
                                                decoration: AppDecoration
                                                    .outlinePurple9004c,
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding: getPadding(
                                                        top: 1,
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          CustomImageView(
                                                            url: wishlistdata[
                                                                    index]
                                                                .productData!
                                                                .image!,
                                                            // imagePath: ImageConstant.imgImage5,
                                                            height: getSize(
                                                              65,
                                                            ),
                                                            width: getSize(
                                                              65,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: getPadding(
                                                              left: 5,
                                                            ),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Container(
                                                                      width:
                                                                          getHorizontalSize(
                                                                        220,
                                                                      ),
                                                                      child:
                                                                          Text(
                                                                        wishlistdata[index]
                                                                            .productData!
                                                                            .name!,
                                                                        maxLines:
                                                                            1,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style: AppStyle
                                                                            .txtRobotoRegular14Purple400,
                                                                      ),
                                                                    ),
                                                                    CustomImageView(
                                                                      onTap:
                                                                          () async {
                                                                        await removefromwishlist(wishlistdata[index]
                                                                            .productData!
                                                                            .id!);
                                                                        setState(
                                                                            () {
                                                                          initState();
                                                                        });
                                                                      },
                                                                      svgPath:
                                                                          ImageConstant
                                                                              .imgFavorite,
                                                                      height:
                                                                          getVerticalSize(
                                                                        12,
                                                                      ),
                                                                      width:
                                                                          getHorizontalSize(
                                                                        14,
                                                                      ),
                                                                      margin:
                                                                          getMargin(
                                                                        left:
                                                                            66,
                                                                        top: 1,
                                                                        bottom:
                                                                            11,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      getPadding(
                                                                    left: 2,
                                                                    top: 3,
                                                                  ),
                                                                  child: Row(
                                                                    children: [
                                                                      CustomImageView(
                                                                        svgPath:
                                                                            ImageConstant.imgVectorPurple900,
                                                                        height:
                                                                            getVerticalSize(
                                                                          8,
                                                                        ),
                                                                        width:
                                                                            getHorizontalSize(
                                                                          5,
                                                                        ),
                                                                        margin:
                                                                            getMargin(
                                                                          bottom:
                                                                              3,
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            getPadding(
                                                                          left:
                                                                              2,
                                                                        ),
                                                                        child:
                                                                            Text(
                                                                          wishlistdata[index]
                                                                              .productData!
                                                                              .salePrice!,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          textAlign:
                                                                              TextAlign.left,
                                                                          style:
                                                                              AppStyle.txtRobotoMedium10,
                                                                        ),
                                                                      ),
                                                                      CustomImageView(
                                                                        svgPath:
                                                                            ImageConstant.imgVectorGray400,
                                                                        height:
                                                                            getVerticalSize(
                                                                          7,
                                                                        ),
                                                                        width:
                                                                            getHorizontalSize(
                                                                          4,
                                                                        ),
                                                                        margin:
                                                                            getMargin(
                                                                          left:
                                                                              5,
                                                                          top:
                                                                              1,
                                                                          bottom:
                                                                              3,
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        height:
                                                                            getVerticalSize(
                                                                          10,
                                                                        ),
                                                                        width:
                                                                            getHorizontalSize(
                                                                          25,
                                                                        ),
                                                                        margin:
                                                                            getMargin(
                                                                          left:
                                                                              2,
                                                                          top:
                                                                              1,
                                                                        ),
                                                                        child:
                                                                            Stack(
                                                                          alignment:
                                                                              Alignment.topLeft,
                                                                          children: [
                                                                            Align(
                                                                              alignment: Alignment.center,
                                                                              child: Text(
                                                                                wishlistdata[index].productData!.mrpPrice!,
                                                                                overflow: TextOverflow.ellipsis,
                                                                                textAlign: TextAlign.left,
                                                                                style: AppStyle.txtRobotoMedium8Gray400,
                                                                              ),
                                                                            ),
                                                                            Align(
                                                                              alignment: Alignment.topLeft,
                                                                              child: Padding(
                                                                                padding: getPadding(
                                                                                  top: 4,
                                                                                ),
                                                                                child: SizedBox(
                                                                                  width: getHorizontalSize(
                                                                                    23,
                                                                                  ),
                                                                                  child: Divider(
                                                                                    height: getVerticalSize(
                                                                                      1,
                                                                                    ),
                                                                                    thickness: getVerticalSize(
                                                                                      1,
                                                                                    ),
                                                                                    color: ColorConstant.gray40001,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      getPadding(
                                                                    left: 1,
                                                                    top: 2,
                                                                  ),
                                                                  child: Text(
                                                                    wishlistdata[index]
                                                                            .productData!
                                                                            .discountPer! +
                                                                        " % Off",
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style: AppStyle
                                                                        .txtRobotoMedium8Purple900,
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      getPadding(
                                                                    left: 1,
                                                                    top: 2,
                                                                  ),
                                                                  child: Text(
                                                                    "msg_limited_time_offer"
                                                                        .tr,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style: AppStyle
                                                                        .txtRobotoRegular8,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: getPadding(
                                                        top: 15,
                                                      ),
                                                      child: Divider(
                                                        height: getVerticalSize(
                                                          1,
                                                        ),
                                                        thickness:
                                                            getVerticalSize(
                                                          1,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      // color: Colors.black,
                                                      width: 350,
                                                      height: 30,
                                                      child: InkWell(
                                                        onTap: () async {
                                                          await addtocart(
                                                              wishlistdata[
                                                                      index]
                                                                  .productData!
                                                                  .id!);
                                                          setState(() {
                                                            initState();
                                                          });
                                                        },
                                                        child: Container(
                                                          padding: getPadding(
                                                            top: 15,
                                                          ),
                                                          child: Text(
                                                            "lbl_add_to_cart"
                                                                .tr,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: AppStyle
                                                                .txtRobotoMedium10,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                          // WhislistItemWidget(widget.data,wishlistdata[index].productData);
                                        })))
                          ]))
                ],
              );
            } else if (!snapshot.hasData) {
              return Center(
                  child: Image(
                image: AssetImage("assets/images/wishlist_empty.png"),
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
      // bottomNavigationBar:
      // Container(
      //     margin: getMargin(left: 14, right: 14, bottom: 12),
      //     decoration: BoxDecoration(
      //         boxShadow:  <BoxShadow>[
      //           BoxShadow(
      //             color: Colors.black12.withOpacity(0.1),
      //             offset: Offset(2.0, 4.0),
      //             blurRadius: 1.0,
      //             //blurStyle: BlurStyle.outer
      //           ),
      //         ],
      //         image: DecorationImage(
      //
      //             image: fs.Svg(ImageConstant.imgGroup203,color: Colors.black87,),
      //             fit: BoxFit.cover)),
      //     child: Column(
      //         mainAxisSize: MainAxisSize.min,
      //         mainAxisAlignment: MainAxisAlignment.start,
      //         children: [
      //           Container(
      //               height: getVerticalSize(86),
      //               width: getHorizontalSize(400),
      //               decoration: BoxDecoration(
      //                   image: DecorationImage(
      //                       image: fs.Svg(ImageConstant.imgGroup203),
      //                       fit: BoxFit.cover)),
      //               child: Stack(alignment: Alignment.center, children: [
      //                 Align(
      //                     alignment: Alignment.bottomCenter,
      //                     child: Padding(
      //                         padding: getPadding(
      //                             left: 41, right: 44, bottom: 6),
      //                         child: Column(
      //                             mainAxisSize: MainAxisSize.min,
      //                             mainAxisAlignment:
      //                                 MainAxisAlignment.start,
      //                             children: [
      //                               CustomImageView(
      //                                   svgPath: ImageConstant.imgGroup2,
      //                                   height: getVerticalSize(47),
      //                                   width: getHorizontalSize(315)),
      //                               Padding(
      //                                   padding: getPadding(
      //                                       left: 7, top: 4, right: 1),
      //                                   child: Row(
      //                                       mainAxisAlignment:
      //                                           MainAxisAlignment
      //                                               .spaceBetween,
      //                                       children: [
      //                                         Text("lbl_home".tr,
      //                                             overflow: TextOverflow
      //                                                 .ellipsis,
      //                                             textAlign:
      //                                                 TextAlign.center,
      //                                             style: AppStyle
      //                                                 .txtRobotoMedium8Purple900),
      //                                         Text("lbl_store".tr,
      //                                             overflow: TextOverflow
      //                                                 .ellipsis,
      //                                             textAlign:
      //                                                 TextAlign.center,
      //                                             style: AppStyle
      //                                                 .txtRobotoMedium8),
      //                                         Text("lbl_profile".tr,
      //                                             overflow: TextOverflow
      //                                                 .ellipsis,
      //                                             textAlign:
      //                                                 TextAlign.left,
      //                                             style: AppStyle
      //                                                 .txtRobotoMedium8)
      //                                       ]))
      //                             ]))),
      //                 Align(
      //                     alignment: Alignment.center,
      //                     child: Container(
      //                         padding: getPadding(
      //                             left: 41, top: 6, right: 41, bottom: 6),
      //                         decoration: BoxDecoration(
      //                             image: DecorationImage(
      //                                 image: fs.Svg(
      //                                     ImageConstant.imgGroup203),
      //                                 fit: BoxFit.cover)),
      //                         child: Column(
      //                             mainAxisSize: MainAxisSize.min,
      //                             mainAxisAlignment:
      //                                 MainAxisAlignment.end,
      //                             children: [
      //                               CustomImageView(
      //                                   svgPath: ImageConstant
      //                                       .imgGroup2Purple900,
      //                                   height: getVerticalSize(47),
      //                                   width: getHorizontalSize(315),
      //                                   margin: getMargin(top: 11)),
      //                               Padding(
      //                                   padding: getPadding(
      //                                       left: 7, top: 4, right: 4),
      //                                   child: Row(
      //                                       mainAxisAlignment:
      //                                           MainAxisAlignment
      //                                               .spaceBetween,
      //                                       children: [
      //                                         Text("lbl_home".tr,
      //                                             overflow: TextOverflow
      //                                                 .ellipsis,
      //                                             textAlign:
      //                                                 TextAlign.left,
      //                                             style: AppStyle
      //                                                 .txtRobotoMedium8),
      //                                         Text("lbl_store".tr,
      //                                             overflow: TextOverflow
      //                                                 .ellipsis,
      //                                             textAlign:
      //                                                 TextAlign.left,
      //                                             style: AppStyle
      //                                                 .txtRobotoMedium8Purple900),
      //                                         Text("lbl_profile".tr,
      //                                             overflow: TextOverflow
      //                                                 .ellipsis,
      //                                             textAlign:
      //                                                 TextAlign.left,
      //                                             style: AppStyle
      //                                                 .txtRobotoMedium8)
      //                                       ]))
      //                             ])))
      //               ]))
      //         ]))
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

  onTapArrowleft2() {
    Get.back();
  }
}
