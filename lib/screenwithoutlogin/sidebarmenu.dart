import 'package:icon_badge/icon_badge.dart';
import 'package:keshav_s_application2/presentation/app_inbox/app_inbox_screen.dart';
import 'package:keshav_s_application2/presentation/drawermenuitems/blogs/BlogsScreen.dart';
import 'package:keshav_s_application2/presentation/drawermenuitems/offers/OffersScreen.dart';
import 'package:keshav_s_application2/presentation/log_in_screen/log_in_screen.dart';
import 'package:keshav_s_application2/presentation/otp_screen/models/otp_model.dart';
import 'package:keshav_s_application2/presentation/profile_screen/profile_screen.dart';
import 'package:keshav_s_application2/presentation/store_screen/store_screen.dart';
import 'package:keshav_s_application2/screenwithoutlogin/BlogsScreen1.dart';
import 'package:keshav_s_application2/screenwithoutlogin/HtmlPage.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import 'package:flutter/material.dart';
import 'package:keshav_s_application2/core/app_export.dart';

import '../presentation/need_help/NeedHelp.dart';
import 'InAppWebview.dart';
import 'StoreScreen1.dart';
import 'Website.dart';
import 'offersscreen1.dart';

// ignore_for_file: must_be_immutable
class SidebarMenu extends StatefulWidget {
  var inboxCount;
  SidebarMenu(this.inboxCount);
  @override
  State<SidebarMenu> createState() => _SidebarMenuState();
}

class _SidebarMenuState extends State<SidebarMenu> {
  // var inbox_count;
  //
  // @override
  // void initState() {
  //   fetchCount();
  //   super.initState();
  // }
  //
  // fetchCount()async{
  //   SharedPreferences prefs_inbox_count = await SharedPreferences.getInstance();
  //   inbox_count=int.parse(prefs_inbox_count.getString('inbox_count')!);
  //   print("inbox count :$inbox_count");
  // }
  // SidebarMenu(this.controller);
  @override
  Widget build(BuildContext context) {
    double baseWidth = 428;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(300),
        ),
        child: SizedBox(
          width: 300,
          child: Drawer(
              child: Container(
                  width: getHorizontalSize(400),
                  padding: getPadding(left: 0, top: 0, right: 0, bottom: 0),
                  decoration: AppDecoration.outlineBlack90026.copyWith(
                      borderRadius: BorderRadiusStyle.customBorderBR393),
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(393 * fem),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x26000000),
                                offset: Offset(2 * fem, 1 * fem),
                                blurRadius: 3 * fem,
                              ),
                            ],
                          ),
                          child: Stack(children: [
                            Image.asset(
                              'assets/images/mask-group.png',
                              scale: 2,
                              // width: 369*fem,
                              // height: 117*fem,
                            ),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    // color: Colors.white,
                                    padding: EdgeInsets.fromLTRB(
                                        12.0, 35.0, 8.0, 0.0),
                                    // child: Column(
                                    //   crossAxisAlignment: CrossAxisAlignment.start,
                                    //   children: [
                                    //     Row(
                                    //       children: [
                                    //         Container(constraints: const BoxConstraints(
                                    //           maxWidth: 200,
                                    //         ),
                                    //
                                    //           child: FittedBox(
                                    //             fit:BoxFit.fill,
                                    //             child: Text(
                                    //               'Hi '+ widget.data.firstName.capitalizeFirst,
                                    //               textAlign: TextAlign.center,
                                    //               style: TextStyle(
                                    //                 fontFamily: 'Roboto',
                                    //                 fontSize: 15*ffem,
                                    //                 fontWeight: FontWeight.w500,
                                    //                 height: 1.1725*ffem/fem,
                                    //                 letterSpacing: 0.7*fem,
                                    //                 color: Color(0xff000000),
                                    //               ),
                                    //             ),
                                    //           ),
                                    //         ),
                                    //         // IconButton(onPressed: (){
                                    //         //   Get.toNamed(AppRoutes.profileScreen);
                                    //         // }, icon: Icon(Icons.edit_calendar_outlined,color: Colors.blue,size: 20,))
                                    //       ],
                                    //     ),
                                    //     Container(
                                    //       constraints: const BoxConstraints(
                                    //         maxWidth: 250,
                                    //       ),
                                    //       child: FittedBox(
                                    //         fit: BoxFit.fill,
                                    //         child: Text(
                                    //           widget.data.email,
                                    //           textAlign: TextAlign.center,
                                    //           style: TextStyle(
                                    //             fontFamily: 'Roboto',
                                    //             fontSize: 12*ffem,
                                    //             fontWeight: FontWeight.w400,
                                    //             height: 1.1725*ffem/fem,
                                    //             letterSpacing: 0.7*fem,
                                    //             color: Color(0xff000000),
                                    //           ),
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ],
                                    // )
                                  ),
                                ]),
                          ]),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                            padding: getPadding(
                                left: 18, right: 24, top: 10, bottom: 0),
                            child: InkWell(
                              onTap: () {
                                // Get.toNamed(AppRoutes.storeScreen);
                                // pushNewScreenWithRouteSettings(
                                //   context,
                                //   settings: RouteSettings(name: AppRoutes.storeScreen),
                                //   screen: StoreScreen(),
                                //   withNavBar: true,
                                //   pageTransitionAnimation: PageTransitionAnimation.cupertino,
                                // );
                                pushScreen(
                                  context,
                                  screen: StoreScreen1(),
                                  withNavBar:
                                      true, // OPTIONAL VALUE. True by default.
                                  pageTransitionAnimation:
                                      PageTransitionAnimation.cupertino,
                                );
                              },
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("msg_shop_by_department".tr,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: AppStyle
                                            .txtRobotoMedium12Black900
                                            .copyWith(
                                                letterSpacing:
                                                    getHorizontalSize(0.6))),
                                    CustomImageView(
                                        svgPath:
                                            ImageConstant.imgArrowrightGray500,
                                        height: getVerticalSize(10),
                                        width: getHorizontalSize(6),
                                        margin: getMargin(top: 2, bottom: 2))
                                  ]),
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        CustomPaint(
                          size: Size(280, 2),
                          painter: CurvePainter(),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => OffersScreen1(),
                            ));
                          },
                          child: Container(
                              width: 75.w,
                              padding: getPadding(
                                  left: 18, right: 24, top: 20, bottom: 10),
                              child:
                                  // IconButton(onPressed:(){
                                  //   Navigator.push(context,MaterialPageRoute(
                                  //     builder: (context) => OffersScreen1(),
                                  //   ));
                                  // },icon:Icon(Icons.notification_add)),
                                  Text("Offers",
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400,
                                        color: ColorConstant.black900,
                                      ))),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => HtmlPAGE(),
                            ));
                          },
                          child: Container(
                              width: 75.w,
                              padding: getPadding(
                                  left: 18, right: 24, top: 10, bottom: 10),
                              child: Text("Html Page",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400,
                                    color: ColorConstant.black900,
                                  ))),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SMTAppInboxScreen(),
                            ));
                          },
                          child: Container(
                              width: 75.w,
                              padding: getPadding(
                                  left: 18, right: 24, top: 10, bottom: 10),
                              child: Row(
                                children: [
                                  Text("App Inbox",
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400,
                                        color: ColorConstant.black900,
                                      )),
                                  SizedBox(width: 10,),
                                  IconBadge(
                                    icon: Icon(Icons.notifications_none),
                                    itemCount: widget.inboxCount==null?0:widget.inboxCount,
                                    badgeColor: Colors.red,
                                    itemColor: Colors.white,
                                    top: 0,
                                    right: 1,
                                    hideZero: false,
                                    onTap: () {
                                      print('test');
                                    },
                                  ),

                                ],
                              )),
                        ),

                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Website(),
                            ));
                          },
                          child: Container(
                              width: 75.w,
                              padding: getPadding(
                                  left: 18, right: 24, top: 10, bottom: 10),
                              child: Row(
                                children: [
                                  Text("Website",
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400,
                                        color: ColorConstant.black900,
                                      )),

                                ],
                              )),
                        ),

                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Inappwebview(),
                            ));
                          },
                          child: Container(
                              width: 75.w,
                              padding: getPadding(
                                  left: 18, right: 24, top: 10, bottom: 10),
                              child: Text("Webview",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400,
                                    color: ColorConstant.black900,
                                  ))),
                        ),
                        InkWell(
                          onTap: () {
                            pushScreen(
                              context,
                              screen: LogInScreen(),
                              withNavBar:
                                  false, // OPTIONAL VALUE. True by default.
                              pageTransitionAnimation:
                                  PageTransitionAnimation.cupertino,
                            );
                          },
                          child: Container(
                              width: 75.w,
                              padding: getPadding(
                                  left: 18, right: 24, top: 10, bottom: 10),
                              child: Text("My Orders",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400,
                                    color: ColorConstant.black900,
                                  ))),
                        ),
                        InkWell(
                          onTap: () {
                            pushScreen(
                              context,
                              screen: LogInScreen(),
                              withNavBar:
                                  false, // OPTIONAL VALUE. True by default.
                              pageTransitionAnimation:
                                  PageTransitionAnimation.cupertino,
                            );
                            // pushNewScreen(
                            //   context,
                            //   screen: WhislistScreen(widget.data),
                            //   withNavBar:
                            //   false, // OPTIONAL VALUE. True by default.
                            //   pageTransitionAnimation:
                            //   PageTransitionAnimation.cupertino,
                            // );
                          },
                          child: Container(
                              width: 75.w,
                              padding: getPadding(
                                  left: 18, right: 24, top: 10, bottom: 10),
                              child: Text("Wishlist",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400,
                                    color: ColorConstant.black900,
                                  ))),
                        ),
                        // InkWell(
                        //   onTap: (){
                        //
                        //   },
                        //   child: Container(
                        //       width: 75.w,
                        //       padding: getPadding(left:18,right: 24,top:10,bottom: 10),
                        //       child: Text("lbl_buy_on_phone".tr,
                        //           overflow: TextOverflow.ellipsis,
                        //           textAlign: TextAlign.left,
                        //           style: TextStyle(fontSize: 14,fontFamily: 'Roboto',
                        //             fontWeight: FontWeight.w400,color: ColorConstant.black900,))),
                        // ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => BlogsScreen1(),
                            ));
                          },
                          child: Container(
                              width: 75.w,
                              padding: getPadding(
                                  left: 18, right: 24, top: 10, bottom: 10),
                              child: Text("lbl_our_blogs".tr,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400,
                                    color: ColorConstant.black900,
                                  ))),
                        ),
                        // InkWell(
                        //   onTap: (){
                        //
                        //   },
                        //   child: Container(
                        //       width: 75.w,
                        //       padding: getPadding(left:18,right: 24,top:10,bottom: 10),
                        //       child: Text("lbl_partner_with_us".tr,
                        //           overflow: TextOverflow.ellipsis,
                        //           textAlign: TextAlign.left,
                        //           style: TextStyle(fontSize: 14,fontFamily: 'Roboto',
                        //             fontWeight: FontWeight.w400,color: ColorConstant.black900,))),
                        // ),

                        SizedBox(
                          height: 20,
                        ),
                        CustomPaint(
                          size: Size(280, 2),
                          painter: CurvePainter(),
                        ),
                        InkWell(
                          onTap: () {
                            pushScreen(
                              context,
                              screen: LogInScreen(),
                              withNavBar:
                                  false, // OPTIONAL VALUE. True by default.
                              pageTransitionAnimation:
                                  PageTransitionAnimation.cupertino,
                            );
                            // Navigator.of(context).push(MaterialPageRoute(
                            //   builder: (context) => LogInScreen(),
                            // ));
                          },
                          child: Container(
                              width: 75.w,
                              padding: getPadding(
                                  left: 18, right: 24, top: 20, bottom: 10),
                              child: Text("lbl_my_account".tr,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400,
                                    color: ColorConstant.black900,
                                  ))),
                        ),
                        // Padding(
                        //     padding: getPadding(left:18,right: 24,top:10,bottom: 10),
                        //     child: Text("lbl_track_order".tr,
                        //         overflow: TextOverflow.ellipsis,
                        //         textAlign: TextAlign.left,
                        //         style: TextStyle(fontSize: 14,fontFamily: 'Roboto',
                        //           fontWeight: FontWeight.w400,color: ColorConstant.black900,))),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => NeedHelp(),
                            ));
                          },
                          child: Container(
                              width: 75.w,
                              padding: getPadding(
                                  left: 18, right: 24, top: 10, bottom: 10),
                              child: Text("lbl_need_help".tr,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400,
                                    color: ColorConstant.black900,
                                  ))),
                        ),
                        InkWell(
                            onTap: () {
                              onTapTxtAboutus();
                            },
                            child: Container(
                                width: 75.w,
                                padding: getPadding(
                                    left: 18, right: 24, top: 10, bottom: 10),
                                child: Text("lbl_about_us2".tr,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                      color: ColorConstant.black900,
                                    ))))
                      ]))),
        ),
      ),
    );
  }

  onTapTxtAboutus() {
    Get.toNamed(AppRoutes.aboutUsScreen);
  }
}

onTapTxtMyAccount() {
  Get.toNamed(AppRoutes.profileScreen);
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.black;
    paint.style = PaintingStyle.fill; // Change this to fill

    var path = Path();

    path.moveTo(0, 0);
    path.quadraticBezierTo(size.width / 2, size.height / 2, size.width, 0);
    path.quadraticBezierTo(size.width / 2, -size.height / 2, 0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
