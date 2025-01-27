import 'package:get/get.dart';
import 'after_scroll1_item_model.dart';

class AfterScrollOneModel {
  RxList<AfterScroll1ItemModel> afterScroll1ItemList =
      RxList.generate(4, (index) => AfterScroll1ItemModel());
}
