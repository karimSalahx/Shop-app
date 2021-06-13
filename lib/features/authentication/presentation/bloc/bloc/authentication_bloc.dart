import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import '../../../../../usecases.dart';
import '../../../domain/entity/logout_entity.dart';
import '../../../domain/usecases/logout_user.dart';
import '../../../../../core/error/failures.dart';
import '../../../domain/entity/login_entity.dart';
import '../../../domain/entity/register_entity.dart';
import '../../../domain/usecases/login_user.dart';
import '../../../domain/usecases/register_user.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String CREDENTIAL_FAILURE_MESSAGE =
    'Credentials Entered are not Correct!';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final LoginUser loginUser;
  final RegisterUser registerUser;
  final LogoutUser logoutUser;
  AuthenticationBloc(
      {@required this.loginUser,
      @required this.registerUser,
      @required this.logoutUser})
      : assert(
          loginUser != null && registerUser != null && logoutUser != null,
        ),
        super(
          AuthenticationInitialState(),
        );

  bool isVisible = true;

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
    } else if (event is ChangePasswordVisibiliyEvent) {
      isVisible = !isVisible;
      // false
      if (isVisible)
        yield PasswordVisibleState();
      else
        yield PasswordNotVisibleState();
    } else if (event is LogoutUserEvent) {
      yield AuthenticationLoadingState();
      final logoutEither = await logoutUser(NoParam());
      yield* logoutEither.fold(
        (Failures l) async* {
          yield AuthenticationErrorState(_mapErrorStateToMessage(l));
        },
        (LogoutEntity r) async* {
          yield UserLoggedOutState(r);
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
      case CredentialsFailure:
        return (l as CredentialsFailure).message;
        break;
      default:
        return 'Unexpected Error';
        break;
    }
  }
}
