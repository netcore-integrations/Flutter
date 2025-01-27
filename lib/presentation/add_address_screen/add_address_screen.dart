import 'dart:async';

// import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:keshav_s_application2/core/utils/utils.dart';
import 'package:keshav_s_application2/presentation/add_address_screen/models/add_address_model.dart';
import 'package:keshav_s_application2/presentation/otp_screen/models/otp_model.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

import 'package:sizer/sizer.dart';

import '../add_address_screen/widgets/add_address_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:keshav_s_application2/core/app_export.dart';
import 'package:keshav_s_application2/widgets/app_bar/appbar_image.dart';
import 'package:keshav_s_application2/widgets/app_bar/appbar_title.dart';
import 'package:keshav_s_application2/widgets/app_bar/custom_app_bar.dart';
import 'package:keshav_s_application2/widgets/custom_checkbox.dart';
import 'package:keshav_s_application2/widgets/custom_drop_down.dart';
import 'package:keshav_s_application2/widgets/custom_text_form_field.dart';

import 'dart:convert';

import 'package:dio/dio.dart' as dio;

import '../add_address_screen_click_on_manage_address_screen/add_address_screen_click_on_manage_address_screen.dart';

class AddAddressScreen extends StatefulWidget {
  Data data;
  AddAddressScreen(this.data);

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  TextEditingController fullnameController = TextEditingController();

  TextEditingController mobilenumberController = TextEditingController();

  TextEditingController pincodeController = TextEditingController();

  TextEditingController addressController = TextEditingController();

  TextEditingController cityController = TextEditingController();

  TextEditingController stateController = TextEditingController();

  TextEditingController countryController = TextEditingController();
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  // List<String> dropdownItemList = ["Item One", "Item Two", "Item Three"];
  bool isCheckbox = false;

  bool isCheckbox1 = false;

  bool isCheckbox2 = false;

  bool isCheckbox3 = false;
  int? check1;
  int? check2;
  String selected = "";
  List<String> _checked = [];
  GroupController controller = GroupController();
  List checkListItems = [
    {
      "id": 0,
      "value": false,
      "title": "Home",
    },
    {
      "id": 1,
      "value": false,
      "title": "Office",
    },
  ];

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isPhone(String input) =>
      RegExp(r'^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$')
          .hasMatch(input);

  Future<AddressAdd> postRequest() async {
    var url = 'https://fabfurni.com/api/Auth/addressAdd';
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
      "name": fullnameController.text,
      "mobile_number": mobilenumberController.text,
      "address_one": addressController.text,
      "address_two": "",
      "city": cityController.text,
      "state": stateController.text,
      "country": countryController.text,
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
      if (AddressAdd.fromJson(jsonObject).status == "true") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(bottom: 20.0),
          duration: Duration(seconds: 2),
          content: Text(
            "Address Added Successfully",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.greenAccent,
        ));
        Navigator.of(context).pop();
        // Navigator.push(context,MaterialPageRoute(
        //   builder: (context) => AddAddressScreenClickOnManageAddressScreen(widget.data),
        // ));
        // Navigator.of(context).pushReplacement(MaterialPageRoute(
        //   builder: (context) => LogInScreen(),
        // ));
      } else if (AddressAdd.fromJson(jsonObject).status == "false") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(bottom: 20.0),
            content: Text(AddressAdd.fromJson(jsonObject).message!),
            backgroundColor: Colors.redAccent));
        // setState(() {
        //   _btnController.error();
        // });
      } else if (AddressAdd.fromJson(jsonObject).data == null) {
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
      print(AddressAdd.fromJson(jsonObject).toString());
      return AddressAdd.fromJson(
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
                    text: "ADD NEW ADDRESS",
                    margin: getMargin(left: 19, top: 49, bottom: 42)),
                // AppbarImage(
                //     height: getVerticalSize(32),
                //     width: getHorizontalSize(106),
                //     imagePath: ImageConstant.imgFinallogo03,
                //     margin: getMargin(left: 13, top: 44, bottom: 15)),
                styleType: Style.bgShadowBlack90033),
            body: SingleChildScrollView(
              child: Form(
                  key: _formKey,
                  child: Container(
                    padding: EdgeInsets.only(top: 40),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomTextFormField(
                            focusNode: FocusNode(),
                            controller: fullnameController,
                            hintText: "Full Name",
                            margin: getMargin(left: 25, right: 28),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter name';
                              }
                              return null;
                            },
                          ),
                          CustomTextFormField(
                            focusNode: FocusNode(),
                            controller: mobilenumberController,
                            hintText: "Mobile Number",
                            margin: getMargin(left: 25, top: 23, right: 28),
                            textInputType: TextInputType.phone,
                            maxLength: 10,
                            validator: (value) {
                              if (value!.isEmpty &&
                                  !isPhone(value) &&
                                  value.length != 10) {
                                return 'Please enter the 10 digit phone number';
                              }
                              return null;
                            },
                          ),
                          CustomTextFormField(
                            focusNode: FocusNode(),
                            controller: pincodeController,
                            hintText: "Pincode",
                            margin: getMargin(left: 25, top: 5, right: 28),
                            maxLength: 6,
                            textInputType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty && value.length != 6) {
                                return 'Please enter valid pincode';
                              }
                              return null;
                            },
                          ),
                          CustomTextFormField(
                            focusNode: FocusNode(),
                            controller: addressController,
                            hintText: "Address & Landmark",
                            margin: getMargin(left: 25, top: 8, right: 28),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter the address';
                              }
                              return null;
                            },
                          ),
                          CustomTextFormField(
                            focusNode: FocusNode(),
                            controller: cityController,
                            hintText: "City",
                            margin: getMargin(left: 25, top: 24, right: 28),
                            textInputAction: TextInputAction.done,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter the city';
                              }
                              return null;
                            },
                          ),
                          CustomTextFormField(
                            focusNode: FocusNode(),
                            controller: stateController,
                            hintText: "State",
                            margin: getMargin(left: 25, top: 24, right: 28),
                            textInputAction: TextInputAction.done,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter the state';
                              }
                              return null;
                            },
                          ),
                          CustomTextFormField(
                            focusNode: FocusNode(),
                            controller: countryController,
                            hintText: "Country",
                            margin: getMargin(left: 25, top: 24, right: 28),
                            textInputAction: TextInputAction.done,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter the country';
                              }
                              return null;
                            },
                          ),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                  // height: getVerticalSize(75),
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
                                    //       GroupedButtonsOrientation.HORIZONTAL,
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
                                    //       AppStyle.txtRobotoRegular12Black900,
                                    //   onChange: (bool isChecked, String label,
                                    //       int index) {
                                    //     check1 = index;
                                    //     print(check1);
                                    //     print(
                                    //         "isChecked: $isChecked   label: $label  index: $index");
                                    //   },
                                    //   onSelected: (List selected) =>
                                    //       setState(() {
                                    //     if (selected.length > 1) {
                                    //       selected.removeAt(0);
                                    //       print(
                                    //           'selected length  ${selected.length}');
                                    //     } else {
                                    //       print("only one");
                                    //     }
                                    //     _checked = selected as List<String>;
                                    //   }),
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
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                  padding: getPadding(left: 10, top: 20),
                                  child: Row(children: [
                                    Container(
                                        // padding: getPadding(all: 3),
                                        // decoration:
                                        //     AppDecoration.outlinePurple900,
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                          Checkbox(
                                            activeColor: Colors.purple,
                                            value: isCheckbox2,
                                            onChanged: (value) {
                                              setState(() {
                                                isCheckbox2 = value!;
                                              });
                                            },
                                          ),
                                          // Container(
                                          //     height: getSize(8),
                                          //     width: getSize(8),
                                          //     decoration: BoxDecoration(
                                          //         color: ColorConstant
                                          //             .purple900,
                                          //         border: Border.all(
                                          //             color: ColorConstant
                                          //                 .purple900,
                                          //             width:
                                          //                 getHorizontalSize(
                                          //                     1))))
                                        ])),
                                    Padding(
                                        padding: getPadding(left: 0, top: 2),
                                        child: Text(
                                            "Billing Address Is The Same As Shipping Address",
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: AppStyle
                                                .txtRobotoRegular12Black900))
                                  ]))),
                          // Padding(
                          //     padding: getPadding(left: 25, top: 24, right: 25),
                          //     child: ListView.separated(
                          //         physics: NeverScrollableScrollPhysics(),
                          //         shrinkWrap: true,
                          //         separatorBuilder: (context, index) {
                          //           return SizedBox(
                          //               height: getVerticalSize(25));
                          //         },
                          //         itemCount: 2,
                          //         itemBuilder: (context, index) {
                          //           return AddAddressItemWidget(
                          //               onTapStackedit: () {
                          //             // onTapStackedit(context);
                          //           });
                          //         })),
                          Container(
                              width: double.maxFinite,
                              height: 39.h,
                              // color: Colors.black,
                              child: GestureDetector(
                                onTap: () {
                                  FocusManager.instance.primaryFocus!.unfocus();
                                  if (_formKey.currentState!.validate()) {
                                    postRequest();
                                    Timer(Duration(seconds: 3), () {
                                      mobilenumberController.clear();
                                      fullnameController.clear();
                                      pincodeController.clear();
                                      addressController.clear();
                                      cityController.clear();
                                      stateController.clear();
                                      countryController.clear();
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
                                },
                                child: Container(
                                    margin: getMargin(top: 37.h),
                                    padding: getPadding(
                                        left: 128,
                                        top: 20,
                                        right: 128,
                                        bottom: 20),
                                    decoration: AppDecoration.fillPurple900
                                        .copyWith(
                                            borderRadius: BorderRadiusStyle
                                                .customBorderLR60),
                                    child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                              padding: getPadding(top: 0),
                                              child: Text("SAVE AND CONTINUE",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: AppStyle
                                                      .txtRobotoMedium16
                                                      .copyWith(
                                                          letterSpacing:
                                                              getHorizontalSize(
                                                                  0.8))))
                                        ])),
                              )),
                          // Padding(
                          //     padding: getPadding(top: 17),
                          //     child: Divider(
                          //         height: getVerticalSize(5),
                          //         thickness: getVerticalSize(5),
                          //         color: ColorConstant.purple50))
                        ]),
                  )),
            )));
  }

  // onTapStackedit(BuildContext context) {
  onTapArrowleft(BuildContext context) {
    Navigator.pop(context);
  }
}
