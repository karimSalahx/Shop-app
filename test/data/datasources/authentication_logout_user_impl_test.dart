import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdd_test/core/error/server_exception.dart';
import 'package:tdd_test/features/authentication/data/datasources/authentication_logout_user.dart';
import 'package:tdd_test/features/authentication/data/model/logout_model.dart';

import '../../fixtures/fixture_reader.dart';

class MockSharedPreferneces extends Mock implements SharedPreferences {}

class MockHttpClient extends Mock implements http.Client {}

const CACHE_TOKEN = 'CACHE_TOKEN';
const _baseUrl = 'https://student.valuxapps.com/api/';

void main() {
  AuthenticationLogoutUserImpl logoutUserImpl;
  MockSharedPreferneces mockSharedPreferneces;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    mockSharedPreferneces = MockSharedPreferneces();
    logoutUserImpl = AuthenticationLogoutUserImpl(
      sharedPreferences: mockSharedPreferneces,
      client: mockHttpClient,
    );
  });

  final _logoutEntity =
      LogoutModel(status: true, message: 'Logout done successfully');
  final tToken =
      'tdxlV4nUV8Jex8AKSIIX1uYECciKbTByz0l3OSfMEUawePy7bnX929cRKOnEF7rRaOa23J';

  group('Logout', () {
    void setUpMockClientSuccess200() {
      when(
        mockHttpClient.post(
          any,
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          fixture('logout_user.json'),
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
          fixture('logout_failure.json'),
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
      Should make post request on logout endpoint 
      with content type json and lang
      eng and authorization 
      ''',
      () async {
        // arrange
        setUpMockClientSuccess200();
        // act
        await logoutUserImpl.logoutUser(tToken);
        // assert
        verify(
          mockHttpClient.post(
            Uri.parse(_baseUrl + 'logout'),
            headers: {'Content-Type': 'application/json', 'lang': 'en'},
            body: jsonEncode(<String, String>{'Authorization': tToken}),
          ),
        );
      },
    );

    test(
      'should throw server exception when the status code is not 200',
      () async {
        // arrange
        setUpMockHttpClientFail();
        // act
        final fun = logoutUserImpl.logoutUser;
        // assert
        expect(() => fun(tToken), throwsA(isA<ServerException>()));
      },
    );
    test(
      'should throw credential exception when the status code is 200 but status is false',
      () async {
        // arrange
        setUpMockClientSuccess200ButFailureInput();
        // act
        final fun = logoutUserImpl.logoutUser;
        // assert
        expect(() => fun(tToken), throwsA(isA<CredentialException>()));
      },
    );

    test(
      'should remove cache token key when status code is 200',
      () async {
        // arrange

        setUpMockClientSuccess200();
        when(mockSharedPreferneces.containsKey(any)).thenReturn(true);
        when(mockSharedPreferneces.remove(any)).thenAnswer((_) async => true);
        // act
        await logoutUserImpl.logoutUser(tToken);
        // assert
        verify(mockSharedPreferneces.remove(CACHE_TOKEN));
      },
    );

    test(
      'should throw cache exception when logout flag is false',
      () async {
        // arrange
        setUpMockClientSuccess200();
        when(mockSharedPreferneces.containsKey(any)).thenReturn(true);
        when(mockSharedPreferneces.remove(any)).thenAnswer((_) async => false);
        // act
        final fun = logoutUserImpl.logoutUser;
        // assert
        expect(() => fun(tToken), throwsA(isA<CacheException>()));
      },
    );

    test(
      'should return Login Model when the contains key is false',
      () async {
        // arrange
        setUpMockClientSuccess200();
        when(mockSharedPreferneces.containsKey(any)).thenReturn(false);
        // act
        final res = await logoutUserImpl.logoutUser(tToken);
        // assert
        verifyNever(mockSharedPreferneces.remove(any));
        expect(res, equals(_logoutEntity));
      },
    );

    test(
      'should return login model when contains key is true and remove is true',
      () async {
        // arrange
        setUpMockClientSuccess200();
        when(mockSharedPreferneces.containsKey(any)).thenReturn(true);
        when(mockSharedPreferneces.remove(any)).thenAnswer((_) async => true);
        // act
        final res = await logoutUserImpl.logoutUser(tToken);
        // assert
        expect(res, equals(_logoutEntity));
      },
    );
  });
}
