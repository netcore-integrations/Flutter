import '../controller/cart_screen_controller.dart';
import 'package:get/get.dart';

class CartScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CartScreenController());
  }
}
