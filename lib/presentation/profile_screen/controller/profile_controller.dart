import 'package:keshav_s_application2/core/app_export.dart';
import 'package:keshav_s_application2/presentation/profile_screen/models/profile_model.dart';
import 'package:flutter/material.dart';

class ProfileController extends GetxController {
  TextEditingController fullnameoneController = TextEditingController();

  TextEditingController mobilenumberController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  // Rx<ProfileModel> profileModelObj = ProfileModel().obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    fullnameoneController.dispose();
    mobilenumberController.dispose();
    emailController.dispose();
  }
}
