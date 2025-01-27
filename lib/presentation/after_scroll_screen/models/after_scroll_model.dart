import 'package:get/get.dart';
import 'after_scroll_item_model.dart';

class AfterScrollModel {
  RxList<AfterScrollItemModel> afterScrollItemList =
      RxList.generate(4, (index) => AfterScrollItemModel());
}
