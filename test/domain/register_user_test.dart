import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_test/features/authentication/domain/entity/register_model.dart';
import 'package:tdd_test/features/authentication/domain/repository/authentication_repository.dart';
import 'package:tdd_test/features/authentication/domain/usecases/register_user.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  MockAuthenticationRepository mockAuthenticationRepository;
  RegisterUser usecase;

  setUp(() {
    mockAuthenticationRepository = MockAuthenticationRepository();
    usecase = RegisterUser(mockAuthenticationRepository);
  });

  final tName = "Abdelrahman ALgazzar";
  final tPhone = "12384678";
  final tEmail = "algazza.abdelrahman@gmaill.com";
  final tPassword = "123456";

  final tRegisterData = RegisterData(
    name: tName,
    phone: tPhone,
    email: tEmail,
    id: 943,
    token:
        "54jjNlhivnYE1ylZqfs9CIxBcT1Gezb8RKQ282DSkUqoODMLSr04hggQOsWmkzTx6coMix",
  );
  final tRegisterModel = RegisterEntity(
    status: true,
    message: "Registration done successfully",
    data: tRegisterData,
  );
  final tRegisterModelParam = RegisterParamModel(
    name: tName,
    phone: tPhone,
    email: tEmail,
    password: tPassword,
  );

  test(
    'should return register model when logged in',
    () async {
      // arrange
      when(mockAuthenticationRepository.registerUser(any)).thenAnswer(
        (_) async => Right(tRegisterModel),
      );
      // act
      final res = await usecase(tRegisterModelParam);
      // assert
      expect(res, Right(tRegisterModel));
      verify(mockAuthenticationRepository.registerUser(tRegisterModelParam));
    },
  );
}
