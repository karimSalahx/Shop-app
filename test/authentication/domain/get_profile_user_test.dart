import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_test/features/authentication/domain/entity/profile_entity.dart';
import 'package:tdd_test/features/authentication/domain/repository/authentication_repository.dart';
import 'package:tdd_test/features/authentication/domain/usecases/get_profile_user.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  MockAuthenticationRepository repository;
  GetProfileUser usecase;

  setUp(() {
    repository = MockAuthenticationRepository();
    usecase = GetProfileUser(repository);
  });

  String tToken =
      'EJ6DKErwawaaE7LnVvUMERonSjhi3T3H337Cgm2dwxetTQoS8GWm3DYnei0SpuR9lqTdZc';

  final tProfileEntity = ProfileEntity(
    status: true,
    message: null,
    data: ProfileDataEntity(
      id: 613,
      name: "Abdelrahman ALgazzar",
      email: "karemmohamed2002@gmail.com",
      phone: "123456728",
      image:
          "https://student.valuxapps.com/storage/uploads/users/igYRtX84xb_1619709039.jpeg",
      points: 0,
      credit: 0,
      token:
          "mIcOIfLRlGiCbasuoKSwjIl6RbmaTixN0JTrP4Ea77YVLO1WewhwA8SHb55mjATPy7YiOK",
    ),
  );

  test(
    'should call getUserProfile with user token as a parameter',
    () async {
      // arrange
      when(repository.getUserProfile(any))
          .thenAnswer((_) async => Right(tProfileEntity));
      // act
      final res = await usecase(TokenParam(tToken));
      // assert
      expect(res, equals(Right(tProfileEntity)));
      //! must inheret equatable so he can compare between two objects
      verify(repository.getUserProfile(TokenParam(tToken)));
    },
  );
}
