import 'package:keshav_s_application2/core/app_export.dart';
import 'package:keshav_s_application2/presentation/otp_screen/models/otp_model.dart';
import 'package:flutter/material.dart';

class OtpController extends GetxController {
  TextEditingController group290Controller = TextEditingController();

  Rx<OtpModel> otpModelObj = OtpModel().obs;

  var one = Get.arguments;

  @override
  void onInit() {
    print(one[0]);
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void fetchData() {
    print("error");
  }

  @override
  void onClose() {
    super.onClose();
    group290Controller.dispose();
  }
}
