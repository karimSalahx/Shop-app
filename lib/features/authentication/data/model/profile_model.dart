import 'package:meta/meta.dart';
import '../../domain/entity/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  ProfileModel({
    @required bool status,
    @required String message,
    @required ProfileDataModel data,
  }) : super(status: status, data: data, message: message);

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        status: json["status"],
        message: json['message'],
        data: ProfileDataModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        'message': message,
        "data": (data as ProfileDataModel).toJson(),
      };
}

class ProfileDataModel extends ProfileDataEntity {
  ProfileDataModel({
    @required int id,
    @required String name,
    @required String email,
    @required String phone,
    @required String image,
    @required int points,
    @required int credit,
    @required String token,
  }) : super(
          credit: credit,
          email: email,
          id: id,
          image: image,
          name: name,
          phone: phone,
          points: points,
          token: token,
        );

  factory ProfileDataModel.fromJson(Map<String, dynamic> json) =>
      ProfileDataModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        image: json["image"],
        points: json["points"],
        credit: json["credit"],
        token: json["token"],
      );
  // return map with this as key and value
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "image": image,
        "points": points,
        "credit": credit,
        "token": token,
      };
}
