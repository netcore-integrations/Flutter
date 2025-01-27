import '../controller/after_scroll_one_controller.dart';
import 'package:get/get.dart';

class AfterScrollOneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AfterScrollOneController());
  }
}
