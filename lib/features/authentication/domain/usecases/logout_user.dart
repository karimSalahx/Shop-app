import '../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../entity/logout_entity.dart';
import '../repository/authentication_repository.dart';
import '../../../../usecases.dart';

class LogoutUser implements UseCases<LogoutEntity, NoParam> {
  AuthenticationRepository repository;
  LogoutUser(this.repository);
  @override
  Future<Either<Failures, LogoutEntity>> call(NoParam param) async {
    return await repository.logout();
  }
}
