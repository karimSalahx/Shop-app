import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_test/features/authentication/data/model/profile_model.dart';
import 'package:tdd_test/features/authentication/domain/entity/profile_entity.dart';

import '../../fixtures/authentication_fixture_reader.dart';

void main() {
  final tProfileModel = ProfileModel(
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

  test(
    'should be a subclass of Profile Entity',
    () async {
      expect(tProfileModel, isA<ProfileEntity>());
    },
  );

  group('FromJson', () {
    test(
      'should return Profile Model when from json is called',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            jsonDecode(authenticationFixture('success_profile.json'));
        // act
        final res = ProfileModel.fromJson(jsonMap);
        // assert
        expect(res, equals(tProfileModel));
      },
    );
  });

  group('ToJson', () {
    test(
      'should convert json to register model when to json is called',
      () async {
        expect(
          tProfileModel.toJson(),
          jsonDecode(
            authenticationFixture(
              'success_profile.json',
            ),
          ),
        );
      },
    );
  });
}
