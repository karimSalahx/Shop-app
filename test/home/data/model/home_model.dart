import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_test/features/home/data/models/home_model.dart';
import 'package:tdd_test/features/home/domain/entity/home_entity.dart';

import '../../../authentication/fixtures/fixture_reader.dart';

void main() {
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

  test(
    'should be a subclass of Login Entity',
    () async {
      expect(tHomeModelSuccess, isA<HomeEntity>());
    },
  );

  group('FromJson', () {
    test(
      'should return Login Model when from json is called',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            jsonDecode(fixture('home_model_simplified.json'));
        // act
        final res = HomeModel.fromJson(jsonMap);
        // assert
        expect(res, equals(tHomeModelSuccess));
      },
    );
  });

  group('ToJson', () {
    test(
      'should convert object to json when to json is called',
      () {
        expect(
          tHomeModelSuccess.toJson(),
          equals(
            jsonDecode(
              fixture(
                'home_model_simplified.json',
              ),
            ),
          ),
        );
      },
    );
  });
}
