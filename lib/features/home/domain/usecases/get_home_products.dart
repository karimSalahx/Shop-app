import '../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../entity/home_entity.dart';
import '../repository/home_repository.dart';
import '../../../../usecases.dart';

class GetHomeProducts implements UseCases<HomeEntity, NoParam> {
  HomeRepository repository;
  GetHomeProducts(this.repository);
  @override
  Future<Either<Failures, HomeEntity>> call(NoParam params) async =>
      repository.getHomeProducts();
}
