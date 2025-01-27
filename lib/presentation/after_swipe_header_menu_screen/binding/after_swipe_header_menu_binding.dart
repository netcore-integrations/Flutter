import '../controller/after_swipe_header_menu_controller.dart';
import 'package:get/get.dart';

class AfterSwipeHeaderMenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AfterSwipeHeaderMenuController());
  }
}
