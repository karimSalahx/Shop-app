import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_test/features/authentication/domain/entity/login_entity.dart';
import 'package:tdd_test/features/authentication/domain/repository/authentication_repository.dart';
import 'package:tdd_test/features/authentication/domain/usecases/login_user.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  MockAuthenticationRepository repository;
  LoginUser usecase;
  setUp(() {
    repository = MockAuthenticationRepository();
    usecase = LoginUser(repository);
  });

  final temail = 'user@gmail.com';
  final tPassword = '12345';
  final tDataModel = LoginData(
    id: 613,
    name: "Abdelrahman ALgazzar",
    email: "karemmohamed2002@gmail.com",
    phone: "123456728",
    points: 0,
    credit: 0,
    token:
        "tCzXE8ITM0752meGP5DKhZL7SEkCbUbutfj4pxlXFgMGmO7lttZQlM9SfqOryJVNPZJskm",
  );
  final tLoginModel = LoginEntity(
    status: true,
    message: 'Login Done successfulyy',
    data: tDataModel,
  );

  test(
    'should return user Model when logged in',
    () async {
      // arrange
      when(repository.loginUser(
              email: anyNamed('email'), password: anyNamed('password')))
          .thenAnswer(
        (_) async => Right(tLoginModel),
      );
      // act
      final res = await usecase(LoginParam(email: temail, password: tPassword));
      // assert
      expect(res, Right(tLoginModel));
      verify(repository.loginUser(email: temail, password: tPassword));
    },
  );
}
