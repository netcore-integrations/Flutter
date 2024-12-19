import '../controller/click_gstin_controller.dart';
import 'package:get/get.dart';

class ClickGstinBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ClickGstinController());
  }
}
