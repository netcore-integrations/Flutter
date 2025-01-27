import '../controller/filter_controller.dart';
import '../models/filter_item_model.dart';
import 'package:flutter/material.dart';
import 'package:keshav_s_application2/core/app_export.dart';

// ignore: must_be_immutable
class FilterItemWidget extends StatelessWidget {
  FilterItemWidget(this.filterItemModelObj);

  FilterItemModel filterItemModelObj;

  var controller = Get.find<FilterController>();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: getSize(
              9,
            ),
            width: getSize(
              9,
            ),
            margin: getMargin(
              top: 4,
              bottom: 3,
            ),
            decoration: BoxDecoration(
              color: ColorConstant.purple900,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(
                  getHorizontalSize(
                    21,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: getPadding(
              left: 15,
            ),
            child: Obx(
              () => Text(
                filterItemModelObj.typeTxt.value,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: AppStyle.txtRobotoRegular14,
              ),
            ),
          ),
          Spacer(),
          Padding(
            padding: getPadding(
              bottom: 6,
            ),
            child: Obx(
              () => Text(
                filterItemModelObj.zipcodeTxt.value,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: AppStyle.txtRobotoRegular8Gray500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
