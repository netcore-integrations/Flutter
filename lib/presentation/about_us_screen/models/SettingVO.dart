class SettingVO {
  String? status;
  String? message;
  List<Setting>? data;

  SettingVO({this.status, this.message, this.data});

  SettingVO.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Setting>[];
      json['data'].forEach((v) {
        data!.add(new Setting.fromJson(v));
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

class Setting {
  String? id;
  String? name;
  String? settingsKeys;
  String? settingsValues;
  String? inputField;
  String? status;
  String? createdOn;
  var updatedOn;

  Setting(
      {this.id,
      this.name,
      this.settingsKeys,
      this.settingsValues,
      this.inputField,
      this.status,
      this.createdOn,
      this.updatedOn});

  Setting.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    settingsKeys = json['settings_keys'];
    settingsValues = json['settings_values'];
    inputField = json['input_field'];
    status = json['status'];
    createdOn = json['created_on'];
    updatedOn = json['updated_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['settings_keys'] = this.settingsKeys;
    data['settings_values'] = this.settingsValues;
    data['input_field'] = this.inputField;
    data['status'] = this.status;
    data['created_on'] = this.createdOn;
    data['updated_on'] = this.updatedOn;
    return data;
  }
}
