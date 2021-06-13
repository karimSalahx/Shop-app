import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import '../entity/profile_entity.dart';
import '../usecases/get_profile_user.dart';
import '../entity/logout_entity.dart';
import '../../../../core/error/failures.dart';
import '../entity/login_entity.dart';
import '../entity/register_entity.dart';
import '../usecases/register_user.dart';

abstract class AuthenticationRepository {
  Future<Either<Failures, LoginEntity>> loginUser({
    @required String email,
    @required String password,
  });

  Future<Either<Failures, RegisterEntity>> registerUser(
    RegisterParamModel registerParamModel,
  );

  Future<Either<Failures, LogoutEntity>> logout();

  Future<Either<Failures, ProfileEntity>> getUserProfile(TokenParam token);
}
