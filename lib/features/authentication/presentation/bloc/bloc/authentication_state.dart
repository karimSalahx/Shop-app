part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitialState extends AuthenticationState {}

class AuthenticationLoadingState extends AuthenticationState {}

class AuthenticationLoggedInState extends AuthenticationState {
  final LoginEntity loginModel;
  AuthenticationLoggedInState(this.loginModel);

  @override
  List<Object> get props => [loginModel];
}

class AuthenticationRegisteredState extends AuthenticationState {
  final RegisterEntity registerModel;
  AuthenticationRegisteredState(this.registerModel);

  @override
  List<Object> get props => [registerModel];
}

class AuthenticationErrorState extends AuthenticationState {
  final String message;
  AuthenticationErrorState(this.message);
  @override
  List<Object> get props => [message];
}
