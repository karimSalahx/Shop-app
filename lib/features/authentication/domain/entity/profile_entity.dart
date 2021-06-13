import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class ProfileEntity extends Equatable {
  final bool status;
  final String message;
  final ProfileDataEntity data;

  ProfileEntity({
    @required this.status,
    @required this.data,
    @required this.message,
  });

  @override
  List<Object> get props => [this.status, this.data];
}

class ProfileDataEntity extends Equatable {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String image;
  final int points;
  final int credit;
  final String token;

  ProfileDataEntity({
    @required this.id,
    @required this.name,
    @required this.email,
    @required this.phone,
    @required this.image,
    @required this.points,
    @required this.credit,
    @required this.token,
  });

  @override
  List<Object> get props => [
        this.id,
        this.name,
        this.email,
        this.phone,
        this.image,
        this.points,
        this.credit,
        this.token,
      ];
}
