import '../controller/click_after_slect_tab_furniture_controller.dart';
import 'package:get/get.dart';

class ClickAfterSlectTabFurnitureBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ClickAfterSlectTabFurnitureController());
  }
}
