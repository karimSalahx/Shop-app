import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_test/core/error/failures.dart';
import 'package:tdd_test/features/authentication/data/model/register_model.dart';
import 'package:tdd_test/features/authentication/domain/entity/login_model.dart';
import 'package:tdd_test/features/authentication/domain/entity/register_model.dart';
import 'package:tdd_test/features/authentication/domain/usecases/login_user.dart';
import 'package:tdd_test/features/authentication/domain/usecases/register_user.dart';
import 'package:tdd_test/features/authentication/presentation/bloc/bloc/authentication_bloc.dart';

class MockLoginUser extends Mock implements LoginUser {}

class MockRegisterUser extends Mock implements RegisterUser {}

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
void main() {
  MockLoginUser mockLoginUser;
  MockRegisterUser mockRegisterUser;
  AuthenticationBloc bloc;

  setUp(() {
    mockLoginUser = MockLoginUser();
    mockRegisterUser = MockRegisterUser();
    bloc = AuthenticationBloc(
      loginUser: mockLoginUser,
      registerUser: mockRegisterUser,
    );
  });

  test(
    'Initial state should be AuthenticationIntialState',
    () async {
      expect(bloc.state, AuthenticationInitialState());
    },
  );

  group('Login', () {
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

    final temail = 'user@gmail.com';
    final tPassword = '12345';
    final loginParam = LoginParam(email: temail, password: tPassword);

    test(
      'should call the login method to login user',
      () async {
        // arrange
        when(mockLoginUser(any)).thenAnswer(
          (_) async => Right(
            tLoginModel,
          ),
        );
        // act
        bloc.add(LogInAuthenticationEvent(email: temail, password: tPassword));
        await untilCalled(mockLoginUser(any));
        // assert
        verify(mockLoginUser(loginParam));
      },
    );

    test(
      '''should emit [AuthenticationLoadingState,AuthenticationError]
         with a proper message for the error
         when Login fails for serverFailure
      ''',
      () async {
        // arrange
        when(mockLoginUser(any)).thenAnswer((_) async => Left(ServerFailure()));
        // act
        final expected = [
          AuthenticationLoadingState(),
          AuthenticationErrorState(SERVER_FAILURE_MESSAGE),
        ];
        expectLater(bloc.stream, emitsInOrder(expected));
        bloc.add(LogInAuthenticationEvent(email: temail, password: tPassword));
        await untilCalled(mockLoginUser(any));
        verify(mockLoginUser(LoginParam(email: temail, password: tPassword)));
      },
    );

    test(
      '''should emit [AuthenticationLoadingState,AuthenticationError]
         with a proper message for the error
         when Login fails for cacheFailure
      ''',
      () async {
        // arrange
        when(mockLoginUser(any)).thenAnswer((_) async => Left(CacheFailure()));
        // act
        final expected = [
          AuthenticationLoadingState(),
          AuthenticationErrorState(CACHE_FAILURE_MESSAGE),
        ];
        expectLater(bloc.stream, emitsInOrder(expected));
        bloc.add(LogInAuthenticationEvent(email: temail, password: tPassword));
        await untilCalled(mockLoginUser(any));
        verify(mockLoginUser(LoginParam(email: temail, password: tPassword)));
      },
    );

    test(
      'should emit [AuthenticationLoadingState,AuthenticationLoggedInState] when the login success',
      () async {
        // arrange
        when(mockLoginUser(any)).thenAnswer((_) async => Right(tLoginModel));
        // act
        final expected = [
          AuthenticationLoadingState(),
          AuthenticationLoggedInState(tLoginModel),
        ];
        // assert
        expectLater(bloc.stream, emitsInOrder(expected));
        bloc.add(LogInAuthenticationEvent(email: temail, password: tPassword));
        await untilCalled(mockLoginUser(any));
        verify(mockLoginUser(LoginParam(email: temail, password: tPassword)));
      },
    );
  });
  group('Register', () {
    final tRegisterParam = RegisterParamModel(
      name: "Abdelrahman ALgazzar",
      phone: "12384678",
      email: "algazza.abdelrahman@gmaill.com",
      password: "123456",
    );
    final tRegisterDataModel = RegisterDataModel(
      name: "Abdelrahman ALgazzar",
      phone: "12384678",
      email: "algazza.abdelrahman@gmaill.com",
      id: 943,
      token:
          "54jjNlhivnYE1ylZqfs9CIxBcT1Gezb8RKQ282DSkUqoODMLSr04hggQOsWmkzTx6coMix",
    );
    final tRegisterModel = RegisterEntity(
      status: true,
      message: "Registration done successfully",
      data: tRegisterDataModel,
    );

    test(
      'should call register method to register user',
      () async {
        when(mockRegisterUser(any))
            .thenAnswer((realInvocation) async => Right(tRegisterModel));

        bloc.add(RegisterAuthenticationEvent(tRegisterParam));
        await untilCalled(mockRegisterUser(any));
        verify(mockRegisterUser(tRegisterParam));
      },
    );
    test(
      '''should emit [AuthenticationLoadingState,AuthenticationError]
         with a proper message for the error
         when register fails for serverFailure
      ''',
      () async {
        // arrange
        when(mockRegisterUser(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        // act
        final expected = [
          AuthenticationLoadingState(),
          AuthenticationErrorState(SERVER_FAILURE_MESSAGE),
        ];
        expectLater(bloc.stream, emitsInOrder(expected));
        bloc.add(RegisterAuthenticationEvent(tRegisterParam));
      },
    );
    test(
      'should emit [AuthenticationLoadingState,AuthenticationLRegisteredState] when the register success',
      () async {
        // arrange
        when(mockRegisterUser(any))
            .thenAnswer((_) async => Right(tRegisterModel));
        // act
        final expected = [
          AuthenticationLoadingState(),
          AuthenticationRegisteredState(tRegisterModel),
        ];
        // assert
        expectLater(bloc.stream, emitsInOrder(expected));
        bloc.add(RegisterAuthenticationEvent(tRegisterParam));
      },
    );
  });
}
