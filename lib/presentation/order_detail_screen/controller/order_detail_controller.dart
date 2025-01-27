import 'package:keshav_s_application2/core/app_export.dart';
import 'package:keshav_s_application2/presentation/order_detail_screen/models/order_detail_model.dart';

class OrderDetailController extends GetxController {
  Rx<OrderDetailModel> orderDetailModelObj = OrderDetailModel().obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
