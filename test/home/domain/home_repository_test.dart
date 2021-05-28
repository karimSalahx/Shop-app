import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_test/features/home/domain/entity/home_entity.dart';
import 'package:tdd_test/features/home/domain/repository/home_repository.dart';
import 'package:tdd_test/features/home/domain/usecases/get_home_products.dart';
import 'package:tdd_test/usecases.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

void main() {
  MockHomeRepository mockHomeRepository;
  GetHomeProducts usecase;
  setUp(() {
    mockHomeRepository = MockHomeRepository();
    usecase = GetHomeProducts(mockHomeRepository);
  });

  final tHomeEntitySuccess = HomeEntity(
    status: true,
    data: DataEntity(
      banners: [
        BannersEntity(
          id: 13,
          image:
              'https://student.valuxapps.com/storage/uploads/banners/1619501214k9Xz9.banner_foods.png',
          category: CategoryEntity(
            id: 27,
            image:
                'https://student.valuxapps.com/storage/uploads/categories/1619502074w3Zie.rau-cu-qua.png',
            name: 'Fresh food',
          ),
        ),
      ],
      ad: 'https://student.valuxapps.com/storage/uploads/banners/1619501214k9Xz9.banner_foods.png',
      products: [
        ProductsEntity(
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

  test(
    'should return Home Entity when getHomeProduct is called',
    () async {
      // arrange
      when(mockHomeRepository.getHomeProducts())
          .thenAnswer((_) async => Right(tHomeEntitySuccess));
      // act
      final res = await usecase(NoParam());
      // assert
      expect(res, equals(Right(tHomeEntitySuccess)));
      verify(mockHomeRepository.getHomeProducts());
    },
  );
}
