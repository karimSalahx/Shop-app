import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdd_test/core/error/server_exception.dart';
import 'package:tdd_test/features/authentication/data/model/profile_model.dart';
import 'package:tdd_test/features/authentication/domain/usecases/get_profile_user.dart';

abstract class AuthenticationGetProfileUser {
  Future<ProfileModel> getProfileUser(TokenParam token);
}

const _baseUrl = 'https://student.valuxapps.com/api/';

class AuthenticationGetProfileUserImpl implements AuthenticationGetProfileUser {
  final SharedPreferences sharedPreferences;
  final http.Client client;
  AuthenticationGetProfileUserImpl({
    @required this.sharedPreferences,
    @required this.client,
  });
  @override
  Future<ProfileModel> getProfileUser(TokenParam token) async {
    final http.Response res = await client.get(
      Uri.parse(_baseUrl + 'profile'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'lang': 'en',
        'Authorization': token.token,
      },
    );
    if (res.statusCode == 200) {
      // jsonDecode to convert from json to map
      final _profileModel = ProfileModel.fromJson(jsonDecode(res.body));
      if (_profileModel.status == false)
        throw CredentialException('Not Authorized');
      else
        return _profileModel;
    } else
      throw ServerException();
  }
}
