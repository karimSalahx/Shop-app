import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

// We will need equatable so we pass the test because we need to compare
// instance of objects in test
@immutable
class LoginEntity extends Equatable {
  final bool status;
  final String message;
  final LoginData data;

  LoginEntity({
    @required this.status,
    @required this.message,
    @required this.data,
  });

  @override
  List<Object> get props => [status, message, data];
}

@immutable
class LoginData extends Equatable {
  final int id;
  final String name;
  final String email;
  final String phone;
  final int points;
  final int credit;
  final String token;

  LoginData({
    @required this.id,
    @required this.name,
    @required this.email,
    @required this.phone,
    @required this.points,
    @required this.credit,
    @required this.token,
  });

  @override
  List<Object> get props => [id, name, email, phone, points, credit, token];
}
