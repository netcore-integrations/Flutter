import 'package:keshav_s_application2/presentation/add_address_screen_click_on_manage_address_screen/add_address_screen_click_on_manage_address_screen.dart';
import 'package:keshav_s_application2/presentation/cart_screen/cart_screen.dart';
import 'package:keshav_s_application2/presentation/changepassword/changepassword.dart';
import 'package:keshav_s_application2/presentation/log_in_screen/log_in_screen.dart';
import 'package:keshav_s_application2/presentation/my_orders_screen/my_orders_screen.dart';
import 'package:keshav_s_application2/presentation/otp_screen/models/otp_model.dart';
import 'package:keshav_s_application2/presentation/profile_screen/profile_screen.dart';
import 'package:keshav_s_application2/presentation/search_screen/search_screen.dart';
import 'package:keshav_s_application2/presentation/sidebar_menu_draweritem/sidebar_menu_draweritem.dart';
import 'package:keshav_s_application2/presentation/wallet/wallet_screen.dart';
import 'package:keshav_s_application2/presentation/whislist_screen/whislist_screen.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartech_appinbox/smartech_appinbox.dart';
import 'package:smartech_base/smartech_base.dart';

import '../../screenwithoutlogin/sidebarmenu.dart';
import '../resetPassword/resetpasswordafterlogin.dart';
import 'controller/profile_one_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as fs;
import 'package:keshav_s_application2/core/app_export.dart';
import 'package:keshav_s_application2/widgets/app_bar/appbar_image.dart';
import 'package:keshav_s_application2/widgets/app_bar/appbar_subtitle_5.dart';
import 'package:keshav_s_application2/widgets/app_bar/appbar_subtitle_6.dart';
import 'package:keshav_s_application2/widgets/app_bar/custom_app_bar.dart';

class ProfileOneScreen extends StatefulWidget {
  //Data data;
  String mobileNumber;
  ProfileOneScreen(
      //this.data
      this.mobileNumber
      );
  @override
  State<ProfileOneScreen> createState() => _ProfileOneScreenState();
}

class _ProfileOneScreenState extends State<ProfileOneScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var inbox_count;

  @override
  void initState() {
    getAppInboxMessageCount();
    super.initState();
  }

  Future getAppInboxMessageCount({String? smtAppInboxMessageType}) async {
    await SmartechAppinbox()
        .getAppInboxMessageCount(
        smtAppInboxMessageType: smtAppInboxMessageType ?? "")
        .then(
          (value) {
        inbox_count=int.tryParse(value.toString() ?? "");
        print(inbox_count);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            key: _scaffoldKey,
            backgroundColor: ColorConstant.whiteA700,
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
                              // pushScreen(
                              //   context,
                              //   screen: WhislistScreen(widget.data),
                              //   withNavBar:
                              //       false, // OPTIONAL VALUE. True by default.
                              //   pageTransitionAnimation:
                              //       PageTransitionAnimation.cupertino,
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
                              // pushScreen(
                              //   context,
                              //   screen: CartScreen(widget.data),
                              //   withNavBar:
                              //       false, // OPTIONAL VALUE. True by default.
                              //   pageTransitionAnimation:
                              //       PageTransitionAnimation.cupertino,
                              // );
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
            drawer: SidebarMenu(inbox_count),
            // SidebarMenuDraweritem(
            //     widget.data
            // ),
            body: SingleChildScrollView(
              child: Container(
                  width: double.maxFinite,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            height: getVerticalSize(75),
                            width: double.maxFinite,
                            margin: getMargin(top: 0),
                            child:
                                Stack(alignment: Alignment.center, children: [
                              Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Padding(
                                      padding: getPadding(left: 28, bottom: 7),
                                      child: Text("lbl_new",
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style: AppStyle.txtRobotoMedium9))),
                              Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                      padding: getPadding(
                                          left: 28,
                                          top: 16,
                                          right: 28,
                                          bottom: 14),
                                      decoration: AppDecoration.fillPurple50,
                                      child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                                padding: getPadding(top: 0),
                                                child: Row(children: [
                                                  Text(
                                                      'Hi ' +
                                                          // widget.data.firstName!
                                                          //     .capitalizeFirst!,
                                                          widget.mobileNumber,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign: TextAlign.left,
                                                      style: AppStyle
                                                          .txtRobotoRegular14Black900
                                                          .copyWith(
                                                              letterSpacing:
                                                                  getHorizontalSize(
                                                                      0.7))),
                                                  CustomImageView(
                                                      onTap: () {
                                                        // Navigator.of(context)
                                                        //     .push(
                                                        //         MaterialPageRoute(
                                                        //   builder: (context) =>
                                                        //       ProfileScreen(
                                                        //           widget.data),
                                                        // ));
                                                      },
                                                      svgPath:
                                                          ImageConstant.imgEdit,
                                                      height:
                                                          getVerticalSize(14),
                                                      width:
                                                          getHorizontalSize(14),
                                                      margin: getMargin(
                                                          left: 15,
                                                          top: 3,
                                                          bottom: 3))
                                                ])),
                                            Padding(
                                                padding: getPadding(top: 9),
                                                child: Text(
                                                   // widget.data.email!
                                                    "user1@gmail.com",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.left,
                                                    style: AppStyle
                                                        .txtRobotoLight10
                                                        .copyWith(
                                                            letterSpacing:
                                                                getHorizontalSize(
                                                                    0.5))))
                                          ]))),
                              CustomImageView(
                                  imagePath: ImageConstant.imgRectangle136,
                                  height: getVerticalSize(75),
                                  width: getHorizontalSize(22),
                                  alignment: Alignment.centerRight)
                            ])),
                        InkWell(
                          onTap: () {
                            // Navigator.of(context).push(MaterialPageRoute(
                            //   builder: (context) => MyOrdersScreen(widget.data),
                            // ));
                          },
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                  padding: getPadding(left: 25, top: 20),
                                  child: Row(children: [
                                    CustomImageView(
                                        svgPath: ImageConstant.imgMap,
                                        height: getVerticalSize(17),
                                        width: getHorizontalSize(25),
                                        margin: getMargin(bottom: 1)),
                                    Padding(
                                        padding: getPadding(left: 34, top: 1),
                                        child: Text("My Orders",
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: AppStyle
                                                .txtRobotoRegular14Purple400))
                                  ]))),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Divider(color: Colors.purple,thickness: 0.5,),
                        // ),
                        // InkWell(
                        //   onTap: (){
                        //
                        //   },
                        //   child: Align(
                        //       alignment: Alignment.centerLeft,
                        //       child: Padding(
                        //           padding: getPadding(left: 25, top: 0),
                        //           child: Row(children: [
                        //             CustomImageView(
                        //                 svgPath: ImageConstant.imgLocationPurple700,
                        //                 height: getVerticalSize(25),
                        //                 width: getHorizontalSize(18),
                        //                 margin: getMargin(left: 4)),
                        //             Padding(
                        //                 padding: getPadding(left: 34, top: 1),
                        //                 child: Text("Track Orders",
                        //                     overflow: TextOverflow.ellipsis,
                        //                     textAlign: TextAlign.left,
                        //                     style: AppStyle
                        //                         .txtRobotoRegular14Purple400))
                        //           ]))),
                        // ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Divider(
                            color: Colors.purple,
                            thickness: 0.5,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            // pushScreen(
                            //   context,
                            //   screen: WhislistScreen(widget.data),
                            //   withNavBar:
                            //       false, // OPTIONAL VALUE. True by default.
                            //   pageTransitionAnimation:
                            //       PageTransitionAnimation.cupertino,
                            // );
                          },
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                  padding: getPadding(left: 25, top: 0),
                                  child: Row(children: [
                                    CustomImageView(
                                        svgPath:
                                            ImageConstant.imgFavoritePurple700,
                                        height: getVerticalSize(25),
                                        width: getHorizontalSize(18),
                                        margin: getMargin(left: 4)),
                                    Padding(
                                        padding: getPadding(left: 34, top: 1),
                                        child: Text("Wishlist",
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: AppStyle
                                                .txtRobotoRegular14Purple400))
                                  ]))),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Divider(
                            color: Colors.purple,
                            thickness: 0.5,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) =>
                            //             WalletScreen(widget.data)));
                          },
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                  padding: getPadding(left: 25, top: 0),
                                  child: Row(children: [
                                    CustomImageView(
                                        svgPath: ImageConstant.imgFilePurple700,
                                        height: getVerticalSize(25),
                                        width: getHorizontalSize(18),
                                        margin: getMargin(left: 4)),
                                    Padding(
                                        padding: getPadding(left: 34, top: 1),
                                        child: Text("My Wallet",
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: AppStyle
                                                .txtRobotoRegular14Purple400))
                                  ]))),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Divider(
                            color: Colors.purple,
                            thickness: 0.5,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            // Navigator.of(context).push(MaterialPageRoute(
                            //   builder: (context) =>
                            //       AddAddressScreenClickOnManageAddressScreen(
                            //           widget.data),
                            // ));
                          },
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                  padding: getPadding(left: 25, top: 0),
                                  child: Row(children: [
                                    CustomImageView(
                                        svgPath:
                                            ImageConstant.imgVectorPurple700,
                                        height: getVerticalSize(25),
                                        width: getHorizontalSize(18),
                                        margin: getMargin(left: 4)),
                                    Padding(
                                        padding: getPadding(left: 34, top: 1),
                                        child: Text("Address Book",
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: AppStyle
                                                .txtRobotoRegular14Purple400))
                                  ]))),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Divider(
                            color: Colors.purple,
                            thickness: 0.5,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => ChangePassword(
                            //               widget.data,
                            //             )));
                          },
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                  padding: getPadding(left: 25, top: 0),
                                  child: Row(children: [
                                    CustomImageView(
                                        svgPath: ImageConstant.imgLock,
                                        height: getVerticalSize(25),
                                        width: getHorizontalSize(18),
                                        margin: getMargin(left: 4)),
                                    Padding(
                                        padding: getPadding(left: 34, top: 1),
                                        child: Text("Change Password",
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: AppStyle
                                                .txtRobotoRegular14Purple400))
                                  ]))),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Divider(
                            color: Colors.purple,
                            thickness: 0.5,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) =>
                            //             ResetPasswordAfterLogin(
                            //               widget.data,
                            //             )));
                          },
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                  padding: getPadding(left: 25, top: 0),
                                  child: Row(children: [
                                    CustomImageView(
                                        svgPath: ImageConstant.imgLock,
                                        height: getVerticalSize(25),
                                        width: getHorizontalSize(18),
                                        margin: getMargin(left: 4)),
                                    Padding(
                                        padding: getPadding(left: 34, top: 1),
                                        child: Text("Reset Password",
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: AppStyle
                                                .txtRobotoRegular14Purple400))
                                  ]))),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Divider(
                            color: Colors.purple,
                            thickness: 0.5,
                          ),
                        ),
                        // InkWell(
                        //   onTap: (){
                        //
                        //   },
                        //   child: Align(
                        //       alignment: Alignment.centerLeft,
                        //       child: Padding(
                        //           padding: getPadding(left: 25, top: 0),
                        //           child: Row(children: [
                        //             CustomImageView(
                        //                 svgPath: ImageConstant.imgArrowdown,
                        //                 height: getVerticalSize(25),
                        //                 width: getHorizontalSize(18),
                        //                 margin: getMargin(left: 4)),
                        //             Padding(
                        //                 padding: getPadding(left: 34, top: 1),
                        //                 child: Text("Two Step Verification",
                        //                     overflow: TextOverflow.ellipsis,
                        //                     textAlign: TextAlign.left,
                        //                     style: AppStyle
                        //                         .txtRobotoRegular14Purple400))
                        //           ]))),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Divider(color: Colors.purple,thickness: 0.5,),
                        // ),
                        InkWell(
                          onTap: () async {
                            final SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.clear();
                            Smartech().logoutAndClearUserIdentity(true);
                            Navigator.of(context, rootNavigator: true)
                                .pushAndRemoveUntil(
                                    new MaterialPageRoute(
                                      builder: (context) => LogInScreen(),
                                    ),
                                    (route) => false);
                          },
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                  padding: getPadding(left: 25, top: 0),
                                  child: Row(children: [
                                    CustomImageView(
                                        svgPath: ImageConstant.imgVolume,
                                        height: getVerticalSize(25),
                                        width: getHorizontalSize(18),
                                        margin: getMargin(left: 4)),
                                    Padding(
                                        padding: getPadding(left: 34, top: 1),
                                        child: Text("Sign Out",
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: AppStyle
                                                .txtRobotoRegular14Purple400))
                                  ]))),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Divider(
                            color: Colors.purple,
                            thickness: 0.5,
                          ),
                        ),

                        // Container(
                        //     height: getVerticalSize(477),
                        //     width: double.maxFinite,
                        //     margin: getMargin(top: 21),
                        //     child: Stack(alignment: Alignment.center, children: [
                        //       Align(
                        //           alignment: Alignment.centerLeft,
                        //           child: Padding(
                        //               padding: getPadding(left: 25),
                        //               child: Column(
                        //                   mainAxisSize: MainAxisSize.min,
                        //                   crossAxisAlignment:
                        //                       CrossAxisAlignment.start,
                        //                   mainAxisAlignment:
                        //                       MainAxisAlignment.start,
                        //                   children: [
                        //                     CustomImageView(
                        //                         svgPath: ImageConstant
                        //                             .imgLocationPurple700,
                        //                         height: getVerticalSize(25),
                        //                         width: getHorizontalSize(18),
                        //                         margin: getMargin(left: 4)),
                        //                     CustomImageView(
                        //                         svgPath: ImageConstant
                        //                             .imgFavoritePurple700,
                        //                         height: getVerticalSize(21),
                        //                         width: getHorizontalSize(25),
                        //                         margin: getMargin(top: 45)),
                        //                     CustomImageView(
                        //                         svgPath: ImageConstant
                        //                             .imgFilePurple700,
                        //                         height: getVerticalSize(21),
                        //                         width: getHorizontalSize(25),
                        //                         margin: getMargin(top: 45)),
                        //                     CustomImageView(
                        //                         svgPath: ImageConstant
                        //                             .imgVectorPurple700,
                        //                         height: getVerticalSize(25),
                        //                         width: getHorizontalSize(21),
                        //                         alignment: Alignment.centerLeft,
                        //                         margin: getMargin(top: 44)),
                        //                     CustomImageView(
                        //                         svgPath: ImageConstant.imgLock,
                        //                         height: getVerticalSize(25),
                        //                         width: getHorizontalSize(21),
                        //                         alignment: Alignment.centerLeft,
                        //                         margin: getMargin(top: 43)),
                        //                     CustomImageView(
                        //                         svgPath:
                        //                             ImageConstant.imgArrowdown,
                        //                         height: getVerticalSize(19),
                        //                         width: getHorizontalSize(21),
                        //                         alignment: Alignment.centerLeft,
                        //                         margin: getMargin(top: 46)),
                        //                     CustomImageView(
                        //                         svgPath: ImageConstant.imgVolume,
                        //                         height: getVerticalSize(19),
                        //                         width: getHorizontalSize(25),
                        //                         alignment: Alignment.centerLeft,
                        //                         margin: getMargin(top: 47))
                        //                   ]))),
                        //       Align(
                        //           alignment: Alignment.center,
                        //           child: Container(
                        //               padding: getPadding(
                        //                   left: 0,
                        //                   top: 26,
                        //                   right: 84,
                        //                   bottom: 26),
                        //               decoration: BoxDecoration(
                        //                   image: DecorationImage(
                        //                       image: AssetImage(
                        //                           ImageConstant.imgGroup167),
                        //                       fit: BoxFit.fill)),
                        //               child: Column(
                        //                   mainAxisSize: MainAxisSize.min,
                        //                   crossAxisAlignment:
                        //                       CrossAxisAlignment.start,
                        //                   mainAxisAlignment:
                        //                       MainAxisAlignment.start,
                        //                   children: [
                        //                     Text("Track_Orders",
                        //                         overflow: TextOverflow.ellipsis,
                        //                         textAlign: TextAlign.left,
                        //                         style: AppStyle
                        //                             .txtRobotoRegular14Purple400),
                        //                     Padding(
                        //                         padding: getPadding(top: 51),
                        //                         child: Text("Wishlist",
                        //                             overflow:
                        //                                 TextOverflow.ellipsis,
                        //                             textAlign: TextAlign.left,
                        //                             style: AppStyle
                        //                                 .txtRobotoRegular14Purple400)),
                        //                     Padding(
                        //                         padding: getPadding(top: 52),
                        //                         child: Text("My Wallet",
                        //                             overflow:
                        //                                 TextOverflow.ellipsis,
                        //                             textAlign: TextAlign.left,
                        //                             style: AppStyle
                        //                                 .txtRobotoRegular14Purple400)),
                        //                     Padding(
                        //                         padding: getPadding(top: 49),
                        //                         child: Text("Address Book",
                        //                             overflow:
                        //                                 TextOverflow.ellipsis,
                        //                             textAlign: TextAlign.left,
                        //                             style: AppStyle
                        //                                 .txtRobotoRegular14Purple400)),
                        //                     Padding(
                        //                         padding: getPadding(top: 53),
                        //                         child: Text(
                        //                             "Change Password",
                        //                             overflow:
                        //                                 TextOverflow.ellipsis,
                        //                             textAlign: TextAlign.left,
                        //                             style: AppStyle
                        //                                 .txtRobotoRegular14Purple400)),
                        //                     Padding(
                        //                         padding: getPadding(top: 49),
                        //                         child: Text(
                        //                             "Two Step Verification"
                        //                                 ,
                        //                             overflow:
                        //                                 TextOverflow.ellipsis,
                        //                             textAlign: TextAlign.left,
                        //                             style: AppStyle
                        //                                 .txtRobotoRegular14Purple400)),
                        //                     Padding(
                        //                         padding: getPadding(top: 49),
                        //                         child: Text("Sign Out",
                        //                             overflow:
                        //                                 TextOverflow.ellipsis,
                        //                             textAlign: TextAlign.left,
                        //                             style: AppStyle
                        //                                 .txtRobotoRegular14Purple400))
                        //                   ])))
                        //     ])),
                        // Padding(
                        //     padding: getPadding(left: 28, top: 80, right: 17),
                        //     child: Row(
                        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //         children: [
                        //           Text("lbl_new",
                        //               overflow: TextOverflow.ellipsis,
                        //               textAlign: TextAlign.left,
                        //               style: AppStyle.txtRobotoMedium9),
                        //           Text("lbl_30_off2",
                        //               overflow: TextOverflow.ellipsis,
                        //               textAlign: TextAlign.left,
                        //               style: AppStyle.txtRobotoMedium9)
                        //         ])),
                        // Container(
                        //     height: getVerticalSize(86),
                        //     width: getHorizontalSize(400),
                        //     margin: getMargin(top: 31),
                        //     decoration: BoxDecoration(
                        //         image: DecorationImage(
                        //             image: fs.Svg(ImageConstant.imgGroup203),
                        //             fit: BoxFit.cover)),
                        //     child: Stack(alignment: Alignment.center, children: [
                        //       Align(
                        //           alignment: Alignment.bottomCenter,
                        //           child: Padding(
                        //               padding: getPadding(
                        //                   left: 41, right: 44, bottom: 6),
                        //               child: Column(
                        //                   mainAxisSize: MainAxisSize.min,
                        //                   mainAxisAlignment:
                        //                       MainAxisAlignment.start,
                        //                   children: [
                        //                     CustomImageView(
                        //                         svgPath: ImageConstant.imgGroup2,
                        //                         height: getVerticalSize(47),
                        //                         width: getHorizontalSize(315)),
                        //                     Padding(
                        //                         padding: getPadding(
                        //                             left: 7, top: 4, right: 1),
                        //                         child: Row(
                        //                             mainAxisAlignment:
                        //                                 MainAxisAlignment
                        //                                     .spaceBetween,
                        //                             children: [
                        //                               Text("lbl_home",
                        //                                   overflow: TextOverflow
                        //                                       .ellipsis,
                        //                                   textAlign:
                        //                                       TextAlign.left,
                        //                                   style: AppStyle
                        //                                       .txtRobotoMedium8Purple900),
                        //                               Text("lbl_store",
                        //                                   overflow: TextOverflow
                        //                                       .ellipsis,
                        //                                   textAlign:
                        //                                       TextAlign.left,
                        //                                   style: AppStyle
                        //                                       .txtRobotoMedium8),
                        //                               Text("lbl_profile",
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
                        //                         svgPath: ImageConstant
                        //                             .imgGroup2Gray500,
                        //                         height: getVerticalSize(47),
                        //                         width: getHorizontalSize(315),
                        //                         margin: getMargin(top: 11)),
                        //                     Padding(
                        //                         padding: getPadding(
                        //                             left: 7, top: 4, right: 3),
                        //                         child: Row(
                        //                             mainAxisAlignment:
                        //                                 MainAxisAlignment
                        //                                     .spaceBetween,
                        //                             children: [
                        //                               Text("lbl_home",
                        //                                   overflow: TextOverflow
                        //                                       .ellipsis,
                        //                                   textAlign:
                        //                                       TextAlign.left,
                        //                                   style: AppStyle
                        //                                       .txtRobotoMedium8),
                        //                               Text("lbl_store",
                        //                                   overflow: TextOverflow
                        //                                       .ellipsis,
                        //                                   textAlign:
                        //                                       TextAlign.left,
                        //                                   style: AppStyle
                        //                                       .txtRobotoMedium8),
                        //                               Text("lbl_profile",
                        //                                   overflow: TextOverflow
                        //                                       .ellipsis,
                        //                                   textAlign:
                        //                                       TextAlign.left,
                        //                                   style: AppStyle
                        //                                       .txtRobotoMedium8Purple900)
                        //                             ]))
                        //                   ])))
                        //     ])),
                        // Padding(
                        //     padding: getPadding(left: 8, top: 83, right: 8),
                        //     child: Row(
                        //         mainAxisAlignment: MainAxisAlignment.center,
                        //         crossAxisAlignment: CrossAxisAlignment.end,
                        //         children: [
                        //           Padding(
                        //               padding: getPadding(bottom: 4),
                        //               child: Text("msg_fabiola_2_seater2",
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
                        //               child: Text("lbl_49_999",
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
                        //               child: Text("msg_casacraft_by_fabfurni",
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
                        //                         child: Text("lbl_99_999",
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
                        //                 Text("msg_limited_time_offer",
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
                        //                           Text("lbl_ships_in_1_day",
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
                        //                   getMargin(left: 35, top: 9, bottom: 2))
                        //         ])),
                        // Padding(
                        //     padding: getPadding(top: 17),
                        //     child: Divider(
                        //         height: getVerticalSize(5),
                        //         thickness: getVerticalSize(5),
                        //         color: ColorConstant.purple50))
                      ])),
            )));
  }

  onTapSearch() {
    // Navigator.of(context).push(MaterialPageRoute(
    //   builder: (context) => SearchScreen(widget.data, ''),
    // ));
  }

  onTapWishlist() {
    Get.toNamed(AppRoutes.whislistScreen);
  }

  onTapArrowleft7() {
    Get.back();
  }
}
