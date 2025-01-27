import 'package:keshav_s_application2/core/app_export.dart';
import 'package:keshav_s_application2/presentation/sidebar_menu_draweritem/models/sidebar_menu_model.dart';

class SidebarMenuController extends GetxController {
  Rx<SidebarMenuModel> sidebarMenuModelObj = SidebarMenuModel().obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
