import 'package:keshav_s_application2/core/app_export.dart';
import 'package:keshav_s_application2/presentation/track_order_bottomsheet/models/track_order_model.dart';

class TrackOrderController extends GetxController {
  Rx<TrackOrderModel> trackOrderModelObj = TrackOrderModel().obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
