import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_test/core/error/failures.dart';
import 'package:tdd_test/features/home/data/models/home_model.dart';
import 'package:tdd_test/features/home/domain/usecases/get_home_products.dart';
import 'package:tdd_test/features/home/presentation/bloc/bloc/home_bloc.dart';
import 'package:tdd_test/usecases.dart';

class MockGetHomeProducts extends Mock implements GetHomeProducts {}

void main() {
  HomeBloc bloc;
  MockGetHomeProducts mockGetHomeProducts;
  setUp(() {
    mockGetHomeProducts = MockGetHomeProducts();
    bloc = HomeBloc(getHomeProducts: mockGetHomeProducts);
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

  test(
    'should emit home initial as the initial state',
    () async {
      expect(bloc.state, equals(HomeInitial()));
    },
  );

  test(
    'should call get home products when event is get home products event',
    () async {
      // arrange
      when(mockGetHomeProducts(any))
          .thenAnswer((_) async => Right(tHomeModelSuccess));
      // act
      bloc.add(GetHomeProductsEvent());
      // assert
      await untilCalled(mockGetHomeProducts(any));
      verify(mockGetHomeProducts(NoParam()));
    },
  );

  test(
    '''
         should emit [HomeLoadingState,HomeErrorState]
         with a proper message for the error
         when get home products get server failure
  ''',
    () async {
      when(mockGetHomeProducts(any))
          .thenAnswer((_) async => Left(ServerFailure()));
      final expected = [
        HomeLoadingState(),
        HomeErrorState(SERVER_FAILURE_MESSAGE)
      ];
      bloc.add(GetHomeProductsEvent());
      expectLater(bloc.stream, emitsInOrder(expected));
      await untilCalled(mockGetHomeProducts(any));
    },
  );
}
