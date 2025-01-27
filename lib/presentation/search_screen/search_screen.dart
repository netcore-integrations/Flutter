import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:keshav_s_application2/core/app_export.dart';
import 'package:keshav_s_application2/presentation/select_product_screen/models/ProductList.dart'
    as products;
import 'package:keshav_s_application2/widgets/app_bar/appbar_image.dart';
import 'package:keshav_s_application2/widgets/app_bar/custom_app_bar.dart';
import 'package:keshav_s_application2/widgets/custom_button.dart';
import 'package:keshav_s_application2/widgets/custom_text_form_field.dart';

import '../otp_screen/models/otp_model.dart';
import '../product_detail_screen/QuantityBottomSheet.dart';
import '../product_detail_screen/models/AddWishlist.dart';
import '../product_detail_screen/models/AddtoCart.dart';
import '../product_detail_screen/product_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  Data data;

  // StoreData category;
  String keyword_id;

  SearchScreen(this.data, this.keyword_id);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

TextEditingController searchController = TextEditingController();

class _SearchScreenState extends State<SearchScreen> {
  Future<products.ProductList>? product;
  List<products.ProductListData> productlist = [];
  var sortBy = '';

  closeKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: ColorConstant.whiteA700,
            appBar: CustomAppBar(
                height: getVerticalSize(85),
                leadingWidth: 27,
                leading: AppbarImage(
                    height: getVerticalSize(15),
                    width: getHorizontalSize(9),
                    svgPath: ImageConstant.imgArrowleftPurple900,
                    margin: getMargin(left: 18, top: 20, bottom: 20),
                    onTap: onTapArrowleft17),
                centerTitle: true,
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Search',
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    )
                  ],
                ),
                styleType: Style.bgOutlineGray40003),
            body: Container(
                width: double.maxFinite,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 15, right: 5, left: 5),
                        child: TextField(
                          style: TextStyle(fontSize: 14.0),
                          controller: searchController,
                          onSubmitted: (value) {
                            if (value.toString().trim().isNotEmpty) {
                              //value is entered text after ENTER press
                              //you can also call any function here or make setState() to assign value to other variable
                              handleSearch(value);
                            }
                          },
                          textInputAction: TextInputAction.search,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(15),
                            fillColor: Colors.grey.shade100,
                            suffixIcon: IconButton(
                                iconSize: 30,
                                icon: Icon(Icons.search),
                                onPressed: () async {
                                  handleSearch(searchController.text);
                                }),
                            filled: true,
                            labelText: "Search",
                            hintText: 'Search By Product Name,SKU,Code',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ),
                      /*CustomButton(
                          height: getVerticalSize(29),
                          width: getHorizontalSize(156),
                          text: "Recently Viewed",
                          margin: getMargin(top: 12),
                          variant: ButtonVariant.FillPurple50,
                          shape: ButtonShape.Square,
                          fontStyle: ButtonFontStyle.RobotoRegular14,
                          alignment: Alignment.centerRight),
                      Padding(
                          padding: getPadding(left: 20, top: 26, right: 47),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomButton(
                                    height: getVerticalSize(25),
                                    width: getHorizontalSize(90),
                                    text: "Sofa Sets",
                                    margin: getMargin(left: 31),
                                    variant: ButtonVariant.OutlinePurple700,
                                    shape: ButtonShape.CustomBorderBR44,
                                    padding: ButtonPadding.PaddingAll4,
                                    fontStyle: ButtonFontStyle
                                        .RobotoRegular14Purple700),
                                CustomButton(
                                    height: getVerticalSize(25),
                                    width: getHorizontalSize(90),
                                    text: "Recliner",
                                    margin: getMargin(left: 31),
                                    variant: ButtonVariant.OutlinePurple700,
                                    shape: ButtonShape.CustomBorderBR44,
                                    padding: ButtonPadding.PaddingAll4,
                                    fontStyle: ButtonFontStyle
                                        .RobotoRegular14Purple700),
                                CustomButton(
                                    height: getVerticalSize(25),
                                    width: getHorizontalSize(84),
                                    text: "Chairs",
                                    margin: getMargin(left: 31),
                                    variant: ButtonVariant.OutlinePurple700,
                                    shape: ButtonShape.CustomBorderBR44,
                                    padding: ButtonPadding.PaddingAll4,
                                    fontStyle: ButtonFontStyle
                                        .RobotoRegular14Purple700)
                              ])),*/
                      SizedBox(
                        height: 20,
                      ),
                      productlist.isNotEmpty
                          ? Expanded(
                              child: ListView.builder(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: productlist.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                        width: double.maxFinite,
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                child: Column(
                                                  children: [
                                                    Container(
                                                        height: getVerticalSize(
                                                            206),
                                                        width:
                                                            getHorizontalSize(
                                                                412),
                                                        margin:
                                                            getMargin(top: 8),
                                                        child: Stack(
                                                            alignment: Alignment
                                                                .topCenter,
                                                            children: [
                                                              CustomImageView(
                                                                  url: productlist[
                                                                          index]
                                                                      .image,
                                                                  height:
                                                                      getVerticalSize(
                                                                          206),
                                                                  width:
                                                                      getHorizontalSize(
                                                                          412),
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  onTap: () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .push(
                                                                            MaterialPageRoute(
                                                                      builder: (context) => ProductDetailScreen(
                                                                          widget
                                                                              .data,
                                                                          productlist[index]
                                                                              .id!),
                                                                    ));
                                                                  }),
                                                              Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .topCenter,
                                                                  child: Padding(
                                                                      padding: getPadding(bottom: 190),
                                                                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                                                        Container(
                                                                            width:
                                                                                getHorizontalSize(60),
                                                                            margin: getMargin(bottom: 1),
                                                                            padding: getPadding(left: 20, top: 1, right: 20, bottom: 1),
                                                                            decoration: AppDecoration.txtOutlineBlack9003f.copyWith(borderRadius: BorderRadiusStyle.txtCustomBorderBR20),
                                                                            child: Text("lbl_new".tr, overflow: TextOverflow.ellipsis, textAlign: TextAlign.left, style: AppStyle.txtRobotoMedium9)),
                                                                        Container(
                                                                            width: getHorizontalSize(
                                                                                60),
                                                                            padding: getPadding(
                                                                                left: 9,
                                                                                top: 2,
                                                                                right: 9,
                                                                                bottom: 2),
                                                                            decoration: AppDecoration.txtOutlineBlack9003f1.copyWith(borderRadius: BorderRadiusStyle.txtCustomBorderBL20),
                                                                            child: Text("lbl_30_off2".tr, overflow: TextOverflow.ellipsis, textAlign: TextAlign.left, style: AppStyle.txtRobotoMedium9))
                                                                      ])))
                                                            ])),
                                                    Padding(
                                                        padding: getPadding(
                                                            left: 8,
                                                            top: 8,
                                                            right: 8),
                                                        child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                  width: 300,
                                                                  padding:
                                                                      getPadding(
                                                                          bottom:
                                                                              3),
                                                                  child: Text(
                                                                      productlist[
                                                                              index]
                                                                          .name!,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style: AppStyle
                                                                          .txtRobotoRegular18)),
                                                              Spacer(),
                                                              CustomImageView(
                                                                  svgPath:
                                                                      ImageConstant
                                                                          .imgCut,
                                                                  height:
                                                                      getVerticalSize(
                                                                          11),
                                                                  width:
                                                                      getHorizontalSize(
                                                                          7),
                                                                  margin:
                                                                      getMargin(
                                                                          top:
                                                                              3,
                                                                          bottom:
                                                                              4)),
                                                              Padding(
                                                                  padding:
                                                                      getPadding(
                                                                          left:
                                                                              4,
                                                                          top:
                                                                              3,
                                                                          right:
                                                                              4),
                                                                  child: Text(
                                                                      productlist[
                                                                              index]
                                                                          .salePrice!,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style: AppStyle
                                                                          .txtRobotoMedium12Purple900))
                                                            ])),
                                                    Padding(
                                                        padding: getPadding(
                                                            left: 8,
                                                            top: 2,
                                                            right: 8),
                                                        child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                  productlist[index]
                                                                          .categoryName! +
                                                                      " by " +
                                                                      productlist[
                                                                              index]
                                                                          .brandName!,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style: AppStyle
                                                                      .txtRobotoRegular12Purple700),
                                                              Spacer(),
                                                              CustomImageView(
                                                                  svgPath:
                                                                      ImageConstant
                                                                          .imgVectorGray500,
                                                                  height:
                                                                      getVerticalSize(
                                                                          8),
                                                                  width:
                                                                      getHorizontalSize(
                                                                          5),
                                                                  margin:
                                                                      getMargin(
                                                                          top:
                                                                              1,
                                                                          bottom:
                                                                              3)),
                                                              Container(
                                                                  height:
                                                                      getVerticalSize(
                                                                          12),
                                                                  width:
                                                                      getHorizontalSize(
                                                                          32),
                                                                  margin:
                                                                      getMargin(
                                                                          left:
                                                                              3),
                                                                  child: Stack(
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      children: [
                                                                        Align(
                                                                            alignment: Alignment
                                                                                .center,
                                                                            child: Text(productlist[index].mrpPrice!,
                                                                                overflow: TextOverflow.ellipsis,
                                                                                textAlign: TextAlign.left,
                                                                                style: AppStyle.txtRobotoMedium10Gray500)),
                                                                        Align(
                                                                            alignment:
                                                                                Alignment.center,
                                                                            child: SizedBox(width: getHorizontalSize(32), child: Divider(height: getVerticalSize(1), thickness: getVerticalSize(1), color: ColorConstant.gray500)))
                                                                      ]))
                                                            ])),
                                                    Padding(
                                                        padding: getPadding(
                                                            left: 8,
                                                            top: 11,
                                                            right: 12),
                                                        child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .end,
                                                            children: [
                                                              Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                        "msg_limited_time_offer"
                                                                            .tr,
                                                                        overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                        textAlign:
                                                                            TextAlign
                                                                                .left,
                                                                        style: AppStyle
                                                                            .txtRobotoRegular10Black900),
                                                                    Padding(
                                                                        padding: getPadding(
                                                                            top:
                                                                                8),
                                                                        child: Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              Text("lbl_ships_in_1_day".tr, overflow: TextOverflow.ellipsis, textAlign: TextAlign.left, style: AppStyle.txtRobotoMedium10Black900),
                                                                              CustomImageView(svgPath: ImageConstant.imgCar, height: getVerticalSize(10), width: getHorizontalSize(13), margin: getMargin(left: 9, bottom: 1))
                                                                            ]))
                                                                  ]),
                                                              Spacer(),
                                                              CustomImageView(
                                                                  onTap: () {
                                                                    addtowishlist(
                                                                        productlist[index]
                                                                            .id!);
                                                                  },
                                                                  svgPath:
                                                                      ImageConstant
                                                                          .imgLocation,
                                                                  height:
                                                                      getVerticalSize(
                                                                          18),
                                                                  width:
                                                                      getHorizontalSize(
                                                                          21),
                                                                  margin: getMargin(
                                                                      top: 10,
                                                                      bottom:
                                                                          3)),
                                                              CustomImageView(
                                                                  onTap: () {
                                                                    _showQuantityBottomSheet(
                                                                        context,
                                                                        productlist[index]
                                                                            .id!);
                                                                  },
                                                                  svgPath:
                                                                      ImageConstant
                                                                          .imgCart,
                                                                  height:
                                                                      getVerticalSize(
                                                                          20),
                                                                  width:
                                                                      getHorizontalSize(
                                                                          23),
                                                                  margin:
                                                                      getMargin(
                                                                          left:
                                                                              35,
                                                                          top:
                                                                              9,
                                                                          bottom:
                                                                              2))
                                                            ])),
                                                    Padding(
                                                        padding:
                                                            getPadding(top: 16),
                                                        child: Divider(
                                                            height:
                                                                getVerticalSize(
                                                                    5),
                                                            thickness:
                                                                getVerticalSize(
                                                                    5),
                                                            color: ColorConstant
                                                                .purple50)),
                                                  ],
                                                ),
                                              ),
                                              // Container(
                                              //     height: getVerticalSize(206),
                                              //     width: getHorizontalSize(412),
                                              //     margin: getMargin(top: 5),
                                              //     child:
                                              //     Stack(alignment: Alignment.topCenter, children: [
                                              //       CustomImageView(
                                              //           imagePath: ImageConstant.imgImage14,
                                              //           height: getVerticalSize(206),
                                              //           width: getHorizontalSize(412),
                                              //           alignment: Alignment.center),
                                              //       Align(
                                              //           alignment: Alignment.topCenter,
                                              //           child: Padding(
                                              //               padding: getPadding(bottom: 190),
                                              //               child: Row(
                                              //                   mainAxisAlignment:
                                              //                   MainAxisAlignment.spaceBetween,
                                              //                   children: [
                                              //                     Container(
                                              //                         width: getHorizontalSize(60),
                                              //                         margin: getMargin(bottom: 1),
                                              //                         padding: getPadding(
                                              //                             left: 20,
                                              //                             top: 1,
                                              //                             right: 20,
                                              //                             bottom: 1),
                                              //                         decoration: AppDecoration
                                              //                             .txtOutlineBlack9003f
                                              //                             .copyWith(
                                              //                             borderRadius:
                                              //                             BorderRadiusStyle
                                              //                                 .txtCustomBorderBR20),
                                              //                         child: Text("lbl_new".tr,
                                              //                             overflow:
                                              //                             TextOverflow.ellipsis,
                                              //                             textAlign: TextAlign.left,
                                              //                             style: AppStyle
                                              //                                 .txtRobotoMedium9)),
                                              //                     Container(
                                              //                         width: getHorizontalSize(60),
                                              //                         padding: getPadding(
                                              //                             left: 9,
                                              //                             top: 2,
                                              //                             right: 9,
                                              //                             bottom: 2),
                                              //                         decoration: AppDecoration
                                              //                             .txtOutlineBlack9003f1
                                              //                             .copyWith(
                                              //                             borderRadius:
                                              //                             BorderRadiusStyle
                                              //                                 .txtCustomBorderBL20),
                                              //                         child: Text("lbl_30_off2".tr,
                                              //                             overflow:
                                              //                             TextOverflow.ellipsis,
                                              //                             textAlign: TextAlign.left,
                                              //                             style: AppStyle
                                              //                                 .txtRobotoMedium9))
                                              //                   ])))
                                              //     ])),
                                              // Padding(
                                              //     padding: getPadding(left: 8, top: 8, right: 8),
                                              //     child: Row(
                                              //         mainAxisAlignment: MainAxisAlignment.center,
                                              //         crossAxisAlignment: CrossAxisAlignment.start,
                                              //         children: [
                                              //           Padding(
                                              //               padding: getPadding(bottom: 3),
                                              //               child: Text("msg_fabiola_2_seater2".tr,
                                              //                   overflow: TextOverflow.ellipsis,
                                              //                   textAlign: TextAlign.left,
                                              //                   style: AppStyle
                                              //                       .txtRobotoRegular12Black900)),
                                              //           Spacer(),
                                              //           CustomImageView(
                                              //               svgPath: ImageConstant.imgCut,
                                              //               height: getVerticalSize(11),
                                              //               width: getHorizontalSize(7),
                                              //               margin: getMargin(top: 3, bottom: 4)),
                                              //           Padding(
                                              //               padding: getPadding(left: 4, top: 3),
                                              //               child: Text("lbl_49_999".tr,
                                              //                   overflow: TextOverflow.ellipsis,
                                              //                   textAlign: TextAlign.left,
                                              //                   style: AppStyle
                                              //                       .txtRobotoMedium12Purple900))
                                              //         ])),
                                              // Padding(
                                              //     padding: getPadding(left: 8, top: 2, right: 8),
                                              //     child: Row(
                                              //         mainAxisAlignment: MainAxisAlignment.center,
                                              //         children: [
                                              //           Text("msg_casacraft_by_fabfurni".tr,
                                              //               overflow: TextOverflow.ellipsis,
                                              //               textAlign: TextAlign.left,
                                              //               style:
                                              //               AppStyle.txtRobotoRegular10Purple9001),
                                              //           Spacer(),
                                              //           CustomImageView(
                                              //               svgPath: ImageConstant.imgVectorGray500,
                                              //               height: getVerticalSize(8),
                                              //               width: getHorizontalSize(5),
                                              //               margin: getMargin(top: 1, bottom: 3)),
                                              //           Container(
                                              //               height: getVerticalSize(12),
                                              //               width: getHorizontalSize(32),
                                              //               margin: getMargin(left: 3),
                                              //               child: Stack(
                                              //                   alignment: Alignment.center,
                                              //                   children: [
                                              //                     Align(
                                              //                         alignment: Alignment.center,
                                              //                         child: Text("lbl_99_999".tr,
                                              //                             overflow:
                                              //                             TextOverflow.ellipsis,
                                              //                             textAlign: TextAlign.left,
                                              //                             style: AppStyle
                                              //                                 .txtRobotoMedium10Gray500)),
                                              //                     Align(
                                              //                         alignment: Alignment.center,
                                              //                         child: SizedBox(
                                              //                             width: getHorizontalSize(32),
                                              //                             child: Divider(
                                              //                                 height:
                                              //                                 getVerticalSize(1),
                                              //                                 thickness:
                                              //                                 getVerticalSize(1),
                                              //                                 color: ColorConstant
                                              //                                     .gray500)))
                                              //                   ]))
                                              //         ])),
                                              // Padding(
                                              //     padding: getPadding(left: 8, top: 11, right: 12),
                                              //     child: Row(
                                              //         mainAxisAlignment: MainAxisAlignment.center,
                                              //         crossAxisAlignment: CrossAxisAlignment.end,
                                              //         children: [
                                              //           Column(
                                              //               mainAxisAlignment: MainAxisAlignment.start,
                                              //               children: [
                                              //                 Text("msg_limited_time_offer".tr,
                                              //                     overflow: TextOverflow.ellipsis,
                                              //                     textAlign: TextAlign.left,
                                              //                     style: AppStyle
                                              //                         .txtRobotoRegular10Black900),
                                              //                 Padding(
                                              //                     padding: getPadding(top: 8),
                                              //                     child: Row(
                                              //                         mainAxisAlignment:
                                              //                         MainAxisAlignment.center,
                                              //                         children: [
                                              //                           Text("lbl_ships_in_1_day".tr,
                                              //                               overflow:
                                              //                               TextOverflow.ellipsis,
                                              //                               textAlign: TextAlign.left,
                                              //                               style: AppStyle
                                              //                                   .txtRobotoMedium10Black900),
                                              //                           CustomImageView(
                                              //                               svgPath:
                                              //                               ImageConstant.imgCar,
                                              //                               height: getVerticalSize(10),
                                              //                               width:
                                              //                               getHorizontalSize(13),
                                              //                               margin: getMargin(
                                              //                                   left: 9, bottom: 1))
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
                                              //               margin:
                                              //               getMargin(left: 35, top: 9, bottom: 2))
                                              //         ])),
                                              // Padding(
                                              //     padding: getPadding(top: 16),
                                              //     child: Divider(
                                              //         height: getVerticalSize(5),
                                              //         thickness: getVerticalSize(5),
                                              //         color: ColorConstant.purple50)),
                                              // Container(
                                              //     height: getVerticalSize(206),
                                              //     width: getHorizontalSize(412),
                                              //     margin: getMargin(top: 5),
                                              //     child: Stack(alignment: Alignment.center, children: [
                                              //       Align(
                                              //           alignment: Alignment.topCenter,
                                              //           child: Container(
                                              //               margin:
                                              //                   getMargin(left: 6, top: 45, right: 6),
                                              //               padding: getPadding(
                                              //                   left: 41, top: 6, right: 41, bottom: 6),
                                              //               decoration: BoxDecoration(
                                              //                   image: DecorationImage(
                                              //                       image: fs.Svg(
                                              //                           ImageConstant.imgGroup203),
                                              //                       fit: BoxFit.cover)),
                                              //               child: Column(
                                              //                   mainAxisSize: MainAxisSize.min,
                                              //                   mainAxisAlignment:
                                              //                       MainAxisAlignment.end,
                                              //                   children: [
                                              //                     CustomImageView(
                                              //                         svgPath: ImageConstant.imgGroup2,
                                              //                         height: getVerticalSize(47),
                                              //                         width: getHorizontalSize(315),
                                              //                         margin: getMargin(top: 11)),
                                              //                     Padding(
                                              //                         padding: getPadding(
                                              //                             left: 7, top: 4, right: 4),
                                              //                         child: Row(
                                              //                             mainAxisAlignment:
                                              //                                 MainAxisAlignment
                                              //                                     .spaceBetween,
                                              //                             children: [
                                              //                               Text("lbl_home".tr,
                                              //                                   overflow: TextOverflow
                                              //                                       .ellipsis,
                                              //                                   textAlign:
                                              //                                       TextAlign.left,
                                              //                                   style: AppStyle
                                              //                                       .txtRobotoMedium8Purple900),
                                              //                               Text("lbl_store".tr,
                                              //                                   overflow: TextOverflow
                                              //                                       .ellipsis,
                                              //                                   textAlign:
                                              //                                       TextAlign.left,
                                              //                                   style: AppStyle
                                              //                                       .txtRobotoMedium8),
                                              //                               Text("lbl_profile".tr,
                                              //                                   overflow: TextOverflow
                                              //                                       .ellipsis,
                                              //                                   textAlign:
                                              //                                       TextAlign.left,
                                              //                                   style: AppStyle
                                              //                                       .txtRobotoMedium8)
                                              //                             ]))
                                              //                   ]))),
                                              //       Align(
                                              //           alignment: Alignment.center,
                                              //           child: Container(
                                              //               height: getVerticalSize(206),
                                              //               width: getHorizontalSize(412),
                                              //               child: Stack(
                                              //                   alignment: Alignment.topCenter,
                                              //                   children: [
                                              //                     CustomImageView(
                                              //                         imagePath:
                                              //                             ImageConstant.imgImage14,
                                              //                         height: getVerticalSize(206),
                                              //                         width: getHorizontalSize(412),
                                              //                         alignment: Alignment.center),
                                              //                     Align(
                                              //                         alignment: Alignment.topCenter,
                                              //                         child: Column(
                                              //                             mainAxisSize:
                                              //                                 MainAxisSize.min,
                                              //                             mainAxisAlignment:
                                              //                                 MainAxisAlignment.start,
                                              //                             children: [
                                              //                               Row(
                                              //                                   mainAxisAlignment:
                                              //                                       MainAxisAlignment
                                              //                                           .spaceBetween,
                                              //                                   children: [
                                              //                                     Container(
                                              //                                         width:
                                              //                                             getHorizontalSize(
                                              //                                                 60),
                                              //                                         margin:
                                              //                                             getMargin(
                                              //                                                 bottom:
                                              //                                                     1),
                                              //                                         padding:
                                              //                                             getPadding(
                                              //                                                 left: 20,
                                              //                                                 top: 1,
                                              //                                                 right: 20,
                                              //                                                 bottom:
                                              //                                                     1),
                                              //                                         decoration: AppDecoration
                                              //                                             .txtOutlineBlack9003f
                                              //                                             .copyWith(
                                              //                                                 borderRadius:
                                              //                                                     BorderRadiusStyle
                                              //                                                         .txtCustomBorderBR20),
                                              //                                         child: Text(
                                              //                                             "lbl_new".tr,
                                              //                                             overflow:
                                              //                                                 TextOverflow
                                              //                                                     .ellipsis,
                                              //                                             textAlign:
                                              //                                                 TextAlign
                                              //                                                     .left,
                                              //                                             style: AppStyle
                                              //                                                 .txtRobotoMedium9)),
                                              //                                     Container(
                                              //                                         width:
                                              //                                             getHorizontalSize(
                                              //                                                 60),
                                              //                                         padding:
                                              //                                             getPadding(
                                              //                                                 left: 9,
                                              //                                                 top: 2,
                                              //                                                 right: 9,
                                              //                                                 bottom:
                                              //                                                     2),
                                              //                                         decoration: AppDecoration
                                              //                                             .txtOutlineBlack9003f1
                                              //                                             .copyWith(
                                              //                                                 borderRadius:
                                              //                                                     BorderRadiusStyle
                                              //                                                         .txtCustomBorderBL20),
                                              //                                         child: Text(
                                              //                                             "lbl_30_off2"
                                              //                                                 .tr,
                                              //                                             overflow:
                                              //                                                 TextOverflow
                                              //                                                     .ellipsis,
                                              //                                             textAlign:
                                              //                                                 TextAlign
                                              //                                                     .left,
                                              //                                             style: AppStyle
                                              //                                                 .txtRobotoMedium9))
                                              //                                   ]),
                                              //                               Container(
                                              //                                   margin: getMargin(
                                              //                                       left: 6,
                                              //                                       top: 29,
                                              //                                       right: 6),
                                              //                                   padding: getPadding(
                                              //                                       left: 41,
                                              //                                       top: 6,
                                              //                                       right: 41,
                                              //                                       bottom: 6),
                                              //                                   decoration: BoxDecoration(
                                              //                                       image: DecorationImage(
                                              //                                           image: fs.Svg(
                                              //                                               ImageConstant
                                              //                                                   .imgGroup203),
                                              //                                           fit: BoxFit
                                              //                                               .cover)),
                                              //                                   child: Column(
                                              //                                       mainAxisAlignment:
                                              //                                           MainAxisAlignment
                                              //                                               .end,
                                              //                                       children: [
                                              //                                         CustomImageView(
                                              //                                             svgPath:
                                              //                                                 ImageConstant
                                              //                                                     .imgGroup2Purple900,
                                              //                                             height:
                                              //                                                 getVerticalSize(
                                              //                                                     47),
                                              //                                             width:
                                              //                                                 getHorizontalSize(
                                              //                                                     315),
                                              //                                             margin:
                                              //                                                 getMargin(
                                              //                                                     top:
                                              //                                                         11)),
                                              //                                         Padding(
                                              //                                             padding:
                                              //                                                 getPadding(
                                              //                                                     left:
                                              //                                                         7,
                                              //                                                     top:
                                              //                                                         4,
                                              //                                                     right:
                                              //                                                         4),
                                              //                                             child: Row(
                                              //                                                 mainAxisAlignment:
                                              //                                                     MainAxisAlignment
                                              //                                                         .spaceBetween,
                                              //                                                 children: [
                                              //                                                   Text(
                                              //                                                       "lbl_home"
                                              //                                                           .tr,
                                              //                                                       overflow:
                                              //                                                           TextOverflow.ellipsis,
                                              //                                                       textAlign: TextAlign.left,
                                              //                                                       style: AppStyle.txtRobotoMedium8),
                                              //                                                   Text(
                                              //                                                       "lbl_store"
                                              //                                                           .tr,
                                              //                                                       overflow:
                                              //                                                           TextOverflow.ellipsis,
                                              //                                                       textAlign: TextAlign.left,
                                              //                                                       style: AppStyle.txtRobotoMedium8Purple900),
                                              //                                                   Text(
                                              //                                                       "lbl_profile"
                                              //                                                           .tr,
                                              //                                                       overflow:
                                              //                                                           TextOverflow.ellipsis,
                                              //                                                       textAlign: TextAlign.left,
                                              //                                                       style: AppStyle.txtRobotoMedium8)
                                              //                                                 ]))
                                              //                                       ]))
                                              //                             ]))
                                              //                   ])))
                                              //     ])),
                                              // Padding(
                                              //     padding: getPadding(left: 8, top: 8, right: 8),
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
                                              //               child: Text("msg_casacraft_by_fabfurni".tr,
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
                                              //                         alignment: Alignment.bottomCenter,
                                              //                         child: Padding(
                                              //                             padding:
                                              //                                 getPadding(bottom: 5),
                                              //                             child: SizedBox(
                                              //                                 width:
                                              //                                     getHorizontalSize(32),
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
                                              //               mainAxisAlignment: MainAxisAlignment.start,
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
                                              //                           Text("lbl_ships_in_1_day".tr,
                                              //                               overflow:
                                              //                                   TextOverflow.ellipsis,
                                              //                               textAlign: TextAlign.left,
                                              //                               style: AppStyle
                                              //                                   .txtRobotoMedium10Black9001),
                                              //                           CustomImageView(
                                              //                               svgPath:
                                              //                                   ImageConstant.imgCar,
                                              //                               height: getVerticalSize(10),
                                              //                               width:
                                              //                                   getHorizontalSize(13),
                                              //                               margin: getMargin(
                                              //                                   left: 9,
                                              //                                   top: 1,
                                              //                                   bottom: 1))
                                              //                         ]))
                                              //               ]),
                                              //           Spacer(),
                                              //           // CustomImageView(
                                              //           //     svgPath: ImageConstant.imgLocation,
                                              //           //     height: getVerticalSize(18),
                                              //           //     width: getHorizontalSize(21),
                                              //           //     margin: getMargin(top: 10, bottom: 3)),
                                              //           // CustomImageView(
                                              //           //     svgPath: ImageConstant.imgCart,
                                              //           //     height: getVerticalSize(20),
                                              //           //     width: getHorizontalSize(23),
                                              //           //     margin:
                                              //           //         getMargin(left: 35, top: 9, bottom: 2))
                                              //         ])),
                                              // Padding(
                                              //     padding: getPadding(top: 17),
                                              //     child: Divider(
                                              //         height: getVerticalSize(5),
                                              //         thickness: getVerticalSize(5),
                                              //         color: ColorConstant.purple50))
                                            ]));
                                  }),
                            )
                          : Container(),
                    ]))));
  }

  void handleSearch(String query) {
    // Handle the search query here
    print('Search query: $query');
    closeKeyboard();
    productlist.clear();
    product = getProduct();
    product!.then((value) {
      setState(() {
        productlist = value.data!;
      });
    });
  }

  Future<AddWishlist> addtowishlist(String product_id) async {
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

      if (AddWishlist.fromJson(jsonObject).status == "true") {
        // print(orders.MyOrdersModel.fromJson(jsonObject).data.first.products.first.image);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: Duration(seconds: 1),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(bottom: 10.0),
            content: Text(
              "Added to Wishlist " +
                  AddWishlist.fromJson(jsonObject).message! +
                  "ly",
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.greenAccent));

        return AddWishlist.fromJson(jsonObject);

        // inviteList.sort((a, b) => a.id.compareTo(b.id));
      } else if (AddWishlist.fromJson(jsonObject).status == "false") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(bottom: 10.0),
            content: Text(
                AddWishlist.fromJson(jsonObject).message!.capitalizeFirst!),
            backgroundColor: Colors.redAccent));
      } else if (AddWishlist.fromJson(jsonObject).data == null) {
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

  onTapImgImagefourteen() {
    Get.toNamed(AppRoutes.productDetailScreen);
  }

  onTapArrowleft5() {
    Navigator.of(context).pop();
    // Get.back();
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
            duration: Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(bottom: 10.0),
            content: Text(
              "Added to Cart " + AddtoCart.fromJson(jsonObject).message! + "ly",
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.greenAccent));

        return AddtoCart.fromJson(jsonObject);

        // inviteList.sort((a, b) => a.id.compareTo(b.id));
      } else if (AddtoCart.fromJson(jsonObject).status == "false") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: Duration(seconds: 3),
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

  Future<products.ProductList> getProduct() async {
    Map data = {
      'user_id': widget.data.id,
      "category_id": "",
      "sub_category_id": "",
      "keyword_id": '',
      "brand_id": "",
      "city_id": "",
      "search_text": searchController.text
    };
    //encode Map to JSON
    var body = json.encode(data);
    var response =
        await dio.Dio().post("https://fabfurni.com/api/Webservice/productList",
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

      if (products.ProductList.fromJson(jsonObject).status == "true") {
        // print(orders.MyOrdersModel.fromJson(jsonObject).data.first.products.first.image);
        return products.ProductList.fromJson(jsonObject);

        // inviteList.sort((a, b) => a.id.compareTo(b.id));
      } else if (products.ProductList.fromJson(jsonObject).status == "false") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: Duration(seconds: 1),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(bottom: 5.0),
            dismissDirection: DismissDirection.none,
            content: Text(products.ProductList.fromJson(jsonObject)
                .message!
                .capitalizeFirst!),
            backgroundColor: Colors.redAccent));
        Timer(Duration(seconds: 2), () {
          Navigator.of(context).pop();
        });
      } else if (products.ProductList.fromJson(jsonObject).data == null) {
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

  onTapArrowleft17() {
    Navigator.of(context).pop();
    // Get.back();
  }
}
