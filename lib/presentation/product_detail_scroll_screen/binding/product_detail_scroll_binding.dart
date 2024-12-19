import '../controller/product_detail_scroll_controller.dart';
import 'package:get/get.dart';

class ProductDetailScrollBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductDetailScrollController());
  }
}
