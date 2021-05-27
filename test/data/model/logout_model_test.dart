import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_test/features/authentication/data/model/logout_model.dart';
import 'package:tdd_test/features/authentication/domain/entity/logout_entity.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  final _logoutEntity =
      LogoutModel(status: true, message: 'Logout done successfully');

  test('register model should be  a subclass of register entity', () {
    expect(_logoutEntity, isA<LogoutEntity>());
  });

  group('FromJson', () {
    test(
      'should return logout model when from json is called',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            jsonDecode(fixture('logout_user.json'));
        // act
        final res = LogoutModel.fromJson(jsonMap);
        // assert
        expect(res, equals(_logoutEntity));
      },
    );
  });
}
