import 'package:dartz/dartz.dart';
import 'package:tdd_test/core/error/failures.dart';
import 'package:tdd_test/features/home/domain/entity/home_entity.dart';

abstract class HomeRepository {
  Future<Either<Failures, HomeEntity>> getHomeProducts();
}
