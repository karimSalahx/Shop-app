import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class RegisterEntity extends Equatable {
  final bool status;
  final String message;
  final RegisterData data;

  RegisterEntity({
    @required this.status,
    @required this.message,
    @required this.data,
  });

  @override
  List<Object> get props => [status, message, data];
}

@immutable
class RegisterData extends Equatable {
  final String name;
  final String phone;
  final String email;
  final int id;
  final String token;

  RegisterData({
    @required this.name,
    @required this.phone,
    @required this.email,
    @required this.id,
    @required this.token,
  });

  @override
  List<Object> get props => [name, phone, email, id, token];
}
