import 'package:meta/meta.dart';
import '../../domain/entity/login_entity.dart';

class LoginModel extends LoginEntity {
  LoginModel({
    @required bool status,
    @required String message,
    @required LoginDataModel data,
  }) : super(status: status, message: message, data: data);
  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null ? LoginDataModel.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = Map<String, dynamic>();
    map['status'] = this.status;
    map['message'] = this.message;
    if (this.data != null) {
      map['data'] = (this.data as LoginDataModel).toJson();
    }
    return map;
  }
}

class LoginDataModel extends LoginData {
  LoginDataModel({
    @required int id,
    @required String phone,
    @required String name,
    @required String email,
    @required int points,
    @required int credit,
    @required String token,
  }) : super(
          credit: credit,
          email: email,
          id: id,
          name: name,
          phone: phone,
          points: points,
          token: token,
        );
  factory LoginDataModel.fromJson(Map<String, dynamic> json) {
    return LoginDataModel(
      id: json['id'],
      phone: json['phone'],
      name: json['name'],
      email: json['email'],
      points: json['points'],
      credit: json['credit'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;

    data['points'] = this.points;
    data['credit'] = this.credit;
    data['token'] = this.token;
    return data;
  }
}
