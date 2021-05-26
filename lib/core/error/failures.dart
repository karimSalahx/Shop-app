import 'package:equatable/equatable.dart';

abstract class Failures extends Equatable {
  final List properties = const [];
  Failures([properties]);

  @override
  List<Object> get props => [properties];
}

class ServerFailure extends Failures {}

class CacheFailure extends Failures {}

class CredentialsFailure extends Failures {
  final String message;
  CredentialsFailure(this.message);
}
