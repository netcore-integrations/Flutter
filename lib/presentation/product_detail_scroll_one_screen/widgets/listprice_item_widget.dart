import '../controller/product_detail_scroll_one_controller.dart';
import '../models/listprice_item_model.dart';
import 'package:flutter/material.dart';
import 'package:keshav_s_application2/core/app_export.dart';

// ignore: must_be_immutable
class ListpriceItemWidget extends StatelessWidget {
  ListpriceItemWidget(this.listpriceItemModelObj);

  ListpriceItemModel listpriceItemModelObj;

  var controller = Get.find<ProductDetailScrollOneController>();

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Container(
        margin: getMargin(
          right: 10,
        ),
        padding: getPadding(
          left: 10,
          top: 4,
          right: 10,
          bottom: 4,
        ),
        decoration: AppDecoration.fillWhiteA700,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomImageView(
              imagePath: ImageConstant.imgImage5,
              height: getSize(
                101,
              ),
              width: getSize(
                101,
              ),
              margin: getMargin(
                top: 5,
              ),
            ),
            Padding(
              padding: getPadding(
                top: 5,
              ),
              child: Text(
                "msg_luxerious_dining".tr,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: AppStyle.txtRobotoMedium8Black900.copyWith(
                  letterSpacing: getHorizontalSize(
                    0.16,
                  ),
                ),
              ),
            ),
            Container(
              height: getVerticalSize(
                10,
              ),
              width: getHorizontalSize(
                63,
              ),
              margin: getMargin(
                top: 2,
              ),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "msg_starting_12_325".tr,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: AppStyle.txtRobotoRegular8Gray600.copyWith(
                        letterSpacing: getHorizontalSize(
                          0.16,
                        ),
                      ),
                    ),
                  ),
                  CustomImageView(
                    svgPath: ImageConstant.imgVectorGray600,
                    height: getVerticalSize(
                      7,
                    ),
                    width: getHorizontalSize(
                      5,
                    ),
                    alignment: Alignment.topRight,
                    margin: getMargin(
                      top: 1,
                      right: 26,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
