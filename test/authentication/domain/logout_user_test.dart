import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_test/features/authentication/domain/entity/logout_entity.dart';
import 'package:tdd_test/features/authentication/domain/repository/authentication_repository.dart';
import 'package:tdd_test/features/authentication/domain/usecases/logout_user.dart';
import 'package:tdd_test/usecases.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  MockAuthenticationRepository mockAuthenticationRepository;
  LogoutUser usecase;

  setUp(() {
    mockAuthenticationRepository = MockAuthenticationRepository();
    usecase = LogoutUser(mockAuthenticationRepository);
  });
  final _logoutEntity =
      LogoutEntity(status: true, message: 'Logout done successfully');

  test(
    'should return logout entity when logout function is called',
    () async {
      // arrange
      when(mockAuthenticationRepository.logout()).thenAnswer(
        (_) async => Right(
          _logoutEntity,
        ),
      );
      // act
      final res = await usecase(NoParam());
      // assert
      expect(res, equals(Right(_logoutEntity)));
      verify(mockAuthenticationRepository.logout());
    },
  );
}
