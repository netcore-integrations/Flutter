import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:html/parser.dart';
import 'package:keshav_s_application2/core/utils/appConstant.dart';
import 'package:keshav_s_application2/presentation/about_us_screen/models/SettingVO.dart';
import 'package:keshav_s_application2/presentation/log_in_screen/log_in_screen.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:sizer/sizer.dart';
import 'package:smartech_base/smartech_base.dart';

import '../../core/utils/utils.dart';
import '../../widgets/app_bar/appbar_title.dart';
// import '../filter_screen/models/FilterVO.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as fs;
import 'package:keshav_s_application2/core/app_export.dart';
import 'package:keshav_s_application2/widgets/app_bar/appbar_image.dart';
import 'package:keshav_s_application2/widgets/app_bar/appbar_subtitle_5.dart';
import 'package:keshav_s_application2/widgets/app_bar/appbar_subtitle_6.dart';
import 'package:keshav_s_application2/widgets/app_bar/custom_app_bar.dart';

import '../widgets/custom_button.dart';

class ProfileScreenWithoutLogin extends StatefulWidget {
  @override
  State<ProfileScreenWithoutLogin> createState() =>
      _ProfileScreenWithoutLogin();
}

class _ProfileScreenWithoutLogin extends State<ProfileScreenWithoutLogin> {
  // final List<Setting> _listData = <Setting>[];
  // SettingVO settingVO;
  // String versionCode;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   _requestData();
  //   getVersion();
  // }

  @override
  Widget build(BuildContext context) {
    Smartech().trackEvent('profile_screen', {});
    return SafeArea(
        child: Scaffold(
      backgroundColor: ColorConstant.whiteA700,
      appBar: CustomAppBar(
          height: getVerticalSize(91),
          // leadingWidth: 34,
          // leading: AppbarImage(
          //     height: getVerticalSize(15),
          //     width: getHorizontalSize(9),
          //     svgPath: ImageConstant.imgArrowleft,
          //     margin: getMargin(left: 25, top: 53, bottom: 23),
          //     onTap: (){
          //       Navigator.pop(context);
          //     }),
          // title: AppbarTitle(
          //     text: "Need Help",
          //     margin: getMargin(left: 19, top: 50, bottom: 18)),
          // actions: [
          //   AppbarImage(
          //       height: getSize(21),
          //       width: getSize(21),
          //       svgPath: ImageConstant.imgSearch,
          //       margin: getMargin(left: 12, top: 51, right: 19)),
          //   Container(
          //       height: getVerticalSize(23),
          //       width: getHorizontalSize(27),
          //       margin:
          //           getMargin(left: 20, top: 48, right: 19, bottom: 1),
          //       child: Stack(alignment: Alignment.topRight, children: [
          //         AppbarImage(
          //             height: getVerticalSize(18),
          //             width: getHorizontalSize(21),
          //             svgPath: ImageConstant.imgLocation,
          //             margin: getMargin(top: 5, right: 6)),
          //         AppbarSubtitle6(
          //             text: "lbl_2".tr,
          //             margin: getMargin(left: 17, bottom: 13))
          //       ])),
          //   Container(
          //       height: getVerticalSize(24),
          //       width: getHorizontalSize(29),
          //       margin: getMargin(left: 14, top: 48, right: 31),
          //       child: Stack(alignment: Alignment.topRight, children: [
          //         AppbarImage(
          //             height: getVerticalSize(20),
          //             width: getHorizontalSize(23),
          //             svgPath: ImageConstant.imgCart,
          //             margin: getMargin(top: 4, right: 6)),
          //         AppbarSubtitle6(
          //             text: "lbl_3".tr,
          //             margin: getMargin(left: 19, bottom: 14))
          //       ]))
          // ],
          styleType: Style.bgStyle_1),
      body: Container(
          width: double.maxFinite,
          padding: getPadding(top: 20, bottom: 20),
          child: Column(
            children: [
              SizedBox(
                height: 14.h,
              ),
              CustomImageView(
                imagePath: ImageConstant.imgAppicon0202,
                height: getSize(
                  222,
                ),
                width: getSize(
                  222,
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              CustomButton(
                  onTap: () {
                    pushScreen(
                      context,
                      screen: LogInScreen(),
                      withNavBar: false, // OPTIONAL VALUE. True by default.
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                    );
                  },
                  height: getVerticalSize(35),
                  text: "LOGIN",
                  margin: getMargin(left: 40, top: 14, right: 40),
                  variant: ButtonVariant.FillPurple900,
                  shape: ButtonShape.RoundedBorder5,
                  fontStyle: ButtonFontStyle.RobotoMedium16),
              // ElevatedButton(
              //     onPressed: (){
              //       pushNewScreen(
              //         context,
              //         screen: LogInScreen(),
              //         withNavBar:
              //         false, // OPTIONAL VALUE. True by default.
              //         pageTransitionAnimation:
              //         PageTransitionAnimation.cupertino,
              //       );
              //       // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
              //       //     LogInScreen()), (Route<dynamic> route) => false);
              //     },
              //     child:   Text("Login",style: SafeGoogleFont(
              //   'Poppins SemiBold',
              //   fontSize: 18.sp,
              //   fontWeight: FontWeight.w400,
              //   // height: 1.2575 * ffem / fem,
              //   color: Colors.black,
              // ),),),
            ],
          )
          // Column(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     children: [
          //       InkWell(
          //         onTap: () {
          //           AppConstant.aboutType = '1';
          //           int index = _listData.indexWhere((setting) => setting.settingsKeys == 'terms_condition');
          //           AppConstant.terms = _parseHtmlString(_listData[index].settingsValues);
          //           onTapTxt();
          //         },
          //         child: Padding(
          //             padding: getPadding(left: 39, right: 32),
          //             child: Row(
          //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                 children: [
          //                   Text("lbl_terms_of_use2".tr,
          //                       overflow: TextOverflow.ellipsis,
          //                       textAlign: TextAlign.left,
          //                       style: AppStyle
          //                           .txtRobotoRegular12Black900
          //                           .copyWith(
          //                           letterSpacing:
          //                           getHorizontalSize(1.8))),
          //                   CustomImageView(
          //                       svgPath: ImageConstant.imgArrowrightGray500,
          //                       height: getVerticalSize(10),
          //                       width: getHorizontalSize(6),
          //                       margin: getMargin(top: 3, bottom: 2))
          //                 ])),
          //       ),
          //       Padding(
          //           padding: getPadding(top: 15),
          //           child: Divider(
          //               height: getVerticalSize(1),
          //               thickness: getVerticalSize(1))),
          //       InkWell(
          //         onTap: () {
          //           AppConstant.aboutType = '2';
          //           int index = _listData.indexWhere((setting) => setting.settingsKeys == 'privacy_policy');
          //           AppConstant.terms = _parseHtmlString(_listData[index].settingsValues);
          //           onTapTxt();
          //         },
          //         child: Padding(
          //             padding: getPadding(left: 39, top: 21, right: 32),
          //             child: Row(
          //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                 children: [
          //                   Text("lbl_privacy_policy".tr,
          //                       overflow: TextOverflow.ellipsis,
          //                       textAlign: TextAlign.left,
          //                       style: AppStyle.txtRobotoRegular12Black900
          //                           .copyWith(
          //                           letterSpacing:
          //                           getHorizontalSize(1.8))),
          //                   CustomImageView(
          //                       svgPath: ImageConstant.imgArrowrightGray500,
          //                       height: getVerticalSize(10),
          //                       width: getHorizontalSize(6),
          //                       margin: getMargin(top: 1, bottom: 3))
          //                 ])),
          //       ),
          //       Padding(
          //           padding: getPadding(top: 13),
          //           child: Divider(
          //               height: getVerticalSize(1),
          //               thickness: getVerticalSize(1))),
          //       InkWell(
          //         onTap: () {
          //           AppConstant.aboutType = '3';
          //           int index = _listData.indexWhere((setting) => setting.settingsKeys == 'return_policy');
          //           AppConstant.terms = _parseHtmlString(_listData[index].settingsValues);
          //           onTapTxt();
          //         },
          //         child: Padding(
          //             padding: getPadding(left: 39, top: 21, right: 32),
          //             child: Row(
          //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                 children: [
          //                   Text("Return policy",
          //                       overflow: TextOverflow.ellipsis,
          //                       textAlign: TextAlign.left,
          //                       style: AppStyle.txtRobotoRegular12Black900
          //                           .copyWith(
          //                           letterSpacing:
          //                           getHorizontalSize(1.8))),
          //                   CustomImageView(
          //                       svgPath: ImageConstant.imgArrowrightGray500,
          //                       height: getVerticalSize(10),
          //                       width: getHorizontalSize(6),
          //                       margin: getMargin(top: 1, bottom: 3))
          //                 ])),
          //       ),
          //       Visibility(
          //         visible: false,
          //         child: Padding(
          //             padding: getPadding(top: 13),
          //             child: Divider(
          //                 height: getVerticalSize(1),
          //                 thickness: getVerticalSize(1))),
          //       ),
          //       Visibility(
          //         visible: false,
          //         child: InkWell(
          //           onTap: () {
          //             AppConstant.aboutType = '4';
          //             onTapTxt();
          //           },
          //           child: Padding(
          //               padding: getPadding(left: 39, top: 20, right: 32),
          //               child: Row(
          //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                   children: [
          //                     Text("msg_grievance_redressal".tr,
          //                         overflow: TextOverflow.ellipsis,
          //                         textAlign: TextAlign.left,
          //                         style: AppStyle.txtRobotoRegular12Black900
          //                             .copyWith(
          //                             letterSpacing:
          //                             getHorizontalSize(1.8))),
          //                     CustomImageView(
          //                         svgPath: ImageConstant.imgArrowrightGray500,
          //                         height: getVerticalSize(10),
          //                         width: getHorizontalSize(6),
          //                         margin: getMargin(top: 2, bottom: 2))
          //                   ])),
          //         ),
          //       ),
          //       Padding(
          //           padding: getPadding(top: 14),
          //           child: Divider(
          //               height: getVerticalSize(1),
          //               thickness: getVerticalSize(1))),
          //       Align(
          //           alignment: Alignment.centerLeft,
          //           child: Padding(
          //               padding: getPadding(left: 39, top: 20),
          //               child: Text("Version: " + versionCode.toString(),
          //                   overflow: TextOverflow.ellipsis,
          //                   textAlign: TextAlign.left,
          //                   style: AppStyle.txtRobotoRegular10.copyWith(
          //                       letterSpacing: getHorizontalSize(1.5))))),
          //       CustomImageView(
          //           imagePath: ImageConstant.imgFinallogo03,
          //           height: getVerticalSize(44),
          //           width: getHorizontalSize(148),
          //           margin: getMargin(top: 45, bottom: 5))
          //     ])
          ),
    ));
  }

  // getVersion() async {
  //   PackageInfo packageInfo = await PackageInfo.fromPlatform();
  //   String versionName = packageInfo.version;
  //   print('Version Name: $versionName');
  //   setState(() {
  //     versionCode = packageInfo.version;
  //   });
  // }
  //
  // String _parseHtmlString(String htmlString) {
  //
  //   var document = parse(htmlString);
  //
  //   String parsedString = parse(document.body.text).documentElement.text;
  //
  //   return parsedString;
  // }
  // apiCall() {
  //   BaseOptions options = new BaseOptions(
  //       baseUrl: 'https://fabfurni.com/api/',
  //       connectTimeout: Duration(seconds: 60), // 60 seconds
  //       receiveTimeout: Duration(seconds: 60), // 60 seconds
  //       headers: {
  //         "Accept": "application/json",
  //         'content-type': 'application/json; charset=UTF-8',
  //       });
  //   final dioClient = Dio(options);
  //   return dioClient;
  // }
  // Future<void> _requestData() async {
  //   try {
  //     var response = await apiCall().get(
  //       'Auth/settings',
  //     );
  //     if (response.statusCode == 200) {
  //       settingVO = SettingVO.fromJson(jsonDecode(response.toString()));
  //       if (settingVO != null &&
  //           settingVO.status == 'true' &&
  //           settingVO.data.isNotEmpty) {
  //         _listData.addAll(settingVO.data);
  //
  //
  //       }
  //       setState(() {});
  //     } else {}
  //   } catch (e) {
  //     return null;
  //   }
  // }

  onTapArrowleft1() {
    Get.back();
  }
}
