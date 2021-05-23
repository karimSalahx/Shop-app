import 'package:http/http.dart' as http;
import '../model/register_model.dart';
import '../../domain/usecases/register_user.dart';

abstract class AuthenticationRegisterUser {
  Future<RegisterModel> registerUser(RegisterParamModel param);
}

class AuthenticationRegisterUserImpl implements AuthenticationRegisterUser {
  final http.Client client;
  AuthenticationRegisterUserImpl(this.client);
  @override
  Future<RegisterModel> registerUser(RegisterParamModel param) {}
}
