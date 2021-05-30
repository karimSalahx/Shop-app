import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:tdd_test/core/error/server_exception.dart';
import 'package:tdd_test/features/home/data/datasources/home_get_home_products.dart';
import 'package:tdd_test/features/home/data/models/home_model.dart';

import '../../fixtures/home_fixture_reader.dart';

class MockClient extends Mock implements http.Client {}

const _baseUrl = 'https://student.valuxapps.com/api/';

void main() {
  HomeGetHomeProductsImpl datasource;
  MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    datasource = HomeGetHomeProductsImpl(mockClient);
  });
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

  void setUpMockClientSuccess200() {
    when(
      mockClient.get(
        any,
        headers: anyNamed('headers'),
      ),
    ).thenAnswer(
      (_) async => http.Response(
        homeFixture('home_model_simplified.json'),
        200,
      ),
    );
  }

  void setUpMockClientFail404() {
    when(
      mockClient.get(
        any,
        headers: anyNamed('headers'),
      ),
    ).thenAnswer(
      (_) async => http.Response(
        'Something went wrong',
        404,
      ),
    );
  }

  test(
    'should make get request on the base ',
    () async {
      // arrange
      setUpMockClientSuccess200();
      // act
      await datasource.getHomdProducts();
      // assert
      verify(
        mockClient.get(
          Uri.parse(_baseUrl + 'home'),
          headers: {'Content-Type': 'application/json', 'lang': 'en'},
        ),
      );
    },
  );

  test(
    'should throw server exception if response code is not 200',
    () async {
      // arrange
      setUpMockClientFail404();
      // act
      final fun = datasource.getHomdProducts;
      // assert
      expect(() => fun(), equals(throwsA(isA<ServerException>())));
    },
  );

  test(
    'should return home model when status code is 200 ok',
    () async {
      // arrange
      setUpMockClientSuccess200();
      // act
      final res = await datasource.getHomdProducts();
      // assert
      expect(res, equals(tHomeModelSuccess));
    },
  );
}
