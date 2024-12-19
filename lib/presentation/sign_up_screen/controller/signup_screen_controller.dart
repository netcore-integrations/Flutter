import 'package:keshav_s_application2/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:keshav_s_application2/presentation/sign_up_screen/models/signup_screen_model.dart';

class SignUpScreenController extends GetxController {
  TextEditingController fullnameController = TextEditingController();

  TextEditingController mobilenumberController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  Rx<SignUpScreenModel> SignUpScreenModelObj = SignUpScreenModel().obs;

  Rx<bool> isShowPassword = false.obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    fullnameController.dispose();
    mobilenumberController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
}
