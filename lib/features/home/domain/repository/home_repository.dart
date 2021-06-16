import 'package:dartz/dartz.dart';
import 'package:tdd_test/features/home/domain/entity/add_remove_favorites_entity.dart';
import 'package:tdd_test/features/home/domain/usecases/add_remove_product_to_favorites.dart';
import '../../../../core/error/failures.dart';
import '../entity/home_entity.dart';

abstract class HomeRepository {
  Future<Either<Failures, HomeEntity>> getHomeProducts();
  Future<Either<Failures, AddRemoveFavoritesEntity>>
      addRemoveProductToFavorites(ProductParam param);
}
