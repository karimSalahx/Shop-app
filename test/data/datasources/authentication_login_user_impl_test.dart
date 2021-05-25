import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdd_test/core/error/server_exception.dart';
import 'package:tdd_test/features/authentication/data/datasources/authentication_login_user.dart';
import 'package:tdd_test/features/authentication/data/model/login_model.dart';

import '../../fixtures/fixture_reader.dart';

class MockSharedPreferneces extends Mock implements SharedPreferences {}

class MockHttpClient extends Mock implements http.Client {}

const CACHE_TOKEN = 'CACHE_TOKEN';
const _baseUrl = 'https://student.valuxapps.com/api/';
void main() {
  AuthenticationLoginUserImpl loginUserImpl;
  MockSharedPreferneces mockSharedPreferneces;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    mockSharedPreferneces = MockSharedPreferneces();
    loginUserImpl = AuthenticationLoginUserImpl(
      sharedPreferences: mockSharedPreferneces,
      client: mockHttpClient,
    );
  });

  final tDataModel = LoginDataModel(
    id: 613,
    name: "Abdelrahman ALgazzar",
    email: "karemmohamed2002@gmail.com",
    phone: "123456728",
    points: 0,
    credit: 0,
    token:
        "tCzXE8ITM0752meGP5DKhZL7SEkCbUbutfj4pxlXFgMGmO7lttZQlM9SfqOryJVNPZJskm",
  );
  final tLoginModel = LoginModel(
    status: true,
    message: "Login done successfully",
    data: tDataModel,
  );

  final temail = 'user@gmail.com';
  final tPassword = '12345';
  final tToken = tLoginModel.data.token;

  group('Cache Token', () {
    test(
      'should return true if cache token is successful',
      () async {
        // arrange
        when(mockSharedPreferneces.setString(any, any)).thenAnswer(
          (_) async => true,
        );
        // act
        final res = await loginUserImpl.cacheToken(tToken);
        // assert
        verify(mockSharedPreferneces.setString(CACHE_TOKEN, tToken));
        expect(res, equals(true));
      },
    );
  });

  group('Login User', () {
    void setUpMockClientSuccess200() {
      when(
        mockHttpClient.post(
          any,
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          fixture('login.json'),
          200,
        ),
      );
    }

    void setUpMockClientSuccess200ButFailureInput() {
      when(
        mockHttpClient.post(
          any,
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          fixture('failure_login.json'),
          200,
        ),
      );
    }

    void setUpMockHttpClientFail() {
      when(
        mockHttpClient.post(
          any,
          headers: anyNamed('headers'),
          body: anyNamed('body'),
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
            should perform a POST request on a url
            with email and password being the end point
            and with application-content json header 
      ''',
      () async {
        // arrange
        setUpMockClientSuccess200();
        // act
        await loginUserImpl.loginUser(email: temail, password: tPassword);

        // assert
        verify(
          mockHttpClient.post(
            Uri.parse(_baseUrl + 'login'),
            body: jsonEncode(
              <String, String>{'email': temail, 'password': tPassword},
            ),
            headers: {'Content-Type': 'application/json', 'lang': 'en'},
          ),
        );
      },
    );
    test(
      'should throw server exception if response code is not 200',
      () async {
        // arrange
        setUpMockHttpClientFail();
        // act
        final fun = loginUserImpl.loginUser;
        // assert
        expect(() => fun(email: temail, password: tPassword),
            throwsA(isA<ServerException>()));
      },
    );

    test(
      'should throw credentials exception if status is failure',
      () async {
        // arrange
        setUpMockClientSuccess200ButFailureInput();
        // act
        final fun = loginUserImpl.loginUser;
        // assert
        expect(() => fun(email: temail, password: tPassword),
            throwsA(isA<CredentialException>()));
      },
    );

    test(
      'should return login model when response code is 200',
      () async {
        // arrange
        setUpMockClientSuccess200();
        // act
        final res =
            await loginUserImpl.loginUser(email: temail, password: tPassword);
        // assert
        expect(res, equals(tLoginModel));
      },
    );
  });
}
