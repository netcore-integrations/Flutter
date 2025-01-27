class CategorySubcategory {
  CategorySubcategory({
    this.status,
    this.message,
    this.data,
  });

  CategorySubcategory.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? status;
  String? message;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data!.toJson();
    }
    return map;
  }
}

class Data {
  Data({
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
    this.subCategory,
  });

  Data.fromJson(dynamic json) {
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
    if (json['sub_category'] != null) {
      subCategory = [];
      json['sub_category'].forEach((v) {
        subCategory!.add(SubCategory.fromJson(v));
      });
    }
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
  List<SubCategory>? subCategory;

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
    if (subCategory != null) {
      map['sub_category'] = subCategory!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class SubCategory {
  SubCategory({
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

  SubCategory.fromJson(dynamic json) {
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
  dynamic? updateOn;

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
