import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_test/core/error/failures.dart';
import 'package:tdd_test/features/authentication/data/model/register_model.dart';
import 'package:tdd_test/features/authentication/domain/entity/login_entity.dart';
import 'package:tdd_test/features/authentication/domain/entity/logout_entity.dart';
import 'package:tdd_test/features/authentication/domain/entity/register_entity.dart';
import 'package:tdd_test/features/authentication/domain/usecases/login_user.dart';
import 'package:tdd_test/features/authentication/domain/usecases/logout_user.dart';
import 'package:tdd_test/features/authentication/domain/usecases/register_user.dart';
import 'package:tdd_test/features/authentication/presentation/bloc/bloc/authentication_bloc.dart';

class MockLoginUser extends Mock implements LoginUser {}

class MockRegisterUser extends Mock implements RegisterUser {}

class MockAuthenticationBloc extends Mock implements AuthenticationBloc {}

class MockLogoutUser extends Mock implements LogoutUser {}

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
void main() {
  MockLoginUser mockLoginUser;
  MockRegisterUser mockRegisterUser;
  MockLogoutUser mockLogoutUser;
  AuthenticationBloc bloc;

  setUp(() {
    mockLoginUser = MockLoginUser();
    mockRegisterUser = MockRegisterUser();
    mockLogoutUser = MockLogoutUser();
    bloc = AuthenticationBloc(
      loginUser: mockLoginUser,
      registerUser: mockRegisterUser,
      logoutUser: mockLogoutUser,
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
  group(
    'Register',
    () {
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

      final _logoutEntity =
          LogoutEntity(status: true, message: 'Logout done successfully');
      final tToken =
          'tdxlV4nUV8Jex8AKSIIX1uYECciKbTByz0l3OSfMEUawePy7bnX929cRKOnEF7rRaOa23J';

      test(
        'should call register method to register user',
        () async {
          when(mockRegisterUser(any))
              .thenAnswer((_) async => Right(tRegisterModel));

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

      test(
        'should call logout  method to logout user',
        () async {
          when(mockLogoutUser(any))
              .thenAnswer((_) async => Right(_logoutEntity));

          bloc.add(LogoutUserEvent(tToken));
          await untilCalled(mockLogoutUser(any));
          verify(mockLogoutUser(LogoutParam(tToken)));
        },
      );

      test(
        '''should emit [AuthenticationLoadingState,AuthenticationError]
         with a proper message for the error
         when logout fails for serverFailure
      ''',
        () async {
          // arrange
          when(mockLogoutUser(any))
              .thenAnswer((_) async => Left(ServerFailure()));
          // act
          final expected = [
            AuthenticationLoadingState(),
            AuthenticationErrorState(SERVER_FAILURE_MESSAGE),
          ];
          expectLater(bloc.stream, emitsInOrder(expected));
          bloc.add(LogoutUserEvent(tToken));
        },
      );

      test(
        'should emit [AuthenticationLoadingState,UserLoggedOut] when the log out success',
        () async {
          // arrange
          when(mockLogoutUser(any))
              .thenAnswer((_) async => Right(_logoutEntity));
          // act
          final expected = [
            AuthenticationLoadingState(),
            UserLoggedOutState(_logoutEntity),
          ];
          // assert
          expectLater(bloc.stream, emitsInOrder(expected));
          bloc.add(LogoutUserEvent(tToken));
        },
      );
      test(
        '''should emit [AuthenticationLoadingState,AuthenticationError]
         with a proper message for the error
         when logout fails for cacheFailure
      ''',
        () async {
          // arrange
          when(mockLogoutUser(any))
              .thenAnswer((_) async => Left(CacheFailure()));
          // act
          final expected = [
            AuthenticationLoadingState(),
            AuthenticationErrorState(CACHE_FAILURE_MESSAGE),
          ];
          expectLater(bloc.stream, emitsInOrder(expected));
          bloc.add(LogoutUserEvent(tToken));
        },
      );
    },
  );
}
