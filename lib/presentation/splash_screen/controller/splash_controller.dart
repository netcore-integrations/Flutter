import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:keshav_s_application2/core/app_export.dart';
import 'package:keshav_s_application2/landingpage.dart';
import 'package:keshav_s_application2/presentation/otp_screen/models/otp_model.dart';
import 'package:keshav_s_application2/presentation/splash_screen/models/splash_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  Rx<SplashModel> splashModelObj = SplashModel().obs;

  @override
  void onReady() async {
    super.onReady();
    Future.delayed(const Duration(milliseconds: 3000), () {
      // Get.offNamed(AppRoutes.logInScreen);
    });
  }

  @override
  void onClose() {
    super.onClose();
  }
}
