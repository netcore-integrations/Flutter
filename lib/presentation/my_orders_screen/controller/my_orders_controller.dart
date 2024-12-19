import 'package:keshav_s_application2/core/app_export.dart';
import 'package:keshav_s_application2/presentation/my_orders_screen/models/my_orders_model.dart';
import 'package:flutter/material.dart';

class MyOrdersController extends GetxController {
  TextEditingController deliverydateController = TextEditingController();

  TextEditingController deliverydateController1 = TextEditingController();

  TextEditingController deliverydateController2 = TextEditingController();

  Rx<MyOrdersModel> myOrdersModelObj = MyOrdersModel().obs;

  SelectionPopupModel? selectedDropDownValue;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    deliverydateController.dispose();
    deliverydateController1.dispose();
    deliverydateController2.dispose();
  }

  // onSelected(dynamic value) {
  //   selectedDropDownValue = value as SelectionPopupModel;
  //   myOrdersModelObj.value.dropdownItemList.forEach((element) {
  //     element.isSelected = false;
  //     if (element.id == value.id) {
  //       element.isSelected = true;
  //     }
  //   });
  //   myOrdersModelObj.value.dropdownItemList.refresh();
  // }
}
