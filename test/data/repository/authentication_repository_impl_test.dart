import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_test/core/error/failures.dart';
import 'package:tdd_test/core/error/server_exception.dart';
import 'package:tdd_test/features/authentication/data/datasources/authentication_login_user.dart';
import 'package:tdd_test/features/authentication/data/datasources/authentication_logout_user.dart';
import 'package:tdd_test/features/authentication/data/datasources/authentication_register_user.dart';
import 'package:tdd_test/features/authentication/data/model/login_model.dart';
import 'package:tdd_test/features/authentication/data/model/logout_model.dart';
import 'package:tdd_test/features/authentication/data/model/register_model.dart';
import 'package:tdd_test/features/authentication/data/repository/authentication_repository_impl.dart';
import 'package:tdd_test/features/authentication/domain/usecases/register_user.dart';

class MockAuthenticationLoginUser extends Mock
    implements AuthenticationLoginUser {}

class MockAuthenticationRegisterUser extends Mock
    implements AuthenticationRegisterUser {}

class MockAuthenticationLogoutUser extends Mock
    implements AuthenticationLogoutUser {}

void main() {
  MockAuthenticationLoginUser mockAuthenticationLoginUser;
  MockAuthenticationRegisterUser mockAuthenticationRegisterUser;
  MockAuthenticationLogoutUser mockAuthenticationLogoutUser;
  AuthenticationRepositoryImpl authenticationRepositoryImpl;

  setUp(() {
    mockAuthenticationLoginUser = MockAuthenticationLoginUser();
    mockAuthenticationRegisterUser = MockAuthenticationRegisterUser();
    mockAuthenticationLogoutUser = MockAuthenticationLogoutUser();
    authenticationRepositoryImpl = AuthenticationRepositoryImpl(
      authenticationLoginUser: mockAuthenticationLoginUser,
      authenticationRegisterUser: mockAuthenticationRegisterUser,
      authenticationLogoutUser: mockAuthenticationLogoutUser,
    );
  });

  group('Login User', () {
    final tRegisterParam = RegisterParamModel(
      name: "Abdelrahman ALgazzar",
      phone: "12384678",
      email: "algazza.abdelrahman@gmaill.com",
      password: "123456",
    );

    final tDataModel = LoginDataModel(
      id: 613,
      name: "Abdelrahman ALgazzar",
      email: "karemmohamed2002@gmail.com",
      phone: "123456728",
      points: 0,
      credit: 0,
      token:
          "tCzXE8ITM0752meGP5DKhZL7SEkCbUbutfj4pxlXFgMGmO7lttZQlM9SfqOryJVNPZJskm",
    );
    final tRegisterDataModel = RegisterDataModel(
      name: "Abdelrahman ALgazzar",
      phone: "12384678",
      email: "algazza.abdelrahman@gmaill.com",
      id: 943,
      token:
          "54jjNlhivnYE1ylZqfs9CIxBcT1Gezb8RKQ282DSkUqoODMLSr04hggQOsWmkzTx6coMix",
    );
    final tRegisterModel = RegisterModel(
        status: true,
        message: "Registration done successfully",
        data: tRegisterDataModel);
    final tLoginModel = LoginModel(
      status: true,
      message: "Login done successfully",
      data: tDataModel,
    );

    final temail = 'user@gmail.com';
    final tPassword = '12345';
    final tToken = tLoginModel.data.token;

    test(
      'should login user when there is internet connection',
      () async {
        // arrange
        when(
          mockAuthenticationLoginUser.loginUser(
            email: anyNamed('email'),
            password: anyNamed('password'),
          ),
        ).thenAnswer(
          (_) async => tLoginModel,
        );
        // act
        await authenticationRepositoryImpl.loginUser(
          email: temail,
          password: tPassword,
        );
        // assert
        verify(
          mockAuthenticationLoginUser.loginUser(
            email: temail,
            password: tPassword,
          ),
        );
      },
    );

    test(
      'should cache user token after successfult login',
      () async {
        when(
          mockAuthenticationLoginUser.loginUser(
            email: anyNamed('email'),
            password: anyNamed('password'),
          ),
        ).thenAnswer(
          (_) async => tLoginModel,
        );
        await authenticationRepositoryImpl.loginUser(
          email: temail,
          password: tPassword,
        );

        verify(
          mockAuthenticationLoginUser.cacheToken(
            tLoginModel.data.token,
          ),
        );
      },
    );

    test(
      'should catch server exception and map to server failure',
      () async {
        // arrange
        when(
          mockAuthenticationLoginUser.loginUser(
            email: anyNamed('email'),
            password: anyNamed('password'),
          ),
        ).thenThrow(
          ServerException(),
        );
        // act
        final res = await authenticationRepositoryImpl.loginUser(
          email: temail,
          password: tPassword,
        );
        // assert
        verify(mockAuthenticationLoginUser.loginUser(
            email: temail, password: tPassword));
        expect(res, equals(Left(ServerFailure())));
      },
    );
    test(
      'should catch cache exception and map to cache failure',
      () async {
        // arrange
        when(
          mockAuthenticationLoginUser.loginUser(
            email: anyNamed('email'),
            password: anyNamed('password'),
          ),
        ).thenAnswer(
          (_) async => tLoginModel,
        );
        when(
          mockAuthenticationLoginUser.cacheToken(any),
        ).thenThrow(
          CacheException(),
        );
        // act
        final res = await authenticationRepositoryImpl.loginUser(
          email: temail,
          password: tPassword,
        );
        // assert
        verify(
          mockAuthenticationLoginUser.loginUser(
            email: temail,
            password: tPassword,
          ),
        );
        verify(mockAuthenticationLoginUser.cacheToken(tToken));
        expect(res, equals(Left(CacheFailure())));
      },
    );
    test(
      'should return login model when the login process is good',
      () async {
        // arrange
        when(
          mockAuthenticationLoginUser.loginUser(
            email: anyNamed('email'),
            password: anyNamed('password'),
          ),
        ).thenAnswer(
          (_) async => tLoginModel,
        );
        // act
        final res = await authenticationRepositoryImpl.loginUser(
          email: temail,
          password: tPassword,
        );
        verify(
          mockAuthenticationLoginUser.loginUser(
            email: temail,
            password: tPassword,
          ),
        );
        verify(mockAuthenticationLoginUser.cacheToken(tToken));
        expect(res, equals(Right(tLoginModel)));
        // assert
      },
    );

    test(
      'should call register user with register paramter',
      () async {
        // arrange
        when(mockAuthenticationRegisterUser.registerUser(any)).thenAnswer(
          (_) async => tRegisterModel,
        );
        // act
        await authenticationRepositoryImpl.registerUser(tRegisterParam);

        // assert
        verify(mockAuthenticationRegisterUser.registerUser(tRegisterParam));
      },
    );

    test(
      'should catch server exception and map to server failure in registration',
      () async {
        // arrange
        when(mockAuthenticationRegisterUser.registerUser(any)).thenThrow(
          ServerException(),
        );
        // act
        final res =
            await authenticationRepositoryImpl.registerUser(tRegisterParam);

        // assert
        verify(mockAuthenticationRegisterUser.registerUser(tRegisterParam));
        expect(res, equals(Left(ServerFailure())));
      },
    );

    test(
      'should return register model user when the registration is completed',
      () async {
        // arrange
        when(mockAuthenticationRegisterUser.registerUser(any)).thenAnswer(
          (_) async => tRegisterModel,
        );
        // act
        final res =
            await authenticationRepositoryImpl.registerUser(tRegisterParam);
        // assert
        verify(mockAuthenticationRegisterUser.registerUser(tRegisterParam));
        expect(res, equals(Right(tRegisterModel)));
      },
    );
  });
  group(
    'Logout',
    () {
      final _logoutEntity =
          LogoutModel(status: true, message: 'Logout done successfully');
      final tToken =
          'tdxlV4nUV8Jex8AKSIIX1uYECciKbTByz0l3OSfMEUawePy7bnX929cRKOnEF7rRaOa23J';

      test(
        'should logout user when the method is called',
        () async {
          // arrange
          when(mockAuthenticationLogoutUser.logoutUser(any))
              .thenAnswer((_) async => _logoutEntity);
          // act
          await authenticationRepositoryImpl.logout(tToken);
          // assert
          verify(mockAuthenticationLogoutUser.logoutUser(tToken));
        },
      );

      test(
        'should return left of server failure when mock throws server exception',
        () async {
          // arrange
          when(mockAuthenticationLogoutUser.logoutUser(any))
              .thenThrow(ServerException());
          // act
          final res = await authenticationRepositoryImpl.logout(tToken);
          // assert
          expect(res, equals(Left(ServerFailure())));
        },
      );
      test(
        'should return left of cache failure when mock throws cache exception',
        () async {
          // arrange
          when(mockAuthenticationLogoutUser.logoutUser(any))
              .thenThrow(CacheException());
          // act
          final res = await authenticationRepositoryImpl.logout(tToken);
          // assert
          expect(res, equals(Left(CacheFailure())));
        },
      );
      test(
        'should return right login model when every thing is ok',
        () async {
          // arrange
          when(mockAuthenticationLogoutUser.logoutUser(any))
              .thenAnswer((_) async => _logoutEntity);
          // act
          final res = await authenticationRepositoryImpl.logout(tToken);
          // assert
          expect(res, equals(Right(_logoutEntity)));
        },
      );
    },
  );
}
