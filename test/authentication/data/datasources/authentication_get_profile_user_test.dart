import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdd_test/core/error/server_exception.dart';
import 'package:tdd_test/features/authentication/data/datasources/authentication_get_profile_user.dart';
import 'package:tdd_test/features/authentication/data/model/profile_model.dart';
import 'package:tdd_test/features/authentication/domain/usecases/get_profile_user.dart';

import '../../fixtures/authentication_fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

class MockHttpClient extends Mock implements http.Client {}

const CACHE_TOKEN = 'CACHE_TOKEN';
const _baseUrl = 'https://student.valuxapps.com/api/';

void main() {
  MockSharedPreferences sharedPreferences;
  MockHttpClient client;
  AuthenticationGetProfileUserImpl datasource;
  setUp(() {
    sharedPreferences = MockSharedPreferences();
    client = MockHttpClient();
    datasource = AuthenticationGetProfileUserImpl(
      client: client,
      sharedPreferences: sharedPreferences,
    );
  });

  String tToken =
      'EJ6DKErwawaaE7LnVvUMERonSjhi3T3H337Cgm2dwxetTQoS8GWm3DYnei0SpuR9lqTdZc';

  final tProfileEntity = ProfileModel(
    status: true,
    message: null,
    data: ProfileDataModel(
      id: 613,
      name: "Abdelrahman ALgazzar",
      email: "karemmohamed2002@gmail.com",
      phone: "123456728",
      image:
          "https://student.valuxapps.com/storage/uploads/users/igYRtX84xb_1619709039.jpeg",
      points: 0,
      credit: 0,
      token:
          "mIcOIfLRlGiCbasuoKSwjIl6RbmaTixN0JTrP4Ea77YVLO1WewhwA8SHb55mjATPy7YiOK",
    ),
  );

  group(
    'Login',
    () {
      void setUpMockClientSuccess200() {
        when(
          client.get(
            any,
            headers: anyNamed('headers'),
          ),
        ).thenAnswer(
          (_) async => http.Response(
            authenticationFixture('success_profile.json'),
            200,
          ),
        );
      }

      void setUpMockClientSuccess200ButFailureInput() {
        when(
          client.get(
            any,
            headers: anyNamed('headers'),
          ),
        ).thenAnswer(
          (_) async => http.Response(
            authenticationFixture('failure_profile.json'),
            200,
          ),
        );
      }

      void setUpMockHttpClientFail() {
        when(
          client.get(
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
        '''
       should perform GET request on base url with tToken in 
       headers as Authorization and lang as en
       and with application-content json header
       ''',
        () async {
          // arrange
          setUpMockClientSuccess200();
          // act
          await datasource.getProfileUser(TokenParam(tToken));
          // assert
          verify(
            client.get(
              Uri.parse(_baseUrl + 'profile'),
              headers: <String, String>{
                'Content-Type': 'application/json',
                'lang': 'en',
                'Authorization': tToken,
              },
            ),
          );
        },
      );
      test(
        'should return Profile Model if status code is 200 ok',
        () async {
          // arrange
          setUpMockClientSuccess200();
          // act
          final res = await datasource.getProfileUser(TokenParam(tToken));
          // assert
          expect(res, equals(tProfileEntity));
        },
      );

      test(
        'should throw server exception if response code is not 200',
        () async {
          // arrange
          setUpMockHttpClientFail();
          // act
          final fun = datasource.getProfileUser;
          // assert
          expect(
            () => fun(TokenParam(tToken)),
            throwsA(
              isA<ServerException>(),
            ),
          );
        },
      );
      // TODO Fix This!
      // test(
      //   'should throw credentials exception if status is failure',
      //   () async {
      //     // arrange
      //     setUpMockClientSuccess200ButFailureInput();
      //     // act
      //     final fun = datasource.getProfileUser;
      //     // assert
      //     expect(
      //       () => fun(TokenParam(tToken)),
      //       throwsA(
      //         isA<CredentialException>(),
      //       ),
      //     );
      //   },
      // );
    },
  );
}
