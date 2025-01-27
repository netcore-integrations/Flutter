import 'dart:convert';

import 'package:keshav_s_application2/presentation/add_address_screen/add_address_screen.dart';
import 'package:keshav_s_application2/presentation/add_address_screen_click_on_manage_address_screen/ManageAddressModel.dart';
import 'package:keshav_s_application2/presentation/cart_screen/cart_screen.dart';
import 'package:keshav_s_application2/presentation/otp_screen/models/otp_model.dart'
    as otp;
import 'package:keshav_s_application2/presentation/search_screen/search_screen.dart';
import 'package:keshav_s_application2/presentation/whislist_screen/whislist_screen.dart';
import 'package:keshav_s_application2/widgets/app_bar/appbar_subtitle_6.dart';
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

class AddAddressScreenClickOnManageAddressScreen extends StatefulWidget {
  otp.Data data;
  AddAddressScreenClickOnManageAddressScreen(this.data);
  @override
  State<AddAddressScreenClickOnManageAddressScreen> createState() =>
      _AddAddressScreenClickOnManageAddressScreenState();
}

class _AddAddressScreenClickOnManageAddressScreenState
    extends State<AddAddressScreenClickOnManageAddressScreen> {
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
                title: AppbarTitle(
                    text: "MANAGE ADDRESS",
                    margin: getMargin(left: 19, top: 49, bottom: 42)),
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
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SearchScreen(widget.data, ''),
                        ));
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
                        //     text: "lbl_2".tr,
                        //     margin: getMargin(left: 17, bottom: 13))
                      ])),
                  Container(
                      height: getVerticalSize(24),
                      width: getHorizontalSize(29),
                      margin: getMargin(left: 14, top: 5, right: 31),
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
              child: Stack(
                children: [
                  ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                  ),
                  Container(
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
                                                            height:
                                                                getVerticalSize(
                                                                    25));
                                                      },
                                                      itemCount:
                                                          addresslist.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return ListhomeItemWidget(
                                                            widget.data,
                                                            addresslist[index]
                                                            //     onTapStackedit: () {
                                                            //   // onTapStackedit(context);
                                                            // }
                                                            );
                                                      })),
                                              CustomButton(
                                                  variant: ButtonVariant
                                                      .FillPurple900,
                                                  height: getVerticalSize(50),
                                                  width: getHorizontalSize(250),
                                                  text: "Add New Address",
                                                  margin: getMargin(
                                                      top: 30, right: 64),
                                                  padding:
                                                      ButtonPadding.PaddingT16,
                                                  fontStyle: ButtonFontStyle
                                                      .RobotoMedium15,
                                                  prefixWidget: Container(
                                                      margin:
                                                          getMargin(right: 12),
                                                      // decoration: BoxDecoration(
                                                      //     color: ColorConstant.whiteA700),
                                                      child: CustomImageView(
                                                        svgPath: ImageConstant
                                                            .imgPlus,
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
                ],
              ),
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
