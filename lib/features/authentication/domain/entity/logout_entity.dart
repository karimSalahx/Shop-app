import 'package:equatable/equatable.dart';

class LogoutEntity extends Equatable {
  final bool status;
  final String message;
  LogoutEntity({this.status, this.message});

  @override
  List<Object> get props => [this.status, this.message];
}
