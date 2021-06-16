import 'package:flutter/cupertino.dart';
import 'package:tdd_test/features/home/data/datasources/home_add_remove_favorities.dart';
import 'package:tdd_test/features/home/domain/usecases/add_remove_product_to_favorites.dart';

import 'package:tdd_test/features/home/domain/entity/add_remove_favorites_entity.dart';

import '../../../../core/error/server_exception.dart';
import '../datasources/home_get_home_products.dart';
import '../models/home_model.dart';
import '../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../../domain/repository/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeGetHomeProducts homeGetHomeProducts;
  final HomeAddRemoveFavorities homeAddRemoveFavorities;
  HomeRepositoryImpl({
    @required this.homeGetHomeProducts,
    @required this.homeAddRemoveFavorities,
  });
  @override
  Future<Either<Failures, HomeModel>> getHomeProducts() async {
    try {
      final HomeModel _homeModel = await homeGetHomeProducts.getHomdProducts();
      return Right(_homeModel);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failures, AddRemoveFavoritesEntity>>
      addRemoveProductToFavorites(ProductParam param) async {
    try {
      final _model = await homeAddRemoveFavorities.addRemoveToFavorities(param);
      return Right(_model);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
