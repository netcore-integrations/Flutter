// import 'package:keshav_s_application2/core/app_export.dart';
// import 'package:keshav_s_application2/presentation/add_address_screen/models/add_address_model.dart';
// import 'package:flutter/material.dart';
//
// class AddAddressController extends GetxController {
//   TextEditingController fullnameController = TextEditingController();
//
//   TextEditingController mobilenumberController = TextEditingController();
//
//   TextEditingController pincodeController = TextEditingController();
//
//   TextEditingController addressController = TextEditingController();
//
//   TextEditingController cityController = TextEditingController();
//
//   Rx<AddAddressModel> addAddressModelObj = AddAddressModel().obs;
//
//   SelectionPopupModel selectedDropDownValue;
//
//   SelectionPopupModel selectedDropDownValue1;
//
//   @override
//   void onReady() {
//     super.onReady();
//   }
//
//   @override
//   void onClose() {
//     super.onClose();
//     fullnameController.dispose();
//     mobilenumberController.dispose();
//     pincodeController.dispose();
//     addressController.dispose();
//     cityController.dispose();
//   }
//
//   onSelected(dynamic value) {
//     selectedDropDownValue = value as SelectionPopupModel;
//     addAddressModelObj.value.dropdownItemList.forEach((element) {
//       element.isSelected = false;
//       if (element.id == value.id) {
//         element.isSelected = true;
//       }
//     });
//     addAddressModelObj.value.dropdownItemList.refresh();
//   }
//
//   onSelected1(dynamic value) {
//     selectedDropDownValue1 = value as SelectionPopupModel;
//     addAddressModelObj.value.dropdownItemList1.forEach((element) {
//       element.isSelected = false;
//       if (element.id == value.id) {
//         element.isSelected = true;
//       }
//     });
//     addAddressModelObj.value.dropdownItemList1.refresh();
//   }
// }
