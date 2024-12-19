import 'package:keshav_s_application2/core/app_export.dart';
import 'package:keshav_s_application2/presentation/filter_screen/models/filter_model.dart';
import 'package:flutter/material.dart';

class FilterController extends GetxController {
  TextEditingController group187Controller = TextEditingController();

  Rx<FilterModel> filterModelObj = FilterModel().obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    group187Controller.dispose();
  }
}
