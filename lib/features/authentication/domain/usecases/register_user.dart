import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import '../../../../core/error/failures.dart';
import '../entity/register_model.dart';
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

class RegisterParamModel {
  String name;
  String phone;
  String email;
  String password;

  RegisterParamModel({
    @required this.name,
    @required this.phone,
    @required this.email,
    @required this.password,
  });
}
