class AddressList {
  String? status;
  String? message;
  List<AddressData>? data;

  AddressList({this.status, this.message, this.data});

  AddressList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <AddressData>[];
      json['data'].forEach((v) {
        data!.add(new AddressData.fromJson(v));
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

class AddressData {
  String? id;
  String? userId;
  String? name;
  String? addressOne;
  String? addressTwo;
  String? city;
  String? state;
  String? country;
  String? pincode;
  String? isActive;
  String? defaulted;
  String? isDelete;
  String? createOn;
  Null updateOn;

  AddressData(
      {this.id,
      this.userId,
      this.name,
      this.addressOne,
      this.addressTwo,
      this.city,
      this.state,
      this.country,
      this.pincode,
      this.isActive,
      this.defaulted,
      this.isDelete,
      this.createOn,
      this.updateOn});

  AddressData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    addressOne = json['address_one'];
    addressTwo = json['address_two'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    pincode = json['pincode'];
    isActive = json['is_active'];
    defaulted = json['default'];
    isDelete = json['is_delete'];
    createOn = json['create_on'];
    updateOn = json['update_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['address_one'] = this.addressOne;
    data['address_two'] = this.addressTwo;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['pincode'] = this.pincode;
    data['is_active'] = this.isActive;
    data['default'] = this.defaulted;
    data['is_delete'] = this.isDelete;
    data['create_on'] = this.createOn;
    data['update_on'] = this.updateOn;
    return data;
  }
}
