import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_test/features/authentication/data/model/login_model.dart';
import 'package:tdd_test/features/authentication/domain/entity/login_model.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
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

  test(
    'should be a subclass of Login Entity',
    () async {
      expect(tLoginModel, isA<LoginEntity>());
    },
  );

  group('FromJson', () {
    test(
      'should return Login Model when from json is called',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = jsonDecode(fixture('login.json'));
        // act
        final res = LoginModel.fromJson(jsonMap);
        // assert
        expect(res, equals(tLoginModel));
      },
    );
  });

  group('ToJson', () {
    test(
      'should convert object to json when to json is called',
      () {
        expect(tLoginModel.toJson(), equals(jsonDecode(fixture('login.json'))));
      },
    );
  });
}
