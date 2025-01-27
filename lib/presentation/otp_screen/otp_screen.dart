import 'dart:async';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:keshav_s_application2/core/utils/utils.dart';
import 'package:keshav_s_application2/landingpage.dart';
import 'package:keshav_s_application2/presentation/otp_screen/models/otp_model.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartech_base/smartech_base.dart';

import 'controller/otp_controller.dart';
import 'dart:convert';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:keshav_s_application2/core/app_export.dart';
import 'package:keshav_s_application2/widgets/custom_button.dart';
import 'package:keshav_s_application2/widgets/custom_text_form_field.dart';

class OtpScreen extends StatefulWidget {
  String mobileNumber;
  String otp;
  OtpScreen(this.mobileNumber, this.otp);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController otpController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  Future<OtpModel> postRequest() async {
    var url = 'https://fabfurni.com/api/Auth/verifyOtp';
    // var token = "HDJJHJHJHSJHDJAHDAD";

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "User-Agent": "PostmanRuntime/7.30.0",
      "Accept": "*/*",
      "Accept-Encoding": "gzip, deflate, br",
      "Connection": "keep-alive"
    };

    dio.FormData formData = dio.FormData.fromMap({
      'mobile': widget.mobileNumber,
      "otp": widget.otp,
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
      if (OtpModel.fromJson(jsonObject).status == "true") {
        // SharedPreferences prefs = await SharedPreferences.getInstance();
        // prefs.setBool("isLoggedIn", true);
        setState(() {
          Timer(Duration(seconds: 1), () {
            _btnController.success();
          });
        });
        SharedPreferences pref = await SharedPreferences.getInstance();
        // var json = jsonDecode(jsonObject);
        String user = jsonEncode(jsonObject);
        print(user.toString());
        pref.setString('userData', user);
        pref.setBool("isLoggedIn", true);
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //   behavior: SnackBarBehavior.floating,
        //   margin: EdgeInsets.only(top: 100.0),
        //   duration: Duration(seconds: 2),
        //   content: Text(
        //     "Login Successful",
        //     style: TextStyle(color: Colors.black),
        //   ),
        //   backgroundColor: Colors.greenAccent,
        // ));
        Map<String, dynamic> json1 = jsonDecode(pref.getString('userData')!);
        var user1 = OtpModel.fromJson(json1);
        print(user1.data);
        Smartech().login(user1.data!.mobile!);
        print(OtpModel.fromJson(jsonObject).data!.otps!);
        Navigator.of(context).pushAndRemoveUntil<dynamic>(
          MaterialPageRoute(
            builder: (context) =>
                landingPage(OtpModel.fromJson(jsonObject).data!),
          ),
          (route) => false,
        );
        Fluttertoast.showToast(
            msg: "Logged in Successfully",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.greenAccent,
            textColor: Colors.black,
            fontSize: 14.0);
      } else if (OtpModel.fromJson(jsonObject).status == "false") {
        Fluttertoast.showToast(
            msg: OtpModel.fromJson(jsonObject).message!,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.redAccent,
            textColor: Colors.black,
            fontSize: 14.0);
        setState(() {
          _btnController.error();
        });
      } else if (OtpModel.fromJson(jsonObject).data == null) {
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
      print(OtpModel.fromJson(jsonObject).toString());
      return OtpModel.fromJson(
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
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: ColorConstant.whiteA700,
        body: Form(
          key: _formKey,
          child: Container(
            width: double.maxFinite,
            padding: getPadding(
              top: 27,
              bottom: 27,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomImageView(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  svgPath: ImageConstant.imgClosesvgrepocom,
                  height: getSize(
                    18,
                  ),
                  width: getSize(
                    18,
                  ),
                  alignment: Alignment.centerLeft,
                  margin: getMargin(
                    left: 24,
                    top: 2,
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: getPadding(
                      top: 45,
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: getVerticalSize(
                            16,
                          ),
                          width: getHorizontalSize(
                            21,
                          ),
                          margin: getMargin(
                            top: 3,
                            bottom: 2,
                          ),
                          decoration: BoxDecoration(
                            color: ColorConstant.purple900,
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(
                                getHorizontalSize(
                                  30,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: getPadding(
                            left: 6,
                          ),
                          child: Text(
                            "lbl_enter_otp".tr,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtRobotoMedium18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: getPadding(
                      left: 27,
                      top: 13,
                    ),
                    child: Text(
                      "msg_enter_your_4".tr,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: AppStyle.txtRobotoRegular12Purple700,
                    ),
                  ),
                ),
                CustomTextFormField(
                  focusNode: FocusNode(),
                  controller: otpController,
                  hintText: "lbl_enter_otp".tr,
                  margin: getMargin(
                    left: 27,
                    top: 68,
                    right: 26,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter the OTP";
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.done,
                  suffix: Container(
                    margin: getMargin(
                      left: 12,
                      right: 11,
                      bottom: 4,
                    ),
                    // decoration: BoxDecoration(
                    //   color: ColorConstant.purple900,
                    // ),

                    child: CustomImageView(
                      svgPath: ImageConstant.imgVector,
                    ),
                  ),
                  suffixConstraints: BoxConstraints(
                    maxHeight: getVerticalSize(
                      26,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: getPadding(
                      top: 7,
                      right: 36,
                    ),
                    child: Text(
                      "lbl_resend_otp".tr,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: AppStyle.txtRobotoRegular14Blue700,
                    ),
                  ),
                ),
                CustomButton(
                  onTap: () {
                    FocusManager.instance.primaryFocus!.unfocus();
                    if (_formKey.currentState!.validate() &&
                        otpController.text == widget.otp) {
                      postRequest();
                      Timer(Duration(seconds: 3), () {
                        otpController.clear();
                        _btnController.reset();
                      });
                      // print(field);
                      // if(cred!.=='success'){
                      //
                      // }
                    } else {
                      Fluttertoast.showToast(
                          msg: "OTP entered is not valid",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 3,
                          backgroundColor: Colors.red,
                          textColor: Colors.black,
                          fontSize: 14.0);
                      setState(() {
                        Timer(Duration(seconds: 0), () {
                          _btnController.reset();
                        });
                      });
                    }
                  },
                  height: getVerticalSize(
                    39,
                  ),
                  text: "lbl_login2".tr,
                  margin: getMargin(
                    left: 27,
                    top: 29,
                    right: 26,
                  ),
                  variant: ButtonVariant.FillPurple900,
                  padding: ButtonPadding.PaddingAll11,
                  fontStyle: ButtonFontStyle.RobotoMedium14,
                ),
                Spacer(),
                // Text(
                //   "msg_or_continue_with".tr,
                //   overflow: TextOverflow.ellipsis,
                //   textAlign: TextAlign.left,
                //   style: AppStyle.txtRobotoRegular15,
                // ),
                // CustomImageView(
                //   svgPath: ImageConstant.imgGooglesvgrepocom,
                //   height: getSize(
                //     45,
                //   ),
                //   width: getSize(
                //     45,
                //   ),
                //   margin: getMargin(
                //     top: 21,
                //   ),
                // ),
                CustomImageView(
                  imagePath: ImageConstant.imgFinallogo03,
                  height: getVerticalSize(
                    32,
                  ),
                  width: getHorizontalSize(
                    106,
                  ),
                  margin: getMargin(
                    top: 39,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
