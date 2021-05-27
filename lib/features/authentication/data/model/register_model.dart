import 'package:flutter/cupertino.dart';
import '../../domain/entity/register_entity.dart';

class RegisterModel extends RegisterEntity {
  RegisterModel({
    @required bool status,
    @required String message,
    @required RegisterDataModel data,
  }) : super(data: data, status: status, message: message);
  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null
          ? RegisterDataModel.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = new Map<String, dynamic>();
    map['status'] = this.status;
    map['message'] = this.message;
    if (this.data != null) {
      map['data'] = (this.data as RegisterDataModel).toJson();
    }
    return map;
  }
}

class RegisterDataModel extends RegisterData {
  RegisterDataModel({
    @required String name,
    @required String phone,
    @required String email,
    @required int id,
    @required String token,
  }) : super(
          email: email,
          id: id,
          name: name,
          phone: phone,
          token: token,
        );
  factory RegisterDataModel.fromJson(Map<String, dynamic> json) {
    return RegisterDataModel(
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      id: json['id'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['id'] = this.id;
    data['token'] = this.token;
    return data;
  }
}
