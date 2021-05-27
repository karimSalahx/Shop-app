import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../entity/logout_entity.dart';
import '../repository/authentication_repository.dart';
import '../../../../usecases.dart';

class LogoutUser implements UseCases<LogoutEntity, LogoutParam> {
  AuthenticationRepository repository;
  LogoutUser(this.repository);
  @override
  Future<Either<Failures, LogoutEntity>> call(LogoutParam params) async {
    return await repository.logout(params.token);
  }
}

class LogoutParam extends Equatable {
  final String token;
  LogoutParam(this.token);

  @override
  List<Object> get props => [this.token];
}
