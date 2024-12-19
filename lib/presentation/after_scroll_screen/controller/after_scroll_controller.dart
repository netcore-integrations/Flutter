import 'package:keshav_s_application2/core/app_export.dart';
import 'package:keshav_s_application2/presentation/after_scroll_screen/models/after_scroll_model.dart';

class AfterScrollController extends GetxController {
  Rx<AfterScrollModel> afterScrollModelObj = AfterScrollModel().obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
