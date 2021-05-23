import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'core/error/failures.dart';

abstract class UseCases<T, P> {
  Future<Either<Failures, T>> call(P params);
}

class NoParam extends Equatable {
  @override
  List<Object> get props => [];
}
