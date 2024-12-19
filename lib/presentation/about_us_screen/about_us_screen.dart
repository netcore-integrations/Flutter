import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:html/parser.dart';
import 'package:keshav_s_application2/core/utils/appConstant.dart';
import 'package:keshav_s_application2/presentation/about_us_screen/models/SettingVO.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:smartech_nudges/netcore_px.dart';

import '../filter_screen/models/FilterVO.dart';
import 'controller/about_us_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as fs;
import 'package:keshav_s_application2/core/app_export.dart';
import 'package:keshav_s_application2/widgets/app_bar/appbar_image.dart';
import 'package:keshav_s_application2/widgets/app_bar/appbar_subtitle_5.dart';
import 'package:keshav_s_application2/widgets/app_bar/appbar_subtitle_6.dart';
import 'package:keshav_s_application2/widgets/app_bar/custom_app_bar.dart';
import 'package:gtm/gtm.dart';

class AboutUsScreen extends StatefulWidget {
  @override
  State<AboutUsScreen> createState() => _aboutUsScreen();
}

class _aboutUsScreen extends State<AboutUsScreen> {
  final List<Setting> _listData = <Setting>[];
  SettingVO? settingVO;
  String? versionCode;

  final gtm = Gtm.instance;
  var event_name = "about_us";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _requestData();
    getVersion();
    // Push event
    NetcorePX.instance.logEvent(event_name, "smt", {
      "user_no":912342,
      "name":"keshav",
      "age":22
    });
    gtm.push(
      'about_us',
      parameters: {
        'user_no': 912342,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: ColorConstant.whiteA700,
      appBar: CustomAppBar(
          height: getVerticalSize(91),
          leadingWidth: 34,
          leading: AppbarImage(
              height: getVerticalSize(15),
              width: getHorizontalSize(9),
              svgPath: ImageConstant.imgArrowleft,
              margin: getMargin(left: 25, top: 53, bottom: 23),
              onTap: onTapArrowleft1),
          title: AppbarSubtitle5(
              text: "lbl_about_us".tr,
              margin: getMargin(left: 19, top: 50, bottom: 18)),
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
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            InkWell(
              onTap: () {
                AppConstant.aboutType = '1';
                int index = _listData.indexWhere(
                    (setting) => setting.settingsKeys == 'terms_condition');
                AppConstant.terms =
                    _parseHtmlString(_listData[index].settingsValues!);
                onTapTxt();
              },
              child: Padding(
                  padding: getPadding(left: 39, right: 32),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("lbl_terms_of_use2".tr,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtRobotoRegular12Black900.copyWith(
                                letterSpacing: getHorizontalSize(1.8))),
                        CustomImageView(
                            svgPath: ImageConstant.imgArrowrightGray500,
                            height: getVerticalSize(10),
                            width: getHorizontalSize(6),
                            margin: getMargin(top: 3, bottom: 2))
                      ])),
            ),
            Padding(
                padding: getPadding(top: 15),
                child: Divider(
                    height: getVerticalSize(1), thickness: getVerticalSize(1))),
            InkWell(
              onTap: () {
                AppConstant.aboutType = '2';
                int index = _listData.indexWhere(
                    (setting) => setting.settingsKeys == 'privacy_policy');
                AppConstant.terms =
                    _parseHtmlString(_listData[index].settingsValues!);
                onTapTxt();
              },
              child: Padding(
                  padding: getPadding(left: 39, top: 21, right: 32),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("lbl_privacy_policy".tr,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtRobotoRegular12Black900.copyWith(
                                letterSpacing: getHorizontalSize(1.8))),
                        CustomImageView(
                            svgPath: ImageConstant.imgArrowrightGray500,
                            height: getVerticalSize(10),
                            width: getHorizontalSize(6),
                            margin: getMargin(top: 1, bottom: 3))
                      ])),
            ),
            Padding(
                padding: getPadding(top: 13),
                child: Divider(
                    height: getVerticalSize(1), thickness: getVerticalSize(1))),
            InkWell(
              onTap: () {
                AppConstant.aboutType = '3';
                int index = _listData.indexWhere(
                    (setting) => setting.settingsKeys == 'return_policy');
                AppConstant.terms =
                    _parseHtmlString(_listData[index].settingsValues!);
                onTapTxt();
              },
              child: Padding(
                  padding: getPadding(left: 39, top: 21, right: 32),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Return policy",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtRobotoRegular12Black900.copyWith(
                                letterSpacing: getHorizontalSize(1.8))),
                        CustomImageView(
                            svgPath: ImageConstant.imgArrowrightGray500,
                            height: getVerticalSize(10),
                            width: getHorizontalSize(6),
                            margin: getMargin(top: 1, bottom: 3))
                      ])),
            ),
            Visibility(
              visible: false,
              child: Padding(
                  padding: getPadding(top: 13),
                  child: Divider(
                      height: getVerticalSize(1),
                      thickness: getVerticalSize(1))),
            ),
            Visibility(
              visible: false,
              child: InkWell(
                onTap: () {
                  AppConstant.aboutType = '4';
                  onTapTxt();
                },
                child: Padding(
                    padding: getPadding(left: 39, top: 20, right: 32),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("msg_grievance_redressal".tr,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtRobotoRegular12Black900
                                  .copyWith(
                                      letterSpacing: getHorizontalSize(1.8))),
                          CustomImageView(
                              svgPath: ImageConstant.imgArrowrightGray500,
                              height: getVerticalSize(10),
                              width: getHorizontalSize(6),
                              margin: getMargin(top: 2, bottom: 2))
                        ])),
              ),
            ),
            Padding(
                padding: getPadding(top: 14),
                child: Divider(
                    height: getVerticalSize(1), thickness: getVerticalSize(1))),
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                    padding: getPadding(left: 39, top: 20),
                    child: Text("Version: " + versionCode.toString(),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: AppStyle.txtRobotoRegular10
                            .copyWith(letterSpacing: getHorizontalSize(1.5))))),
            CustomImageView(
                imagePath: ImageConstant.imgFinallogo03,
                height: getVerticalSize(44),
                width: getHorizontalSize(148),
                margin: getMargin(top: 45, bottom: 5))
          ])),
      // bottomNavigationBar: Container(
      //     margin: getMargin(left: 14, right: 14, bottom: 12),
      //     decoration: BoxDecoration(
      //         image: DecorationImage(
      //             image: fs.Svg(ImageConstant.imgGroup203),
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
      //                 CustomImageView(
      //                     svgPath: ImageConstant.imgGroup2,
      //                     height: getVerticalSize(47),
      //                     width: getHorizontalSize(315),
      //                     alignment: Alignment.topCenter,
      //                     margin: getMargin(top: 18)),
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

  onTapTxt() {
    Get.toNamed(AppRoutes.termsOfConditionScreen);
  }

  getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String versionName = packageInfo.version;
    print('Version Name: $versionName');
    setState(() {
      versionCode = packageInfo.version;
    });
  }

  String _parseHtmlString(String htmlString) {
    var document = parse(htmlString);

    String parsedString = parse(document.body!.text).documentElement!.text;

    return parsedString;
  }

  apiCall() {
    BaseOptions options = new BaseOptions(
        baseUrl: 'https://fabfurni.com/api/',
        connectTimeout: Duration(seconds: 60), // 60 seconds
        receiveTimeout: Duration(seconds: 60), // 60 seconds
        headers: {
          "Accept": "application/json",
          'content-type': 'application/json; charset=UTF-8',
        });
    final dioClient = Dio(options);
    return dioClient;
  }

  Future<void> _requestData() async {
    try {
      var response = await apiCall().get(
        'Auth/settings',
      );
      if (response.statusCode == 200) {
        settingVO = SettingVO.fromJson(jsonDecode(response.toString()));
        if (settingVO != null &&
            settingVO!.status == 'true' &&
            settingVO!.data!.isNotEmpty) {
          _listData.addAll(settingVO!.data!);
        }
        setState(() {});
      } else {}
    } catch (e) {
      return null;
    }
  }

  onTapArrowleft1() {
    Get.back();
  }
}
