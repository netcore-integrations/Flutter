import '../controller/track_order_one_controller.dart';
import 'package:get/get.dart';

class TrackOrderOneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TrackOrderOneController());
  }
}
