class WishlistScreenModel {
  String? status;
  String? message;
  List<WishListData>? data;

  WishlistScreenModel({this.status, this.message, this.data});

  WishlistScreenModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <WishListData>[];
      json['data'].forEach((v) {
        data!.add(new WishListData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WishListData {
  String? id;
  String? userId;
  String? productId;
  ProductData? productData;

  WishListData({this.id, this.userId, this.productId, this.productData});

  WishListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    productId = json['product_id'];
    productData = json['product_data'] != null
        ? new ProductData.fromJson(json['product_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['product_id'] = this.productId;
    if (this.productData != null) {
      data['product_data'] = this.productData!.toJson();
    }
    return data;
  }
}

class ProductData {
  String? id;
  String? name;
  String? code;
  String? categoryId;
  String? subCategoryId;
  String? brandId;
  String? keywordsId;
  String? cityId;
  String? mrpPrice;
  String? salePrice;
  String? discountPrice;
  String? discountPer;
  String? description;
  String? image;
  String? sellerId;
  String? emiOption;
  String? monthWarrenty;
  String? easyReturn;
  String? safeDelivery;
  String? metaTitle;
  String? metaDescription;
  String? isActive;
  String? featured;
  String? isDelete;
  String? createOn;
  String? updateOn;

  ProductData(
      {this.id,
      this.name,
      this.code,
      this.categoryId,
      this.subCategoryId,
      this.brandId,
      this.keywordsId,
      this.cityId,
      this.mrpPrice,
      this.salePrice,
      this.discountPrice,
      this.discountPer,
      this.description,
      this.image,
      this.sellerId,
      this.emiOption,
      this.monthWarrenty,
      this.easyReturn,
      this.safeDelivery,
      this.metaTitle,
      this.metaDescription,
      this.isActive,
      this.featured,
      this.isDelete,
      this.createOn,
      this.updateOn});

  ProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    brandId = json['brand_id'];
    keywordsId = json['keywords_id'];
    cityId = json['city_id'];
    mrpPrice = json['mrp_price'];
    salePrice = json['sale_price'];
    discountPrice = json['discount_price'];
    discountPer = json['discount_per'];
    description = json['description'];
    image = json['image'];
    sellerId = json['seller_id'];
    emiOption = json['emi_option'];
    monthWarrenty = json['month_warrenty'];
    easyReturn = json['easy_return'];
    safeDelivery = json['safe_delivery'];
    metaTitle = json['meta_title'];
    metaDescription = json['meta_description'];
    isActive = json['is_active'];
    featured = json['featured'];
    isDelete = json['is_delete'];
    createOn = json['create_on'];
    updateOn = json['update_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    data['category_id'] = this.categoryId;
    data['sub_category_id'] = this.subCategoryId;
    data['brand_id'] = this.brandId;
    data['keywords_id'] = this.keywordsId;
    data['city_id'] = this.cityId;
    data['mrp_price'] = this.mrpPrice;
    data['sale_price'] = this.salePrice;
    data['discount_price'] = this.discountPrice;
    data['discount_per'] = this.discountPer;
    data['description'] = this.description;
    data['image'] = this.image;
    data['seller_id'] = this.sellerId;
    data['emi_option'] = this.emiOption;
    data['month_warrenty'] = this.monthWarrenty;
    data['easy_return'] = this.easyReturn;
    data['safe_delivery'] = this.safeDelivery;
    data['meta_title'] = this.metaTitle;
    data['meta_description'] = this.metaDescription;
    data['is_active'] = this.isActive;
    data['featured'] = this.featured;
    data['is_delete'] = this.isDelete;
    data['create_on'] = this.createOn;
    data['update_on'] = this.updateOn;
    return data;
  }
}
