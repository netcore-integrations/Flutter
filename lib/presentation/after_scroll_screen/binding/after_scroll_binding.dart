import '../controller/after_scroll_controller.dart';
import 'package:get/get.dart';

class AfterScrollBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AfterScrollController());
  }
}
