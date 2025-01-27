import 'dart:convert';

import 'package:dio/dio.dart' as dio;
import 'package:keshav_s_application2/core/app_export.dart';
import 'package:keshav_s_application2/presentation/log_in_screen/models/log_in_model.dart';
import 'package:flutter/material.dart';

class LogInController extends GetxController {
  TextEditingController mobilenumberController = TextEditingController();

  Rx<LogInModel> logInModelObj = LogInModel().obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    mobilenumberController.dispose();
  }

  // Future<LogInModel> postRequest(
  //     ) async {
  //   var url = 'https://fabfurni.com/api/Auth/login';
  //   // var token = "HDJJHJHJHSJHDJAHDAD";
  //
  //   Map<String, String> headers = {
  //     "Content-Type": "application/json",
  //     "User-Agent": "PostmanRuntime/7.30.0",
  //     "Accept": "*/*",
  //     "Accept-Encoding": "gzip, deflate, br",
  //     "Connection": "keep-alive"
  //   };
  //
  //
  //   dio.FormData formData = dio.FormData.fromMap({
  //     'mobile': mobilenumberController.text,
  //     // 'password': password,
  //     // 'fcm_token': token,
  //   });
  //   print(formData.fields);
  //   var response = await dio.Dio().post(url,
  //       options: dio.Options(
  //         headers: {
  //           "Content-Type": "application/json",
  //           "Accept": "*/*",
  //         },
  //       ),
  //       data: formData);
  //   // print(response.data);
  //   // String jsonsDataString = response.data.toString();
  //   var jsonObject = jsonDecode(response.toString());
  //   // print(jsonObject.toString());
  //   if (response.statusCode == 200) {
  //     if (LogInModel.fromJson(jsonObject).status == 200) {
  //       // SharedPreferences prefs = await SharedPreferences.getInstance();
  //       // prefs?.setBool("isLoggedIn", true);
  //       // setState(() {
  //       //   Timer(Duration(seconds: 1), () {
  //       //     _btnController.success();
  //       //   });
  //       // });
  //       // SharedPreferences pref = await SharedPreferences.getInstance();
  //       // // var json = jsonDecode(jsonObject);
  //       // String user = jsonEncode(jsonObject);
  //       // print(user.toString());
  //       // pref.setString('userData', user);
  //       // pref?.setBool("isLoggedIn", true);
  //       // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       //   duration: Duration(seconds: 2),
  //       //   content: Text(
  //       //     "Login Successful",
  //       //     style: TextStyle(color: Colors.black),
  //       //   ),
  //       //   backgroundColor: Colors.greenAccent,
  //       // ));
  //       // Map json1 = jsonDecode(pref.getString('userData'));
  //       // var user1 = LoginData.fromJson(json1);
  //       // print(user1.data);
  //       // Navigator.of(context).push(MaterialPageRoute(
  //       //   builder: (context) => landingPage(
  //       //       user1.data.name,
  //       //       user1.data.id,
  //       //       user1.data.chepterId,
  //       //       user1.data.cityId,
  //       //       user1.data.chapterDetails?? "",
  //       //       user1.data.chapterUserDetails?? "",
  //       //       user1.data),
  //       // ));
  //     } else if (LogInModel.fromJson(jsonObject).status == 400) {
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //           content: Text(LoginData.fromJson(jsonObject).message),
  //           backgroundColor: Colors.redAccent));
  //       setState(() {
  //         _btnController.error();
  //       });
  //     }
  //     else if (LoginData.fromJson(jsonObject).data.chepterName == null){
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //           content: Text('Server Error..Please try again after sometime', style: SafeGoogleFont(
  //             'Poppins SemiBold',
  //             // fontSize: 18 * ffem,
  //             fontWeight: FontWeight.w400,
  //             // height: 1.2575 * ffem / fem,
  //             color: Colors.black,
  //           ),),
  //           backgroundColor: Colors.redAccent));
  //       setState(() {
  //         _btnController.error();
  //       });
  //
  //     }
  //
  //     // print(Logindata.fromJson(jsonObject).message);
  //     print(LoginData.fromJson(jsonObject).toString());
  //     return LoginData.fromJson(
  //         jsonObject); // you can mapping json object also here
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       content: Text("Sending Message"),
  //     )); // you can mapping json object also here
  //   }
  //   return jsonObject;
  //   // return response;
  // }
}
