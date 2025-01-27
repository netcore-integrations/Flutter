class OffersModel {
  String? status;
  String? message;
  List<OffersData>? data;

  OffersModel({this.status, this.message, this.data});

  OffersModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <OffersData>[];
      json['data'].forEach((v) {
        data!.add(new OffersData.fromJson(v));
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

class OffersData {
  String? id;
  String? keywordsId;
  String? title;
  String? image;
  String? description;
  String? promoCode;
  String? coupanType;
  String? type;
  String? amount;
  String? minCart;
  String? startDate;
  String? endDate;
  String? status;
  String? metaTitle;
  String? metaDescription;
  String? createdAt;
  String? isDelete;

  OffersData(
      {this.id,
      this.keywordsId,
      this.title,
      this.image,
      this.description,
      this.promoCode,
      this.coupanType,
      this.type,
      this.amount,
      this.minCart,
      this.startDate,
      this.endDate,
      this.status,
      this.metaTitle,
      this.metaDescription,
      this.createdAt,
      this.isDelete});

  OffersData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    keywordsId = json['keywords_id'];
    title = json['title'];
    image = json['image'];
    description = json['description'];
    promoCode = json['promo_code'];
    coupanType = json['coupan_type'];
    type = json['type'];
    amount = json['amount'];
    minCart = json['min_cart'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    status = json['status'];
    metaTitle = json['meta_title'];
    metaDescription = json['meta_description'];
    createdAt = json['created_at'];
    isDelete = json['is_delete'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['keywords_id'] = this.keywordsId;
    data['title'] = this.title;
    data['image'] = this.image;
    data['description'] = this.description;
    data['promo_code'] = this.promoCode;
    data['coupan_type'] = this.coupanType;
    data['type'] = this.type;
    data['amount'] = this.amount;
    data['min_cart'] = this.minCart;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['status'] = this.status;
    data['meta_title'] = this.metaTitle;
    data['meta_description'] = this.metaDescription;
    data['created_at'] = this.createdAt;
    data['is_delete'] = this.isDelete;
    return data;
  }
}
