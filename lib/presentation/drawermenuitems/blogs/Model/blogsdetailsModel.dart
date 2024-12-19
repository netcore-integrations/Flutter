class BlogsDetailModel {
  String? status;
  String? message;
  List<BlogsDetailData>? data;

  BlogsDetailModel({this.status, this.message, this.data});

  BlogsDetailModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <BlogsDetailData>[];
      json['data'].forEach((v) {
        data!.add(new BlogsDetailData.fromJson(v));
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

class BlogsDetailData {
  String? id;
  String? name;
  String? image;
  String? description;
  String? metaTitle;
  String? metaDescription;
  String? isActive;
  String? isDelete;
  String? createOn;
  String? updateOn;

  BlogsDetailData(
      {this.id,
      this.name,
      this.image,
      this.description,
      this.metaTitle,
      this.metaDescription,
      this.isActive,
      this.isDelete,
      this.createOn,
      this.updateOn});

  BlogsDetailData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    description = json['description'];
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
    data['description'] = this.description;
    data['meta_title'] = this.metaTitle;
    data['meta_description'] = this.metaDescription;
    data['is_active'] = this.isActive;
    data['is_delete'] = this.isDelete;
    data['create_on'] = this.createOn;
    data['update_on'] = this.updateOn;
    return data;
  }
}
