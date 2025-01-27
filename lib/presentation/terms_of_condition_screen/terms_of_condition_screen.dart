import '../../core/utils/appConstant.dart';
import 'controller/terms_of_condition_controller.dart';
import 'package:flutter/material.dart';
import 'package:keshav_s_application2/core/app_export.dart';
import 'package:keshav_s_application2/widgets/app_bar/appbar_image.dart';
import 'package:keshav_s_application2/widgets/app_bar/appbar_subtitle_5.dart';
import 'package:keshav_s_application2/widgets/app_bar/custom_app_bar.dart';

class TermsOfConditionScreen extends StatefulWidget {
  @override
  State<TermsOfConditionScreen> createState() => _termsOfConditionScreen();
}

class _termsOfConditionScreen extends State<TermsOfConditionScreen> {
  String toolbarName = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (AppConstant.aboutType == '1') {
      toolbarName = "lbl_terms_of_use".tr;
    } else if (AppConstant.aboutType == '2') {
      toolbarName = "lbl_privacy_policy".tr;
    } else if (AppConstant.aboutType == '3') {
      toolbarName = "Return policy";
    } else if (AppConstant.aboutType == '4') {
      toolbarName = "msg_grievance_redressal".tr;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConstant.whiteA700,
            appBar: CustomAppBar(
                height: getVerticalSize(92),
                leadingWidth: 34,
                leading: AppbarImage(
                    height: getVerticalSize(15),
                    width: getHorizontalSize(9),
                    svgPath: ImageConstant.imgArrowleft,
                    margin: getMargin(left: 25, top: 53, bottom: 23),
                    onTap: onTapArrowleft),
                title: AppbarSubtitle5(
                    text: toolbarName,
                    margin: getMargin(left: 19, top: 50, bottom: 18)),
                styleType: Style.bgStyle),
            body: SingleChildScrollView(
              child: Container(
                  width: double.maxFinite,
                  padding: getPadding(left: 25, top: 33, right: 25, bottom: 33),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomImageView(
                            svgPath: ImageConstant.imgFile,
                            height: getVerticalSize(59),
                            width: getHorizontalSize(45),
                            alignment: Alignment.center),
                        Container(
                            width: getHorizontalSize(364),
                            margin: getMargin(top: 20, right: 13),
                            child: Text(AppConstant.terms,
                                maxLines: null,
                                textAlign: TextAlign.left,
                                style: AppStyle.txtRobotoLight12.copyWith(
                                    letterSpacing: getHorizontalSize(0.24)))),
                      ])),
            )));
  }

  onTapArrowleft() {
    Get.back();
  }
}
