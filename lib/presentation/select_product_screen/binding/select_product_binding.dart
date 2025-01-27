import '../controller/select_product_controller.dart';
import 'package:get/get.dart';

class SelectProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SelectProductController());
  }
}
