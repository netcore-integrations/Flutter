import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:html/parser.dart';
import 'package:keshav_s_application2/core/utils/utils.dart';
import 'package:keshav_s_application2/presentation/about_us_screen/models/SettingVO.dart';
import 'package:keshav_s_application2/presentation/log_in_screen/log_in_screen.dart';
import 'package:keshav_s_application2/presentation/sign_up_screen/models/signup_screen_model.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

import '../../core/utils/appConstant.dart';
import '../../screenwithoutlogin/landingpage1.dart';
import 'controller/signup_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:keshav_s_application2/core/app_export.dart';
import 'package:keshav_s_application2/core/utils/validation_functions.dart';
import 'package:keshav_s_application2/widgets/custom_button.dart';
import 'package:keshav_s_application2/widgets/custom_text_form_field.dart';

import 'dart:convert';

import 'package:dio/dio.dart' as dio;

// ignore_for_file: must_be_immutable
class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController fullnameController = TextEditingController();

  TextEditingController mobilenumberController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  bool _isObscure = false;
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  final List<Setting> _listData = <Setting>[];
  SettingVO? settingVO;
  String? versionCode;

  Future<SignUpScreenModel> postRequest(
      String name, String mobile, String email, String password) async {
    var url = 'https://fabfurni.com/api/Auth/signUp';
    var token = "432222222222";

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "User-Agent": "PostmanRuntime/7.30.0",
      "Accept": "*/*",
      "Accept-Encoding": "gzip, deflate, br",
      "Connection": "keep-alive"
    };

    dio.FormData formData = dio.FormData.fromMap({
      'name': name,
      'mobile': mobile,
      'email': email,
      'password': password,
      'fcm_token': token,
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
      if (SignUpScreenModel.fromJson(jsonObject).status == "true") {
        print(SignUpScreenModel.fromJson(jsonObject).data!.otps!);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 2),
          content: Text(
            "Sign up Successful",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.greenAccent,
        ));
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LogInScreen()),
            (Route<dynamic> route) => false);
      } else if (SignUpScreenModel.fromJson(jsonObject).status == "false") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(SignUpScreenModel.fromJson(jsonObject).message!),
            backgroundColor: Colors.redAccent));
        setState(() {
          _btnController.error();
        });
      } else if (SignUpScreenModel.fromJson(jsonObject).data == null) {
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
      print(SignUpScreenModel.fromJson(jsonObject).toString());
      return SignUpScreenModel.fromJson(
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
  void initState() {
    // TODO: implement initState
    super.initState();
    _requestData();
    getVersion();
  }

  @override
  void dispose() {
    fullnameController.dispose();
    mobilenumberController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String versionName = packageInfo.version;
    print('Version Name: $versionName');
    setState(() {
      versionCode = packageInfo.version;
    });
  }

  onTapTxt() {
    Get.toNamed(AppRoutes.termsOfConditionScreen);
  }

  apiCall() {
    BaseOptions options = new BaseOptions(
        baseUrl: 'https://fabfurni.com/api/',
        connectTimeout: Duration(seconds: 60), // 60 seconds
        receiveTimeout: Duration(seconds: 60), // 60 seconds
        headers: {
          "Accept": "application/json",
          'content-type': 'application/json; charset=UTF-8',
        });
    final dioClient = Dio(options);
    return dioClient;
  }

  Future<void> _requestData() async {
    try {
      var response = await apiCall().get(
        'Auth/settings',
      );
      if (response.statusCode == 200) {
        settingVO = SettingVO.fromJson(jsonDecode(response.toString()));
        if (settingVO != null &&
            settingVO!.status == 'true' &&
            settingVO!.data!.isNotEmpty) {
          _listData.addAll(settingVO!.data!);
        }
        setState(() {});
      } else {}
    } catch (e) {
      return null;
    }
  }

  String _parseHtmlString(String htmlString) {
    var document = parse(htmlString);

    String parsedString = parse(document.body!.text).documentElement!.text;

    return parsedString;
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
                    padding: getPadding(top: 27, bottom: 27),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomImageView(
                              svgPath: ImageConstant.imgClosesvgrepocom,
                              height: getSize(18),
                              width: getSize(18),
                              alignment: Alignment.centerLeft,
                              margin: getMargin(left: 24, top: 2),
                              onTap: () {
                                // pushScreen(
                                //   context,
                                //   screen: landingPage1(),
                                //   withNavBar:
                                //       false, // OPTIONAL VALUE. True by default.
                                //   pageTransitionAnimation:
                                //       PageTransitionAnimation.cupertino,
                                // );
                              }),
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
                                                color: ColorConstant.purple900,
                                                borderRadius: BorderRadius.only(
                                                    bottomRight:
                                                        Radius.circular(
                                                            getHorizontalSize(
                                                                30))))),
                                        Padding(
                                            padding: getPadding(left: 6),
                                            child: Text("lbl_sign_up".tr,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style:
                                                    AppStyle.txtRobotoMedium18))
                                      ]))),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                  padding: getPadding(left: 28, top: 10),
                                  child: Text("lbl_register".tr,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: AppStyle
                                          .txtRobotoRegular12Purple700))),
                          CustomTextFormField(
                              focusNode: FocusNode(),
                              controller: fullnameController,
                              hintText: "lbl_full_name".tr,
                              margin: getMargin(left: 27, top: 71, right: 26),
                              validator: (value) {
                                if (!isText(value!)) {
                                  return "Please enter your full name";
                                }
                                return null;
                              }),
                          CustomTextFormField(
                              focusNode: FocusNode(),
                              controller: mobilenumberController,
                              hintText: "lbl_mobile_number".tr,
                              margin: getMargin(left: 27, top: 18, right: 26),
                              textInputType: TextInputType.phone,
                              validator: (value) {
                                if (!isValidPhone(value!)) {
                                  return "Please enter valid phone number";
                                }
                                return null;
                              }),
                          CustomTextFormField(
                              focusNode: FocusNode(),
                              controller: emailController,
                              hintText: "lbl_email_id".tr,
                              margin: getMargin(left: 27, top: 18, right: 26),
                              textInputType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null ||
                                    (!isValidEmail(value, isRequired: true))) {
                                  return "Please enter valid email";
                                }
                                return null;
                              }),
                          CustomTextFormField(
                            focusNode: FocusNode(),
                            controller: passwordController,
                            hintText: "Enter New password",
                            margin: getMargin(left: 27, top: 18, right: 26),
                            textInputAction: TextInputAction.done,
                            textInputType: TextInputType.visiblePassword,
                            // suffix: InkWell(
                            //     onTap: () {
                            //       newpasswordController._isObscure =
                            //       !controller.isShowPassword.value;
                            //     },
                            //     child: Container(
                            //         margin: getMargin(
                            //             left: 30,
                            //             top: 1,
                            //             right: 7,
                            //             bottom: 5),
                            //         // decoration: BoxDecoration(
                            //         //     color: ColorConstant.purple900),
                            //         child: CustomImageView(
                            //             svgPath: controller
                            //                 .isShowPassword.value
                            //                 ? ImageConstant.imgContrast
                            //                 : ImageConstant.imgContrast))),
                            suffix: IconButton(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
                              icon: Icon(
                                // Based on passwordVisible state choose the icon
                                _isObscure
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: ColorConstant.purple700,
                              ),
                              onPressed: () {
                                // Update the state i.e. toogle the state of passwordVisible variable
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              },
                            ),
                            suffixConstraints:
                                BoxConstraints(maxHeight: getVerticalSize(20)),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter the password';
                              }
                              return null;
                            },
                            isObscureText: !_isObscure,
                            // isObscureText: !is
                          ),
                          CustomButton(
                              height: getVerticalSize(39),
                              text: "lbl_register2".tr,
                              margin: getMargin(left: 27, top: 24, right: 26),
                              variant: ButtonVariant.FillPurple900,
                              padding: ButtonPadding.PaddingAll11,
                              fontStyle: ButtonFontStyle.RobotoMedium14,
                              onTap: onTapRegisterone),
                          Container(
                              width: getHorizontalSize(300),
                              margin: getMargin(top: 12),
                              child: RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text: "msg_by_clicking_here2".tr,
                                        style: TextStyle(
                                            color: ColorConstant.black900,
                                            fontSize: getFontSize(14),
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w400)),
                                    TextSpan(
                                        text: "Terms of Use",
                                        style: TextStyle(
                                            color: ColorConstant.purple700,
                                            fontSize: getFontSize(14),
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w400),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            AppConstant.aboutType = '1';
                                            int index = _listData.indexWhere(
                                                (setting) =>
                                                    setting.settingsKeys ==
                                                    'terms_condition');
                                            AppConstant.terms =
                                                _parseHtmlString(
                                                    _listData[index]
                                                        .settingsValues!);
                                            onTapTxt();
                                            // setState(() {
                                            //   _launched = _launchInBrowser(Uri(scheme: 'https', host: '', path: 'headers/'));
                                            // });
                                            // }),
                                          }),
                                    TextSpan(
                                        text: "lbl".tr,
                                        style: TextStyle(
                                            color: ColorConstant.black900,
                                            fontSize: getFontSize(14),
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w400)),
                                    TextSpan(
                                        text: "lbl_privacy_policy2".tr,
                                        style: TextStyle(
                                            color: ColorConstant.purple700,
                                            fontSize: getFontSize(14),
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w400),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            AppConstant.aboutType = '2';
                                            int index = _listData.indexWhere(
                                                (setting) =>
                                                    setting.settingsKeys ==
                                                    'privacy_policy');
                                            AppConstant.terms =
                                                _parseHtmlString(
                                                    _listData[index]
                                                        .settingsValues!);
                                            onTapTxt();
                                            // setState(() {
                                            //   _launched = _launchInBrowser(Uri(scheme: 'https', host: '', path: 'headers/'));
                                            // });
                                            // }),
                                          })
                                  ]),
                                  textAlign: TextAlign.center)),
                          Spacer(),
                          Text("lbl_existing_user".tr,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtRobotoMedium12),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Padding(
                                padding: getPadding(top: 8),
                                child: Text("lbl_log_in".tr,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: AppStyle.txtRobotoMedium18)),
                          ),
                          // Padding(
                          //     padding: getPadding(top: 101),
                          //     child: Text("msg_or_continue_with".tr,
                          //         overflow: TextOverflow.ellipsis,
                          //         textAlign: TextAlign.left,
                          //         style: AppStyle.txtRobotoRegular15)),
                          // CustomImageView(
                          //     svgPath: ImageConstant.imgGooglesvgrepocom,
                          //     height: getSize(45),
                          //     width: getSize(45),
                          //     margin: getMargin(top: 21)),
                          CustomImageView(
                              imagePath: ImageConstant.imgFinallogo03,
                              height: getVerticalSize(32),
                              width: getHorizontalSize(106),
                              margin: getMargin(top: 39))
                        ])))));
  }

  onTapImgClosesvgrepocom() {
    Get.toNamed(AppRoutes.logInScreen);
  }

  onTapRegisterone() {
    FocusManager.instance.primaryFocus!.unfocus();
    if (_formKey.currentState!.validate()) {
      postRequest(fullnameController.text, mobilenumberController.text,
          emailController.text, passwordController.text);
      Timer(Duration(seconds: 3), () {
        mobilenumberController.clear();
        fullnameController.clear();
        emailController.clear();
        passwordController.clear();
        _btnController.reset();
      });
      // print(field);
      // if(cred!.=='success'){
      //
      // }
    } else {
      setState(() {
        Timer(Duration(seconds: 0), () {
          _btnController.reset();
        });
      });
    }
  }
}
