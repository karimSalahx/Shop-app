import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entity/home_entity.dart';

abstract class HomeRepository {
  Future<Either<Failures, HomeEntity>> getHomeProducts();
}
