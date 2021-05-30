import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_test/core/error/failures.dart';
import 'package:tdd_test/core/error/server_exception.dart';
import 'package:tdd_test/features/home/data/datasources/home_get_home_products.dart';
import 'package:tdd_test/features/home/data/models/home_model.dart';
import 'package:tdd_test/features/home/data/repository/home_repository_impl.dart';

class MockHomeGetHomeProducts extends Mock implements HomeGetHomeProducts {}

void main() {
  HomeRepositoryImpl repository;
  MockHomeGetHomeProducts mockHomeRepository;

  final tHomeModelSuccess = HomeModel(
    status: true,
    data: DataModel(
      banners: [
        BannerModel(
          id: 13,
          image:
              'https://student.valuxapps.com/storage/uploads/banners/1619501214k9Xz9.banner_foods.png',
          category: CategoryModel(
            id: 27,
            image:
                'https://student.valuxapps.com/storage/uploads/categories/1619502074w3Zie.rau-cu-qua.png',
            name: 'Fresh food',
          ),
        ),
      ],
      ad: 'https://student.valuxapps.com/storage/uploads/banners/1619501214k9Xz9.banner_foods.png',
      products: [
        ProductModel(
          id: 69,
          price: 189,
          oldPrice: 189,
          discount: 0,
          image:
              'https://student.valuxapps.com/storage/uploads/products/16202553592lT06.1.jpg',
          name: 'KN95 Face Mask white from pert 10pcs',
          description:
              'BrandPert\r\nPackage weight in KGs: 98 grams\r\nType: Protection Masks\r\nPackage height: 13.6 centimeters\r\nPackage Wid: th6.4 centimeters',
          images: [
            "https://student.valuxapps.com/storage/uploads/products/1620255359qMP2C.1.jpg",
            "https://student.valuxapps.com/storage/uploads/products/1620255359ZDzlh.2.jpg"
          ],
          inFavorites: false,
          inCart: false,
        )
      ],
    ),
  );
  setUp(() {
    mockHomeRepository = MockHomeGetHomeProducts();
    repository = HomeRepositoryImpl(mockHomeRepository);
  });

  test(
    'should call get home products',
    () async {
      // arrange
      when(mockHomeRepository.getHomdProducts())
          .thenAnswer((_) async => tHomeModelSuccess);
      // act
      await repository.getHomeProducts();
      // assert
      verify(mockHomeRepository.getHomdProducts());
    },
  );

  test(
    'should catch server exception and transfer to server failure',
    () async {
      // arrange
      when(mockHomeRepository.getHomdProducts()).thenThrow(ServerException());
      // act
      final res = await repository.getHomeProducts();
      // assert
      expect(res, equals(Left(ServerFailure())));
    },
  );

  test(
    'should return home model when everyhting is ok',
    () async {
      // arrange
      when(mockHomeRepository.getHomdProducts())
          .thenAnswer((_) async => tHomeModelSuccess);
      // act
      final res = await repository.getHomeProducts();
      // assert
      expect(res, equals(Right(tHomeModelSuccess)));
    },
  );
}
