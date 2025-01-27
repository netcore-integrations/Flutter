import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keshav_s_application2/core/app_export.dart';
import 'package:keshav_s_application2/presentation/filter_screen/models/FilterVO.dart';
import 'package:keshav_s_application2/widgets/app_bar/appbar_image.dart';
import 'package:keshav_s_application2/widgets/app_bar/custom_app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/utils/appConstant.dart';
import '../otp_screen/models/otp_model.dart';
import '../select_product_screen/productlistafterclickionbanner.dart';
import 'models/Item.dart';

class FilterScreen extends StatefulWidget {
  @override
  State<FilterScreen> createState() => _filterScreen();
}

class _filterScreen extends State<FilterScreen> {
  final List<Category> _listDataCategory = <Category>[];
  final List<SubCategorys> _listDataSubCategory = <SubCategorys>[];
  final List<Keywords> _listDataKeywords = <Keywords>[];
  final List<Brands> _listDataBrands = <Brands>[];
  FilterVO? filterVO;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _requestDataBlog();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: ColorConstant.whiteA700,
            appBar: CustomAppBar(
                height: getVerticalSize(60),
                leadingWidth: 27,
                title: Padding(
                    padding: getPadding(left: 10, top: 10, bottom: 15),
                    child: Text("lbl_filter".tr,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: AppStyle.txtRobotoRegular19)),
                actions: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        AppConstant.selectedIndex = 0;
                        AppConstant.selectedIndexCategory = -1;
                        AppConstant.selectedIndexCategoryId = '';

                        AppConstant.selectedIndexSubCategory = -1;
                        AppConstant.selectedIndexSubCategoryId = '';

                        AppConstant.selectedIndexKeyword = -1;
                        AppConstant.selectedIndexKeywordId = '';

                        AppConstant.selectedIndexBrand = -1;
                        AppConstant.selectedIndexBrandId = '';
                      });
                    },
                    child: Padding(
                        padding:
                            getPadding(left: 9, top: 20, right: 20, bottom: 19),
                        child: Text("lbl_clear".tr,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtRobotoRegular18Bluegray400)),
                  )
                ],
                styleType: Style.bgOutlineGray40003),
            bottomSheet: Container(
                margin: EdgeInsets.only(bottom: 20),
                width: double.maxFinite,
                decoration: AppDecoration.outlinePurple300,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          AppConstant.selectedIndex = 0;
                          AppConstant.selectedIndexCategory = -1;
                          AppConstant.selectedIndexCategoryId = '';

                          AppConstant.selectedIndexSubCategory = -1;
                          AppConstant.selectedIndexSubCategoryId = '';

                          AppConstant.selectedIndexKeyword = -1;
                          AppConstant.selectedIndexKeywordId = '';

                          AppConstant.selectedIndexBrand = -1;
                          AppConstant.selectedIndexBrandId = '';
                          // SharedPreferences prefs =
                          //     await SharedPreferences.getInstance();
                          // Map json1 = jsonDecode(prefs.getString('userData'));
                          // var user1 = OtpModel.fromJson(json1);
                          List<String> stringArray = [
                            '',
                            '',
                            '',
                            '',
                          ];
                          Navigator.pop(context, stringArray.toList());
                        },
                        child: Padding(
                            padding: getPadding(top: 17, bottom: 20),
                            child: Text("Clear All".toUpperCase(),
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: AppStyle.txtRobotoMedium19)),
                      ),
                      SizedBox(
                          height: getVerticalSize(61),
                          child: VerticalDivider(
                              width: getHorizontalSize(1),
                              thickness: getVerticalSize(1),
                              color: ColorConstant.purple300,
                              endIndent: getHorizontalSize(4))),
                      GestureDetector(
                        onTap: () async {
                          // SharedPreferences prefs =
                          //     await SharedPreferences.getInstance();
                          // Map json1 = jsonDecode(prefs.getString('userData'));
                          // var user1 = OtpModel.fromJson(json1);
                          List<String> stringArray = [
                            AppConstant.selectedIndexCategoryId,
                            AppConstant.selectedIndexSubCategoryId,
                            AppConstant.selectedIndexKeywordId,
                            AppConstant.selectedIndexBrandId
                          ];
                          Navigator.pop(context, stringArray.toList());
                          /*Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => productlisrafterclickonbanner(
                                user1.data,
                                AppConstant.selectedIndexKeywordId,
                                AppConstant.selectedIndexCategoryId,
                                AppConstant.selectedIndexSubCategoryId,
                                AppConstant.selectedIndexBrandId),
                          ));*/
                        },
                        child: Padding(
                            padding: getPadding(top: 16, bottom: 21),
                            child: Text("lbl_apply".tr,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: AppStyle.txtRobotoMedium19Purple900)),
                      )
                    ])),
            body: Container(
                //width: double.maxFinite,
                child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 100,
                  color: ColorConstant.gray200,
                  child: ListView.builder(
                      reverse: false,
                      scrollDirection: Axis.vertical,
                      itemCount: StaticData.items.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              AppConstant.selectedIndex = index;
                            });
                          },
                          child: Container(
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 10),
                                  child: Text(
                                    StaticData.items[index].name!,
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                        color:
                                            AppConstant.selectedIndex == index
                                                ? Color(0xffD04767)
                                                : Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
                AppConstant.selectedIndex == 0
                    ? Expanded(
                        child: Container(
                        margin: EdgeInsets.only(bottom: 70),
                        child: Padding(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: _listDataCategory.isNotEmpty
                                ? GridView.builder(
                                    physics: ScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            // Number of columns in the grid
                                            childAspectRatio: 2.3,
                                            // Desired aspect ratio (width:height) of each grid item
                                            crossAxisSpacing: 5),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return InkWell(
                                        onTap: () {
                                          setState(() {
                                            if (AppConstant
                                                    .selectedIndexCategory ==
                                                index) {
                                              AppConstant
                                                  .selectedIndexCategory = -1;
                                              AppConstant
                                                  .selectedIndexCategoryId = '';
                                              return;
                                            }
                                            AppConstant.selectedIndexCategory =
                                                index;
                                            AppConstant
                                                    .selectedIndexCategoryId =
                                                _listDataCategory[index].id!;
                                          });
                                        },
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 3),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Card(
                                                elevation: 2,
                                                shape: RoundedRectangleBorder(
                                                  side: BorderSide(
                                                    color: AppConstant
                                                                .selectedIndexCategory ==
                                                            index
                                                        ? Color(0xffD04767)
                                                        : Colors.white,
                                                    // Border color
                                                    width: 2.0, // Border width
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 5,
                                                      vertical: 10),
                                                  child: Text(
                                                    _listDataCategory[index]
                                                        .name!,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 10,
                                                        color: AppConstant
                                                                    .selectedIndexCategory ==
                                                                index
                                                            ? Color(0xffD04767)
                                                            : Colors.black),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    itemCount: _listDataCategory.length,
                                  )
                                : Container()),
                      ))
                    : Container(),
                AppConstant.selectedIndex == 1
                    ? Expanded(
                        child: Container(
                        margin: EdgeInsets.only(bottom: 70),
                        child: Padding(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: _listDataSubCategory.isNotEmpty
                                ? GridView.builder(
                                    physics: ScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            // Number of columns in the grid
                                            childAspectRatio: 2.3,
                                            // Desired aspect ratio (width:height) of each grid item
                                            crossAxisSpacing: 5),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return InkWell(
                                        onTap: () {
                                          setState(() {
                                            if (AppConstant
                                                    .selectedIndexSubCategory ==
                                                index) {
                                              AppConstant
                                                  .selectedIndexSubCategory = -1;
                                              AppConstant
                                                  .selectedIndexSubCategoryId = '';
                                              return;
                                            }
                                            AppConstant
                                                    .selectedIndexSubCategory =
                                                index;
                                            AppConstant
                                                    .selectedIndexSubCategoryId =
                                                _listDataSubCategory[index].id!;
                                          });
                                        },
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 3),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Card(
                                                elevation: 2,
                                                shape: RoundedRectangleBorder(
                                                  side: BorderSide(
                                                    color: AppConstant
                                                                .selectedIndexSubCategory ==
                                                            index
                                                        ? Color(0xffD04767)
                                                        : Colors.white,
                                                    // Border color
                                                    width: 2.0, // Border width
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 5,
                                                      vertical: 10),
                                                  child: Text(
                                                    _listDataSubCategory[index]
                                                        .name!,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 10,
                                                        color: AppConstant
                                                                    .selectedIndexSubCategory ==
                                                                index
                                                            ? Color(0xffD04767)
                                                            : Colors.black),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    itemCount: _listDataSubCategory.length,
                                  )
                                : Container()),
                      ))
                    : Container(),
                AppConstant.selectedIndex == 2
                    ? Expanded(
                        child: Container(
                        margin: EdgeInsets.only(bottom: 70),
                        child: Padding(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: _listDataKeywords.isNotEmpty
                                ? GridView.builder(
                                    physics: ScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            // Number of columns in the grid
                                            childAspectRatio: 2.3,
                                            // Desired aspect ratio (width:height) of each grid item
                                            crossAxisSpacing: 5),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return InkWell(
                                        onTap: () {
                                          setState(() {
                                            if (AppConstant
                                                    .selectedIndexKeyword ==
                                                index) {
                                              AppConstant.selectedIndexKeyword =
                                                  -1;
                                              AppConstant
                                                  .selectedIndexKeywordId = '';
                                              return;
                                            }
                                            AppConstant.selectedIndexKeyword =
                                                index;
                                            AppConstant.selectedIndexKeywordId =
                                                _listDataKeywords[index].id!;
                                          });
                                        },
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 3),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Card(
                                                elevation: 2,
                                                shape: RoundedRectangleBorder(
                                                  side: BorderSide(
                                                    color: AppConstant
                                                                .selectedIndexKeyword ==
                                                            index
                                                        ? Color(0xffD04767)
                                                        : Colors.white,
                                                    // Border color
                                                    width: 2.0, // Border width
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 5,
                                                      vertical: 10),
                                                  child: Text(
                                                    _listDataKeywords[index]
                                                        .name!,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 10,
                                                        color: AppConstant
                                                                    .selectedIndexKeyword ==
                                                                index
                                                            ? Color(0xffD04767)
                                                            : Colors.black),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    itemCount: _listDataKeywords.length,
                                  )
                                : Container()),
                      ))
                    : Container(),
                AppConstant.selectedIndex == 3
                    ? Expanded(
                        child: Container(
                        margin: EdgeInsets.only(bottom: 70),
                        child: Padding(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: _listDataBrands.isNotEmpty
                                ? GridView.builder(
                                    physics: ScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            // Number of columns in the grid
                                            childAspectRatio: 2.3,
                                            // Desired aspect ratio (width:height) of each grid item
                                            crossAxisSpacing: 5),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return InkWell(
                                        onTap: () {
                                          setState(() {
                                            if (AppConstant
                                                    .selectedIndexBrand ==
                                                index) {
                                              AppConstant.selectedIndexBrand =
                                                  -1;
                                              AppConstant.selectedIndexBrandId =
                                                  '';
                                              return;
                                            }
                                            AppConstant.selectedIndexBrand =
                                                index;
                                            AppConstant.selectedIndexBrandId =
                                                _listDataBrands[index].id!;
                                          });
                                        },
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 3),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Card(
                                                elevation: 2,
                                                shape: RoundedRectangleBorder(
                                                  side: BorderSide(
                                                    color: AppConstant
                                                                .selectedIndexBrand ==
                                                            index
                                                        ? Color(0xffD04767)
                                                        : Colors.white,
                                                    // Border color
                                                    width: 2.0, // Border width
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 5,
                                                      vertical: 10),
                                                  child: Text(
                                                    _listDataBrands[index]
                                                        .name!,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 10,
                                                        color: AppConstant
                                                                    .selectedIndexBrand ==
                                                                index
                                                            ? Color(0xffD04767)
                                                            : Colors.black),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    itemCount: _listDataBrands.length,
                                  )
                                : Container()),
                      ))
                    : Container(),
              ],
            ))));
  }

  apiCall() {
    BaseOptions options = new BaseOptions(
        baseUrl: 'https://fabfurni.com/api/Webservice/',
        connectTimeout: Duration(seconds: 60), // 60 seconds
        receiveTimeout: Duration(seconds: 60), // 60 seconds
        headers: {
          "Accept": "application/json",
          'content-type': 'application/json; charset=UTF-8',
        });
    final dioClient = Dio(options);
    return dioClient;
  }

  Future<void> _requestDataBlog() async {
    try {
      var response = await apiCall().get(
        'filterdata',
      );
      if (response.statusCode == 200) {
        filterVO = FilterVO.fromJson(jsonDecode(response.toString()));
        if (filterVO != null &&
            filterVO!.status! == 'true' &&
            filterVO!.data!.category!.isNotEmpty) {
          _listDataCategory.addAll(filterVO!.data!.category!);
          _listDataSubCategory.addAll(filterVO!.data!.subCategory!);
          _listDataKeywords.addAll(filterVO!.data!.keywords!);
          _listDataBrands.addAll(filterVO!.data!.brands!);
          setState(() {});
        } else {
          setState(() {});
        }
      } else {}
    } catch (e) {
      return null;
    }
  }

  onTapArrowleft18() {
    Get.back();
  }
}
