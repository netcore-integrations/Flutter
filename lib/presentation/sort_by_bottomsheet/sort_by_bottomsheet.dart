import 'controller/sort_by_controller.dart';
import 'package:flutter/material.dart';
import 'package:keshav_s_application2/core/app_export.dart';

// ignore_for_file: must_be_immutable
class SortByBottomsheet extends StatefulWidget {
  // SortByBottomsheet(this.controller);
  //
  // SortByController controller;

  @override
  State<SortByBottomsheet> createState() => _SortByBottomsheetState();
}

class _SortByBottomsheetState extends State<SortByBottomsheet> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.maxFinite,
        child: Container(
          width: double.maxFinite,
          padding: getPadding(
            top: 16,
            bottom: 16,
          ),
          decoration: AppDecoration.fillWhiteA700,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: getPadding(
                  left: 14,
                ),
                child: Text(
                  "lbl_sort_by".tr,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: AppStyle.txtRobotoMedium18.copyWith(
                    letterSpacing: getHorizontalSize(
                      0.7,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: getPadding(
                  top: 13,
                ),
                child: Divider(
                  height: getVerticalSize(
                    1,
                  ),
                  thickness: getVerticalSize(
                    1,
                  ),
                ),
              ),
              // Padding(
              //   padding: getPadding(
              //     left: 14,
              //     top: 15,
              //   ),
              //   child: Row(
              //     children: [
              //       Container(
              //         height: getSize(
              //           9,
              //         ),
              //         width: getSize(
              //           9,
              //         ),
              //         margin: getMargin(
              //           top: 2,
              //           bottom: 3,
              //         ),
              //         // decoration: BoxDecoration(
              //         //   color: ColorConstant.purple900,
              //         //   borderRadius: BorderRadius.only(
              //         //     bottomRight: Radius.circular(
              //         //       getHorizontalSize(
              //         //         21,
              //         //       ),
              //         //     ),
              //         //   ),
              //         // ),
              //       ),
              //       Padding(
              //         padding: getPadding(
              //           left: 10,
              //         ),
              //         child: Text(
              //           "lbl_relevance".tr,
              //           overflow: TextOverflow.ellipsis,
              //           textAlign: TextAlign.left,
              //           style: AppStyle.txtRobotoBold12.copyWith(
              //             letterSpacing: getHorizontalSize(
              //               0.6,
              //             ),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context, "lbl_relevance".tr);
                },
                child: Padding(
                  padding: getPadding(
                    left: 33,
                    top: 20,
                  ),
                  child: Text(
                    "lbl_relevance".tr,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 14,
                        color: ColorConstant.black900,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context, "msg_highest_priced_first".tr);
                },
                child: Padding(
                  padding: getPadding(
                    left: 33,
                    top: 20,
                  ),
                  child: Text(
                    "msg_highest_priced_first".tr,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 14,
                        color: ColorConstant.black900,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context, "msg_lowest_priced_first".tr);
                },
                child: Padding(
                  padding: getPadding(
                    left: 33,
                    top: 17,
                  ),
                  child: Text(
                    "msg_lowest_priced_first".tr,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 14,
                        color: ColorConstant.black900,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context, "msg_fastest_shipping".tr);
                },
                child: Padding(
                  padding: getPadding(
                    left: 33,
                    top: 20,
                  ),
                  child: Text(
                    "msg_fastest_shipping".tr,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 14,
                        color: ColorConstant.black900,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context, "lbl_newest".tr);
                },
                child: Padding(
                  padding: getPadding(
                    left: 33,
                    top: 18,
                    bottom: 12,
                  ),
                  child: Text(
                    "lbl_newest".tr,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 14,
                        color: ColorConstant.black900,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
