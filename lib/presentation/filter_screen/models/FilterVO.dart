class FilterVO {
  String? status;
  String? message;
  Data? data;

  FilterVO({this.status, this.message, this.data});

  FilterVO.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Category>? category;
  List<SubCategorys>? subCategory;
  List<Keywords>? keywords;
  List<Brands>? brands;

  Data({this.category, this.subCategory, this.keywords, this.brands});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['category'] != null) {
      category = <Category>[];
      json['category'].forEach((v) {
        category!.add(new Category.fromJson(v));
      });
    }
    if (json['sub_category'] != null) {
      subCategory = <SubCategorys>[];
      json['sub_category'].forEach((v) {
        subCategory!.add(new SubCategorys.fromJson(v));
      });
    }
    if (json['keywords'] != null) {
      keywords = <Keywords>[];
      json['keywords'].forEach((v) {
        keywords!.add(new Keywords.fromJson(v));
      });
    }
    if (json['brands'] != null) {
      brands = <Brands>[];
      json['brands'].forEach((v) {
        brands!.add(new Brands.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.category != null) {
      data['category'] = this.category!.map((v) => v.toJson()).toList();
    }
    if (this.subCategory != null) {
      data['sub_category'] = this.subCategory!.map((v) => v.toJson()).toList();
    }
    if (this.keywords != null) {
      data['keywords'] = this.keywords!.map((v) => v.toJson()).toList();
    }
    if (this.brands != null) {
      data['brands'] = this.brands!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
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

  Category(
      {this.id,
      this.parentId,
      this.name,
      this.image,
      this.banner,
      this.metaTitle,
      this.metaDescription,
      this.isActive,
      this.isDelete,
      this.createOn,
      this.updateOn});

  Category.fromJson(Map<String, dynamic> json) {
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    data['name'] = this.name;
    data['image'] = this.image;
    data['banner'] = this.banner;
    data['meta_title'] = this.metaTitle;
    data['meta_description'] = this.metaDescription;
    data['is_active'] = this.isActive;
    data['is_delete'] = this.isDelete;
    data['create_on'] = this.createOn;
    data['update_on'] = this.updateOn;
    return data;
  }
}

class SubCategorys {
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

  SubCategorys(
      {this.id,
      this.parentId,
      this.name,
      this.image,
      this.banner,
      this.metaTitle,
      this.metaDescription,
      this.isActive,
      this.isDelete,
      this.createOn,
      this.updateOn});

  SubCategorys.fromJson(Map<String, dynamic> json) {
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    data['name'] = this.name;
    data['image'] = this.image;
    data['banner'] = this.banner;
    data['meta_title'] = this.metaTitle;
    data['meta_description'] = this.metaDescription;
    data['is_active'] = this.isActive;
    data['is_delete'] = this.isDelete;
    data['create_on'] = this.createOn;
    data['update_on'] = this.updateOn;
    return data;
  }
}

class Keywords {
  String? id;
  String? name;
  String? metaTitle;
  String? metaDescription;
  String? isActive;
  String? isDelete;
  String? createOn;
  var updateOn;

  Keywords(
      {this.id,
      this.name,
      this.metaTitle,
      this.metaDescription,
      this.isActive,
      this.isDelete,
      this.createOn,
      this.updateOn});

  Keywords.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    metaTitle = json['meta_title'];
    metaDescription = json['meta_description'];
    isActive = json['is_active'];
    isDelete = json['is_delete'];
    createOn = json['create_on'];
    updateOn = json['update_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['meta_title'] = this.metaTitle;
    data['meta_description'] = this.metaDescription;
    data['is_active'] = this.isActive;
    data['is_delete'] = this.isDelete;
    data['create_on'] = this.createOn;
    data['update_on'] = this.updateOn;
    return data;
  }
}

class Brands {
  String? id;
  String? name;
  String? image;
  String? metaTitle;
  String? metaDescription;
  String? isActive;
  String? isDelete;
  String? createOn;
  String? updateOn;

  Brands(
      {this.id,
      this.name,
      this.image,
      this.metaTitle,
      this.metaDescription,
      this.isActive,
      this.isDelete,
      this.createOn,
      this.updateOn});

  Brands.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    metaTitle = json['meta_title'];
    metaDescription = json['meta_description'];
    isActive = json['is_active'];
    isDelete = json['is_delete'];
    createOn = json['create_on'];
    updateOn = json['update_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['meta_title'] = this.metaTitle;
    data['meta_description'] = this.metaDescription;
    data['is_active'] = this.isActive;
    data['is_delete'] = this.isDelete;
    data['create_on'] = this.createOn;
    data['update_on'] = this.updateOn;
    return data;
  }
}
