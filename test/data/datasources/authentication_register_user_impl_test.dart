import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:tdd_test/core/error/server_exception.dart';
import 'package:tdd_test/features/authentication/data/datasources/authentication_register_user.dart';
import 'package:tdd_test/features/authentication/data/model/register_model.dart';
import 'package:tdd_test/features/authentication/domain/usecases/register_user.dart';

import '../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

const _baseUrl = 'https://student.valuxapps.com/api/';
void main() {
  AuthenticationRegisterUserImpl registerUserImpl;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    registerUserImpl = AuthenticationRegisterUserImpl(mockHttpClient);
  });

  group('Register User', () {
    final tRegisterParam = RegisterParamModel(
      name: "Abdelrahman ALgazzar",
      phone: "12384678",
      email: "algazza.abdelrahman@gmaill.com",
      password: "123456",
    );
    final tRegisterDataModel = RegisterDataModel(
      name: "Abdelrahman ALgazzar",
      phone: "12384678",
      email: "algazza.abdelrahman@gmaill.com",
      id: 943,
      token:
          "54jjNlhivnYE1ylZqfs9CIxBcT1Gezb8RKQ282DSkUqoODMLSr04hggQOsWmkzTx6coMix",
    );
    final tRegisterModel = RegisterModel(
      status: true,
      message: "Registration done successfully",
      data: tRegisterDataModel,
    );

    void setUpMockClientSuccess200() {
      when(
        mockHttpClient.post(
          any,
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          fixture('register.json'),
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

    void setUpMockClientSuccess200ButFailureInput() {
      when(
        mockHttpClient.post(
          any,
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          fixture('failure_register.json'),
          200,
        ),
      );
    }

    test(
      '''
            should perform a POST request on a url
            with Register param being the end point
            and with application-content json header 
      ''',
      () async {
        // arrange
        setUpMockClientSuccess200();
        // act
        await registerUserImpl.registerUser(tRegisterParam);

        // assert
        verify(
          mockHttpClient.post(Uri.parse(_baseUrl + 'register'),
              headers: {'Content-Type': 'application/json', 'lang': 'en'},
              body: jsonEncode(<String, String>{
                'name': tRegisterParam.name,
                'phone': tRegisterParam.phone,
                'email': tRegisterParam.email,
                'password': tRegisterParam.password,
              })),
        );
      },
    );
    test(
      'should throw server exception if response code is not 200',
      () async {
        // arrange
        setUpMockHttpClientFail();
        // act
        final fun = registerUserImpl.registerUser;
        // assert
        expect(() => fun(tRegisterParam), throwsA(isA<ServerException>()));
      },
    );

    test(
      'should throw credential exception if response code is 200 and status is failed',
      () async {
        // arrange
        setUpMockClientSuccess200ButFailureInput();
        // act
        final fun = registerUserImpl.registerUser;
        // assert
        expect(() => fun(tRegisterParam), throwsA(isA<CredentialException>()));
      },
    );
    test(
      'should return login model when response code is 200',
      () async {
        // arrange
        setUpMockClientSuccess200();
        // act
        final res = await registerUserImpl.registerUser(tRegisterParam);
        // assert
        expect(res, equals(tRegisterModel));
      },
    );
  });
}
