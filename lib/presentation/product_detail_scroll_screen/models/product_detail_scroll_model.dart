import 'package:get/get.dart';
import 'listprice1_item_model.dart';

class ProductDetailScrollModel {
  RxList<Listprice1ItemModel> listprice1ItemList =
      RxList.generate(4, (index) => Listprice1ItemModel());
}
