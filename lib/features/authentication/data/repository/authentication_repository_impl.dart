import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:tdd_test/features/authentication/data/datasources/authentication_get_profile_user.dart';
import '../../domain/usecases/get_profile_user.dart';
import '../../domain/entity/profile_entity.dart';
import '../datasources/authentication_logout_user.dart';
import '../model/logout_model.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/server_exception.dart';
import '../../domain/repository/authentication_repository.dart';
import '../../domain/usecases/register_user.dart';
import '../datasources/authentication_login_user.dart';
import '../datasources/authentication_register_user.dart';
import '../model/login_model.dart';
import '../model/register_model.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationLoginUser authenticationLoginUser;
  final AuthenticationRegisterUser authenticationRegisterUser;
  final AuthenticationLogoutUser authenticationLogoutUser;
  final AuthenticationGetProfileUser authenticationGetProfileUser;

  AuthenticationRepositoryImpl({
    @required this.authenticationLoginUser,
    @required this.authenticationRegisterUser,
    @required this.authenticationLogoutUser,
    @required this.authenticationGetProfileUser,
  });

  @override
  Future<Either<Failures, LoginModel>> loginUser({
    @required String email,
    @required String password,
  }) async {
    try {
      final LoginModel _userModel = await authenticationLoginUser.loginUser(
        email: email,
        password: password,
      );
      if (_userModel.data != null) {
        await authenticationLoginUser.cacheToken(_userModel.data.token);
      }
      return Right(_userModel);
    } on ServerException {
      return Left(ServerFailure());
    } on CacheException {
      return Left(CacheFailure());
    } on CredentialException catch (e) {
      return Left(CredentialsFailure(e.message));
    }
  }

  @override
  Future<Either<Failures, RegisterModel>> registerUser(
    RegisterParamModel registerParamModel,
  ) async {
    try {
      final RegisterModel _userRegisterModel =
          await authenticationRegisterUser.registerUser(registerParamModel);
      return Right(_userRegisterModel);
    } on ServerException {
      return Left(ServerFailure());
    } on CredentialException catch (e) {
      return Left(CredentialsFailure(e.message));
    }
  }

  @override
  Future<Either<Failures, LogoutModel>> logout() async {
    try {
      final _logoutModel = await authenticationLogoutUser.logoutUser();
      return Right(_logoutModel);
    } on ServerException {
      return Left(ServerFailure());
    } on CredentialException catch (e) {
      return Left(CredentialsFailure(e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failures, ProfileEntity>> getUserProfile(
    TokenParam token,
  ) async {
    try {
      final _profileModel =
          await authenticationGetProfileUser.getProfileUser(token);
      return Right(_profileModel);
    } on ServerException {
      return Left(ServerFailure());
    } on CredentialException catch (e) {
      return Left(CredentialsFailure(e.message));
    }
  }
}
