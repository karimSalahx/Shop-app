import 'package:tdd_test/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tdd_test/features/home/domain/entity/home_entity.dart';
import 'package:tdd_test/features/home/domain/repository/home_repository.dart';
import 'package:tdd_test/usecases.dart';

class GetHomeProducts implements UseCases<HomeEntity, NoParam> {
  HomeRepository repository;
  GetHomeProducts(this.repository);
  @override
  Future<Either<Failures, HomeEntity>> call(NoParam params) async =>
      repository.getHomeProducts();
}
