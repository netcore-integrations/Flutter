import 'package:keshav_s_application2/core/app_export.dart';
import 'package:keshav_s_application2/presentation/product_detail_scroll_screen/models/product_detail_scroll_model.dart';

class ProductDetailScrollController extends GetxController {
  Rx<ProductDetailScrollModel> productDetailScrollModelObj =
      ProductDetailScrollModel().obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
