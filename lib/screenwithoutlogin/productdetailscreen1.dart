import 'dart:async';

import 'package:flutter/services.dart';
import 'package:keshav_s_application2/core/utils/utils.dart';
import 'package:keshav_s_application2/core/utils/validation_functions.dart';
import 'package:keshav_s_application2/presentation/cart_screen/cart_screen.dart';
import 'package:keshav_s_application2/presentation/log_in_screen/log_in_screen.dart';
import 'package:keshav_s_application2/presentation/product_detail_screen/models/AddWishlist.dart';
import 'package:keshav_s_application2/presentation/product_detail_screen/models/AddtoCart.dart';
import 'package:keshav_s_application2/presentation/product_detail_screen/models/Product_detail_model.dart'
    as products;
import 'package:keshav_s_application2/presentation/select_product_screen/models/CheckPincode.dart';
import 'package:keshav_s_application2/presentation/whislist_screen/whislist_screen.dart';
import 'package:keshav_s_application2/widgets/custom_drop_down.dart';
import 'package:keshav_s_application2/widgets/custom_text_form_field.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:sizer/sizer.dart';

import 'package:carousel_slider/carousel_slider.dart' as carousel;
import 'package:flutter/material.dart';
import 'package:keshav_s_application2/core/app_export.dart';
import 'package:keshav_s_application2/widgets/app_bar/appbar_image.dart';
import 'package:keshav_s_application2/widgets/app_bar/appbar_subtitle_6.dart';
import 'package:keshav_s_application2/widgets/app_bar/custom_app_bar.dart';
import 'package:keshav_s_application2/widgets/custom_button.dart';
import 'package:keshav_s_application2/widgets/custom_icon_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'dart:convert';

import 'package:dio/dio.dart' as dio;

class ProductDetailScreen1 extends StatefulWidget {
  String product_id;
  ProductDetailScreen1(this.product_id);

  @override
  State<ProductDetailScreen1> createState() => _ProductDetailScreen1State();
}

class _ProductDetailScreen1State extends State<ProductDetailScreen1> {
  var number = "12";

  TextEditingController pincodeController = TextEditingController();
  int silderIndex = 0;

  Future<products.ProductDetailModel>? product;
  products.Data? productlist;
  List<products.SimilarProduct> similarProduct = [];
  List<products.BrandProduct> brandProduct = [];
  List<products.ProductImages> productImages = [];
  List<products.Attributes> attributes = [];
  // List<homes.FavouriteProduct> favouriteProduct = [];
  // List<homes.Bannerswow> bannerswow = [];
  // List<homes.BannersgoodLooks> bannersgoodLooks = [];
  // List<homes.BannersBrothers> bannersBrothers = [];
  List<String> dropdownItemList = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10"
  ];
  String errorMsg = '';
  String? _selectedQty;

  Future<products.ProductDetailModel> getProductDetail() async {
    Map data = {
      // 'user_id': widget.data.id,
      'product_id': widget.product_id,
    };
    //encode Map to JSON
    var body = json.encode(data);
    print('Detail --> ' + json.encode(data));
    var response = await dio.Dio()
        .post("https://fabfurni.com/api/Webservice/product_details",
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

      if (products.ProductDetailModel.fromJson(jsonObject).status == "true") {
        // print(orders.MyOrdersModel.fromJson(jsonObject).data.first.products.first.image);

        return products.ProductDetailModel.fromJson(jsonObject);

        // inviteList.sort((a, b) => a.id.compareTo(b.id));
      } else if (products.ProductDetailModel.fromJson(jsonObject).status ==
          "false") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: Duration(seconds: 2),
            content: Text(products.ProductDetailModel.fromJson(jsonObject)
                .message!
                .capitalizeFirst!),
            backgroundColor: Colors.redAccent));
        Timer(Duration(seconds: 3), () {
          Navigator.of(context).pop();
        });
      } else if (products.ProductDetailModel.fromJson(jsonObject).data ==
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

  // Future<AddtoCart> addtocart(String qty) async {
  //   Map data = {
  //     // 'user_id': widget.data.id,
  //     'product_id':widget.product_id,
  //     'qty':qty,
  //   };
  //   //encode Map to JSON
  //   var body = json.encode(data);
  //   var response =
  //   await dio.Dio().post("https://fabfurni.com/api/Webservice/addtoCart",
  //       options: dio.Options(
  //         headers: {
  //           "Content-Type": "application/json",
  //           "Accept": "*/*",
  //         },
  //       ),
  //       data: body);
  //   var jsonObject = jsonDecode(response.toString());
  //   if (response.statusCode == 200) {
  //     print(jsonObject);
  //
  //     if (AddtoCart.fromJson(jsonObject).status == "true") {
  //       // print(orders.MyOrdersModel.fromJson(jsonObject).data.first.products.first.image);
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //           duration: Duration(seconds: 1),
  //           behavior: SnackBarBehavior.floating,
  //           margin: EdgeInsets.only(bottom: 20.0),
  //           content: Text("Added to Cart Successfully"
  //             // + AddtoCart.fromJson(jsonObject).message+"ly"
  //             ,style: TextStyle(color: Colors.black),),
  //           backgroundColor: Colors.greenAccent));
  //
  //       return AddtoCart.fromJson(jsonObject);
  //
  //       // inviteList.sort((a, b) => a.id.compareTo(b.id));
  //     }else if (AddtoCart.fromJson(jsonObject).status == "false") {
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //           duration: Duration(seconds: 2),
  //           behavior: SnackBarBehavior.floating,
  //           margin: EdgeInsets.only(bottom: 10.0),
  //           content: Text(AddtoCart.fromJson(jsonObject).message.capitalizeFirst),
  //           backgroundColor: Colors.redAccent));
  //
  //     }
  //     else if(AddtoCart.fromJson(jsonObject).data == null){
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //         duration: Duration(seconds: 3),
  //         behavior: SnackBarBehavior.floating,
  //         margin: EdgeInsets.only(bottom: 10.0),
  //         content: Text(
  //           jsonObject['message'] + ' Please check after sometime.',
  //           style: TextStyle(color: Colors.white),
  //         ),
  //         backgroundColor: Colors.redAccent,
  //       ));
  //     }
  //     else {
  //       throw Exception('Failed to load');
  //     }
  //   } else {
  //     throw Exception('Failed to load');
  //   }
  //   return jsonObject;
  // }
  // Future<AddWishlist> addtowishlist() async {
  //   Map data = {
  //     'user_id': widget.data.id,
  //     'product_id':widget.product_id,
  //   };
  //   //encode Map to JSON
  //   var body = json.encode(data);
  //   var response =
  //   await dio.Dio().post("https://fabfurni.com/api/Webservice/addWishlist",
  //       options: dio.Options(
  //         headers: {
  //           "Content-Type": "application/json",
  //           "Accept": "*/*",
  //         },
  //       ),
  //       data: body);
  //   var jsonObject = jsonDecode(response.toString());
  //   if (response.statusCode == 200) {
  //     print(jsonObject);
  //
  //     if (AddWishlist.fromJson(jsonObject).status == "true") {
  //       // print(orders.MyOrdersModel.fromJson(jsonObject).data.first.products.first.image);
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //           duration: Duration(seconds: 1),
  //           behavior: SnackBarBehavior.floating,
  //           margin: EdgeInsets.only(bottom: 10.0),
  //           content: Text("Added to Wishlist "+AddWishlist.fromJson(jsonObject).message+"ly",style: TextStyle(color: Colors.black),),
  //           backgroundColor: Colors.greenAccent));
  //
  //       return AddWishlist.fromJson(jsonObject);
  //
  //       // inviteList.sort((a, b) => a.id.compareTo(b.id));
  //     }else if (AddWishlist.fromJson(jsonObject).status == "false") {
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //           duration: Duration(seconds: 1),
  //           behavior: SnackBarBehavior.floating,
  //           margin: EdgeInsets.only(bottom: 10.0),
  //           content: Text(AddWishlist.fromJson(jsonObject).message.capitalizeFirst),
  //           backgroundColor: Colors.redAccent));
  //
  //     }
  //     else if(AddWishlist.fromJson(jsonObject).data == null){
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //         duration: Duration(seconds: 3),
  //         behavior: SnackBarBehavior.floating,
  //         margin: EdgeInsets.only(bottom: 10.0),
  //         content: Text(
  //           jsonObject['message'] + ' Please check after sometime.',
  //           style: TextStyle(color: Colors.white),
  //         ),
  //         backgroundColor: Colors.redAccent,
  //       ));
  //     }
  //     else {
  //       throw Exception('Failed to load');
  //     }
  //   } else {
  //     throw Exception('Failed to load');
  //   }
  //   return jsonObject;
  // }
  Future<CheckPincode> checkPincode() async {
    Map data = {
      // 'user_id': widget.data.id,
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

  @override
  void initState() {
    product = getProductDetail();
    product!.then((value) {
      setState(() {
        productlist = value.data;
        similarProduct = value.similarProduct!;
        brandProduct = value.brandProduct!;
        productImages = value.data!.productImages!;
        attributes = value.data!.attributes!;
      });
    });
    print(attributes.length);
    print(widget.product_id);

    super.initState();
  }

  @override
  void dispose() {
    pincodeController.dispose();
    super.dispose();
  }

  bool expanded = false;
  bool expanded1 = false;
  bool expanded2 = false;
  bool expanded3 = false;
  bool expanded4 = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
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
                    margin: getMargin(left: 20, top: 30, bottom: 25)),
                // title: AppbarTitle(
                //     text: "MANAGE ADDRESS",
                //     margin: getMargin(left: 19, top: 49, bottom: 42)),
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
                          getMargin(left: 12, top: 22, right: 10, bottom: 10),
                      onTap: () {
                        Get.toNamed(AppRoutes.searchScreen);
                      }),
                  Container(
                      height: getVerticalSize(23),
                      width: getHorizontalSize(27),
                      margin: getMargin(left: 20, top: 5, right: 10, bottom: 0),
                      child: Stack(alignment: Alignment.topRight, children: [
                        AppbarImage(
                            height: getVerticalSize(21),
                            width: getHorizontalSize(21),
                            svgPath: ImageConstant.imgLocation,
                            margin: getMargin(top: 5, right: 6),
                            onTap: () {
                              //   pushScreen(
                              //     context,
                              //     screen: WhislistScreen(widget.data),
                              //     withNavBar:
                              //     false, // OPTIONAL VALUE. True by default.
                              //     pageTransitionAnimation:
                              //     PageTransitionAnimation.cupertino,
                              //   );
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
                            }),
                        // AppbarSubtitle6(
                        //     text: "lbl_2".tr,
                        //     margin: getMargin(left: 17, bottom: 13))
                      ])),
                  Container(
                      height: getVerticalSize(24),
                      width: getHorizontalSize(29),
                      margin: getMargin(left: 14, top: 5, right: 31, bottom: 0),
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
                              // pushScreen(
                              //   context,
                              //   screen: CartScreen(widget.data),
                              //   withNavBar:
                              //   false, // OPTIONAL VALUE. True by default.
                              //   pageTransitionAnimation:
                              //   PageTransitionAnimation.cupertino,
                              // );
                              // Navigator.of(context).pushReplacement(MaterialPageRoute(
                              //   builder: (context) => LogInScreen(),
                              // ));
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
            body: FutureBuilder(
              future: product,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SingleChildScrollView(
                    child: Container(
                        width: double.maxFinite,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                  padding: getPadding(left: 11, top: 11),
                                  child: Text(productlist!.name!,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: AppStyle.txtRobotoRegular18)),
                              Padding(
                                  padding: getPadding(left: 11, top: 2),
                                  child: Text("by " + productlist!.brandName!,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: AppStyle
                                          .txtRobotoRegular12Purple700)),
                              Container(
                                  height: getVerticalSize(215),
                                  width: double.maxFinite,
                                  margin: getMargin(top: 5),
                                  child: Stack(
                                      alignment: Alignment.topRight,
                                      children: [
                                        productImages.length != 0
                                            ? carousel.CarouselSlider.builder(
                                                options: carousel.CarouselOptions(
                                                  height: getVerticalSize(215),
                                                  initialPage: 0,
                                                  autoPlay: true,
                                                  viewportFraction: 1.0,
                                                  enableInfiniteScroll: true,
                                                  autoPlayCurve:
                                                      Curves.fastOutSlowIn,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  onPageChanged:
                                                      (index, reason) {
                                                    silderIndex = index;
                                                  },
                                                  // onScrolled: (index) {
                                                  //   controller.silderIndex.value =
                                                  //       index as int;
                                                  // }
                                                ),
                                                itemCount: productImages.length,
                                                itemBuilder: (context, index,
                                                    realIndex) {
                                                  // SliderItemModel model = controller
                                                  //     .productDetailModelObj
                                                  //     .value
                                                  //     .sliderItemList[index];
                                                  return GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              documentViewer(
                                                                  productImages[
                                                                          index]
                                                                      .images!,
                                                                  context),
                                                        ),
                                                      );
                                                    },
                                                    child: Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: CustomImageView(
                                                        url:
                                                            productImages[index]
                                                                .images!,
                                                        height: getVerticalSize(
                                                          215,
                                                        ),
                                                        width:
                                                            getHorizontalSize(
                                                          428,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                  // SliderItemWidget(model);
                                                })
                                            : GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          documentViewer(
                                                              productlist!
                                                                  .image!,
                                                              context),
                                                    ),
                                                  );
                                                },
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: CustomImageView(
                                                    url: productlist!.image!,
                                                    height: getVerticalSize(
                                                      215,
                                                    ),
                                                    width: getHorizontalSize(
                                                      428,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                        Align(
                                            alignment: Alignment.topRight,
                                            child: Container(
                                                width: getHorizontalSize(60),
                                                padding: getPadding(
                                                    left: 9,
                                                    top: 2,
                                                    right: 9,
                                                    bottom: 2),
                                                decoration: AppDecoration
                                                    .txtOutlineBlack9003f1
                                                    .copyWith(
                                                        borderRadius:
                                                            BorderRadiusStyle
                                                                .txtCustomBorderBL20),
                                                child: Text("lbl_30_off2".tr,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.left,
                                                    style: AppStyle
                                                        .txtRobotoMedium9)))
                                      ])),
                              // Align(
                              //     alignment: Alignment.centerLeft,
                              //     child: Container(
                              //         height: getVerticalSize(8),
                              //         margin: getMargin(top: 6),
                              //         padding: EdgeInsets.only(left: 37.w),
                              //         child: SmoothIndicator(
                              //             offset: 0,
                              //             count: 5,
                              //             // axisDirection: Axis.horizontal,
                              //             effect: ScrollingDotsEffect(
                              //                 spacing: 10,
                              //                 activeDotColor: ColorConstant.purple900,
                              //                 dotColor: ColorConstant.gray40003,
                              //                 dotHeight: getVerticalSize(8),
                              //                 dotWidth: getHorizontalSize(8)), size: Size(0, 0),))),
                              Padding(
                                  padding: getPadding(top: 9),
                                  child: Divider(
                                      height: getVerticalSize(1),
                                      thickness: getVerticalSize(1),
                                      color: ColorConstant.purple50)),
                              Padding(
                                  padding:
                                      getPadding(left: 11, top: 9, right: 10),
                                  child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        CustomImageView(
                                            svgPath: ImageConstant.imgCut,
                                            height: getVerticalSize(14),
                                            width: getHorizontalSize(9),
                                            margin: getMargin(bottom: 4)),
                                        Padding(
                                            padding: getPadding(left: 2),
                                            child: Text(productlist!.salePrice!,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style: AppStyle
                                                    .txtRobotoMedium14Purple900)),
                                        CustomImageView(
                                            svgPath: ImageConstant.imgCall,
                                            height: getVerticalSize(11),
                                            width: getHorizontalSize(7),
                                            margin: getMargin(
                                                left: 11, top: 2, bottom: 5)),
                                        Container(
                                            height: getVerticalSize(15),
                                            width: getHorizontalSize(37),
                                            margin: getMargin(left: 3, top: 2),
                                            child: Stack(
                                                alignment: Alignment.topCenter,
                                                children: [
                                                  Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                          productlist!
                                                              .mrpPrice!,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: AppStyle
                                                              .txtRobotoMedium12Gray500)),
                                                  Align(
                                                      alignment:
                                                          Alignment.topCenter,
                                                      child: Padding(
                                                          padding: getPadding(
                                                              top: 6),
                                                          child: SizedBox(
                                                              width:
                                                                  getHorizontalSize(
                                                                      37),
                                                              child: Divider(
                                                                  height:
                                                                      getVerticalSize(
                                                                          1),
                                                                  thickness:
                                                                      getVerticalSize(
                                                                          1),
                                                                  color: ColorConstant
                                                                      .gray500))))
                                                ])),
                                        Padding(
                                            padding: getPadding(
                                                left: 5, top: 4, bottom: 3),
                                            child: Text(
                                                "msg_inclusive_of_all".tr,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style:
                                                    AppStyle.txtRobotoLight8)),
                                        Spacer(),
                                        // CustomImageView(
                                        //     svgPath: ImageConstant.imgShare,
                                        //     height: getSize(16),
                                        //     width: getSize(16),
                                        //     margin: getMargin(top: 2))
                                      ])),
                              Padding(
                                  padding: getPadding(left: 11, top: 7),
                                  child: Row(children: [
                                    Padding(
                                        padding: getPadding(bottom: 1),
                                        child: Text("lbl_total_saving".tr,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: AppStyle
                                                .txtRobotoRegular8Gray600)),
                                    CustomImageView(
                                        svgPath:
                                            ImageConstant.imgVectorPurple7008x5,
                                        height: getVerticalSize(8),
                                        width: getHorizontalSize(5),
                                        margin: getMargin(left: 6, bottom: 3)),
                                    Padding(
                                        padding: getPadding(left: 4),
                                        child: Text(productlist!.discountPrice!,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: AppStyle
                                                .txtRobotoMedium10Purple700))
                                  ])),
                              Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                      padding: getPadding(top: 16),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Column(
                                              children: [
                                                CustomIconButton(
                                                    height: 30,
                                                    width: 30,
                                                    child: CustomImageView(
                                                        svgPath: ImageConstant
                                                            .imgCalendar)),
                                                Container(
                                                    // width: getHorizontalSize(50),
                                                    child: Text(
                                                        "EMI from\n" +
                                                            productlist!
                                                                .emiOption!,
                                                        maxLines: null,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: AppStyle
                                                            .txtRobotoRegular8Black900)),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                CustomIconButton(
                                                    height: 30,
                                                    width: 30,
                                                    margin: getMargin(left: 30),
                                                    child: CustomImageView(
                                                        svgPath: ImageConstant
                                                            .imgCheckmark)),
                                                Container(
                                                    // width: getHorizontalSize(38),
                                                    margin: getMargin(
                                                        left: 28, bottom: 8),
                                                    child: Text(
                                                        productlist!
                                                                .monthWarrenty! +
                                                            " Months \nWarranty",
                                                        maxLines: null,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: AppStyle
                                                            .txtRobotoRegular8Black900)),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                CustomIconButton(
                                                    height: 30,
                                                    width: 30,
                                                    margin: getMargin(left: 38),
                                                    child: CustomImageView(
                                                        svgPath: ImageConstant
                                                            .imgCutWhiteA700)),
                                                Container(
                                                    // width: getHorizontalSize(24),
                                                    margin: getMargin(
                                                        left: 36, bottom: 10),
                                                    child: Text(
                                                        productlist!
                                                            .easyReturn!,
                                                        maxLines: null,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: AppStyle
                                                            .txtRobotoRegular8Black900)),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                CustomIconButton(
                                                    height: 30,
                                                    width: 30,
                                                    margin: getMargin(left: 38),
                                                    padding: IconButtonPadding
                                                        .PaddingAll5,
                                                    child: CustomImageView(
                                                        svgPath: ImageConstant
                                                            .imgCarWhiteA700)),
                                                Container(
                                                    // width: getHorizontalSize(28),
                                                    margin: getMargin(
                                                        left: 43, bottom: 8),
                                                    child: Text(
                                                        productlist!
                                                            .safeDelivery!,
                                                        maxLines: null,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: AppStyle
                                                            .txtRobotoRegular8Black900))
                                              ],
                                            )
                                          ]))),
                              Padding(
                                  padding: getPadding(left: 20, top: 19),
                                  child: Row(children: [
                                    DropdownButton<String>(
                                      hint: Text(
                                        " Qty  ",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      items:
                                          dropdownItemList.map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (dynamic newValue) {
                                        setState(() {
                                          errorMsg = '';
                                          _selectedQty = newValue;
                                          print(_selectedQty);
                                        });
                                      },
                                      iconEnabledColor: Colors.purple,
                                      value: _selectedQty,
                                      enableFeedback: true,
                                      style: TextStyle(
                                          color: Colors.purple, fontSize: 15),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(
                                          getHorizontalSize(
                                            0.00,
                                          ),
                                        ),
                                        topRight: Radius.circular(
                                          getHorizontalSize(
                                            0.00,
                                          ),
                                        ),
                                        bottomLeft: Radius.circular(
                                          getHorizontalSize(
                                            0.00,
                                          ),
                                        ),
                                        bottomRight: Radius.circular(
                                          getHorizontalSize(
                                            25.00,
                                          ),
                                        ),
                                      ),
                                    ),
                                    // CustomButton(
                                    //     height: getVerticalSize(20),
                                    //     width: getHorizontalSize(60),
                                    //     text: "lbl_qty_1".tr,
                                    //     variant: ButtonVariant.OutlinePurple700,
                                    //     shape: ButtonShape.CustomBorderBR25,
                                    //     padding: ButtonPadding.PaddingT5,
                                    //     fontStyle: ButtonFontStyle.RobotoRegular8,
                                    //     suffixWidget: Container(
                                    //         margin: getMargin(left: 5),
                                    //         // decoration: BoxDecoration(
                                    //         //     color: ColorConstant.purple900),
                                    //         child: Image(
                                    //             image: AssetImage(
                                    //                 'assets/images/arrow_down.png')))),
                                    // Padding(
                                    //     padding:
                                    //     getPadding(left: 9, top: 5, bottom: 4),
                                    //     child: Text("lbl_only_2_left".tr,
                                    //         overflow: TextOverflow.ellipsis,
                                    //         textAlign: TextAlign.left,
                                    //         style:
                                    //         AppStyle.txtRobotoRegular8Yellow900))
                                  ])),
                              CustomButton(
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
                                  height: getVerticalSize(35),
                                  text: "lbl_buy_now".tr,
                                  margin:
                                      getMargin(left: 10, top: 14, right: 10),
                                  variant: ButtonVariant.FillPurple900,
                                  shape: ButtonShape.Square,
                                  fontStyle: ButtonFontStyle.RobotoMedium16),
                              Padding(
                                  padding:
                                      getPadding(left: 10, top: 12, right: 10),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomButton(
                                            onTap: () {
                                              pushScreen(
                                                context,
                                                screen: LogInScreen(),
                                                withNavBar:
                                                    false, // OPTIONAL VALUE. True by default.
                                                pageTransitionAnimation:
                                                    PageTransitionAnimation
                                                        .cupertino,
                                              );
                                              // Navigator.of(context).pushReplacement(MaterialPageRoute(
                                              //   builder: (context) => LogInScreen(),
                                              // ));
                                              // addtowishlist();
                                            },
                                            height: getVerticalSize(35),
                                            width: getHorizontalSize(200),
                                            text: "lbl_add_to_wishlist".tr,
                                            variant: ButtonVariant.FillGray500,
                                            shape: ButtonShape.CustomBorderBL50,
                                            fontStyle:
                                                ButtonFontStyle.RobotoMedium16),
                                        CustomButton(
                                            onTap: () {
                                              pushScreen(
                                                context,
                                                screen: LogInScreen(),
                                                withNavBar:
                                                    false, // OPTIONAL VALUE. True by default.
                                                pageTransitionAnimation:
                                                    PageTransitionAnimation
                                                        .cupertino,
                                              );
                                              // Navigator.of(context).pushReplacement(MaterialPageRoute(
                                              //   builder: (context) => LogInScreen(),
                                              // ));
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
                                            height: getVerticalSize(35),
                                            width: getHorizontalSize(190),
                                            text: "lbl_add_to_cart".tr,
                                            variant: ButtonVariant.FillRed800,
                                            fontStyle:
                                                ButtonFontStyle.RobotoMedium16)
                                      ])),
                              Container(
                                  margin:
                                      getMargin(left: 10, top: 14, right: 10),
                                  padding: getPadding(
                                      left: 18, top: 6, right: 18, bottom: 6),
                                  decoration: AppDecoration.fillPurple5001,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                            padding: getPadding(top: 1),
                                            child: Text(
                                                "msg_delivery_services".tr,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style: AppStyle
                                                    .txtRobotoRegular14Black900)),
                                        Padding(
                                            padding: getPadding(top: 7),
                                            child: Divider(
                                                height: getVerticalSize(1),
                                                thickness: getVerticalSize(1),
                                                color:
                                                    ColorConstant.gray40002)),
                                        Container(
                                          margin: getMargin(
                                              left: 2, top: 10, right: 2),
                                          padding: getPadding(
                                              left: 11,
                                              top: 9,
                                              right: 5,
                                              bottom: 9),
                                          decoration:
                                              AppDecoration.outlineBlack90019,
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
                                                        margin: getMargin(
                                                            bottom: 1),
                                                        variant:
                                                            TextFormFieldVariant
                                                                .None,
                                                        fontStyle:
                                                            TextFormFieldFontStyle
                                                                .RobotoMedium11,
                                                        // textInputAction:
                                                        // TextInputAction.done,
                                                        // textInputType:
                                                        // TextInputType.number,
                                                        validator: (value) {
                                                          if (!isNumeric(
                                                              value!)) {
                                                            return "Please enter valid number";
                                                          }
                                                          return null;
                                                        })),
                                                InkWell(
                                                  onTap: () {
                                                    SystemChannels.textInput
                                                        .invokeMethod(
                                                            'TextInput.hide');
                                                    print("tapped");
                                                    checkPincode();
                                                    pincodeController.clear();
                                                  },
                                                  child: Padding(
                                                      padding: getPadding(
                                                          left: 5, right: 1),
                                                      child: Text(
                                                          "lbl_check".tr,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: AppStyle
                                                              .txtRobotoMedium11)),
                                                )
                                              ]),

                                          // Row(
                                          //     mainAxisAlignment:
                                          //         MainAxisAlignment.center,
                                          //     mainAxisSize: MainAxisSize.min,
                                          //     children: [
                                          //       Padding(
                                          //           padding: getPadding(left: 1),
                                          //           child: TextField(
                                          //             controller: pincodeController,
                                          //               textAlign: TextAlign.left,
                                          //               style: AppStyle
                                          //                   .txtRobotoRegular12Gray600)),
                                          //       Padding(
                                          //           padding: getPadding(left: 265),
                                          //           child: Text("lbl_apply".tr,
                                          //               overflow:
                                          //                   TextOverflow.ellipsis,
                                          //               textAlign: TextAlign.left,
                                          //               style: AppStyle
                                          //                   .txtRobotoMedium12Purple900))
                                          //     ])
                                        ),
                                        Container(
                                            width: getHorizontalSize(194),
                                            margin: getMargin(top: 12),
                                            child: Text(
                                                "msg_enter_pincode_to".tr,
                                                maxLines: null,
                                                textAlign: TextAlign.center,
                                                style: AppStyle
                                                    .txtRobotoRegular10Gray600
                                                    .copyWith(
                                                        letterSpacing:
                                                            getHorizontalSize(
                                                                0.5)))),
                                        Container(
                                            width: getHorizontalSize(174),
                                            margin: getMargin(top: 4),
                                            child: Text(
                                                "msg_delivery_assembly".tr,
                                                maxLines: null,
                                                textAlign: TextAlign.center,
                                                style: AppStyle
                                                    .txtRobotoRegular10Gray800
                                                    .copyWith(
                                                        letterSpacing:
                                                            getHorizontalSize(
                                                                0.5))))
                                      ])),
                              attributes.length != 0
                                  ? Container(
                                      margin: getMargin(
                                          left: 10, top: 10, right: 10),
                                      padding: getPadding(
                                          left: 18,
                                          top: 8,
                                          right: 18,
                                          bottom: 8),
                                      decoration: AppDecoration.fillPurple5001,
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                    "msg_delivery_services".tr,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.left,
                                                    style: AppStyle
                                                        .txtRobotoRegular14Black900)),
                                            Padding(
                                                padding: getPadding(top: 7),
                                                child: Divider(
                                                    height: getVerticalSize(1),
                                                    thickness:
                                                        getVerticalSize(1),
                                                    color:
                                                        ColorConstant.gray40002,
                                                    indent:
                                                        getHorizontalSize(1))),

                                            Container(
                                              width: 400,
                                              height: 200,
                                              child: ListView.builder(
                                                  itemCount: attributes.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Padding(
                                                        padding: getPadding(
                                                            left: 0, top: 8),
                                                        child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            children: [
                                                              FittedBox(
                                                                fit:
                                                                    BoxFit.fill,
                                                                child:
                                                                    Container(
                                                                  width: 120,
                                                                  child: Text(
                                                                      attributes[index]
                                                                              .productKey!
                                                                              .capitalizeFirst! +
                                                                          ":",
                                                                      overflow: TextOverflow
                                                                          .ellipsis,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style: AppStyle
                                                                          .txtRobotoRegular15),
                                                                ),
                                                              ),
                                                              FittedBox(
                                                                fit:
                                                                    BoxFit.fill,
                                                                child: Container(
                                                                    width: 200,
                                                                    padding:
                                                                        getPadding(
                                                                            left:
                                                                                0),
                                                                    child: Text(
                                                                        attributes[index]
                                                                            .productValue!,
                                                                        overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                        textAlign:
                                                                            TextAlign
                                                                                .left,
                                                                        style: AppStyle
                                                                            .txtRobotoRegular15)),
                                                              )
                                                            ]));
                                                  }),
                                            ),
                                            // Padding(
                                            //     padding: getPadding(left: 8, top: 8),
                                            //     child: Row(children: [
                                            //       Text("lbl_brand".tr,
                                            //           overflow: TextOverflow.ellipsis,
                                            //           textAlign: TextAlign.left,
                                            //           style: AppStyle
                                            //               .txtRobotoRegular10Bluegray900),
                                            //       Padding(
                                            //           padding: getPadding(left: 84),
                                            //           child: Text(productlist.brandName,
                                            //               overflow: TextOverflow.ellipsis,
                                            //               textAlign: TextAlign.left,
                                            //               style: AppStyle
                                            //                   .txtRobotoRegular10Bluegray900))
                                            //     ])),
                                            // Padding(
                                            //     padding: getPadding(
                                            //         left: 8, top: 8, right: 92),
                                            //     child: Row(
                                            //         crossAxisAlignment:
                                            //         CrossAxisAlignment.start,
                                            //         children: [
                                            //           Padding(
                                            //               padding: getPadding(bottom: 15),
                                            //               child: Text("lbl_dimension".tr,
                                            //                   overflow:
                                            //                   TextOverflow.ellipsis,
                                            //                   textAlign: TextAlign.left,
                                            //                   style: AppStyle
                                            //                       .txtRobotoRegular10Bluegray900)),
                                            //           Container(
                                            //               width: getHorizontalSize(159),
                                            //               margin: getMargin(left: 63),
                                            //               child: Text(
                                            //                   "msg_h_37_5_w_62".tr,
                                            //                   maxLines: null,
                                            //                   textAlign: TextAlign.left,
                                            //                   style: AppStyle
                                            //                       .txtRobotoRegular10Bluegray9001))
                                            //         ])),
                                            // Padding(
                                            //     padding: getPadding(left: 8, top: 6),
                                            //     child: Row(children: [
                                            //       Text("lbl_weight".tr,
                                            //           overflow: TextOverflow.ellipsis,
                                            //           textAlign: TextAlign.left,
                                            //           style: AppStyle
                                            //               .txtRobotoRegular10Bluegray900),
                                            //       Padding(
                                            //           padding: getPadding(left: 79),
                                            //           child: Text("lbl_46_2_kg".tr,
                                            //               overflow: TextOverflow.ellipsis,
                                            //               textAlign: TextAlign.left,
                                            //               style: AppStyle
                                            //                   .txtRobotoRegular10Bluegray900))
                                            //     ])),
                                            // Padding(
                                            //     padding: getPadding(left: 8, top: 9),
                                            //     child: Row(children: [
                                            //       Text("lbl_warrenty".tr,
                                            //           overflow: TextOverflow.ellipsis,
                                            //           textAlign: TextAlign.left,
                                            //           style: AppStyle
                                            //               .txtRobotoRegular10Bluegray900),
                                            //       Padding(
                                            //           padding: getPadding(left: 70),
                                            //           child: Text(
                                            //               "msg_12_months_warrenty2".tr,
                                            //               overflow: TextOverflow.ellipsis,
                                            //               textAlign: TextAlign.left,
                                            //               style: AppStyle
                                            //                   .txtRobotoRegular10Bluegray900))
                                            //     ])),
                                            // Padding(
                                            //     padding: getPadding(left: 8, top: 8),
                                            //     child: Row(children: [
                                            //       Text("lbl_assembly".tr,
                                            //           overflow: TextOverflow.ellipsis,
                                            //           textAlign: TextAlign.left,
                                            //           style: AppStyle
                                            //               .txtRobotoRegular10Bluegray900),
                                            //       Padding(
                                            //           padding: getPadding(left: 66),
                                            //           child: Text(
                                            //               "msg_carpenter_assembly".tr,
                                            //               overflow: TextOverflow.ellipsis,
                                            //               textAlign: TextAlign.left,
                                            //               style: AppStyle
                                            //                   .txtRobotoRegular10Bluegray900))
                                            //     ])),
                                            // Padding(
                                            //     padding: getPadding(left: 8, top: 7),
                                            //     child: Row(children: [
                                            //       Padding(
                                            //           padding: getPadding(top: 1),
                                            //           child: Text(
                                            //               "msg_primary_material".tr,
                                            //               overflow: TextOverflow.ellipsis,
                                            //               textAlign: TextAlign.left,
                                            //               style: AppStyle
                                            //                   .txtRobotoRegular10Bluegray900)),
                                            //       Padding(
                                            //           padding:
                                            //           getPadding(left: 37, bottom: 1),
                                            //           child: Text("lbl_fabric".tr,
                                            //               overflow: TextOverflow.ellipsis,
                                            //               textAlign: TextAlign.left,
                                            //               style: AppStyle
                                            //                   .txtRobotoRegular10Bluegray900))
                                            //     ])),
                                            // Padding(
                                            //     padding: getPadding(left: 8, top: 9),
                                            //     child: Row(children: [
                                            //       Text("lbl_room_type".tr,
                                            //           overflow: TextOverflow.ellipsis,
                                            //           textAlign: TextAlign.left,
                                            //           style: AppStyle
                                            //               .txtRobotoRegular10Bluegray900),
                                            //       Padding(
                                            //           padding: getPadding(left: 60),
                                            //           child: Text("lbl_living_room".tr,
                                            //               overflow: TextOverflow.ellipsis,
                                            //               textAlign: TextAlign.left,
                                            //               style: AppStyle
                                            //                   .txtRobotoRegular10Bluegray900))
                                            //     ])),
                                            // Padding(
                                            //     padding: getPadding(left: 8, top: 7),
                                            //     child: Row(children: [
                                            //       Text("lbl_seating_height".tr,
                                            //           overflow: TextOverflow.ellipsis,
                                            //           textAlign: TextAlign.left,
                                            //           style: AppStyle
                                            //               .txtRobotoRegular10Bluegray900),
                                            //       Padding(
                                            //           padding: getPadding(left: 45),
                                            //           child: Text("lbl_18".tr,
                                            //               overflow: TextOverflow.ellipsis,
                                            //               textAlign: TextAlign.left,
                                            //               style: AppStyle
                                            //                   .txtRobotoRegular10Bluegray900))
                                            //     ])),
                                            // Padding(
                                            //     padding: getPadding(left: 8, top: 8),
                                            //     child: Row(children: [
                                            //       Text("lbl_color".tr,
                                            //           overflow: TextOverflow.ellipsis,
                                            //           textAlign: TextAlign.left,
                                            //           style: AppStyle
                                            //               .txtRobotoRegular10Bluegray900),
                                            //       Padding(
                                            //           padding: getPadding(left: 86),
                                            //           child: Text("lbl_black".tr,
                                            //               overflow: TextOverflow.ellipsis,
                                            //               textAlign: TextAlign.left,
                                            //               style: AppStyle
                                            //                   .txtRobotoRegular10Bluegray900))
                                            //     ])),
                                            // Padding(
                                            //     padding: getPadding(
                                            //         left: 8, top: 9, bottom: 5),
                                            //     child: Text("lbl_sku".tr,
                                            //         overflow: TextOverflow.ellipsis,
                                            //         textAlign: TextAlign.left,
                                            //         style: AppStyle
                                            //             .txtRobotoRegular10Bluegray900))
                                          ]))
                                  : Container(),
                              Container(
                                  // height: getVerticalSize(442),
                                  width: double.maxFinite,
                                  margin: getMargin(top: 10),
                                  child: Stack(
                                      alignment: Alignment.bottomCenter,
                                      children: [
                                        Align(
                                            alignment: Alignment.topCenter,
                                            child: Container(
                                                padding: getPadding(
                                                    top: 9, bottom: 9),
                                                decoration:
                                                    AppDecoration.fillPurple50,
                                                child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                          "lbl_similar_prodcut"
                                                              .tr,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: AppStyle
                                                              .txtRobotoMedium13
                                                              .copyWith(
                                                                  letterSpacing:
                                                                      getHorizontalSize(
                                                                          0.26))),
                                                      Container(
                                                          height:
                                                              getVerticalSize(
                                                                  130),
                                                          child: ListView
                                                              .separated(
                                                                  padding:
                                                                      getPadding(
                                                                          left:
                                                                              16,
                                                                          top:
                                                                              11),
                                                                  scrollDirection:
                                                                      Axis
                                                                          .horizontal,
                                                                  separatorBuilder:
                                                                      (context,
                                                                          index) {
                                                                    return SizedBox(
                                                                        height:
                                                                            getVerticalSize(10));
                                                                  },
                                                                  itemCount:
                                                                      similarProduct
                                                                          .length,
                                                                  // controller
                                                                  //     .productDetailScrollOneModelObj
                                                                  //     .value
                                                                  //     .listpriceItemList
                                                                  //     .length,
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    // ListpriceItemModel
                                                                    // model =
                                                                    // controller
                                                                    //     .productDetailScrollOneModelObj
                                                                    //     .value
                                                                    //     .listpriceItemList[index];
                                                                    return GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pushReplacement(MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              ProductDetailScreen1(similarProduct[index].id!),
                                                                        ));
                                                                      },
                                                                      child:
                                                                          FittedBox(
                                                                        fit: BoxFit
                                                                            .fill,
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              90.w,
                                                                          margin:
                                                                              getMargin(
                                                                            right:
                                                                                10,
                                                                          ),
                                                                          padding:
                                                                              getPadding(
                                                                            left:
                                                                                10,
                                                                            top:
                                                                                4,
                                                                            right:
                                                                                10,
                                                                            bottom:
                                                                                4,
                                                                          ),
                                                                          decoration:
                                                                              AppDecoration.fillWhiteA700,
                                                                          child:
                                                                              Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.end,
                                                                            children: [
                                                                              CustomImageView(
                                                                                url: similarProduct[index].image!,
                                                                                height: getSize(
                                                                                  130,
                                                                                ),
                                                                                width: getSize(
                                                                                  300,
                                                                                ),
                                                                                margin: getMargin(
                                                                                  top: 5,
                                                                                ),
                                                                              ),
                                                                              Padding(
                                                                                padding: getPadding(
                                                                                  top: 5,
                                                                                ),
                                                                                child: Text(
                                                                                  similarProduct[index].name!,
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                  textAlign: TextAlign.left,
                                                                                  maxLines: 1,
                                                                                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: ColorConstant.black900, fontFamily: 'Roboto'),
                                                                                ),
                                                                              ),
                                                                              Padding(
                                                                                padding: getPadding(
                                                                                  top: 5,
                                                                                ),
                                                                                child: Text(
                                                                                  similarProduct[index].description!,
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                  textAlign: TextAlign.left,
                                                                                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: ColorConstant.black900, fontFamily: 'Roboto'),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    );
                                                                    // ListpriceItemWidget(model);
                                                                  })),
                                                      CustomButton(
                                                          onTap: () {
                                                            setState(() {
                                                              expanded =
                                                                  !expanded;
                                                            });
                                                          },
                                                          height:
                                                              getVerticalSize(
                                                                  30),
                                                          text:
                                                              " Additional Info",
                                                          margin: getMargin(
                                                              left: 15,
                                                              top: 15,
                                                              right: 14),
                                                          shape: ButtonShape
                                                              .Square),
                                                      AnimatedContainer(
                                                        padding:
                                                            EdgeInsets.all(20),
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    200),
                                                        height:
                                                            expanded ? 250 : 0,
                                                        width: expanded
                                                            ? 100.w
                                                            : 0,
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  20),
                                                          decoration: BoxDecoration(
                                                              color: Color(
                                                                  0xffF7F8F9),
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          20)),
                                                              boxShadow: const [
                                                                BoxShadow(
                                                                  color: Colors
                                                                      .grey,
                                                                  offset:
                                                                      Offset(
                                                                          0.0,
                                                                          1.0),
                                                                  blurRadius:
                                                                      6.0,
                                                                ),
                                                              ]),
                                                          child:
                                                              SingleChildScrollView(
                                                            child: Column(
                                                              children: <Widget>[
                                                                Padding(
                                                                    padding: getPadding(
                                                                        left: 0,
                                                                        top: 8),
                                                                    child: Row(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment
                                                                                .start,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceAround,
                                                                        children: [
                                                                          FittedBox(
                                                                            fit:
                                                                                BoxFit.fill,
                                                                            child:
                                                                                Container(
                                                                              width: 75.w,
                                                                              child: Text(productlist!.additionalInformation != "" ? productlist!.additionalInformation! : "No Data Found", overflow: TextOverflow.ellipsis, textAlign: TextAlign.left, style: AppStyle.txtRobotoRegular15),
                                                                            ),
                                                                          ),
                                                                          // FittedBox(
                                                                          //   fit: BoxFit.fill,
                                                                          //   child: Container(
                                                                          //       width: 200,
                                                                          //       padding: getPadding(left: 0),
                                                                          //       child: Text(attributes[index].productValue,
                                                                          //           overflow: TextOverflow.ellipsis,
                                                                          //           textAlign: TextAlign.left,
                                                                          //           style: AppStyle
                                                                          //               .txtRobotoRegular15)),
                                                                          // )
                                                                        ])),
                                                                // Container(
                                                                //   height:50,
                                                                //   padding: EdgeInsets.all(5),
                                                                //   decoration: BoxDecoration(
                                                                //       color: Colors.white,
                                                                //       borderRadius: BorderRadius.all(
                                                                //           Radius.circular(15)),
                                                                //       boxShadow: const [
                                                                //         BoxShadow(
                                                                //           color: Colors.grey,
                                                                //           offset: Offset(0.0, 0.0),
                                                                //           blurRadius: 1.0,
                                                                //         ),
                                                                //       ]),
                                                                //   child: Row(
                                                                //     children: <Widget>[
                                                                //       IconButton(
                                                                //           onPressed: () {},
                                                                //           icon: Image.asset(
                                                                //               'assets/images/img_22.png')),
                                                                //       SizedBox(width: 10,),
                                                                //       Text('**** 8295'),
                                                                //       SizedBox(
                                                                //         width: 130,
                                                                //       ),
                                                                //       IconButton(
                                                                //         onPressed: () {},
                                                                //         icon: Icon(
                                                                //           Icons.arrow_forward_ios,size: 15,),)
                                                                //     ],
                                                                //   ),
                                                                // ),
                                                                // SizedBox(height: 10,),
                                                                // Container(
                                                                //   height:50,
                                                                //   padding: EdgeInsets.all(5),
                                                                //   decoration: BoxDecoration(
                                                                //       color: Colors.white,
                                                                //       borderRadius: BorderRadius.all(
                                                                //           Radius.circular(15)),
                                                                //       boxShadow: const [
                                                                //         BoxShadow(
                                                                //           color: Colors.grey,
                                                                //           offset: Offset(0.0, 0.0),
                                                                //           blurRadius: 1.0,
                                                                //         ),
                                                                //       ]),
                                                                //   child: Row(
                                                                //     children: <Widget>[
                                                                //       IconButton(
                                                                //           onPressed: () {},
                                                                //           icon: Image.asset(
                                                                //               'assets/images/img_23.png')),
                                                                //       SizedBox(width: 10,),
                                                                //       Text('**** 3704'),
                                                                //       SizedBox(
                                                                //         width: 130,
                                                                //       ),
                                                                //       IconButton(
                                                                //         onPressed: () {},
                                                                //         icon: Icon(
                                                                //           Icons.arrow_forward_ios,size: 15,),)
                                                                //     ],
                                                                //   ),
                                                                // ),
                                                                // SizedBox(height: 10,),
                                                                // Container(
                                                                //   height:50,
                                                                //   padding: EdgeInsets.all(5),
                                                                //   decoration: BoxDecoration(
                                                                //       color: Colors.white,
                                                                //       borderRadius: BorderRadius.all(
                                                                //           Radius.circular(15)),
                                                                //       boxShadow: const [
                                                                //         BoxShadow(
                                                                //           color: Colors.grey,
                                                                //           offset: Offset(0.0, 0.0),
                                                                //           blurRadius: 1.0,
                                                                //         ),
                                                                //       ]),
                                                                //   child: Row(
                                                                //     children: <Widget>[
                                                                //       IconButton(
                                                                //           onPressed: () {},
                                                                //           icon: Image.asset(
                                                                //               'assets/images/img_24.png')),
                                                                //       SizedBox(width: 10,),
                                                                //       Text('Cash'),
                                                                //       SizedBox(
                                                                //         width: 160,
                                                                //       ),
                                                                //       IconButton(
                                                                //         onPressed: () {},
                                                                //         icon: Icon(
                                                                //           Icons.arrow_forward_ios,size: 15,),)
                                                                //     ],
                                                                //   ),
                                                                // )
                                                              ],
                                                            ),
                                                          ),
                                                          // height: 120,
                                                        ),
                                                      ),
                                                      CustomButton(
                                                          onTap: () {
                                                            setState(() {
                                                              expanded1 =
                                                                  !expanded1;
                                                            });
                                                          },
                                                          height:
                                                              getVerticalSize(
                                                                  30),
                                                          text:
                                                              "  Customer Redressal",
                                                          margin: getMargin(
                                                              left: 15,
                                                              top: 10,
                                                              right: 14),
                                                          shape: ButtonShape
                                                              .Square),
                                                      AnimatedContainer(
                                                        padding:
                                                            EdgeInsets.all(20),
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    200),
                                                        height:
                                                            expanded1 ? 250 : 0,
                                                        width: expanded1
                                                            ? 100.w
                                                            : 0,
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  20),
                                                          decoration: BoxDecoration(
                                                              color: Color(
                                                                  0xffF7F8F9),
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          20)),
                                                              boxShadow: const [
                                                                BoxShadow(
                                                                  color: Colors
                                                                      .grey,
                                                                  offset:
                                                                      Offset(
                                                                          0.0,
                                                                          1.0),
                                                                  blurRadius:
                                                                      6.0,
                                                                ),
                                                              ]),
                                                          child:
                                                              SingleChildScrollView(
                                                            child: Column(
                                                              children: <Widget>[
                                                                Padding(
                                                                    padding: getPadding(
                                                                        left: 0,
                                                                        top: 8),
                                                                    child: Row(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment
                                                                                .start,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceAround,
                                                                        children: [
                                                                          FittedBox(
                                                                            fit:
                                                                                BoxFit.fill,
                                                                            child:
                                                                                Container(
                                                                              width: 75.w,
                                                                              child: Text(productlist!.customerRedressal != "" ? productlist!.customerRedressal! : "No Data Found", overflow: TextOverflow.ellipsis, textAlign: TextAlign.left, style: AppStyle.txtRobotoRegular15),
                                                                            ),
                                                                          ),
                                                                        ])),
                                                              ],
                                                            ),
                                                          ),
                                                          // height: 120,
                                                        ),
                                                      ),
                                                      CustomButton(
                                                          onTap: () {
                                                            setState(() {
                                                              expanded2 =
                                                                  !expanded2;
                                                            });
                                                          },
                                                          height:
                                                              getVerticalSize(
                                                                  30),
                                                          text:
                                                              " Merchant Info",
                                                          margin: getMargin(
                                                              left: 15,
                                                              top: 10,
                                                              right: 14),
                                                          shape: ButtonShape
                                                              .Square),
                                                      AnimatedContainer(
                                                        padding:
                                                            EdgeInsets.all(20),
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    200),
                                                        height:
                                                            expanded2 ? 250 : 0,
                                                        width: expanded2
                                                            ? 100.w
                                                            : 0,
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  20),
                                                          decoration: BoxDecoration(
                                                              color: Color(
                                                                  0xffF7F8F9),
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          20)),
                                                              boxShadow: const [
                                                                BoxShadow(
                                                                  color: Colors
                                                                      .grey,
                                                                  offset:
                                                                      Offset(
                                                                          0.0,
                                                                          1.0),
                                                                  blurRadius:
                                                                      6.0,
                                                                ),
                                                              ]),
                                                          child:
                                                              SingleChildScrollView(
                                                            child: Column(
                                                              children: <Widget>[
                                                                Padding(
                                                                    padding: getPadding(
                                                                        left: 0,
                                                                        top: 8),
                                                                    child: Row(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment
                                                                                .start,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceAround,
                                                                        children: [
                                                                          FittedBox(
                                                                            fit:
                                                                                BoxFit.fill,
                                                                            child:
                                                                                Container(
                                                                              width: 75.w,
                                                                              child: Text(productlist!.marchantInfo != "" ? productlist!.marchantInfo! : "No Data Found", overflow: TextOverflow.ellipsis, textAlign: TextAlign.left, style: AppStyle.txtRobotoRegular15),
                                                                            ),
                                                                          ),
                                                                        ])),
                                                              ],
                                                            ),
                                                          ),
                                                          // height: 120,
                                                        ),
                                                      ),
                                                      CustomButton(
                                                          onTap: () {
                                                            setState(() {
                                                              expanded3 =
                                                                  !expanded3;
                                                            });
                                                          },
                                                          height:
                                                              getVerticalSize(
                                                                  30),
                                                          text:
                                                              "  Returns & Cancellation",
                                                          margin: getMargin(
                                                              left: 15,
                                                              top: 10,
                                                              right: 14),
                                                          shape: ButtonShape
                                                              .Square),
                                                      AnimatedContainer(
                                                        padding:
                                                            EdgeInsets.all(20),
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    200),
                                                        height:
                                                            expanded3 ? 250 : 0,
                                                        width: expanded3
                                                            ? 100.w
                                                            : 0,
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  20),
                                                          decoration: BoxDecoration(
                                                              color: Color(
                                                                  0xffF7F8F9),
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          20)),
                                                              boxShadow: const [
                                                                BoxShadow(
                                                                  color: Colors
                                                                      .grey,
                                                                  offset:
                                                                      Offset(
                                                                          0.0,
                                                                          1.0),
                                                                  blurRadius:
                                                                      6.0,
                                                                ),
                                                              ]),
                                                          child:
                                                              SingleChildScrollView(
                                                            child: Column(
                                                              children: <Widget>[
                                                                Padding(
                                                                    padding: getPadding(
                                                                        left: 0,
                                                                        top: 8),
                                                                    child: Row(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment
                                                                                .start,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceAround,
                                                                        children: [
                                                                          FittedBox(
                                                                            fit:
                                                                                BoxFit.fill,
                                                                            child:
                                                                                Container(
                                                                              width: 75.w,
                                                                              child: Text(productlist!.returnCancellation != "" ? productlist!.returnCancellation! : "No Data Found", overflow: TextOverflow.ellipsis, textAlign: TextAlign.left, style: AppStyle.txtRobotoRegular15),
                                                                            ),
                                                                          ),
                                                                        ])),
                                                              ],
                                                            ),
                                                          ),
                                                          // height: 120,
                                                        ),
                                                      ),
                                                      CustomButton(
                                                          onTap: () {
                                                            setState(() {
                                                              expanded4 =
                                                                  !expanded4;
                                                            });
                                                          },
                                                          height:
                                                              getVerticalSize(
                                                                  30),
                                                          text:
                                                              "  Warranty Installation",
                                                          margin: getMargin(
                                                              left: 15,
                                                              top: 10,
                                                              right: 14,
                                                              bottom: 5),
                                                          shape: ButtonShape
                                                              .Square),
                                                      AnimatedContainer(
                                                        padding:
                                                            EdgeInsets.all(20),
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    200),
                                                        height:
                                                            expanded4 ? 250 : 0,
                                                        width: expanded4
                                                            ? 100.w
                                                            : 0,
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  20),
                                                          decoration: BoxDecoration(
                                                              color: Color(
                                                                  0xffF7F8F9),
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          20)),
                                                              boxShadow: const [
                                                                BoxShadow(
                                                                  color: Colors
                                                                      .grey,
                                                                  offset:
                                                                      Offset(
                                                                          0.0,
                                                                          1.0),
                                                                  blurRadius:
                                                                      6.0,
                                                                ),
                                                              ]),
                                                          child:
                                                              SingleChildScrollView(
                                                            child: Column(
                                                              children: <Widget>[
                                                                Padding(
                                                                    padding: getPadding(
                                                                        left: 0,
                                                                        top: 8),
                                                                    child: Row(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment
                                                                                .start,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceAround,
                                                                        children: [
                                                                          FittedBox(
                                                                            fit:
                                                                                BoxFit.fill,
                                                                            child:
                                                                                Container(
                                                                              width: 75.w,
                                                                              child: Text(productlist!.returnCancellation != "" ? productlist!.returnCancellation! : "No Data Found", overflow: TextOverflow.ellipsis, textAlign: TextAlign.left, style: AppStyle.txtRobotoRegular15),
                                                                            ),
                                                                          ),
                                                                        ])),
                                                              ],
                                                            ),
                                                          ),
                                                          // height: 120,
                                                        ),
                                                      ),
                                                      Container(
                                                        height: getVerticalSize(
                                                            200),
                                                        decoration:
                                                            AppDecoration
                                                                .fillWhiteA700,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Padding(
                                                                padding:
                                                                    getPadding(
                                                                        top:
                                                                            11),
                                                                child: Text(
                                                                    "msg_more_from_brand"
                                                                        .tr,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style: AppStyle
                                                                        .txtRobotoMedium13
                                                                        .copyWith(
                                                                            letterSpacing:
                                                                                getHorizontalSize(0.26)))),
                                                            Flexible(
                                                              child: ListView
                                                                  .builder(
                                                                      itemCount:
                                                                          brandProduct
                                                                              .length,
                                                                      scrollDirection:
                                                                          Axis
                                                                              .horizontal,
                                                                      itemBuilder:
                                                                          (context,
                                                                              index) {
                                                                        return GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            Navigator.of(context).pushReplacement(MaterialPageRoute(
                                                                              builder: (context) => ProductDetailScreen1(brandProduct[index].id!),
                                                                            ));
                                                                          },
                                                                          child: SingleChildScrollView(
                                                                              padding: getPadding(left: 15, top: 9),
                                                                              child: Column(
                                                                                children: [
                                                                                  CustomImageView(url: brandProduct[index].image!, height: getVerticalSize(124), width: getHorizontalSize(249)),
                                                                                  SizedBox(
                                                                                    height: 4,
                                                                                  ),
                                                                                  Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                                                    Container(width: getHorizontalSize(154), child: Text(brandProduct[index].name!, maxLines: null, textAlign: TextAlign.left, style: AppStyle.txtRobotoRegular14Black900)),
                                                                                    CustomImageView(svgPath: ImageConstant.imgCut, height: getVerticalSize(11), width: getHorizontalSize(7), margin: getMargin(left: 47, top: 3, bottom: 16)),
                                                                                    Padding(padding: getPadding(left: 4, top: 3, bottom: 12), child: Text(brandProduct[index].salePrice!, overflow: TextOverflow.ellipsis, textAlign: TextAlign.left, style: AppStyle.txtRobotoMedium12Purple900)),
                                                                                  ])
                                                                                ],
                                                                              )),
                                                                        );
                                                                      }),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        height: getVerticalSize(
                                                          140,
                                                        ),
                                                        width: double.maxFinite,
                                                        margin: getMargin(
                                                          top: 0,
                                                        ),
                                                        child: Stack(
                                                          alignment: Alignment
                                                              .topCenter,
                                                          children: [
                                                            Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topCenter,
                                                              child: Container(
                                                                padding:
                                                                    getPadding(
                                                                  left: 59,
                                                                  top: 35,
                                                                  right: 59,
                                                                  bottom: 0,
                                                                ),
                                                                // decoration: AppDecoration.fillGray5001,
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
                                                                          getPadding(
                                                                        top: 0,
                                                                      ),
                                                                      child:
                                                                          Text(
                                                                        "msg_like_what_you_see"
                                                                            .tr,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style: AppStyle
                                                                            .txtRobotoRegular14Gray50001,
                                                                      ),
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        SizedBox(
                                                                          width:
                                                                              13.w,
                                                                        ),
                                                                        IconButton(
                                                                            onPressed:
                                                                                () {
                                                                              // _launchInBrowser(Uri.parse(facebook));
                                                                            },
                                                                            icon:
                                                                                Image.asset("assets/images/facebook.png")),
                                                                        SizedBox(
                                                                          width:
                                                                              15,
                                                                        ),
                                                                        IconButton(
                                                                            onPressed:
                                                                                () {
                                                                              // _launchInBrowser(Uri.parse(facebook));
                                                                            },
                                                                            icon:
                                                                                Image.asset("assets/images/instagram.png")),
                                                                        SizedBox(
                                                                          width:
                                                                              15,
                                                                        ),
                                                                        IconButton(
                                                                            onPressed:
                                                                                () {
                                                                              // _launchInBrowser(Uri.parse(facebook));
                                                                            },
                                                                            icon:
                                                                                Image.asset("assets/images/twitter.png")),
                                                                      ],
                                                                    )

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
                                                              alignment:
                                                                  Alignment
                                                                      .topCenter,
                                                              child: SizedBox(
                                                                width: double
                                                                    .maxFinite,
                                                                child: Divider(
                                                                  height:
                                                                      getVerticalSize(
                                                                    1,
                                                                  ),
                                                                  thickness:
                                                                      getVerticalSize(
                                                                    1,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ]))),
                                        // Align(
                                        //     alignment: Alignment.bottomCenter,
                                        //     child: Container(
                                        //         height: getVerticalSize(42),
                                        //         width: double.maxFinite,
                                        //         decoration: BoxDecoration(
                                        //             color: ColorConstant.whiteA700,
                                        //             boxShadow: [
                                        //               BoxShadow(
                                        //                   color:
                                        //                   ColorConstant.black90033,
                                        //                   spreadRadius:
                                        //                   getHorizontalSize(2),
                                        //                   blurRadius:
                                        //                   getHorizontalSize(2),
                                        //                   offset: Offset(0, 0))
                                        //             ]))),
                                        // CustomButton(
                                        //     height: getVerticalSize(43),
                                        //     width: getHorizontalSize(215),
                                        //     text: "lbl_add_to_cart".tr,
                                        //     variant: ButtonVariant.FillBluegray100,
                                        //     shape: ButtonShape.Square,
                                        //     padding: ButtonPadding.PaddingAll15,
                                        //     fontStyle: ButtonFontStyle.RobotoMedium12,
                                        //     alignment: Alignment.bottomLeft),
                                        // Align(
                                        //     alignment: Alignment.bottomRight,
                                        //     child: Container(
                                        //         width: getHorizontalSize(214),
                                        //         padding: getPadding(
                                        //             left: 30,
                                        //             top: 13,
                                        //             right: 74,
                                        //             bottom: 13),
                                        //         decoration:
                                        //         AppDecoration.txtFillPurple900,
                                        //         child: Text("lbl_buy_now".tr,
                                        //             overflow: TextOverflow.ellipsis,
                                        //             textAlign: TextAlign.left,
                                        //             style: AppStyle
                                        //                 .txtRobotoMedium12WhiteA700)))
                                      ])),
                              Padding(
                                  padding: getPadding(top: 0),
                                  child: Divider(
                                      height: getVerticalSize(5),
                                      thickness: getVerticalSize(5),
                                      color: ColorConstant.purple50))
                            ])),
                  );
                } else if (!snapshot.hasData) {
                  return Container();
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                } else {
                  return const Center(
                    heightFactor: 15,
                    child: CircularProgressIndicator(
                      color: Colors.purple,
                    ),
                  );
                }
              },
            )));
  }

  // Future<void> _launchInBrowser(Uri url) async {
  //   if (!await launchUrl(
  //     url,
  //     mode: LaunchMode.inAppWebView,
  //   )) {
  //     throw 'Could not launch $url';
  //   }
  // }

  static Widget documentViewer(String url, context) => SafeArea(
          child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomRight,
                colors: <Color>[Color(0xff000000), Color(0xff000000)],
              ),
            ),
          ),
          elevation: 0.5,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Color(0xff9BA6BF),
              size: 19,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        backgroundColor: Colors.black,
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.184, 1),
              end: Alignment(0.184, -1),
              colors: <Color>[Color(0xff000000), Color(0x00000000)],
              stops: <double>[0, 1],
            ),
          ),
          alignment: Alignment.topCenter,
          // padding: const EdgeInsets.fromLTRB(20.0,0,20,100),
          child: InteractiveViewer(
            panEnabled: true,
            maxScale: 4,
            scaleEnabled: true,
            constrained: false,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(url),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
      ));

  onTapArrowleft6() {
    Navigator.of(context).pop();
    // Get.back();
  }
}
