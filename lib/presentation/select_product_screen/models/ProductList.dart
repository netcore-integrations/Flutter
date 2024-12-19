class ProductList {
  ProductList({
    this.status,
    this.message,
    this.data,
  });

  ProductList.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(ProductListData.fromJson(v));
      });
    }
  }
  String? status;
  String? message;
  List<ProductListData>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class ProductListData {
  ProductListData({
    this.id,
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
    this.description,
    this.image,
    this.metaTitle,
    this.metaDescription,
    this.isActive,
    this.featured,
    this.isDelete,
    this.createOn,
    this.updateOn,
    this.categoryName,
    this.brandName,
    this.isWishlist,
  });

  ProductListData.fromJson(dynamic json) {
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
    description = json['description'];
    image = json['image'];
    metaTitle = json['meta_title'];
    metaDescription = json['meta_description'];
    isActive = json['is_active'];
    featured = json['featured'];
    isDelete = json['is_delete'];
    createOn = json['create_on'];
    updateOn = json['update_on'];
    categoryName = json['category_name'];
    brandName = json['brand_name'];
    isWishlist = json['is_wishlist'];
  }
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
  String? description;
  String? image;
  String? metaTitle;
  String? metaDescription;
  String? isActive;
  String? featured;
  String? isDelete;
  String? createOn;
  String? updateOn;
  String? categoryName;
  String? brandName;
  String? isWishlist;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['code'] = code;
    map['category_id'] = categoryId;
    map['sub_category_id'] = subCategoryId;
    map['brand_id'] = brandId;
    map['keywords_id'] = keywordsId;
    map['city_id'] = cityId;
    map['mrp_price'] = mrpPrice;
    map['sale_price'] = salePrice;
    map['discount_price'] = discountPrice;
    map['description'] = description;
    map['image'] = image;
    map['meta_title'] = metaTitle;
    map['meta_description'] = metaDescription;
    map['is_active'] = isActive;
    map['featured'] = featured;
    map['is_delete'] = isDelete;
    map['create_on'] = createOn;
    map['update_on'] = updateOn;
    map['category_name'] = categoryName;
    map['brand_name'] = brandName;
    map['is_wishlist'] = isWishlist;
    return map;
  }
}
