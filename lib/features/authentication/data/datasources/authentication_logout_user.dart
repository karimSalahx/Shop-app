import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/server_exception.dart';
import '../model/logout_model.dart';

const _baseUrl = 'https://student.valuxapps.com/api/';
const CACHE_TOKEN = 'CACHE_TOKEN';

abstract class AuthenticationLogoutUser {
  Future<LogoutModel> logoutUser();
}

class AuthenticationLogoutUserImpl implements AuthenticationLogoutUser {
  final http.Client client;
  final SharedPreferences sharedPreferences;
  AuthenticationLogoutUserImpl({
    @required this.client,
    @required this.sharedPreferences,
  });
  @override
  Future<LogoutModel> logoutUser() async {
    final String token = sharedPreferences.getString(CACHE_TOKEN);
    final response = await client.post(
      Uri.parse(_baseUrl + 'logout'),
      headers: {
        'Content-Type': 'application/json',
        'lang': 'en',
        'Authorization': token,
      },
    );

    if (response.statusCode == 200) {
      final _logoutModel = LogoutModel.fromJson(jsonDecode(response.body));
      print(_logoutModel);
      if (_logoutModel.status == false)
        throw CredentialException(_logoutModel.message);
      else {
        bool hasKey = sharedPreferences.containsKey(CACHE_TOKEN);
        if (hasKey == true) {
          bool flag = await sharedPreferences.remove(CACHE_TOKEN);
          if (flag == false)
            throw CacheException();
          else
            return _logoutModel;
        } else
          return _logoutModel;
      }
    } else
      throw ServerException();
  }
}
