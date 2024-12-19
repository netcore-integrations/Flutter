import '../controller/order_placed_controller.dart';
import 'package:get/get.dart';

class OrderPlacedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrderPlacedController());
  }
}
