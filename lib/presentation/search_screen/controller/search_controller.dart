import 'package:keshav_s_application2/core/app_export.dart';
import 'package:keshav_s_application2/presentation/search_screen/models/search_model.dart';
import 'package:flutter/material.dart';

class SearchController extends GetxController {
  TextEditingController sofasetsController = TextEditingController();

  TextEditingController searchController = TextEditingController();

  Rx<SearchModel> searchModelObj = SearchModel().obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    sofasetsController.dispose();
    searchController.dispose();
  }
}
