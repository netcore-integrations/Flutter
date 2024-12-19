import '../controller/select_product_one_controller.dart';
import 'package:get/get.dart';

class SelectProductOneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SelectProductOneController());
  }
}
