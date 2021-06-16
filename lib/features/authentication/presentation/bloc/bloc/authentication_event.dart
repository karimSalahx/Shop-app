part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class LogInAuthenticationEvent extends AuthenticationEvent {
  final String email;
  final String password;
  LogInAuthenticationEvent({@required this.email, @required this.password});
  @override
  List<Object> get props => [email, password];
}

class RegisterAuthenticationEvent extends AuthenticationEvent {
  final RegisterParamModel registerParamModel;
  RegisterAuthenticationEvent(this.registerParamModel);
  @override
  List<Object> get props => [registerParamModel];
}

class ChangePasswordVisibiliyEvent extends AuthenticationEvent {
  @override
  List<Object> get props => [];
}

class LogoutUserEvent extends AuthenticationEvent {
  @override
  List<Object> get props => [];
}

class GetUserProfileEvent extends AuthenticationEvent {
  final String token;
  GetUserProfileEvent(this.token);
  @override
  List<Object> get props => [];
}
