import 'package:flutter/material.dart';
import 'package:keshav_s_application2/core/utils/color_constant.dart';
import 'package:keshav_s_application2/core/utils/image_constant.dart';
import 'package:keshav_s_application2/core/utils/size_utils.dart';
import 'package:keshav_s_application2/theme/app_style.dart';
import 'package:keshav_s_application2/widgets/custom_button.dart';
import 'package:keshav_s_application2/widgets/custom_text_form_field.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';
import 'package:sizer/sizer.dart';

import '../widgets/custom_image_view.dart';

class ResetPassword extends StatefulWidget {
  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController newpasswordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  bool _isObscure = false;
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
                                Navigator.pop(context);
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
                                            child: Text("Reset Password",
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style:
                                                    AppStyle.txtRobotoMedium18))
                                      ]))),
                          SizedBox(
                            height: 8.h,
                          ),
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
                          CustomButton(
                              height: getVerticalSize(39),
                              text: "SEND OTP",
                              margin: getMargin(left: 27, top: 24, right: 26),
                              variant: ButtonVariant.FillPurple900,
                              padding: ButtonPadding.PaddingAll11,
                              fontStyle: ButtonFontStyle.RobotoMedium14,
                              onTap: () {}),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "OTP will be sent to your Registered Mobile Number & Email Address",
                              style: TextStyle(
                                  fontSize: 11, fontWeight: FontWeight.w400),
                            ),
                          ),
                          SizedBox(
                            height: 44.h,
                          ),
                          CustomImageView(
                              imagePath: ImageConstant.imgFinallogo03,
                              height: getVerticalSize(32),
                              width: getHorizontalSize(106),
                              margin: getMargin(top: 39))
                        ])))));
  }
}
