import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_test/features/authentication/data/model/register_model.dart';
import 'package:tdd_test/features/authentication/domain/entity/register_model.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  final tName = "Abdelrahman ALgazzar";
  final tPhone = "12384678";
  final tEmail = "algazza.abdelrahman@gmaill.com";

  final tRegisterData = RegisterDataModel(
    name: tName,
    phone: tPhone,
    email: tEmail,
    id: 943,
    token:
        "54jjNlhivnYE1ylZqfs9CIxBcT1Gezb8RKQ282DSkUqoODMLSr04hggQOsWmkzTx6coMix",
  );
  final tRegisterModel = RegisterModel(
    status: true,
    message: "Registration done successfully",
    data: tRegisterData,
  );

  test('register model should be  a subclass of register entity', () {
    expect(tRegisterModel, isA<RegisterEntity>());
  });

  group('FromJson', () {
    test(
      'should return register model when from json is called',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            jsonDecode(fixture('register.json'));
        // act
        final res = RegisterModel.fromJson(jsonMap);
        // assert
        expect(res, equals(tRegisterModel));
      },
    );
  });

  group('ToJson', () {
    test(
      'should convert json to register model when to json is called',
      () async {
        expect(tRegisterModel.toJson(), jsonDecode(fixture('register.json')));
      },
    );
  });
}
