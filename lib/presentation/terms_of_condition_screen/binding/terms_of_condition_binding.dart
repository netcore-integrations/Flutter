import '../controller/terms_of_condition_controller.dart';
import 'package:get/get.dart';

class TermsOfConditionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TermsOfConditionController());
  }
}
