import '../../../../core/error/server_exception.dart';
import '../datasources/home_get_home_products.dart';
import '../models/home_model.dart';
import '../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../../domain/repository/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeGetHomeProducts homeGetHomeProducts;
  HomeRepositoryImpl(this.homeGetHomeProducts);
  @override
  Future<Either<Failures, HomeModel>> getHomeProducts() async {
    try {
      final HomeModel _homeModel = await homeGetHomeProducts.getHomdProducts();
      return Right(_homeModel);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
