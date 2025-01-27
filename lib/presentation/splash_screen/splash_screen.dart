import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:keshav_s_application2/landingpage.dart';
import 'package:keshav_s_application2/presentation/log_in_screen/log_in_screen.dart';
import 'package:keshav_s_application2/presentation/otp_screen/models/otp_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartech_base/smartech_base.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../screenwithoutlogin/landingpage1.dart';
import 'controller/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:keshav_s_application2/core/app_export.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    fetchUser();
    super.initState();
  }

  fetchUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isLoggedIn = prefs.getBool("isLoggedIn");
    var data = prefs.getString('userData');
    if (data != null && isLoggedIn != null && isLoggedIn) {
      Map<String, dynamic> json1 = jsonDecode(prefs.getString('userData')!);
      var user1 = OtpModel.fromJson(json1);
      print(user1.data);
      Smartech().setUserIdentity(user1.data!.mobile!);
      // Smartech().login(user1.data!.mobile!);
      Future.delayed(const Duration(milliseconds: 1500), () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => landingPage(user1.data!),
        ));
        // Smartech().onHandleDeeplink((String? smtDeeplinkSource,
        //     String? smtDeeplink,
        //     Map<dynamic, dynamic>? smtPayload,
        //     Map<dynamic, dynamic>? smtCustomPayload) async {
        //   // String deeplink1=smtDeeplink!;
        //   // print(deeplink1);
        //   print('$smtDeeplink');
        //   print('$smtDeeplink');
        //   Future.delayed(const Duration(milliseconds: 2000), () async {
        //     if (smtDeeplinkSource == 'PushNotification') {
        //       print(smtDeeplink);
        //       String deeplink = smtDeeplink!.substring(0, smtDeeplink.indexOf('?'));
        //       if (deeplink == '/about_us_screen') {
        //         Get.toNamed(AppRoutes.aboutUsScreen);
        //       }
        //     }
        //     if (smtDeeplinkSource == 'InAppMessage') {
        //       // print(smtDeeplink);
        //       if (smtDeeplink!.contains("https")) {
        //         print("navigate to browser with url");
        //         final Uri _url = Uri.parse(smtDeeplink);
        //         if (!await launchUrl(_url)) throw 'Could not launch $_url';
        //         // await
        //         // FlutterWebBrowser.openWebPage(url: smtDeeplink);
        //       }
        //     }
        //   });
        //
        // });
        // Get.offNamed(AppRoutes.logInScreen);
      });
    } else {
      // if(Platform.isIOS){
      //   FirebaseMessaging.instance.getAPNSToken().then((token) {
      //     print('This is IOS Token: ' '${token}');
      //     Smartech().login(token!);
      //   });
      // }
      // else if(Platform.isAndroid){
      //   FirebaseMessaging.instance.getToken().then((token) {
      //     print('This is Android Token: ' '${token}');
      //     Smartech().login(token!);
      //   });
      // }
      Future.delayed(const Duration(milliseconds: 1500), () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => landingPage1(),
        ));
        // Get.offNamed(AppRoutes.logInScreen);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.whiteA700,
        body: Container(
          width: double.maxFinite,
          // padding: getPadding(
          //   top: 26,
          //   bottom: 26,
          // ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Spacer(),
              CustomImageView(
                imagePath: ImageConstant.imgAppicon0202,
                height: getSize(
                  222,
                ),
                width: getSize(
                  222,
                ),
              ),
              CustomImageView(
                imagePath: ImageConstant.imgFinallogo03,
                height: getVerticalSize(
                  44,
                ),
                width: getHorizontalSize(
                  148,
                ),
                margin: getMargin(top: 350, bottom: 30),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
