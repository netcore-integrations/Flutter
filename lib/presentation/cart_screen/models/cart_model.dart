class CartModel {
  String? status;
  String? message;
  int? count;
  int? total;
  List<CartData>? data;

  CartModel({this.status, this.message, this.count, this.total, this.data});

  CartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    count = json['count'];
    total = json['total'];
    if (json['data'] != null) {
      data = <CartData>[];
      json['data'].forEach((v) {
        data!.add(new CartData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['count'] = this.count;
    data['total'] = this.total;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CartData {
  String? id;
  String? userId;
  String? productId;
  String? name;
  String? code;
  String? qty;
  String? description;
  String? image;
  String? mrpPrice;
  String? salePrice;
  String? discountPrice;
  String? cityId;
  String? updateOn;
  ProductDetails? productDetails;

  CartData(
      {this.id,
      this.userId,
      this.productId,
      this.name,
      this.code,
      this.qty,
      this.description,
      this.image,
      this.mrpPrice,
      this.salePrice,
      this.discountPrice,
      this.cityId,
      this.updateOn,
      this.productDetails});

  CartData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    productId = json['product_id'];
    name = json['name'];
    code = json['code'];
    qty = json['qty'];
    description = json['description'];
    image = json['image'];
    mrpPrice = json['mrp_price'];
    salePrice = json['sale_price'];
    discountPrice = json['discount_price'];
    cityId = json['city_id'];
    updateOn = json['update_on'];
    productDetails = json['product_details'] != null
        ? new ProductDetails.fromJson(json['product_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['product_id'] = this.productId;
    data['name'] = this.name;
    data['code'] = this.code;
    data['qty'] = this.qty;
    data['description'] = this.description;
    data['image'] = this.image;
    data['mrp_price'] = this.mrpPrice;
    data['sale_price'] = this.salePrice;
    data['discount_price'] = this.discountPrice;
    data['city_id'] = this.cityId;
    data['update_on'] = this.updateOn;
    if (this.productDetails != null) {
      data['product_details'] = this.productDetails!.toJson();
    }
    return data;
  }
}

class ProductDetails {
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
  List<ProductImages>? productImages;
  List<Null>? attributes;

  ProductDetails(
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
      this.productImages,
      this.attributes});

  ProductDetails.fromJson(Map<String, dynamic> json) {
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
    if (json['product_images'] != null) {
      productImages = <ProductImages>[];
      json['product_images'].forEach((v) {
        productImages!.add(new ProductImages.fromJson(v));
      });
    }
    // if (json['attributes'] != null) {
    //   attributes = <Null>[];
    //   json['attributes'].forEach((v) {
    //     attributes.add(new Null.fromJson(v));
    //   });
    // }
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
    data['description'] = this.description;
    data['image'] = this.image;
    data['meta_title'] = this.metaTitle;
    data['meta_description'] = this.metaDescription;
    data['is_active'] = this.isActive;
    data['featured'] = this.featured;
    data['is_delete'] = this.isDelete;
    data['create_on'] = this.createOn;
    data['update_on'] = this.updateOn;
    data['category_name'] = this.categoryName;
    data['brand_name'] = this.brandName;
    data['is_wishlist'] = this.isWishlist;
    if (this.productImages != null) {
      data['product_images'] =
          this.productImages!.map((v) => v.toJson()).toList();
    }
    // if (this.attributes != null) {
    //   data['attributes'] = this.attributes.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class ProductImages {
  String? id;
  String? productId;
  String? images;

  ProductImages({this.id, this.productId, this.images});

  ProductImages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    images = json['images'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['images'] = this.images;
    return data;
  }
}

class Attributes {}
