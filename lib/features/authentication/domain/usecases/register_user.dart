import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import '../../../../core/error/failures.dart';
import '../entity/register_entity.dart';
import '../repository/authentication_repository.dart';
import '../../../../usecases.dart';

class RegisterUser extends UseCases<RegisterEntity, RegisterParamModel> {
  AuthenticationRepository authenticationRepository;
  RegisterUser(this.authenticationRepository);
  @override
  Future<Either<Failures, RegisterEntity>> call(
      RegisterParamModel params) async {
    return await authenticationRepository.registerUser(params);
  }
}

@immutable
class RegisterParamModel extends Equatable {
  final String name;
  final String phone;
  final String email;
  final String password;

  RegisterParamModel({
    @required this.name,
    @required this.phone,
    @required this.email,
    @required this.password,
  });

  @override
  String toString() => '$name , $phone, $email , $password';

  @override
  List<Object> get props => [this.name, this.phone, this.password, this.email];
}
