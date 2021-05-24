import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:tdd_test/core/error/failures.dart';
import 'package:tdd_test/features/authentication/data/model/login_model.dart';
import 'package:tdd_test/features/authentication/data/model/register_model.dart';
import 'package:tdd_test/features/authentication/domain/entity/login_model.dart';
import 'package:tdd_test/features/authentication/domain/entity/register_model.dart';
import 'package:tdd_test/features/authentication/domain/usecases/login_user.dart';
import 'package:tdd_test/features/authentication/domain/usecases/register_user.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final LoginUser loginUser;
  final RegisterUser registerUser;
  AuthenticationBloc({@required this.loginUser, @required this.registerUser})
      : assert(loginUser != null && registerUser != null),
        super(
          AuthenticationInitialState(),
        );

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is LogInAuthenticationEvent) {
      yield AuthenticationLoadingState();
      final loginEither = await loginUser(
        LoginParam(
          email: event.email,
          password: event.password,
        ),
      );
      yield* loginEither.fold(
        (Failures l) async* {
          yield AuthenticationErrorState(_mapErrorStateToMessage(l));
        },
        (LoginEntity r) async* {
          yield AuthenticationLoggedInState(r);
        },
      );
    } else if (event is RegisterAuthenticationEvent) {
      yield AuthenticationLoadingState();
      final registerEither = await registerUser(event.registerParamModel);
      yield* registerEither.fold(
        (Failures l) async* {
          yield AuthenticationErrorState(_mapErrorStateToMessage(l));
        },
        (RegisterEntity r) async* {
          yield AuthenticationRegisteredState(r);
        },
      );
    }
  }

  String _mapErrorStateToMessage(Failures l) {
    switch (l.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
        break;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
        break;

      default:
        return 'Unexpected Error';
        break;
    }
  }
}
