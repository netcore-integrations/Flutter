import 'dart:convert';

import 'package:html/parser.dart';
import 'package:keshav_s_application2/presentation/add_address_screen/add_address_screen.dart';
import 'package:keshav_s_application2/presentation/add_address_screen_click_on_manage_address_screen/ManageAddressModel.dart';
import 'package:keshav_s_application2/presentation/cart_screen/cart_screen.dart';
import 'package:keshav_s_application2/presentation/otp_screen/models/otp_model.dart'
    as otp;
import 'package:keshav_s_application2/widgets/app_bar/appbar_subtitle_6.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:sizer/sizer.dart';

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

import '../drawermenuitems/offers/Model/OffersModel.dart';

class ApplyCoupon extends StatefulWidget {
  otp.Data data;
  ApplyCoupon(this.data);
  @override
  State<ApplyCoupon> createState() => _ApplyCouponState();
}

class _ApplyCouponState extends State<ApplyCoupon> {
  Future<OffersModel>? offers;
  List<OffersData> offerslist = [];

  Future<OffersModel> getOffersList() async {
    Map data = {
      'user_id': widget.data.id,
    };
    //encode Map to JSON
    var body = json.encode(data);
    var response =
        await dio.Dio().get("https://fabfurni.com/api/Webservice/offerList",
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
      if (OffersModel.fromJson(jsonObject).status == "true") {
        return OffersModel.fromJson(jsonObject);
        // inviteList.sort((a, b) => a.id.compareTo(b.id));
      } else if (OffersModel.fromJson(jsonObject).status == "false") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(OffersModel.fromJson(jsonObject).message!),
            backgroundColor: Colors.redAccent));
      } else if (OffersModel.fromJson(jsonObject).data == null) {
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
    offers = getOffersList();
    offers!.then((value) {
      setState(() {
        offerslist = value.data!;
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
                    text: "OFFERS",
                    margin: getMargin(left: 19, top: 49, bottom: 42)),
                styleType: Style.bgShadowBlack90033),
            body: RefreshIndicator(
              color: Colors.purple,
              onRefresh: () async {
                setState(() {
                  offers = getOffersList();
                  offers!.then((value) {
                    setState(() {
                      offerslist = value.data!;
                    });
                  });
                });
              },
              child: Container(
                  width: size.width,
                  padding: const EdgeInsets.all(8.0),
                  child: FutureBuilder(
                      future: offers,
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
                            return ListView.separated(
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  height: 20,
                                );
                              },
                              itemCount: offerslist.length,
                              itemBuilder: (context, index) {
                                var data = offerslist[index];
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      print("tapped");
                                      List<String> att = [
                                        offerslist[index].id!,
                                        offerslist[index].title!,
                                        offerslist[index].description!,
                                        offerslist[index].promoCode!
                                      ];
                                      Navigator.pop(context, att);
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            duration: Duration(seconds: 1),
                                            content: Text(
                                              "Coupon applied Successfully",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                            backgroundColor:
                                                Colors.greenAccent));
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.all(8),
                                      width: size.width,
                                      height: 100,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(data.image!),
                                              fit: BoxFit.cover),
                                          color: Colors.white,
                                          border: Border.all(
                                            color: Colors
                                                .purple, // Set the desired border color here
                                            width:
                                                1.0, // Set the desired border width here
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12))),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          // ClipRRect(
                                          //   borderRadius: const BorderRadius.all(
                                          //       Radius.circular(16)),
                                          //   child: Container(
                                          //     height: 16.h,
                                          //     width: 90.w,
                                          //     child: Image.network(
                                          //       data.image,
                                          //         fit: BoxFit.cover,
                                          //         width: 100.w,
                                          //         // alignment: Alignment(1.2, 1.2),
                                          //         filterQuality: FilterQuality.high,
                                          //         loadingBuilder:
                                          //             (context, child, loadingProgress) =>
                                          //         (loadingProgress == null)
                                          //             ? child
                                          //             : CircularProgressIndicator(
                                          //           color: Color(0xff9BA6BF),
                                          //           strokeWidth: 2,
                                          //         ),
                                          //         errorBuilder: (context, error, stackTrace) =>
                                          //             Image.asset(
                                          //                 "assets/images/image_not_found.png")
                                          //     ),
                                          //   ),
                                          // ),
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                          Flexible(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              // mainAxisAlignment:
                                              // MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    data.promoCode!.isNotEmpty
                                                        ? Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              // Set the background color here
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(Radius
                                                                          .circular(
                                                                              5)),
                                                              border:
                                                                  Border.all(
                                                                color: Colors
                                                                    .purple, // Set the border color here
                                                                width:
                                                                    1.0, // Set the border width here
                                                              ),
                                                            ),
                                                            child: Text(
                                                              // (Utils.parseHtmlString(
                                                              data.promoCode ??
                                                                  '',
                                                              // ))
                                                              // .sentenceCase,
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 16,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          )
                                                        : Container(),
                                                    data.promoCode!.isNotEmpty
                                                        ? SizedBox(
                                                            width: 4.w,
                                                          )
                                                        : SizedBox(
                                                            width: 0,
                                                          ),
                                                    Text(
                                                      // (Utils.parseHtmlString(
                                                      data.title ?? '',
                                                      // ))
                                                      // .sentenceCase,
                                                      style: const TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.white),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 8),
                                                Text(
                                                  (parseHtmlString(
                                                      data.description ?? '')),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.white),
                                                ),
                                                // SizedBox(height: 6),
                                                // Text(
                                                //   // (Utils.parseHtmlString(
                                                //   "Min Cart Value: "+data.minCart ?? '',
                                                //   // ))
                                                //   // .sentenceCase,
                                                //   style: const TextStyle(
                                                //     fontSize: 12,
                                                //     fontWeight: FontWeight.w500,
                                                //   ),
                                                //   maxLines: 1,
                                                //   overflow: TextOverflow.ellipsis,
                                                // ),
                                                // SizedBox(height: 8),
                                              ],
                                            ),
                                          ),
                                          // Container(
                                          //   width: 90.w,
                                          //   alignment: Alignment.centerRight,
                                          //   padding: EdgeInsets.only(left: 70.w),
                                          //   child: Row(
                                          //     mainAxisAlignment:
                                          //     MainAxisAlignment.spaceBetween,
                                          //     children: [
                                          //       Row(
                                          //         children: [
                                          //           const Icon(
                                          //             Icons.date_range_outlined,
                                          //             size: 12,
                                          //             color: Colors.blueGrey,
                                          //           ),
                                          //           Utils.sizedBoxWidth(4),
                                          //           Text(
                                          //             data.publishDate != null
                                          //                 ? Utils.dateFormatter(
                                          //                 data.publishDate!)
                                          //                 : '',
                                          //             style: const TextStyle(
                                          //                 fontSize: 12,
                                          //                 color: Colors.blueGrey),
                                          //           ),
                                          //         ],
                                          //       ),
                                          //     ],
                                          //   ),
                                          // ),
                                        ],
                                      )),
                                );
                              },
                            );

                            // SingleChildScrollView(
                            //   padding: getPadding(top: 25,bottom: 10),
                            //   child: Padding(
                            //       padding: getPadding(left: 4, right: 25),
                            //       child: Column(
                            //           crossAxisAlignment: CrossAxisAlignment.end,
                            //           mainAxisAlignment: MainAxisAlignment.start,
                            //           children: [
                            //             Padding(
                            //                 padding: getPadding(left: 21),
                            //                 child: ListView.separated(
                            //                     physics: NeverScrollableScrollPhysics(),
                            //                     shrinkWrap: true,
                            //                     separatorBuilder: (context, index) {
                            //                       return SizedBox(
                            //                           height: getVerticalSize(25));
                            //                     },
                            //                     itemCount: addresslist.length,
                            //                     itemBuilder: (context, index) {
                            //                       return GestureDetector(
                            //                         onTap: (){
                            //                           setState(() {
                            //                             print("tapped");
                            //                             List<String> att = [addresslist[index].id,addresslist[index].defaulted,addresslist[index].name,addresslist[index].addressOne+" "+addresslist[index].addressTwo+" "+addresslist[index].state.capitalizeFirst+" " +addresslist[index].country.capitalizeFirst+","+addresslist[index].pincode];
                            //                             Navigator.pop(context,att);
                            //                           });
                            //                           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            //                               duration: Duration(seconds: 1),
                            //                               content: Text("Address selected",style: TextStyle(color: Colors.black),),
                            //                               backgroundColor: Colors.greenAccent));
                            //                         },
                            //                         child: ListhomeItemWidget(widget.data,addresslist[index]
                            //                           //     onTapStackedit: () {
                            //                           //   // onTapStackedit(context);
                            //                           // }
                            //                         ),
                            //                       );
                            //                     })),
                            //             CustomButton(
                            //                 variant: ButtonVariant.FillPurple900,
                            //                 height: getVerticalSize(50),
                            //                 width: getHorizontalSize(250),
                            //                 text: "Add New Address",
                            //                 margin: getMargin(top: 30, right: 64),
                            //                 padding: ButtonPadding.PaddingT16,
                            //                 fontStyle: ButtonFontStyle.RobotoMedium15,
                            //                 prefixWidget: Container(
                            //                     margin: getMargin(right: 12),
                            //                     // decoration: BoxDecoration(
                            //                     //     color: ColorConstant.whiteA700),
                            //                     child: CustomImageView(
                            //                       svgPath: ImageConstant.imgPlus,color: Colors.white,)),
                            //                 onTap: () {
                            //                   onTapAddnewaddress(context);
                            //                 }),
                            //             // Align(
                            //             //     alignment: Alignment.centerLeft,
                            //             //     child: Container(
                            //             //         height: getVerticalSize(14),
                            //             //         width: getHorizontalSize(208),
                            //             //         margin: getMargin(top: 527),
                            //             //         child: Stack(
                            //             //             alignment: Alignment.topCenter,
                            //             //             children: [
                            //             //               Align(
                            //             //                   alignment:
                            //             //                       Alignment.bottomCenter,
                            //             //                   child: Container(
                            //             //                       padding: getPadding(
                            //             //                           left: 67,
                            //             //                           top: 2,
                            //             //                           right: 67,
                            //             //                           bottom: 2),
                            //             //                       decoration: AppDecoration
                            //             //                           .fillLightblueA100
                            //             //                           .copyWith(
                            //             //                               borderRadius:
                            //             //                                   BorderRadiusStyle
                            //             //                                       .customBorderBL11),
                            //             //                       child: Column(
                            //             //                           mainAxisSize:
                            //             //                               MainAxisSize.min,
                            //             //                           mainAxisAlignment:
                            //             //                               MainAxisAlignment
                            //             //                                   .start,
                            //             //                           children: [
                            //             //                             Text(
                            //             //                                 "Boy Fashion 2-4 year",
                            //             //                                 overflow:
                            //             //                                     TextOverflow
                            //             //                                         .ellipsis,
                            //             //                                 textAlign:
                            //             //                                     TextAlign
                            //             //                                         .left,
                            //             //                                 style: AppStyle
                            //             //                                     .txtRobotoRegular8)
                            //             //                           ]))),
                            //             //               Align(
                            //             //                   alignment: Alignment.topCenter,
                            //             //                   child: Container(
                            //             //                       width:
                            //             //                           getHorizontalSize(208),
                            //             //                       padding: getPadding(
                            //             //                           left: 30,
                            //             //                           top: 2,
                            //             //                           right: 67,
                            //             //                           bottom: 2),
                            //             //                       decoration: AppDecoration
                            //             //                           .txtFillLightblueA100
                            //             //                           .copyWith(
                            //             //                               borderRadius:
                            //             //                                   BorderRadiusStyle
                            //             //                                       .txtCustomBorderBL11),
                            //             //                       child: Text(
                            //             //                           "Boy Fashion 2-4 year",
                            //             //                           overflow: TextOverflow
                            //             //                               .ellipsis,
                            //             //                           textAlign:
                            //             //                               TextAlign.left,
                            //             //                           style: AppStyle
                            //             //                               .txtRobotoRegular8)))
                            //             //             ])))
                            //           ])));
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

  static String parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString =
        parse(document.body!.text).documentElement!.text;

    return parsedString;
  }
}
