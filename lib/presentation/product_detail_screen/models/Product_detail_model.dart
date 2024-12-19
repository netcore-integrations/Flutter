class ProductDetailModel {
  ProductDetailModel({
    this.status,
    this.message,
    this.data,
    this.similarProduct,
    this.brandProduct,
  });

  ProductDetailModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    if (json['similar_product'] != null) {
      similarProduct = [];
      json['similar_product'].forEach((v) {
        similarProduct?.add(SimilarProduct.fromJson(v));
      });
    }
    if (json['brand_product'] != null) {
      brandProduct = [];
      json['brand_product'].forEach((v) {
        brandProduct!.add(BrandProduct.fromJson(v));
      });
    }
  }
  String? status;
  String? message;
  Data? data;
  List<SimilarProduct>? similarProduct;
  List<BrandProduct>? brandProduct;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data!.toJson();
    }
    if (similarProduct != null) {
      map['similar_product'] = similarProduct!.map((v) => v.toJson()).toList();
    }
    if (brandProduct != null) {
      map['brand_product'] = brandProduct!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Data {
  Data({
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
    this.updateOn,
    this.additionalInformation,
    this.customerRedressal,
    this.marchantInfo,
    this.returnCancellation,
    this.warentyInstallation,
    this.categoryName,
    this.brandName,
    this.isWishlist,
    this.productImages,
    this.attributes,
  });

  Data.fromJson(dynamic json) {
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
    additionalInformation = json['additional_information'];
    customerRedressal = json['customer_redressal'];
    marchantInfo = json['marchant_info'];
    returnCancellation = json['return_cancellation'];
    warentyInstallation = json['warenty_installation'];
    categoryName = json['category_name'];
    brandName = json['brand_name'];
    isWishlist = json['is_wishlist'];
    if (json['product_images'] != null) {
      productImages = [];
      json['product_images'].forEach((v) {
        productImages!.add(ProductImages.fromJson(v));
      });
    }
    if (json['attributes'] != null) {
      attributes = [];
      json['attributes'].forEach((v) {
        attributes!.add(Attributes.fromJson(v));
      });
    }
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
  String? additionalInformation;
  String? customerRedressal;
  String? marchantInfo;
  String? returnCancellation;
  String? warentyInstallation;
  String? categoryName;
  String? brandName;
  String? isWishlist;
  List<ProductImages>? productImages;
  List<Attributes>? attributes;

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
    map['discount_per'] = discountPer;
    map['description'] = description;
    map['image'] = image;
    map['seller_id'] = sellerId;
    map['emi_option'] = emiOption;
    map['month_warrenty'] = monthWarrenty;
    map['easy_return'] = easyReturn;
    map['safe_delivery'] = safeDelivery;
    map['meta_title'] = metaTitle;
    map['meta_description'] = metaDescription;
    map['is_active'] = isActive;
    map['featured'] = featured;
    map['is_delete'] = isDelete;
    map['create_on'] = createOn;
    map['update_on'] = updateOn;
    map['additional_information'] = additionalInformation;
    map['customer_redressal'] = customerRedressal;
    map['marchant_info'] = marchantInfo;
    map['return_cancellation'] = returnCancellation;
    map['warenty_installation'] = warentyInstallation;
    map['category_name'] = categoryName;
    map['brand_name'] = brandName;
    map['is_wishlist'] = isWishlist;
    if (productImages != null) {
      map['product_images'] = productImages!.map((v) => v.toJson()).toList();
    }
    if (attributes != null) {
      map['attributes'] = attributes!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class ProductImages {
  ProductImages({
    this.id,
    this.productId,
    this.images,
  });

  ProductImages.fromJson(dynamic json) {
    id = json['id'];
    productId = json['product_id'];
    images = json['images'];
  }
  String? id;
  String? productId;
  String? images;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['product_id'] = productId;
    map['images'] = images;
    return map;
  }
}

class SimilarProduct {
  SimilarProduct({
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

  SimilarProduct.fromJson(dynamic json) {
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

class BrandProduct {
  BrandProduct({
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

  BrandProduct.fromJson(dynamic json) {
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

class Attributes {
  String? id;
  String? productId;
  String? productKey;
  String? productValue;

  Attributes({this.id, this.productId, this.productKey, this.productValue});

  Attributes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    productKey = json['product_key'];
    productValue = json['product_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['product_key'] = this.productKey;
    data['product_value'] = this.productValue;
    return data;
  }
}
