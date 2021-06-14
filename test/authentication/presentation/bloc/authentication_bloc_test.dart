import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_test/core/error/failures.dart';
import 'package:tdd_test/core/error/server_exception.dart';
import 'package:tdd_test/features/authentication/data/model/profile_model.dart';
import 'package:tdd_test/features/authentication/data/model/register_model.dart';
import 'package:tdd_test/features/authentication/domain/entity/login_entity.dart';
import 'package:tdd_test/features/authentication/domain/entity/logout_entity.dart';
import 'package:tdd_test/features/authentication/domain/entity/register_entity.dart';
import 'package:tdd_test/features/authentication/domain/usecases/get_profile_user.dart';
import 'package:tdd_test/features/authentication/domain/usecases/login_user.dart';
import 'package:tdd_test/features/authentication/domain/usecases/logout_user.dart';
import 'package:tdd_test/features/authentication/domain/usecases/register_user.dart';
import 'package:tdd_test/features/authentication/presentation/bloc/bloc/authentication_bloc.dart';
import 'package:tdd_test/usecases.dart';

class MockLoginUser extends Mock implements LoginUser {}

class MockRegisterUser extends Mock implements RegisterUser {}

class MockAuthenticationBloc extends Mock implements AuthenticationBloc {}

class MockLogoutUser extends Mock implements LogoutUser {}

class MockGetProfileUser extends Mock implements GetProfileUser {}

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
void main() {
  MockLoginUser mockLoginUser;
  MockRegisterUser mockRegisterUser;
  MockLogoutUser mockLogoutUser;
  MockGetProfileUser mockGetProfileUser;
  AuthenticationBloc bloc;

  setUp(
    () {
      mockLoginUser = MockLoginUser();
      mockRegisterUser = MockRegisterUser();
      mockLogoutUser = MockLogoutUser();
      mockGetProfileUser = MockGetProfileUser();
      bloc = AuthenticationBloc(
        loginUser: mockLoginUser,
        registerUser: mockRegisterUser,
        logoutUser: mockLogoutUser,
        getProfileUser: mockGetProfileUser,
      );
    },
  );

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

          bloc.add(LogoutUserEvent());
          await untilCalled(mockLogoutUser(any));
          verify(mockLogoutUser(NoParam()));
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
          bloc.add(LogoutUserEvent());
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
          bloc.add(LogoutUserEvent());
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
          bloc.add(LogoutUserEvent());
        },
      );
    },
  );

  group('GetUserProfile', () {
    String tToken =
        'EJ6DKErwawaaE7LnVvUMERonSjhi3T3H337Cgm2dwxetTQoS8GWm3DYnei0SpuR9lqTdZc';

    final tProfileEntity = ProfileModel(
      status: true,
      message: null,
      data: ProfileDataModel(
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
      'should call get user profile method to get profile user',
      () async {
        when(mockGetProfileUser(any))
            .thenAnswer((_) async => Right(tProfileEntity));

        bloc.add(GetUserProfileEvent(tToken));
        await untilCalled(mockGetProfileUser(any));
        verify(mockGetProfileUser(TokenParam(tToken)));
      },
    );
    test(
      'should emit user logged in state when user token is available and authorized',
      () async {
        // arrange
        when(mockGetProfileUser(any))
            .thenAnswer((_) async => Right(tProfileEntity));
        // act
        final expected = [
          AuthenticationLoadingState(),
          UserLoggedInState(tProfileEntity)
        ];
        expectLater(bloc.stream, emitsInOrder(expected));
        bloc.add(GetUserProfileEvent(tToken));
      },
    );
    test(
      'should emit UserNotLoggedIn if get user profile throws a Credential Failure',
      () async {
        // arrange
        when(mockGetProfileUser(any)).thenAnswer(
            (_) async => Left(CredentialsFailure('Not Authorized')));
        // act
        final expected = [AuthenticationLoadingState(), UserNotLoggedInState()];
        expectLater(bloc.stream, emitsInOrder(expected));
        // assert
        bloc.add(GetUserProfileEvent(tToken));
      },
    );

    test(
      '''should return Authentication Error when get
     user profile throws a server exception with the proper message''',
      () async {
        // arrange
        when(mockGetProfileUser(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        // act
        final expected = [
          AuthenticationLoadingState(),
          AuthenticationErrorState(SERVER_FAILURE_MESSAGE)
        ];
        expectLater(bloc.stream, emitsInOrder(expected));
        // assert
        bloc.add(GetUserProfileEvent(tToken));
      },
    );
  });
}
