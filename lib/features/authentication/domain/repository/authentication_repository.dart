import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import '../../../../core/error/failures.dart';
import '../entity/login_model.dart';
import '../entity/register_model.dart';
import '../usecases/register_user.dart';

abstract class AuthenticationRepository {
  Future<Either<Failures, LoginEntity>> loginUser({
    @required String email,
    @required String password,
  });

  Future<Either<Failures, RegisterEntity>> registerUser(
    RegisterParamModel registerParamModel,
  );

  Future<Either<Failures, void>> logout();
}
