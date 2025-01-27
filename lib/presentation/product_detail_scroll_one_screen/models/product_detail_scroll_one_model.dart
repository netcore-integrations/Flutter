import 'package:get/get.dart';
import 'listprice_item_model.dart';

class ProductDetailScrollOneModel {
  RxList<ListpriceItemModel> listpriceItemList =
      RxList.generate(4, (index) => ListpriceItemModel());
}
