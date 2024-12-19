import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';
import 'package:sizer/sizer.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/image_constant.dart';
import '../../core/utils/size_utils.dart';
import '../../core/utils/utils.dart';
import '../../theme/app_style.dart';
import '../../widgets/app_bar/appbar_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_form_field.dart';
import '../ResetPassword.dart';

import 'dart:convert';

import 'package:dio/dio.dart' as dio;
import 'package:keshav_s_application2/presentation/otp_screen/models/otp_model.dart'
    as otp;

import 'model/ResetPasswordModel.dart';

class ResetPasswordAfterLogin extends StatefulWidget {
  otp.Data data;
  ResetPasswordAfterLogin(this.data);

  @override
  State<ResetPasswordAfterLogin> createState() =>
      _ResetPasswordAfterLoginState();
}

class _ResetPasswordAfterLoginState extends State<ResetPasswordAfterLogin> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  Future<ResetPasswordModel> postRequest() async {
    var url = 'https://fabfurni.com/api/Auth/resetPassword';
    // var token = "432222222222";

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "User-Agent": "PostmanRuntime/7.30.0",
      "Accept": "*/*",
      "Accept-Encoding": "gzip, deflate, br",
      "Connection": "keep-alive"
    };

    dio.FormData formData = dio.FormData.fromMap({
      "user_id": widget.data.id,
      "email": emailController.text,
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
      if (ResetPasswordModel.fromJson(jsonObject).status == "true") {
        Fluttertoast.showToast(
            msg: "Email sent Successfully. Please check your email",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.greenAccent,
            textColor: Colors.black,
            fontSize: 14.0);
        Navigator.of(context).pop();
        // Navigator.of(context).pushReplacement(MaterialPageRoute(
        //   builder: (context) => LogInScreen(),
        // ));
      } else if (ResetPasswordModel.fromJson(jsonObject).status == "false") {
        Fluttertoast.showToast(
            msg: ResetPasswordModel.fromJson(jsonObject).message!,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.redAccent,
            textColor: Colors.black,
            fontSize: 14.0);
        // setState(() {
        //   _btnController.error();
        // });
      }

      // print(Logindata.fromJson(jsonObject).message);
      print(ResetPasswordModel.fromJson(jsonObject).toString());
      return ResetPasswordModel.fromJson(
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
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: ColorConstant.whiteA700,
            appBar: CustomAppBar(
                height: getVerticalSize(70),
                leadingWidth: 41,
                leading: AppbarImage(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    height: getVerticalSize(15),
                    width: getHorizontalSize(9),
                    svgPath: ImageConstant.imgArrowleft,
                    margin: getMargin(left: 20, top: 30, bottom: 25)),
                title: AppbarTitle(
                    text: "Reset Password",
                    margin: getMargin(left: 19, top: 49, bottom: 42)),
                styleType: Style.bgShadowBlack90033),
            body: Form(
                key: _formKey,
                child: Container(
                    width: double.maxFinite,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                  padding: getPadding(left: 27, top: 45),
                                  child: Text("Enter Your email",
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: AppStyle
                                          .txtRobotoRegular12Purple300))),
                          CustomTextFormField(
                            focusNode: FocusNode(),
                            controller: emailController,
                            margin: getMargin(left: 27, top: 5, right: 26),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter the email';
                              }
                              return null;
                            },
                          ),

                          SizedBox(
                            height: 4.h,
                          ),

                          CustomButton(
                              onTap: () {
                                FocusManager.instance.primaryFocus!.unfocus();
                                if (_formKey.currentState!.validate()) {
                                  postRequest();
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
                              },
                              height: getVerticalSize(39),
                              text: "Submit",
                              margin: getMargin(left: 27, top: 43, right: 26),
                              variant: ButtonVariant.FillPurple900,
                              padding: ButtonPadding.PaddingAll11,
                              fontStyle: ButtonFontStyle.RobotoMedium14),
                          Spacer(),
                          // Padding(
                          //     padding: getPadding(left: 28, right: 17),
                          //     child: Row(
                          //         mainAxisAlignment:
                          //             MainAxisAlignment.spaceBetween,
                          //         children: [
                          //           Text("lbl_new".tr,
                          //               overflow: TextOverflow.ellipsis,
                          //               textAlign: TextAlign.left,
                          //               style: AppStyle.txtRobotoMedium9),
                          //           Text("lbl_30_off2".tr,
                          //               overflow: TextOverflow.ellipsis,
                          //               textAlign: TextAlign.left,
                          //               style: AppStyle.txtRobotoMedium9)
                          //         ])),
                          // Container(
                          //     height: getVerticalSize(86),
                          //     width: getHorizontalSize(400),
                          //     margin: getMargin(top: 31),
                          //     decoration: BoxDecoration(
                          //         image: DecorationImage(
                          //             image: fs.Svg(ImageConstant.imgGroup203),
                          //             fit: BoxFit.cover)),
                          //     child:
                          //         Stack(alignment: Alignment.center, children: [
                          //       Align(
                          //           alignment: Alignment.bottomCenter,
                          //           child: Padding(
                          //               padding: getPadding(
                          //                   left: 41, right: 44, bottom: 6),
                          //               child: Column(
                          //                   mainAxisSize: MainAxisSize.min,
                          //                   mainAxisAlignment:
                          //                       MainAxisAlignment.start,
                          //                   children: [
                          //                     CustomImageView(
                          //                         svgPath:
                          //                             ImageConstant.imgGroup2,
                          //                         height: getVerticalSize(47),
                          //                         width:
                          //                             getHorizontalSize(315)),
                          //                     Padding(
                          //                         padding: getPadding(
                          //                             left: 7,
                          //                             top: 4,
                          //                             right: 1),
                          //                         child: Row(
                          //                             mainAxisAlignment:
                          //                                 MainAxisAlignment
                          //                                     .spaceBetween,
                          //                             children: [
                          //                               Text("lbl_home".tr,
                          //                                   overflow:
                          //                                       TextOverflow
                          //                                           .ellipsis,
                          //                                   textAlign:
                          //                                       TextAlign.left,
                          //                                   style: AppStyle
                          //                                       .txtRobotoMedium8Purple900),
                          //                               Text("lbl_store".tr,
                          //                                   overflow:
                          //                                       TextOverflow
                          //                                           .ellipsis,
                          //                                   textAlign:
                          //                                       TextAlign.left,
                          //                                   style: AppStyle
                          //                                       .txtRobotoMedium8),
                          //                               Text("lbl_profile".tr,
                          //                                   overflow:
                          //                                       TextOverflow
                          //                                           .ellipsis,
                          //                                   textAlign:
                          //                                       TextAlign.left,
                          //                                   style: AppStyle
                          //                                       .txtRobotoMedium8)
                          //                             ]))
                          //                   ]))),
                          //       Align(
                          //           alignment: Alignment.center,
                          //           child: Container(
                          //               padding: getPadding(
                          //                   left: 41,
                          //                   top: 6,
                          //                   right: 41,
                          //                   bottom: 6),
                          //               decoration: BoxDecoration(
                          //                   image: DecorationImage(
                          //                       image: fs.Svg(
                          //                           ImageConstant.imgGroup203),
                          //                       fit: BoxFit.cover)),
                          //               child: Column(
                          //                   mainAxisSize: MainAxisSize.min,
                          //                   mainAxisAlignment:
                          //                       MainAxisAlignment.end,
                          //                   children: [
                          //                     CustomImageView(
                          //                         svgPath: ImageConstant
                          //                             .imgGroup2Gray500,
                          //                         height: getVerticalSize(47),
                          //                         width: getHorizontalSize(315),
                          //                         margin: getMargin(top: 11)),
                          //                     Padding(
                          //                         padding: getPadding(
                          //                             left: 7,
                          //                             top: 4,
                          //                             right: 3),
                          //                         child: Row(
                          //                             mainAxisAlignment:
                          //                                 MainAxisAlignment
                          //                                     .spaceBetween,
                          //                             children: [
                          //                               Text("lbl_home".tr,
                          //                                   overflow:
                          //                                       TextOverflow
                          //                                           .ellipsis,
                          //                                   textAlign:
                          //                                       TextAlign.left,
                          //                                   style: AppStyle
                          //                                       .txtRobotoMedium8),
                          //                               Text("lbl_store".tr,
                          //                                   overflow:
                          //                                       TextOverflow
                          //                                           .ellipsis,
                          //                                   textAlign:
                          //                                       TextAlign.left,
                          //                                   style: AppStyle
                          //                                       .txtRobotoMedium8),
                          //                               Text("lbl_profile".tr,
                          //                                   overflow:
                          //                                       TextOverflow
                          //                                           .ellipsis,
                          //                                   textAlign:
                          //                                       TextAlign.left,
                          //                                   style: AppStyle
                          //                                       .txtRobotoMedium8Purple900)
                          //                             ]))
                          //                   ])))
                          //     ])),
                          // Padding(
                          //     padding: getPadding(left: 8, top: 83, right: 8),
                          //     child: Row(
                          //         mainAxisAlignment: MainAxisAlignment.center,
                          //         crossAxisAlignment: CrossAxisAlignment.end,
                          //         children: [
                          //           Padding(
                          //               padding: getPadding(bottom: 4),
                          //               child: Text("msg_fabiola_2_seater2".tr,
                          //                   overflow: TextOverflow.ellipsis,
                          //                   textAlign: TextAlign.left,
                          //                   style: AppStyle
                          //                       .txtRobotoRegular12Black9001)),
                          //           Spacer(),
                          //           CustomImageView(
                          //               svgPath: ImageConstant.imgCut,
                          //               height: getVerticalSize(11),
                          //               width: getHorizontalSize(7),
                          //               margin: getMargin(top: 4, bottom: 3)),
                          //           Padding(
                          //               padding: getPadding(left: 4, top: 4),
                          //               child: Text("lbl_49_999".tr,
                          //                   overflow: TextOverflow.ellipsis,
                          //                   textAlign: TextAlign.left,
                          //                   style: AppStyle
                          //                       .txtRobotoMedium12Purple9001))
                          //         ])),
                          // Padding(
                          //     padding: getPadding(left: 8, top: 3, right: 8),
                          //     child: Row(
                          //         mainAxisAlignment: MainAxisAlignment.center,
                          //         children: [
                          //           Padding(
                          //               padding: getPadding(bottom: 1),
                          //               child: Text(
                          //                   "msg_casacraft_by_fabfurni".tr,
                          //                   overflow: TextOverflow.ellipsis,
                          //                   textAlign: TextAlign.left,
                          //                   style: AppStyle
                          //                       .txtRobotoRegular10Purple900)),
                          //           Spacer(),
                          //           CustomImageView(
                          //               svgPath: ImageConstant.imgVectorGray500,
                          //               height: getVerticalSize(8),
                          //               width: getHorizontalSize(5),
                          //               margin: getMargin(top: 2, bottom: 3)),
                          //           Container(
                          //               height: getVerticalSize(12),
                          //               width: getHorizontalSize(32),
                          //               margin: getMargin(left: 3, top: 1),
                          //               child: Stack(
                          //                   alignment: Alignment.bottomCenter,
                          //                   children: [
                          //                     Align(
                          //                         alignment: Alignment.center,
                          //                         child: Text("lbl_99_999".tr,
                          //                             overflow:
                          //                                 TextOverflow.ellipsis,
                          //                             textAlign: TextAlign.left,
                          //                             style: AppStyle
                          //                                 .txtRobotoMedium10Gray5001)),
                          //                     Align(
                          //                         alignment:
                          //                             Alignment.bottomCenter,
                          //                         child: Padding(
                          //                             padding:
                          //                                 getPadding(bottom: 5),
                          //                             child: SizedBox(
                          //                                 width:
                          //                                     getHorizontalSize(
                          //                                         32),
                          //                                 child: Divider(
                          //                                     height:
                          //                                         getVerticalSize(
                          //                                             1),
                          //                                     thickness:
                          //                                         getVerticalSize(
                          //                                             1),
                          //                                     color: ColorConstant
                          //                                         .gray500))))
                          //                   ]))
                          //         ])),
                          // Padding(
                          //     padding: getPadding(left: 8, top: 12, right: 12),
                          //     child: Row(
                          //         mainAxisAlignment: MainAxisAlignment.center,
                          //         crossAxisAlignment: CrossAxisAlignment.end,
                          //         children: [
                          //           Column(
                          //               mainAxisAlignment:
                          //                   MainAxisAlignment.start,
                          //               children: [
                          //                 Text("msg_limited_time_offer".tr,
                          //                     overflow: TextOverflow.ellipsis,
                          //                     textAlign: TextAlign.left,
                          //                     style: AppStyle
                          //                         .txtRobotoRegular10Black9001),
                          //                 Padding(
                          //                     padding: getPadding(top: 7),
                          //                     child: Row(
                          //                         mainAxisAlignment:
                          //                             MainAxisAlignment.center,
                          //                         children: [
                          //                           Text(
                          //                               "lbl_ships_in_1_day".tr,
                          //                               overflow: TextOverflow
                          //                                   .ellipsis,
                          //                               textAlign:
                          //                                   TextAlign.left,
                          //                               style: AppStyle
                          //                                   .txtRobotoMedium10Black9001),
                          //                           CustomImageView(
                          //                               svgPath: ImageConstant
                          //                                   .imgCar,
                          //                               height:
                          //                                   getVerticalSize(10),
                          //                               width:
                          //                                   getHorizontalSize(
                          //                                       13),
                          //                               margin: getMargin(
                          //                                   left: 9,
                          //                                   top: 1,
                          //                                   bottom: 1))
                          //                         ]))
                          //               ]),
                          //           Spacer(),
                          //           CustomImageView(
                          //               svgPath: ImageConstant.imgLocation,
                          //               height: getVerticalSize(18),
                          //               width: getHorizontalSize(21),
                          //               margin: getMargin(top: 10, bottom: 3)),
                          //           CustomImageView(
                          //               svgPath: ImageConstant.imgCart,
                          //               height: getVerticalSize(20),
                          //               width: getHorizontalSize(23),
                          //               margin: getMargin(
                          //                   left: 35, top: 9, bottom: 2))
                          //         ])),
                          Padding(
                              padding: getPadding(top: 17),
                              child: Divider(
                                  height: getVerticalSize(5),
                                  thickness: getVerticalSize(5),
                                  color: ColorConstant.purple50))
                        ])))));
    ;
  }
}
