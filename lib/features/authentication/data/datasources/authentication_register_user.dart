import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../../../core/error/server_exception.dart';
import '../model/register_model.dart';
import '../../domain/usecases/register_user.dart';

abstract class AuthenticationRegisterUser {
  Future<RegisterModel> registerUser(RegisterParamModel param);
}

const _baseUrl = 'https://student.valuxapps.com/api/';

class AuthenticationRegisterUserImpl implements AuthenticationRegisterUser {
  final http.Client client;
  AuthenticationRegisterUserImpl(this.client);
  @override
  Future<RegisterModel> registerUser(RegisterParamModel param) async {
    final http.Response response = await client.post(
      Uri.parse(_baseUrl + 'register'),
      headers: {'Content-Type': 'application/json', 'lang': 'en'},
    );
    if (response.statusCode == 200) {
      final _registerModel = RegisterModel.fromJson(jsonDecode(response.body));
      if (_registerModel.status == false)
        throw CredentialException(_registerModel.message);
      else
        return _registerModel;
    } else {
      throw ServerException();
    }
  }
}
