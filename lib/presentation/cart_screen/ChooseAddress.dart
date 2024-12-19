import 'dart:convert';

import 'package:keshav_s_application2/presentation/add_address_screen/add_address_screen.dart';
import 'package:keshav_s_application2/presentation/add_address_screen_click_on_manage_address_screen/ManageAddressModel.dart';
import 'package:keshav_s_application2/presentation/cart_screen/cart_screen.dart';
import 'package:keshav_s_application2/presentation/otp_screen/models/otp_model.dart'
    as otp;
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

import '../add_address_screen_click_on_manage_address_screen/widgets/listhome_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:keshav_s_application2/core/app_export.dart';
import 'package:keshav_s_application2/widgets/app_bar/appbar_image.dart';
import 'package:keshav_s_application2/widgets/app_bar/appbar_subtitle.dart';
import 'package:keshav_s_application2/widgets/app_bar/appbar_title.dart';
import 'package:keshav_s_application2/widgets/app_bar/custom_app_bar.dart';
import 'package:keshav_s_application2/widgets/custom_button.dart';
import 'dart:convert';

import 'package:dio/dio.dart' as dio;

class ChooseAddressToOrderProduct extends StatefulWidget {
  otp.Data data;
  ChooseAddressToOrderProduct(this.data);
  @override
  State<ChooseAddressToOrderProduct> createState() =>
      _ChooseAddressToOrderProductState();
}

class _ChooseAddressToOrderProductState
    extends State<ChooseAddressToOrderProduct> {
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

  @override
  void initState() {
    manageAddress = getAddressList();
    manageAddress!.then((value) {
      setState(() {
        addresslist = value.data!;
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
                leadingWidth: 34,
                leading: AppbarImage(
                    height: getVerticalSize(0),
                    width: getHorizontalSize(0),
                    svgPath: ImageConstant.imgArrowleft,
                    margin: getMargin(left: 25, top: 34, bottom: 42),
                    onTap: () {
                      onTapArrowleft1(context);
                    }),
                title: AppbarImage(
                    height: getVerticalSize(32),
                    width: getHorizontalSize(106),
                    imagePath: ImageConstant.imgFinallogo03,
                    margin: getMargin(left: 13, top: 0, bottom: 15)),
                // actions: [
                //   AppbarImage(
                //       height: getSize(21),
                //       width: getSize(21),
                //       svgPath: ImageConstant.imgSearch,
                //       margin:
                //       getMargin(left: 12, top: 0, right: 10, bottom: 10),
                //       onTap: onTapSearch),
                //   Container(
                //       height: getVerticalSize(23),
                //       width: getHorizontalSize(27),
                //       margin:
                //       getMargin(left: 20, top: 25, right: 10, bottom: 0),
                //       child: Stack(alignment: Alignment.topRight, children: [
                //         AppbarImage(
                //             height: getVerticalSize(21),
                //             width: getHorizontalSize(21),
                //             svgPath: ImageConstant.imgLocation,
                //             margin: getMargin(top: 5, right: 6),
                //             onTap: (){
                //               Get.toNamed(AppRoutes.whislistScreen);
                //             }),
                //         // AppbarSubtitle6(
                //         //     text: "lbl_2".tr,
                //         //     margin: getMargin(left: 17, bottom: 13))
                //       ])),
                //   Container(
                //       height: getVerticalSize(24),
                //       width: getHorizontalSize(29),
                //       margin: getMargin(left: 14, top: 27, right: 31),
                //       child: Stack(alignment: Alignment.topRight, children: [
                //         AppbarImage(
                //             onTap: () {
                //               pushNewScreen(
                //                 context,
                //                 screen: CartScreen(widget.data),
                //                 withNavBar:
                //                 false, // OPTIONAL VALUE. True by default.
                //                 pageTransitionAnimation:
                //                 PageTransitionAnimation.cupertino,
                //               );
                //               // Navigator.of(context).push(MaterialPageRoute(
                //               //   builder: (context) => CartScreen(widget.data),
                //               // ));
                //             },
                //             height: getVerticalSize(20),
                //             width: getHorizontalSize(23),
                //             svgPath: ImageConstant.imgCart,
                //             margin: getMargin(top: 4, right: 6)),
                //         // AppbarSubtitle6(
                //         //     text: "lbl_3".tr,
                //         //     margin: getMargin(left: 19, bottom: 14))
                //       ]))
                // ],
                styleType: Style.bgShadowBlack90033),
            body: RefreshIndicator(
              color: Colors.purple,
              onRefresh: () async {
                setState(() {
                  manageAddress = getAddressList();
                  manageAddress!.then((value) {
                    setState(() {
                      addresslist = value.data!;
                    });
                  });
                });
              },
              child: Container(
                  width: size.width,
                  padding: EdgeInsets.only(bottom: 30),
                  child: FutureBuilder(
                      future: manageAddress,
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
                                padding: getPadding(top: 25, bottom: 10),
                                child: Padding(
                                    padding: getPadding(left: 4, right: 25),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                              padding: getPadding(left: 21),
                                              child: ListView.separated(
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  separatorBuilder:
                                                      (context, index) {
                                                    return SizedBox(
                                                        height: getVerticalSize(
                                                            25));
                                                  },
                                                  itemCount: addresslist.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          print("tapped");
                                                          List<String> att = [
                                                            addresslist[index]
                                                                .id!,
                                                            addresslist[index]
                                                                .defaulted!,
                                                            addresslist[index]
                                                                .name!,
                                                            addresslist[index]
                                                                    .addressOne! +
                                                                " " +
                                                                addresslist[
                                                                        index]
                                                                    .addressTwo! +
                                                                " " +
                                                                addresslist[
                                                                        index]
                                                                    .state!
                                                                    .capitalizeFirst! +
                                                                " " +
                                                                addresslist[
                                                                        index]
                                                                    .country!
                                                                    .capitalizeFirst! +
                                                                "," +
                                                                addresslist[
                                                                        index]
                                                                    .pincode!
                                                          ];
                                                          Navigator.pop(
                                                              context, att);
                                                        });
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                SnackBar(
                                                                    duration: Duration(
                                                                        seconds:
                                                                            1),
                                                                    content:
                                                                        Text(
                                                                      "Address selected",
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.black),
                                                                    ),
                                                                    backgroundColor:
                                                                        Colors
                                                                            .greenAccent));
                                                      },
                                                      child: ListhomeItemWidget(
                                                          widget.data,
                                                          addresslist[index]
                                                          //     onTapStackedit: () {
                                                          //   // onTapStackedit(context);
                                                          // }
                                                          ),
                                                    );
                                                  })),
                                          CustomButton(
                                              variant:
                                                  ButtonVariant.FillPurple900,
                                              height: getVerticalSize(50),
                                              width: getHorizontalSize(250),
                                              text: "Add New Address",
                                              margin:
                                                  getMargin(top: 30, right: 64),
                                              padding: ButtonPadding.PaddingT16,
                                              fontStyle: ButtonFontStyle
                                                  .RobotoMedium15,
                                              prefixWidget: Container(
                                                  margin: getMargin(right: 12),
                                                  // decoration: BoxDecoration(
                                                  //     color: ColorConstant.whiteA700),
                                                  child: CustomImageView(
                                                    svgPath:
                                                        ImageConstant.imgPlus,
                                                    color: Colors.white,
                                                  )),
                                              onTap: () {
                                                onTapAddnewaddress(context);
                                              }),
                                          // Align(
                                          //     alignment: Alignment.centerLeft,
                                          //     child: Container(
                                          //         height: getVerticalSize(14),
                                          //         width: getHorizontalSize(208),
                                          //         margin: getMargin(top: 527),
                                          //         child: Stack(
                                          //             alignment: Alignment.topCenter,
                                          //             children: [
                                          //               Align(
                                          //                   alignment:
                                          //                       Alignment.bottomCenter,
                                          //                   child: Container(
                                          //                       padding: getPadding(
                                          //                           left: 67,
                                          //                           top: 2,
                                          //                           right: 67,
                                          //                           bottom: 2),
                                          //                       decoration: AppDecoration
                                          //                           .fillLightblueA100
                                          //                           .copyWith(
                                          //                               borderRadius:
                                          //                                   BorderRadiusStyle
                                          //                                       .customBorderBL11),
                                          //                       child: Column(
                                          //                           mainAxisSize:
                                          //                               MainAxisSize.min,
                                          //                           mainAxisAlignment:
                                          //                               MainAxisAlignment
                                          //                                   .start,
                                          //                           children: [
                                          //                             Text(
                                          //                                 "Boy Fashion 2-4 year",
                                          //                                 overflow:
                                          //                                     TextOverflow
                                          //                                         .ellipsis,
                                          //                                 textAlign:
                                          //                                     TextAlign
                                          //                                         .left,
                                          //                                 style: AppStyle
                                          //                                     .txtRobotoRegular8)
                                          //                           ]))),
                                          //               Align(
                                          //                   alignment: Alignment.topCenter,
                                          //                   child: Container(
                                          //                       width:
                                          //                           getHorizontalSize(208),
                                          //                       padding: getPadding(
                                          //                           left: 30,
                                          //                           top: 2,
                                          //                           right: 67,
                                          //                           bottom: 2),
                                          //                       decoration: AppDecoration
                                          //                           .txtFillLightblueA100
                                          //                           .copyWith(
                                          //                               borderRadius:
                                          //                                   BorderRadiusStyle
                                          //                                       .txtCustomBorderBL11),
                                          //                       child: Text(
                                          //                           "Boy Fashion 2-4 year",
                                          //                           overflow: TextOverflow
                                          //                               .ellipsis,
                                          //                           textAlign:
                                          //                               TextAlign.left,
                                          //                           style: AppStyle
                                          //                               .txtRobotoRegular8)))
                                          //             ])))
                                        ])));
                          }
                        } else {
                          return const Center(
                            heightFactor: 15,
                            child: CircularProgressIndicator(
                              color: Colors.purple,
                            ),
                          );
                        }
                      }
                      // child: SingleChildScrollView(
                      //     padding: getPadding(top: 25),
                      //     child: Padding(
                      //         padding: getPadding(left: 4, right: 25),
                      //         child: Column(
                      //             crossAxisAlignment: CrossAxisAlignment.end,
                      //             mainAxisAlignment: MainAxisAlignment.start,
                      //             children: [
                      //               Padding(
                      //                   padding: getPadding(left: 21),
                      //                   child: ListView.separated(
                      //                       physics: NeverScrollableScrollPhysics(),
                      //                       shrinkWrap: true,
                      //                       separatorBuilder: (context, index) {
                      //                         return SizedBox(
                      //                             height: getVerticalSize(25));
                      //                       },
                      //                       itemCount: 2,
                      //                       itemBuilder: (context, index) {
                      //                         return ListhomeItemWidget(widget.data
                      //                         //     onTapStackedit: () {
                      //                         //   // onTapStackedit(context);
                      //                         // }
                      //                         );
                      //                       })),
                      //               CustomButton(
                      //                   variant: ButtonVariant.FillPurple900,
                      //                   height: getVerticalSize(50),
                      //                   width: getHorizontalSize(250),
                      //                   text: "Add New Address",
                      //                   margin: getMargin(top: 30, right: 64),
                      //                   padding: ButtonPadding.PaddingT16,
                      //                   fontStyle: ButtonFontStyle.RobotoMedium15,
                      //                   prefixWidget: Container(
                      //                       margin: getMargin(right: 12),
                      //                       // decoration: BoxDecoration(
                      //                       //     color: ColorConstant.whiteA700),
                      //                       child: CustomImageView(
                      //                           svgPath: ImageConstant.imgPlus,color: Colors.white,)),
                      //                   onTap: () {
                      //                     onTapAddnewaddress(context);
                      //                   }),
                      //               // Align(
                      //               //     alignment: Alignment.centerLeft,
                      //               //     child: Container(
                      //               //         height: getVerticalSize(14),
                      //               //         width: getHorizontalSize(208),
                      //               //         margin: getMargin(top: 527),
                      //               //         child: Stack(
                      //               //             alignment: Alignment.topCenter,
                      //               //             children: [
                      //               //               Align(
                      //               //                   alignment:
                      //               //                       Alignment.bottomCenter,
                      //               //                   child: Container(
                      //               //                       padding: getPadding(
                      //               //                           left: 67,
                      //               //                           top: 2,
                      //               //                           right: 67,
                      //               //                           bottom: 2),
                      //               //                       decoration: AppDecoration
                      //               //                           .fillLightblueA100
                      //               //                           .copyWith(
                      //               //                               borderRadius:
                      //               //                                   BorderRadiusStyle
                      //               //                                       .customBorderBL11),
                      //               //                       child: Column(
                      //               //                           mainAxisSize:
                      //               //                               MainAxisSize.min,
                      //               //                           mainAxisAlignment:
                      //               //                               MainAxisAlignment
                      //               //                                   .start,
                      //               //                           children: [
                      //               //                             Text(
                      //               //                                 "Boy Fashion 2-4 year",
                      //               //                                 overflow:
                      //               //                                     TextOverflow
                      //               //                                         .ellipsis,
                      //               //                                 textAlign:
                      //               //                                     TextAlign
                      //               //                                         .left,
                      //               //                                 style: AppStyle
                      //               //                                     .txtRobotoRegular8)
                      //               //                           ]))),
                      //               //               Align(
                      //               //                   alignment: Alignment.topCenter,
                      //               //                   child: Container(
                      //               //                       width:
                      //               //                           getHorizontalSize(208),
                      //               //                       padding: getPadding(
                      //               //                           left: 30,
                      //               //                           top: 2,
                      //               //                           right: 67,
                      //               //                           bottom: 2),
                      //               //                       decoration: AppDecoration
                      //               //                           .txtFillLightblueA100
                      //               //                           .copyWith(
                      //               //                               borderRadius:
                      //               //                                   BorderRadiusStyle
                      //               //                                       .txtCustomBorderBL11),
                      //               //                       child: Text(
                      //               //                           "Boy Fashion 2-4 year",
                      //               //                           overflow: TextOverflow
                      //               //                               .ellipsis,
                      //               //                           textAlign:
                      //               //                               TextAlign.left,
                      //               //                           style: AppStyle
                      //               //                               .txtRobotoRegular8)))
                      //               //             ])))
                      //             ]))),
                      )),
            )));
  }

  onTapAddnewaddress(BuildContext context) {
    pushScreen(
      context,
      screen: AddAddressScreen(widget.data),
      withNavBar: false, // OPTIONAL VALUE. True by default.
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
    // Navigator.of(context).push(MaterialPageRoute(
    //   builder: (context) => AddAddressScreen(),
    // ));
  }

  onTapArrowleft1(BuildContext context) {
    Navigator.pop(context);
  }

  onTapSearch() {
    Get.toNamed(AppRoutes.searchScreen);
  }

  onTapWishlist() {
    Get.toNamed(AppRoutes.whislistScreen);
  }
}
