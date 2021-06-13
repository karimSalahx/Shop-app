import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../entity/profile_entity.dart';
import '../repository/authentication_repository.dart';
import '../../../../usecases.dart';

class GetProfileUser extends UseCases<ProfileEntity, TokenParam> {
  AuthenticationRepository repository;
  GetProfileUser(this.repository);
  @override
  Future<Either<Failures, ProfileEntity>> call(TokenParam params) async {
    return await repository.getUserProfile(params);
  }
}

class TokenParam extends Equatable {
  final String token;
  TokenParam(this.token);

  @override
  List<Object> get props => [this.token];
}
