import 'dart:async';

import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keshav_s_application2/core/utils/utils.dart';
import 'package:keshav_s_application2/presentation/PasswordScreen.dart';
import 'package:keshav_s_application2/presentation/log_in_screen/models/log_in_model.dart';
import 'package:keshav_s_application2/presentation/otp_screen/otp_screen.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

import '../../screenwithoutlogin/landingpage1.dart';
import 'controller/log_in_controller.dart';
import 'dart:convert';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:keshav_s_application2/core/app_export.dart';
import 'package:keshav_s_application2/core/utils/validation_functions.dart';
import 'package:keshav_s_application2/widgets/custom_button.dart';
import 'package:keshav_s_application2/widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class LogInScreen extends StatefulWidget {
  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController mobilenumberController = TextEditingController();
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  Future<LogInModel> postRequest(String mobileNumber) async {
    var url = 'https://fabfurni.com/api/Auth/login';
    // var token = "HDJJHJHJHSJHDJAHDAD";

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "User-Agent": "PostmanRuntime/7.30.0",
      "Accept": "*/*",
      "Accept-Encoding": "gzip, deflate, br",
      "Connection": "keep-alive"
    };

    dio.FormData formData = dio.FormData.fromMap({
      'mobile': mobileNumber,
      // 'password': password,
      // 'fcm_token': token,
    });
    print(formData.fields);
    var response = await dio.Dio().post(url,
        options: dio.Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "*/*",
          },
        ),
        data: formData);
    // print(response.data);
    // String jsonsDataString = response.data.toString();
    var jsonObject = jsonDecode(response.toString());
    // print(jsonObject.toString());
    if (response.statusCode == 200) {
      if (LogInModel.fromJson(jsonObject).status == "true") {
        // SharedPreferences prefs = await SharedPreferences.getInstance();
        // prefs?.setBool("isLoggedIn", true);
        // setState(() {
        //   Timer(Duration(seconds: 1), () {
        //     _btnController.success();
        //   });
        // });
        // SharedPreferences pref = await SharedPreferences.getInstance();
        // // var json = jsonDecode(jsonObject);
        // String user = jsonEncode(jsonObject);
        // print(user.toString());
        // pref.setString('userData', user);
        // pref?.setBool("isLoggedIn", true);
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //   duration: Duration(seconds: 2),
        //   content: Text(
        //     "Login Successful",
        //     style: TextStyle(color: Colors.black),
        //   ),
        //   backgroundColor: Colors.greenAccent,
        // ));
        // Map json1 = jsonDecode(pref.getString('userData'));
        // var user1 = LoginData.fromJson(json1);
        // print(user1.data);
        print(LogInModel.fromJson(jsonObject).data!.otps!);
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => OtpScreen(
              mobileNumber, LogInModel.fromJson(jsonObject).data!.otps!),
        ));
      } else if (LogInModel.fromJson(jsonObject).status == "false") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(LogInModel.fromJson(jsonObject).message!),
            backgroundColor: Colors.redAccent));
        setState(() {
          _btnController.error();
        });
      } else if (LogInModel.fromJson(jsonObject).data == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              'Server Error..Please try again after sometime',
              style: SafeGoogleFont(
                'Poppins SemiBold',
                // fontSize: 18 * ffem,
                fontWeight: FontWeight.w400,
                // height: 1.2575 * ffem / fem,
                color: Colors.black,
              ),
            ),
            backgroundColor: Colors.redAccent));
        setState(() {
          _btnController.error();
        });
      }

      // print(Logindata.fromJson(jsonObject).message);
      print(LogInModel.fromJson(jsonObject).toString());
      return LogInModel.fromJson(
          jsonObject); // you can mapping json object also here
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Sending Message"),
      )); // you can mapping json object also here
    }
    return jsonObject;
    // return response;
  }

  @override
  void dispose() {
    mobilenumberController.dispose();
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            elevation: 24,
            backgroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            title: new Text(
              'Are you sure?',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            content: new Text('Do you want to exit the App',
                style: TextStyle(fontWeight: FontWeight.w400)),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No',
                    style: TextStyle(fontWeight: FontWeight.w400)),
              ),
              TextButton(
                onPressed: () => SystemNavigator.pop(),
                child: new Text('Yes',
                    style: TextStyle(fontWeight: FontWeight.w400)),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: SafeArea(
          child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: ColorConstant.whiteA700,
              body: Form(
                  key: _formKey,
                  child: Container(
                      width: double.maxFinite,
                      padding: getPadding(top: 27, bottom: 27),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                pushScreen(
                                  context,
                                  screen: landingPage1(),
                                  withNavBar:
                                      false, // OPTIONAL VALUE. True by default.
                                  pageTransitionAnimation:
                                      PageTransitionAnimation.cupertino,
                                );
                                // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                //     landingPage1()), (Route<dynamic> route) => false);
                                // Navigator.of(context).pushReplacement(MaterialPageRoute(
                                //   builder: (context) => landingPage1(),
                                // ));
                                // _onWillPop();
                              },
                              child: CustomImageView(
                                  svgPath: ImageConstant.imgClosesvgrepocom,
                                  height: getSize(18),
                                  width: getSize(18),
                                  alignment: Alignment.centerLeft,
                                  margin: getMargin(left: 24, top: 2)),
                            ),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                    padding: getPadding(top: 47),
                                    child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              height: getVerticalSize(16),
                                              width: getHorizontalSize(21),
                                              margin:
                                                  getMargin(top: 1, bottom: 4),
                                              decoration: BoxDecoration(
                                                  color:
                                                      ColorConstant.purple900,
                                                  borderRadius: BorderRadius.only(
                                                      bottomRight:
                                                          Radius.circular(
                                                              getHorizontalSize(
                                                                  30))))),
                                          Padding(
                                              padding: getPadding(left: 6),
                                              child: Text("lbl_log_in".tr,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: AppStyle
                                                      .txtRobotoMedium18))
                                        ]))),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                    width: Get.width,
                                    margin: getMargin(left: 27, top: 10),
                                    child: Text("msg_you_will_be_able".tr,
                                        maxLines: null,
                                        textAlign: TextAlign.left,
                                        style: AppStyle.txtRobotoRegular12))),
                            CustomTextFormField(
                                focusNode: FocusNode(),
                                controller: mobilenumberController,
                                hintText: "lbl_mobile_number".tr,
                                margin: getMargin(left: 27, top: 56, right: 26),
                                textInputAction: TextInputAction.done,
                                textInputType: TextInputType.phone,
                                suffix: Container(
                                    margin: getMargin(
                                        left: 30, right: 14, bottom: 4),
                                    // decoration: BoxDecoration(
                                    //     color: ColorConstant.purple900),
                                    child: CustomImageView(
                                        svgPath: ImageConstant.imgMobile)),
                                suffixConstraints: BoxConstraints(
                                    maxHeight: getVerticalSize(25)),
                                validator: (value) {
                                  if (!isValidPhone(value!) && value.isEmpty) {
                                    return "Please enter valid phone number";
                                  }
                                  return null;
                                }),
                            CustomButton(
                                height: getVerticalSize(39),
                                text: "lbl_send_otp".tr,
                                margin: getMargin(left: 27, top: 25, right: 26),
                                variant: ButtonVariant.FillPurple900,
                                padding: ButtonPadding.PaddingAll11,
                                fontStyle: ButtonFontStyle.RobotoMedium14,
                                onTap: onTapSendotp),
                            CustomButton(
                                onTap: () {
                                  if (mobilenumberController.text.isEmpty) {
                                    Fluttertoast.showToast(
                                        msg: "Please enter the mobile number",
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 3,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.black,
                                        fontSize: 14.0);
                                  } else {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PasswordScreen(
                                                    mobilenumberController
                                                        .text)));
                                  }
                                },
                                height: getVerticalSize(39),
                                text: "msg_login_using_password".tr,
                                margin: getMargin(left: 27, top: 15, right: 26),
                                variant: ButtonVariant.OutlinePurple900,
                                padding: ButtonPadding.PaddingAll11,
                                fontStyle:
                                    ButtonFontStyle.RobotoMedium14Purple900),
                            Padding(
                                padding: getPadding(top: 160),
                                child: Text("msg_new_to_fabfurni".tr,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: AppStyle.txtRobotoMedium12)),
                            Padding(
                                padding: getPadding(top: 9),
                                child: GestureDetector(
                                  onTap: () {
                                    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUpScreen()));
                                    Get.toNamed(AppRoutes.signUpScreen);
                                  },
                                  child: Text("lbl_register_here".tr,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: AppStyle.txtRobotoMedium18),
                                )),
                            Spacer(),
                            Column(
                              children: [
                                // Text("msg_or_continue_with".tr,
                                //     overflow: TextOverflow.ellipsis,
                                //     textAlign: TextAlign.left,
                                //     style: AppStyle.txtRobotoRegular15),
                                // CustomImageView(
                                //     svgPath: ImageConstant.imgGoogle,
                                //     height: getVerticalSize(45),
                                //     width: getHorizontalSize(43),
                                //     margin: getMargin(top: 21),
                                //     onTap: () {
                                //       onTapImgGoogle();
                                //     }),
                                CustomImageView(
                                    imagePath: ImageConstant.imgFinallogo03,
                                    height: getVerticalSize(32),
                                    width: getHorizontalSize(106),
                                    margin: getMargin(top: 39))
                              ],
                            )
                          ]))))),
    );
  }

  onTapSendotp() {
    FocusManager.instance.primaryFocus!.unfocus();
    if (mobilenumberController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Please enter the mobile number",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.black,
          fontSize: 14.0);
    } else {
      // postRequest(
      //   mobilenumberController.text,
      // );
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => OtpScreen(
            mobilenumberController.text, "1111"),
      ));
      Timer(Duration(seconds: 3), () {
        mobilenumberController.clear();
        _btnController.reset();
      });
    }
    // if (_formKey.currentState.validate()) {
    //   postRequest(
    //     mobilenumberController.text,
    //   );
    //   Timer(Duration(seconds: 3), () {
    //     mobilenumberController.clear();
    //     _btnController.reset();
    //   });
    //   // print(field);
    //   // if(cred!.=='success'){
    //   //
    //   // }
    //
    // } else{
    //   setState(() {
    //     Timer(Duration(seconds:0), () {
    //       _btnController.reset();
    //     });
    //   });
    // }
    // Get.toNamed(AppRoutes.otpScreen,arguments: [mobilenumberController.text]);
  }

  // onTapImgGoogle() async {
  //   var url = 'https://accounts.google.com/';
  //   if (!await launch(url)) {
  //     throw 'Could not launch https://accounts.google.com/';
  //   }
  // }
}
