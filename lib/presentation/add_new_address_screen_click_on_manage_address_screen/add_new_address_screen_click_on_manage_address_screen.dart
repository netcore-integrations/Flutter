import 'dart:async';
import 'dart:convert';

import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keshav_s_application2/core/app_export.dart';
import 'package:keshav_s_application2/core/utils/utils.dart';
import 'package:keshav_s_application2/presentation/add_address_screen/add_address_screen.dart';
import 'package:keshav_s_application2/presentation/add_address_screen_click_on_manage_address_screen/ManageAddressModel.dart';
import 'package:keshav_s_application2/presentation/add_new_address_screen_click_on_manage_address_screen/AddressUpdateModel.dart';
import 'package:keshav_s_application2/presentation/cart_screen/cart_screen.dart';
import 'package:keshav_s_application2/presentation/otp_screen/models/otp_model.dart';
import 'package:keshav_s_application2/presentation/search_screen/search_screen.dart';
import 'package:keshav_s_application2/presentation/whislist_screen/whislist_screen.dart';
import 'package:keshav_s_application2/widgets/app_bar/appbar_image.dart';
import 'package:keshav_s_application2/widgets/app_bar/appbar_subtitle.dart';
import 'package:keshav_s_application2/widgets/app_bar/appbar_subtitle_6.dart';
import 'package:keshav_s_application2/widgets/app_bar/appbar_title.dart';
import 'package:keshav_s_application2/widgets/app_bar/custom_app_bar.dart';
import 'package:keshav_s_application2/widgets/custom_button.dart';
import 'package:keshav_s_application2/widgets/custom_phone_number.dart';
import 'package:keshav_s_application2/widgets/custom_text_form_field.dart';

import 'dart:convert';

import 'package:dio/dio.dart' as dio;
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

import 'package:sizer/sizer.dart';
// ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class AddNewAddressScreenClickOnManageAddressScreen extends StatefulWidget {
  Data data;
  AddressData addressdata;
  AddNewAddressScreenClickOnManageAddressScreen(this.data, this.addressdata);
  @override
  State<AddNewAddressScreenClickOnManageAddressScreen> createState() =>
      _AddNewAddressScreenClickOnManageAddressScreenState();
}

class _AddNewAddressScreenClickOnManageAddressScreenState
    extends State<AddNewAddressScreenClickOnManageAddressScreen> {
  TextEditingController cityController = TextEditingController();

  TextEditingController stateController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();

  Country selectedCountry = CountryPickerUtils.getCountryByPhoneCode('91');

  TextEditingController phoneNumberController = TextEditingController();

  TextEditingController fullnameoneController = TextEditingController();

  TextEditingController flatnumberController = TextEditingController();

  TextEditingController streetAddressController = TextEditingController();

  bool isCheckbox = false;

  bool isCheckbox1 = false;

  int? check1;
  int? check2;
  String selected = "";
  List<String> _checked = [];

  GroupController controller = GroupController();

  Future<AddressUpdate> postRequest() async {
    var url = 'https://fabfurni.com/api/Auth/addressUpdate';
    // var token = "432222222222";

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "User-Agent": "PostmanRuntime/7.30.0",
      "Accept": "*/*",
      "Accept-Encoding": "gzip, deflate, br",
      "Connection": "keep-alive"
    };

    dio.FormData formData = dio.FormData.fromMap({
      "address_id": widget.addressdata.id,
      "user_id": widget.addressdata.userId,
      "name": fullnameoneController.text,
      "address_one": flatnumberController.text,
      "address_two": "",
      "city": cityController.text,
      "state": stateController.text,
      "pincode": pincodeController.text,
      "default": check1,
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
      if (AddressUpdate.fromJson(jsonObject).status == "true") {
        Fluttertoast.showToast(
            msg: "Address Updated Successfully",
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
      } else if (AddressUpdate.fromJson(jsonObject).status == "false") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(AddressUpdate.fromJson(jsonObject).message!),
            backgroundColor: Colors.redAccent));
        // setState(() {
        //   _btnController.error();
        // });
      } else if (AddressUpdate.fromJson(jsonObject).data == null) {
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
        // setState(() {
        //   _btnController.error();
        // });
      }

      // print(Logindata.fromJson(jsonObject).message);
      print(AddressUpdate.fromJson(jsonObject).toString());
      return AddressUpdate.fromJson(
          jsonObject); // you can mapping json object also here
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Sending Message"),
      )); // you can mapping json object also here
    }
    return jsonObject;
    // return response;
  }

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    fullnameoneController.text = widget.addressdata.name!.capitalizeFirst!;
    flatnumberController.text = widget.addressdata.addressOne!.capitalizeFirst!;
    pincodeController.text = widget.addressdata.pincode!;
    cityController.text = widget.addressdata.city!.capitalizeFirst!;
    stateController.text = widget.addressdata.state!.capitalizeFirst!;

    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConstant.whiteA700,
            resizeToAvoidBottomInset: false,
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
                    text: "MANAGE ADDRESS",
                    margin: getMargin(left: 19, top: 49, bottom: 42)),
                // AppbarImage(
                //     height: getVerticalSize(32),
                //     width: getHorizontalSize(106),
                //     imagePath: ImageConstant.imgFinallogo03,
                //     margin: getMargin(left: 13, top: 44, bottom: 15)),
                actions: [
                  AppbarImage(
                      height: getSize(21),
                      width: getSize(21),
                      svgPath: ImageConstant.imgSearch,
                      margin:
                          getMargin(left: 12, top: 22, right: 10, bottom: 10),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SearchScreen(widget.data, ''),
                        ));
                      }),
                  Container(
                      height: getVerticalSize(23),
                      width: getHorizontalSize(27),
                      margin:
                          getMargin(left: 20, top: 25, right: 10, bottom: 0),
                      child: Stack(alignment: Alignment.topRight, children: [
                        AppbarImage(
                            height: getVerticalSize(21),
                            width: getHorizontalSize(21),
                            svgPath: ImageConstant.imgLocation,
                            margin: getMargin(top: 5, right: 6),
                            onTap: () {
                              pushScreen(
                                context,
                                screen: WhislistScreen(widget.data),
                                withNavBar:
                                    false, // OPTIONAL VALUE. True by default.
                                pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino,
                              );
                            }),
                        // AppbarSubtitle6(
                        //     text: "lbl_2".tr,
                        //     margin: getMargin(left: 17, bottom: 13))
                      ])),
                  Container(
                      height: getVerticalSize(24),
                      width: getHorizontalSize(29),
                      margin: getMargin(left: 14, top: 27, right: 31),
                      child: Stack(alignment: Alignment.topRight, children: [
                        AppbarImage(
                            onTap: () {
                              pushScreen(
                                context,
                                screen: CartScreen(widget.data),
                                withNavBar:
                                    false, // OPTIONAL VALUE. True by default.
                                pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino,
                              );
                              // Navigator.of(context).push(MaterialPageRoute(
                              //   builder: (context) => CartScreen(widget.data),
                              // ));
                            },
                            height: getVerticalSize(20),
                            width: getHorizontalSize(23),
                            svgPath: ImageConstant.imgCart,
                            margin: getMargin(top: 4, right: 6)),
                        AppbarSubtitle6(
                            text: CartScreen.count.toString(),
                            margin: getMargin(left: 17, bottom: 13))
                      ]))
                ],
                styleType: Style.bgShadowBlack90033),
            body: Container(
                width: double.maxFinite,
                padding: getPadding(left: 12, top: 22, right: 12, bottom: 22),
                child: Form(
                  key: _formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomButton(
                            onTap: () {
                              pushScreen(
                                context,
                                screen: AddAddressScreen(widget.data),
                                withNavBar:
                                    false, // OPTIONAL VALUE. True by default.
                                pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino,
                              );
                            },
                            height: getVerticalSize(39),
                            text: "Add New Address",
                            margin: getMargin(left: 13, right: 13),
                            variant: ButtonVariant.OutlinePurple700,
                            shape: ButtonShape.RoundedBorder5,
                            padding: ButtonPadding.PaddingT10,
                            fontStyle: ButtonFontStyle.RobotoMedium15Black900,
                            prefixWidget: Container(
                                margin: getMargin(right: 12),
                                child: CustomImageView(
                                    svgPath: ImageConstant.imgPlusGray50001)),
                            alignment: Alignment.center),
                        Padding(
                            padding: getPadding(left: 1, top: 17),
                            child: Row(children: [
                              Container(
                                  height: getVerticalSize(14),
                                  width: getHorizontalSize(13),
                                  margin: getMargin(top: 1, bottom: 2),
                                  decoration: BoxDecoration(
                                      color: ColorConstant.purple900,
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(
                                              getHorizontalSize(50))))),
                              Padding(
                                  padding: getPadding(left: 15),
                                  child: Text("Edit Address",
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: AppStyle.txtRobotoMedium15))
                            ])),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                                padding: getPadding(left: 4, top: 16),
                                child: Text("lbl_full_name".tr,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style:
                                        AppStyle.txtRobotoRegular12Purple300))),
                        CustomTextFormField(
                          focusNode: FocusNode(),
                          controller: fullnameoneController,
                          hintText: widget.addressdata.name!.capitalizeFirst!,
                          margin: getMargin(left: 4, top: 5, right: 26),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter name';
                            }
                            return null;
                          },
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                                padding: getPadding(left: 4, top: 13),
                                child: Text("Address & Landmark",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style:
                                        AppStyle.txtRobotoRegular12Purple300))),
                        CustomTextFormField(
                            focusNode: FocusNode(),
                            controller: flatnumberController,
                            hintText:
                                widget.addressdata.addressOne!.capitalizeFirst!,
                            margin: getMargin(left: 4, top: 5, right: 26),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter the address';
                              }
                              return null;
                            }),
                        // Align(
                        //     alignment: Alignment.centerLeft,
                        //     child: Padding(
                        //         padding: getPadding(left: 4, top: 13),
                        //         child: Text("Street Address/colony",
                        //             overflow: TextOverflow.ellipsis,
                        //             textAlign: TextAlign.left,
                        //             style:
                        //                 AppStyle.txtRobotoRegular12Purple300))),
                        // CustomTextFormField(
                        //     focusNode: FocusNode(),
                        //     controller: streetAddressController,
                        //     // hintText: widget.data.email,
                        //     margin: getMargin(left: 4, top: 6, right: 26),
                        //     textInputAction: TextInputAction.done,
                        //     validator: (value) {
                        //       if (value == null) {
                        //         return "Please enter street address";
                        //       }
                        //       return null;
                        //     }),
                        // Align(
                        //     alignment: Alignment.centerLeft,
                        //     child: Padding(
                        //         padding: getPadding(left: 4, top: 13),
                        //         child: Text("Landmark",
                        //             overflow: TextOverflow.ellipsis,
                        //             textAlign: TextAlign.left,
                        //             style:
                        //                 AppStyle.txtRobotoRegular12Purple300))),
                        // CustomTextFormField(
                        //     focusNode: FocusNode(),
                        //     controller: landmarkController,
                        //     // hintText: widget.data.email,
                        //     margin: getMargin(left: 4, top: 6, right: 26),
                        //     textInputAction: TextInputAction.done,
                        //     validator: (value) {
                        //       if (value == null) {
                        //         return "Please enter landmark";
                        //       }
                        //       return null;
                        //     }),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                                padding: getPadding(left: 4, top: 13),
                                child: Text("Pincode",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style:
                                        AppStyle.txtRobotoRegular12Purple300))),
                        CustomTextFormField(
                            focusNode: FocusNode(),
                            controller: pincodeController,
                            hintText: widget.addressdata!.pincode!,
                            maxLength: 6,
                            margin: getMargin(left: 4, top: 6, right: 26),
                            textInputAction: TextInputAction.done,
                            textInputType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter the pincode';
                              }
                              return null;
                            }),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                                padding: getPadding(left: 4, top: 1),
                                child: Text("City",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style:
                                        AppStyle.txtRobotoRegular12Purple300))),
                        CustomTextFormField(
                            focusNode: FocusNode(),
                            controller: cityController,
                            hintText: widget.addressdata.city!.capitalizeFirst!,
                            margin: getMargin(left: 4, top: 6, right: 26),
                            textInputAction: TextInputAction.done,
                            textInputType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter the city';
                              }
                              return null;
                            }),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                                padding: getPadding(left: 4, top: 13),
                                child: Text("State",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style:
                                        AppStyle.txtRobotoRegular12Purple300))),
                        CustomTextFormField(
                            focusNode: FocusNode(),
                            controller: stateController,
                            hintText:
                                widget.addressdata.state!.capitalizeFirst!,
                            margin: getMargin(left: 4, top: 6, right: 26),
                            textInputAction: TextInputAction.done,
                            textInputType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter the state';
                              }
                              return null;
                            }),
                        // Padding(
                        //     padding: getPadding(left: 1, top: 25),
                        //     child: Text("Enter your Name",
                        //         overflow: TextOverflow.ellipsis,
                        //         textAlign: TextAlign.left,
                        //         style: AppStyle.txtRobotoRegular8Purple900)),
                        // Container(
                        //     height: getVerticalSize(18),
                        //     width: getHorizontalSize(70),
                        //     margin: getMargin(left: 1, top: 1),
                        //     child: Stack(
                        //         alignment: Alignment.centerRight,
                        //         children: [
                        //           Align(
                        //               alignment: Alignment.topCenter,
                        //               child: Padding(
                        //                   padding: getPadding(top: 1),
                        //                   child: Text("Savan Mehta",
                        //                       overflow: TextOverflow.ellipsis,
                        //                       textAlign: TextAlign.left,
                        //                       style:
                        //                           AppStyle.txtRobotoRegular12))),
                        //           Align(
                        //               alignment: Alignment.centerRight,
                        //               child: SizedBox(
                        //                   height: getVerticalSize(18),
                        //                   child: VerticalDivider(
                        //                       width: getHorizontalSize(1),
                        //                       thickness: getVerticalSize(1),
                        //                       color: ColorConstant.black900)))
                        //         ])),
                        // Container(
                        //     height: getVerticalSize(279),
                        //     width: getHorizontalSize(402),
                        //     margin: getMargin(top: 2),
                        //     child: Stack(alignment: Alignment.topLeft, children: [
                        //       Align(
                        //           alignment: Alignment.topLeft,
                        //           child: Padding(
                        //               padding: getPadding(top: 9),
                        //               child: Text("Flat No. House/Building",
                        //                   overflow: TextOverflow.ellipsis,
                        //                   textAlign: TextAlign.left,
                        //                   style: AppStyle
                        //                       .txtRobotoRegular8Gray50001))),
                        //       Align(
                        //           alignment: Alignment.topLeft,
                        //           child: Padding(
                        //               padding: getPadding(top: 49),
                        //               child: Text("Street Address/colony",
                        //                   overflow: TextOverflow.ellipsis,
                        //                   textAlign: TextAlign.left,
                        //                   style: AppStyle
                        //                       .txtRobotoRegular8Gray50001))),
                        //       Align(
                        //           alignment: Alignment.topLeft,
                        //           child: Padding(
                        //               padding: getPadding(top: 89),
                        //               child: Text("Landmark",
                        //                   overflow: TextOverflow.ellipsis,
                        //                   textAlign: TextAlign.left,
                        //                   style: AppStyle
                        //                       .txtRobotoRegular8Gray50001))),
                        //       Align(
                        //           alignment: Alignment.topLeft,
                        //           child: Padding(
                        //               padding: getPadding(top: 129),
                        //               child: Text("Pincode",
                        //                   overflow: TextOverflow.ellipsis,
                        //                   textAlign: TextAlign.left,
                        //                   style: AppStyle
                        //                       .txtRobotoRegular8Gray50001))),
                        //       Align(
                        //           alignment: Alignment.bottomLeft,
                        //           child: Padding(
                        //               padding: getPadding(bottom: 98),
                        //               child: Text("City",
                        //                   overflow: TextOverflow.ellipsis,
                        //                   textAlign: TextAlign.left,
                        //                   style: AppStyle
                        //                       .txtRobotoRegular8Gray50001))),
                        //       Align(
                        //           alignment: Alignment.bottomLeft,
                        //           child: Padding(
                        //               padding: getPadding(bottom: 57),
                        //               child: Text("State",
                        //                   overflow: TextOverflow.ellipsis,
                        //                   textAlign: TextAlign.left,
                        //                   style: AppStyle
                        //                       .txtRobotoRegular8Gray50001))),
                        //       Align(
                        //           alignment: Alignment.bottomLeft,
                        //           child: Padding(
                        //               padding: getPadding(left: 36, bottom: 20),
                        //               child: Text("Mobile Number",
                        //                   overflow: TextOverflow.ellipsis,
                        //                   textAlign: TextAlign.left,
                        //                   style: AppStyle
                        //                       .txtRobotoRegular8Gray50001))),
                        //       Align(
                        //           alignment: Alignment.topCenter,
                        //           child: Padding(
                        //               padding: getPadding(top: 80),
                        //               child: SizedBox(
                        //                   width: getHorizontalSize(402),
                        //                   child: Divider(
                        //                       height: getVerticalSize(1),
                        //                       thickness: getVerticalSize(1),
                        //                       color: ColorConstant.gray50001)))),
                        //       Align(
                        //           alignment: Alignment.topCenter,
                        //           child: Padding(
                        //               padding: getPadding(top: 120),
                        //               child: SizedBox(
                        //                   width: getHorizontalSize(402),
                        //                   child: Divider(
                        //                       height: getVerticalSize(1),
                        //                       thickness: getVerticalSize(1),
                        //                       color: ColorConstant.gray50001)))),
                        //       CustomTextFormField(
                        //           width: getHorizontalSize(402),
                        //           focusNode: FocusNode(),
                        //           controller: blocknoController,
                        //           hintText: "Block No. 541",
                        //           margin: getMargin(top: 21),
                        //           variant:
                        //               TextFormFieldVariant.UnderLineGray50001,
                        //           fontStyle: TextFormFieldFontStyle
                        //               .RobotoRegular12Black900,
                        //           alignment: Alignment.topCenter),
                        //       Align(
                        //           alignment: Alignment.topLeft,
                        //           child: Padding(
                        //               padding: getPadding(left: 1, top: 62),
                        //               child: Text("Sky Appartment, Near M.G Road",
                        //                   overflow: TextOverflow.ellipsis,
                        //                   textAlign: TextAlign.left,
                        //                   style: AppStyle.txtRobotoRegular12))),
                        //       Align(
                        //           alignment: Alignment.topLeft,
                        //           child: Padding(
                        //               padding: getPadding(left: 1, top: 102),
                        //               child: Text("Opp. Motivihar,",
                        //                   overflow: TextOverflow.ellipsis,
                        //                   textAlign: TextAlign.left,
                        //                   style: AppStyle.txtRobotoRegular12))),
                        //       CustomTextFormField(
                        //           width: getHorizontalSize(402),
                        //           focusNode: FocusNode(),
                        //           controller: zipcodeController,
                        //           hintText: "40002",
                        //           margin: getMargin(bottom: 119),
                        //           variant:
                        //               TextFormFieldVariant.UnderLineGray50001,
                        //           fontStyle: TextFormFieldFontStyle
                        //               .RobotoRegular12Black900,
                        //           alignment: Alignment.bottomCenter),
                        //       CustomTextFormField(
                        //           width: getHorizontalSize(402),
                        //           focusNode: FocusNode(),
                        //           controller: cityvalueController,
                        //           hintText: "Mumbai",
                        //           margin: getMargin(bottom: 78),
                        //           variant:
                        //               TextFormFieldVariant.UnderLineGray50001,
                        //           fontStyle: TextFormFieldFontStyle
                        //               .RobotoRegular12Black900,
                        //           alignment: Alignment.bottomCenter),
                        //       CustomTextFormField(
                        //           width: getHorizontalSize(402),
                        //           focusNode: FocusNode(),
                        //           controller: statevalueController,
                        //           hintText: "Maharatra",
                        //           margin: getMargin(bottom: 36),
                        //           variant:
                        //               TextFormFieldVariant.UnderLineGray50001,
                        //           fontStyle: TextFormFieldFontStyle
                        //               .RobotoRegular12Black900,
                        //           alignment: Alignment.bottomCenter),
                        //       // Row(children: [
                        //       //   Padding(
                        //       //       padding:
                        //       //           getPadding(left: 1, top: 260, bottom: 4),
                        //       //       child: CountryPickerUtils.getDefaultFlagImage(
                        //       //           country)),
                        //       //   Padding(
                        //       //       padding:
                        //       //           getPadding(left: 8, top: 259, bottom: 1),
                        //       //       child: CountryPickerUtils.getDefaultFlagImage(
                        //       //           country)),
                        //       //   Padding(
                        //       //       padding: getPadding(left: 6, top: 260),
                        //       //       child: CountryPickerUtils.getDefaultFlagImage(
                        //       //           country))
                        //       // ])
                        //     ])),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                                //height: getVerticalSize(75),
                                width: getHorizontalSize(400),
                                margin: getMargin(left: 25, top: 24),
                                child: Row(children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Address Type:",
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: AppStyle.txtRobotoRegular12,
                                    ),
                                    // CustomCheckbox(
                                    //     alignment: Alignment.centerLeft,
                                    //     text: "Address Type:",
                                    //     value: isCheckbox,
                                    //     fontStyle: CheckboxFontStyle
                                    //         .RobotoRegular12,
                                    //     onChange: (value) {
                                    //       isCheckbox = value;
                                    //     })
                                  ),
                                  // Align(
                                  //     alignment: Alignment.centerLeft,
                                  //     child: CustomCheckbox(
                                  //         alignment: Alignment.centerLeft,
                                  //         width: getHorizontalSize(177),
                                  //         text: "Address Type:",
                                  //         value: isCheckbox1,
                                  //         fontStyle: CheckboxFontStyle
                                  //             .RobotoRegular12,
                                  //         isRightCheck: true,
                                  //         onChange: (value) {
                                  //           isCheckbox1 = value;
                                  //         })),
                                  SimpleGroupedCheckbox(
                                    controller: controller,
                                    itemsTitle: [
                                      "Home",
                                      "Office",
                                    ],
                                    values: [1, 2, 4, 5],
                                    groupStyle: GroupStyle(
                                      activeColor: Colors.purple,
                                      itemTitleStyle: TextStyle(fontSize: 13),
                                      // labelStyle:
                                      // AppStyle.txtRobotoRegular12Black900,
                                      // onChange: (bool isChecked, String label,
                                      // int index) {
                                      // check1 = index;
                                      // print(check1);
                                      // print(
                                      // "isChecked: $isChecked   label: $label  index: $index");
                                    ),
                                    onItemSelected: (selected) {
                                      setState(() {
                                        if (selected.length > 1) {
                                          selected.removeAt(0);
                                          print(
                                              'selected length  ${selected.length}');
                                        } else {
                                          print("only one");
                                        }
                                        _checked = selected as List<String>;
                                      });
                                    },
                                  )
                                  // CheckboxGroup(
                                  //   orientation:
                                  //   GroupedButtonsOrientation.HORIZONTAL,
                                  //   margin: const EdgeInsets.only(left: 20.0),
                                  //   labels: <String>[
                                  //     "Home",
                                  //     "Office",
                                  //   ],
                                  //   // disabled: ["Wednesday", "Friday"],
                                  //   checked: _checked,
                                  //   activeColor: Colors.purple,
                                  //   // itemBuilder: (checkbox,label,int){
                                  //   //
                                  //   // },
                                  //   labelStyle:
                                  //   AppStyle.txtRobotoRegular12Black900,
                                  //   onChange: (bool isChecked, String label,
                                  //       int index) {
                                  //     check1 = index;
                                  //     print(check1);
                                  //     print(
                                  //         "isChecked: $isChecked   label: $label  index: $index");
                                  //   },
                                  //   onSelected: (List selected) =>
                                  //       setState(() {
                                  //         if (selected.length > 1) {
                                  //           selected.removeAt(0);
                                  //           print(
                                  //               'selected length  ${selected.length}');
                                  //         } else {
                                  //           print("only one");
                                  //         }
                                  //         _checked = selected as List<String>;
                                  //       }),
                                  // ),

                                  // Container(
                                  //   width:100,
                                  //   child:
                                  //   ListView.builder(
                                  //     scrollDirection: Axis.vertical,
                                  //     itemCount:checkListItems.length,
                                  //         itemBuilder: (context,index){
                                  //           return CheckboxListTile(
                                  //             controlAffinity: ListTileControlAffinity.leading,
                                  //             contentPadding: EdgeInsets.zero,
                                  //             dense: true,
                                  //             title: Text(
                                  //               checkListItems[index]["title"],
                                  //               style: const TextStyle(
                                  //                 fontSize: 16.0,
                                  //                 color: Colors.black,
                                  //               ),
                                  //             ),
                                  //             value: checkListItems[index]["value"],
                                  //             onChanged: (value) {
                                  //               setState(() {
                                  //                 for (var element in checkListItems) {
                                  //                   element["value"] = false;
                                  //                 }
                                  //                 checkListItems[index]["value"] = value;
                                  //                 selected =
                                  //                 "${checkListItems[index]["id"]}, ${checkListItems[index]["title"]}, ${checkListItems[index]["value"]}";
                                  //               });
                                  //             },
                                  //           );
                                  //         },),
                                  // ),

                                  // Container(
                                  //   padding: EdgeInsets.only(left: 20.w),
                                  //     alignment: Alignment.centerRight,
                                  //     child:Row(
                                  //       children: [
                                  //         Checkbox(
                                  //           activeColor: Colors.purple,
                                  //           value: isCheckbox,
                                  //           onChanged: (value) {
                                  //             setState(() {
                                  //               isCheckbox = value;
                                  //               check1=0;
                                  //               print(check1);
                                  //             });
                                  //           },
                                  //         ),
                                  //         Padding(
                                  //             padding: getPadding(left: 0, top: 2),
                                  //             child: Text(
                                  //                 "Home",
                                  //                 overflow: TextOverflow.ellipsis,
                                  //                 textAlign: TextAlign.left,
                                  //                 style: AppStyle.txtRobotoRegular12Black900))
                                  //       ],
                                  //     ),
                                  //     // CustomCheckbox(
                                  //     //     alignment:
                                  //     //         Alignment.centerRight,
                                  //     //     text: "Home",
                                  //     //     value: isCheckbox,
                                  //     //     margin: getMargin(right: 72),
                                  //     //     fontStyle: CheckboxFontStyle
                                  //     //         .RobotoRegular12,
                                  //     //     onChange: (value) {
                                  //     //       setState(() {
                                  //     //         isCheckbox = value;
                                  //     //         check1=1;
                                  //     //         print(check1);
                                  //     //       });
                                  //     //     })
                                  // ),
                                  // Container(
                                  //     padding: EdgeInsets.only(left: 43.w),
                                  //     alignment: Alignment.centerRight,
                                  //     child:  Row(
                                  //       children: [
                                  //         Checkbox(
                                  //           activeColor: Colors.purple,
                                  //           value: isCheckbox1,
                                  //           onChanged: (value) {
                                  //             setState(() {
                                  //               isCheckbox1 = value;
                                  //               check2=1;
                                  //               print(check2);
                                  //             });
                                  //           },
                                  //         ),
                                  //         Padding(
                                  //             padding: getPadding(left: 0, top: 2),
                                  //             child: Text(
                                  //                 "Office",
                                  //                 overflow: TextOverflow.ellipsis,
                                  //                 textAlign: TextAlign.left,
                                  //                 style: AppStyle.txtRobotoRegular12Black900))
                                  //       ],
                                  //     ),
                                  //     // CustomCheckbox(
                                  //     //     alignment:
                                  //     //         Alignment.centerLeft,
                                  //     //     text: "Office",
                                  //     //     value: isCheckbox1,
                                  //     //     fontStyle: CheckboxFontStyle
                                  //     //         .RobotoRegular12,
                                  //     //     onChange: (value) {
                                  //     //       setState(() {
                                  //     //         isCheckbox1 = value;
                                  //     //         check2=2;
                                  //     //         print(check2);
                                  //     //       });
                                  //     //     })
                                  // )
                                ]))),
                        // Container(
                        //     width: getHorizontalSize(400),
                        //     padding: getPadding(left: 1, top: 21),
                        //     child: Row(children: [
                        //       Text("Address Type:",
                        //           overflow: TextOverflow.ellipsis,
                        //           textAlign: TextAlign.left,
                        //           style: AppStyle.txtRobotoRegular12),
                        //       Container(
                        //         padding: EdgeInsets.only(left: 1.w),
                        //         alignment: Alignment.centerRight,
                        //         child:Row(
                        //           children: [
                        //             Checkbox(
                        //               activeColor: Colors.purple,
                        //               value: isCheckbox,
                        //               onChanged: (value) {
                        //                 setState(() {
                        //                   isCheckbox = value;
                        //                   check1=1;
                        //                   print(check1);
                        //                 });
                        //               },
                        //             ),
                        //             Padding(
                        //                 padding: getPadding(left: 0, top: 2),
                        //                 child: Text(
                        //                     "Home",
                        //                     overflow: TextOverflow.ellipsis,
                        //                     textAlign: TextAlign.left,
                        //                     style: AppStyle.txtRobotoRegular12Black900))
                        //           ],
                        //         ),
                        //         // CustomCheckbox(
                        //         //     alignment:
                        //         //         Alignment.centerRight,
                        //         //     text: "Home",
                        //         //     value: isCheckbox,
                        //         //     margin: getMargin(right: 72),
                        //         //     fontStyle: CheckboxFontStyle
                        //         //         .RobotoRegular12,
                        //         //     onChange: (value) {
                        //         //       setState(() {
                        //         //         isCheckbox = value;
                        //         //         check1=1;
                        //         //         print(check1);
                        //         //       });
                        //         //     })
                        //       ),
                        //       Container(
                        //         padding: EdgeInsets.only(left: 3.w),
                        //         alignment: Alignment.centerRight,
                        //         child:  Row(
                        //           children: [
                        //             Checkbox(
                        //               activeColor: Colors.purple,
                        //               value: isCheckbox1,
                        //               onChanged: (value) {
                        //                 setState(() {
                        //                   isCheckbox1 = value;
                        //                   check2=2;
                        //                   print(check2);
                        //                 });
                        //               },
                        //             ),
                        //             Padding(
                        //                 padding: getPadding(left: 0, top: 2),
                        //                 child: Text(
                        //                     "Office",
                        //                     overflow: TextOverflow.ellipsis,
                        //                     textAlign: TextAlign.left,
                        //                     style: AppStyle.txtRobotoRegular12Black900))
                        //           ],
                        //         ),
                        //         // CustomCheckbox(
                        //         //     alignment:
                        //         //         Alignment.centerLeft,
                        //         //     text: "Office",
                        //         //     value: isCheckbox1,
                        //         //     fontStyle: CheckboxFontStyle
                        //         //         .RobotoRegular12,
                        //         //     onChange: (value) {
                        //         //       setState(() {
                        //         //         isCheckbox1 = value;
                        //         //         check2=2;
                        //         //         print(check2);
                        //         //       });
                        //         //     })
                        //       ),
                        //       // Padding(
                        //       //     padding: getPadding(left: 5),
                        //       //     child: Text("Home",
                        //       //         overflow: TextOverflow.ellipsis,
                        //       //         textAlign: TextAlign.left,
                        //       //         style: AppStyle.txtRobotoRegular12)),
                        //       // CustomImageView(
                        //       //     svgPath: ImageConstant.imgComputer,
                        //       //     height: getSize(12),
                        //       //     width: getSize(12),
                        //       //     margin: getMargin(left: 22, top: 2, bottom: 1)),
                        //       // Padding(
                        //       //     padding: getPadding(left: 6),
                        //       //     child: Text("Office",
                        //       //         overflow: TextOverflow.ellipsis,
                        //       //         textAlign: TextAlign.left,
                        //       //         style: AppStyle.txtRobotoRegular12))
                        //     ])),
                        Padding(
                            padding: getPadding(
                                left: 1, top: 15, right: 2, bottom: 5),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomButton(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      height: getVerticalSize(36),
                                      width: getHorizontalSize(195),
                                      text: "CANCEL",
                                      variant: ButtonVariant.FillBluegray100,
                                      shape: ButtonShape.CustomBorderBL50,
                                      padding: ButtonPadding.PaddingAll9,
                                      fontStyle:
                                          ButtonFontStyle.RobotoMedium14),
                                  CustomButton(
                                      height: getVerticalSize(36),
                                      width: getHorizontalSize(196),
                                      variant: ButtonVariant.FillPurple900,
                                      text: "SAVE",
                                      padding: ButtonPadding.PaddingAll9,
                                      fontStyle: ButtonFontStyle.RobotoMedium14,
                                      onTap: () {
                                        FocusManager.instance.primaryFocus!
                                            .unfocus();
                                        if (_formKey.currentState!.validate()) {
                                          postRequest();
                                          Timer(Duration(seconds: 3), () {
                                            flatnumberController.clear();
                                            fullnameoneController.clear();
                                            pincodeController.clear();
                                            cityController.clear();
                                            stateController.clear();
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
                                        // onTapSave(context);
                                      })
                                ]))
                      ]),
                ))));
  }

  // onTapSave(BuildContext context) {
  onTapArrowleft2(BuildContext context) {
    Navigator.pop(context);
  }

  onTapSearch() {
    Get.toNamed(AppRoutes.searchScreen);
  }

  onTapWishlist() {
    Get.toNamed(AppRoutes.whislistScreen);
  }
}
