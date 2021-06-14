import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:tdd_test/features/authentication/data/model/profile_model.dart';
import 'package:tdd_test/features/authentication/domain/entity/profile_entity.dart';
import 'package:tdd_test/features/authentication/domain/usecases/get_profile_user.dart';
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

const CACHE_TOKEN = 'CACHE_TOKEN';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final LoginUser loginUser;
  final RegisterUser registerUser;
  final LogoutUser logoutUser;
  final GetProfileUser getProfileUser;
  AuthenticationBloc({
    @required this.loginUser,
    @required this.registerUser,
    @required this.logoutUser,
    @required this.getProfileUser,
  })  : assert(
          loginUser != null &&
              registerUser != null &&
              logoutUser != null &&
              getProfileUser != null,
        ),
        super(
          AuthenticationInitialState(),
        );

  bool isVisible = true;

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is GetUserProfileEvent) {
      if (event.token != null) {
        // This means that there exist a token in shared pref we need to check if this token authorized
        yield AuthenticationLoadingState();
        final getProfileEither = await getProfileUser(TokenParam(event.token));
        yield* getProfileEither.fold(
          (Failures l) async* {
            switch (l.runtimeType) {
              // if status is false => Not Authorized
              case CredentialsFailure:
                yield UserNotLoggedInState();
                break;
              case ServerFailure:
                yield AuthenticationErrorState(SERVER_FAILURE_MESSAGE);
                break;
              default:
                yield AuthenticationErrorState(SERVER_FAILURE_MESSAGE);
                break;
            }
          },
          // if authorized
          (ProfileEntity r) async* {
            yield UserLoggedInState(r);
          },
        );
      } else
        yield UserNotLoggedInState();
    } else if (event is LogInAuthenticationEvent) {
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
