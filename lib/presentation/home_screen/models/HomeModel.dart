class HomeModel {
  HomeModel({
    this.status,
    this.message,
    this.data,
    this.banners,
    this.bannersResPortrait,
    this.favouriteProduct,
    this.bannerswow,
    this.bannersgoodLooks,
    this.bannersBrothers,
    this.links,
  });

  HomeModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(HomeData.fromJson(v));
      });
    }
    if (json['banners'] != null) {
      banners = [];
      json['banners'].forEach((v) {
        banners!.add(Banners.fromJson(v));
      });
    }
    if (json['bannersResPortrait'] != null) {
      bannersResPortrait = [];
      json['bannersResPortrait'].forEach((v) {
        bannersResPortrait!.add(BannersResPortrait.fromJson(v));
      });
    }
    if (json['favourite_product'] != null) {
      favouriteProduct = [];
      json['favourite_product'].forEach((v) {
        favouriteProduct!.add(FavouriteProduct.fromJson(v));
      });
    }
    if (json['bannerswow'] != null) {
      bannerswow = [];
      json['bannerswow'].forEach((v) {
        bannerswow!.add(Bannerswow.fromJson(v));
      });
    }
    if (json['bannersgoodLooks'] != null) {
      bannersgoodLooks = [];
      json['bannersgoodLooks'].forEach((v) {
        bannersgoodLooks!.add(BannersgoodLooks.fromJson(v));
      });
    }
    if (json['bannersBrothers'] != null) {
      bannersBrothers = [];
      json['bannersBrothers'].forEach((v) {
        bannersBrothers!.add(BannersBrothers.fromJson(v));
      });
    }
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
  }
  String? status;
  String? message;
  List<HomeData>? data;
  List<Banners>? banners;
  List<BannersResPortrait>? bannersResPortrait;
  List<FavouriteProduct>? favouriteProduct;
  List<Bannerswow>? bannerswow;
  List<BannersgoodLooks>? bannersgoodLooks;
  List<BannersBrothers>? bannersBrothers;
  Links? links;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data!.map((v) => v.toJson()).toList();
    }
    if (banners != null) {
      map['banners'] = banners!.map((v) => v.toJson()).toList();
    }
    if (bannersResPortrait != null) {
      map['bannersResPortrait'] =
          bannersResPortrait!.map((v) => v.toJson()).toList();
    }
    if (favouriteProduct != null) {
      map['favourite_product'] =
          favouriteProduct!.map((v) => v.toJson()).toList();
    }
    if (bannerswow != null) {
      map['bannerswow'] = bannerswow!.map((v) => v.toJson()).toList();
    }
    if (bannersgoodLooks != null) {
      map['bannersgoodLooks'] =
          bannersgoodLooks!.map((v) => v.toJson()).toList();
    }
    if (bannersBrothers != null) {
      map['bannersBrothers'] = bannersBrothers!.map((v) => v.toJson()).toList();
    }
    if (links != null) {
      map['links'] = links!.toJson();
    }
    return map;
  }
}

class HomeData {
  HomeData({
    this.id,
    this.parentId,
    this.name,
    this.image,
    this.banner,
    this.metaTitle,
    this.metaDescription,
    this.isActive,
    this.isDelete,
    this.createOn,
    this.updateOn,
  });

  HomeData.fromJson(dynamic json) {
    id = json['id'];
    parentId = json['parent_id'];
    name = json['name'];
    image = json['image'];
    banner = json['banner'];
    metaTitle = json['meta_title'];
    metaDescription = json['meta_description'];
    isActive = json['is_active'];
    isDelete = json['is_delete'];
    createOn = json['create_on'];
    updateOn = json['update_on'];
  }
  String? id;
  String? parentId;
  String? name;
  String? image;
  String? banner;
  String? metaTitle;
  String? metaDescription;
  String? isActive;
  String? isDelete;
  String? createOn;
  String? updateOn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['parent_id'] = parentId;
    map['name'] = name;
    map['image'] = image;
    map['banner'] = banner;
    map['meta_title'] = metaTitle;
    map['meta_description'] = metaDescription;
    map['is_active'] = isActive;
    map['is_delete'] = isDelete;
    map['create_on'] = createOn;
    map['update_on'] = updateOn;
    return map;
  }
}

class BannersResPortrait {
  BannersResPortrait({
    this.id,
    this.type,
    this.name,
    this.image,
    this.keywordId,
    this.link,
    this.metaTitle,
    this.metaDescription,
    this.isActive,
    this.isDelete,
    this.createOn,
    this.updateOn,
  });

  BannersResPortrait.fromJson(dynamic json) {
    id = json['id'];
    type = json['type'];
    name = json['name'];
    image = json['image'];
    keywordId = json['keyword_id'];
    link = json['link'];
    metaTitle = json['meta_title'];
    metaDescription = json['meta_description'];
    isActive = json['is_active'];
    isDelete = json['is_delete'];
    createOn = json['create_on'];
    updateOn = json['update_on'];
  }
  String? id;
  String? type;
  String? name;
  String? image;
  String? keywordId;
  String? link;
  String? metaTitle;
  String? metaDescription;
  String? isActive;
  String? isDelete;
  String? createOn;
  String? updateOn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['type'] = type;
    map['name'] = name;
    map['image'] = image;
    map['keyword_id'] = keywordId;
    map['link'] = link;
    map['meta_title'] = metaTitle;
    map['meta_description'] = metaDescription;
    map['is_active'] = isActive;
    map['is_delete'] = isDelete;
    map['create_on'] = createOn;
    map['update_on'] = updateOn;
    return map;
  }
}

class Banners {
  Banners({
    this.id,
    this.type,
    this.name,
    this.image,
    this.keywordId,
    this.link,
    this.metaTitle,
    this.metaDescription,
    this.isActive,
    this.isDelete,
    this.createOn,
    this.updateOn,
  });

  Banners.fromJson(dynamic json) {
    id = json['id'];
    type = json['type'];
    name = json['name'];
    image = json['image'];
    keywordId = json['keyword_id'];
    link = json['link'];
    metaTitle = json['meta_title'];
    metaDescription = json['meta_description'];
    isActive = json['is_active'];
    isDelete = json['is_delete'];
    createOn = json['create_on'];
    updateOn = json['update_on'];
  }
  String? id;
  String? type;
  String? name;
  String? image;
  String? keywordId;
  String? link;
  String? metaTitle;
  String? metaDescription;
  String? isActive;
  String? isDelete;
  String? createOn;
  String? updateOn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['type'] = type;
    map['name'] = name;
    map['image'] = image;
    map['keyword_id'] = keywordId;
    map['link'] = link;
    map['meta_title'] = metaTitle;
    map['meta_description'] = metaDescription;
    map['is_active'] = isActive;
    map['is_delete'] = isDelete;
    map['create_on'] = createOn;
    map['update_on'] = updateOn;
    return map;
  }
}

class FavouriteProduct {
  FavouriteProduct({
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
  });

  FavouriteProduct.fromJson(dynamic json) {
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
    return map;
  }
}

class Bannerswow {
  Bannerswow({
    this.id,
    this.type,
    this.name,
    this.image,
    this.keywordId,
    this.link,
    this.metaTitle,
    this.metaDescription,
    this.isActive,
    this.isDelete,
    this.createOn,
    this.updateOn,
  });

  Bannerswow.fromJson(dynamic json) {
    id = json['id'];
    type = json['type'];
    name = json['name'];
    image = json['image'];
    keywordId = json['keyword_id'];
    link = json['link'];
    metaTitle = json['meta_title'];
    metaDescription = json['meta_description'];
    isActive = json['is_active'];
    isDelete = json['is_delete'];
    createOn = json['create_on'];
    updateOn = json['update_on'];
  }
  String? id;
  String? type;
  String? name;
  String? image;
  String? keywordId;
  String? link;
  String? metaTitle;
  String? metaDescription;
  String? isActive;
  String? isDelete;
  String? createOn;
  String? updateOn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['type'] = type;
    map['name'] = name;
    map['image'] = image;
    map['keyword_id'] = keywordId;
    map['link'] = link;
    map['meta_title'] = metaTitle;
    map['meta_description'] = metaDescription;
    map['is_active'] = isActive;
    map['is_delete'] = isDelete;
    map['create_on'] = createOn;
    map['update_on'] = updateOn;
    return map;
  }
}

class BannersgoodLooks {
  BannersgoodLooks({
    this.id,
    this.type,
    this.name,
    this.image,
    this.keywordId,
    this.link,
    this.metaTitle,
    this.metaDescription,
    this.isActive,
    this.isDelete,
    this.createOn,
    this.updateOn,
  });

  BannersgoodLooks.fromJson(dynamic json) {
    id = json['id'];
    type = json['type'];
    name = json['name'];
    image = json['image'];
    keywordId = json['keyword_id'];
    link = json['link'];
    metaTitle = json['meta_title'];
    metaDescription = json['meta_description'];
    isActive = json['is_active'];
    isDelete = json['is_delete'];
    createOn = json['create_on'];
    updateOn = json['update_on'];
  }
  String? id;
  String? type;
  String? name;
  String? image;
  String? keywordId;
  String? link;
  String? metaTitle;
  String? metaDescription;
  String? isActive;
  String? isDelete;
  String? createOn;
  String? updateOn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['type'] = type;
    map['name'] = name;
    map['image'] = image;
    map['keyword_id'] = keywordId;
    map['link'] = link;
    map['meta_title'] = metaTitle;
    map['meta_description'] = metaDescription;
    map['is_active'] = isActive;
    map['is_delete'] = isDelete;
    map['create_on'] = createOn;
    map['update_on'] = updateOn;
    return map;
  }
}

class BannersBrothers {
  BannersBrothers({
    this.id,
    this.type,
    this.name,
    this.image,
    this.keywordId,
    this.link,
    this.metaTitle,
    this.metaDescription,
    this.isActive,
    this.isDelete,
    this.createOn,
    this.updateOn,
  });

  BannersBrothers.fromJson(dynamic json) {
    id = json['id'];
    type = json['type'];
    name = json['name'];
    image = json['image'];
    keywordId = json['keyword_id'];
    link = json['link'];
    metaTitle = json['meta_title'];
    metaDescription = json['meta_description'];
    isActive = json['is_active'];
    isDelete = json['is_delete'];
    createOn = json['create_on'];
    updateOn = json['update_on'];
  }
  String? id;
  String? type;
  String? name;
  String? image;
  String? keywordId;
  String? link;
  String? metaTitle;
  String? metaDescription;
  String? isActive;
  String? isDelete;
  String? createOn;
  String? updateOn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['type'] = type;
    map['name'] = name;
    map['image'] = image;
    map['keyword_id'] = keywordId;
    map['link'] = link;
    map['meta_title'] = metaTitle;
    map['meta_description'] = metaDescription;
    map['is_active'] = isActive;
    map['is_delete'] = isDelete;
    map['create_on'] = createOn;
    map['update_on'] = updateOn;
    return map;
  }
}

class Links {
  Links({
    this.facebook,
    this.instagram,
    this.tweeter,
  });

  Links.fromJson(dynamic json) {
    facebook = json['facebook'];
    instagram = json['instagram'];
    tweeter = json['tweeter'];
  }
  String? facebook;
  String? instagram;
  String? tweeter;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['facebook'] = facebook;
    map['instagram'] = instagram;
    map['tweeter'] = tweeter;
    return map;
  }
}
