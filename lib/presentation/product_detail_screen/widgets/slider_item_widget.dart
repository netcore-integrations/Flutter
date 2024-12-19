import '../controller/product_detail_controller.dart';
import '../models/slider_item_model.dart';
import 'package:flutter/material.dart';
import 'package:keshav_s_application2/core/app_export.dart';

// ignore: must_be_immutable
class SliderItemWidget extends StatelessWidget {
  SliderItemWidget(this.sliderItemModelObj);

  SliderItemModel sliderItemModelObj;

  var controller = Get.find<ProductDetailController>();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: CustomImageView(
        imagePath: ImageConstant.imgImage14215x428,
        height: getVerticalSize(
          215,
        ),
        width: getHorizontalSize(
          428,
        ),
      ),
    );
  }
}
