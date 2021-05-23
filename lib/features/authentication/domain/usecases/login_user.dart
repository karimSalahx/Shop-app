import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../entity/login_model.dart';
import '../repository/authentication_repository.dart';
import '../../../../usecases.dart';

class LoginUser extends UseCases<LoginEntity, LoginParam> {
  AuthenticationRepository repository;
  LoginUser(this.repository);
  @override
  Future<Either<Failures, LoginEntity>> call(LoginParam params) async {
    return await repository.loginUser(
      email: params.email,
      password: params.password,
    );
  }
}

class LoginParam extends Equatable {
  final String email;
  final String password;
  LoginParam({this.email, this.password});
  @override
  List<Object> get props => [email, password];
}
