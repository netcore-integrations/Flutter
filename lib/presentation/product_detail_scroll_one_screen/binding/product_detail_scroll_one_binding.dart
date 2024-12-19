import '../controller/product_detail_scroll_one_controller.dart';
import 'package:get/get.dart';

class ProductDetailScrollOneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductDetailScrollOneController());
  }
}
