import 'package:keshav_s_application2/core/app_export.dart';
import 'package:keshav_s_application2/presentation/click_gstin_screen/models/click_gstin_model.dart';
import 'package:flutter/material.dart';

class ClickGstinController extends GetxController {
  TextEditingController priceController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  Rx<ClickGstinModel> clickGstinModelObj = ClickGstinModel().obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    priceController.dispose();
    nameController.dispose();
  }
}
