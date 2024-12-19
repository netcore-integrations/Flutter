import 'package:keshav_s_application2/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:keshav_s_application2/presentation/cart_screen/models/cart_model.dart';

class CartScreenController extends GetxController {
  TextEditingController pincodeController = TextEditingController();

  Rx<CartModel> CartModelObj = CartModel().obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    pincodeController.dispose();
  }
}
