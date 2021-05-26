import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/server_exception.dart';
import '../model/login_model.dart';

const _baseUrl = 'https://student.valuxapps.com/api/';

abstract class AuthenticationLoginUser {
  Future<LoginModel> loginUser({
    @required String email,
    @required String password,
  });

  Future<bool> cacheToken(String token);
}

const CACHE_TOKEN = 'CACHE_TOKEN';

class AuthenticationLoginUserImpl implements AuthenticationLoginUser {
  SharedPreferences sharedPreferences;
  http.Client client;
  AuthenticationLoginUserImpl({
    @required this.sharedPreferences,
    @required this.client,
  });
  @override
  Future<bool> cacheToken(String token) async {
    bool res = await sharedPreferences.setString(CACHE_TOKEN, token);
    if (res == true)
      return res;
    else
      throw CacheException();
  }

  @override
  Future<LoginModel> loginUser({
    @required String email,
    @required String password,
  }) async {
    final http.Response response = await client.post(
      Uri.parse(_baseUrl + 'login'),
      body: jsonEncode(
        <String, String>{'email': email, 'password': password},
      ),
      headers: {'Content-Type': 'application/json', 'lang': 'en'},
    );
    if (response.statusCode == 200) {
      final _loginModel = LoginModel.fromJson(jsonDecode(response.body));
      if (_loginModel.status == false)
        throw CredentialException(_loginModel.message);
      else
        return _loginModel;
    } else {
      throw ServerException();
    }
  }
}
