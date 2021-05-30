import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../../../core/error/server_exception.dart';
import '../models/home_model.dart';

const _baseUrl = 'https://student.valuxapps.com/api/';

abstract class HomeGetHomeProducts {
  Future<HomeModel> getHomdProducts();
}

class HomeGetHomeProductsImpl implements HomeGetHomeProducts {
  final http.Client client;

  HomeGetHomeProductsImpl(this.client);

  @override
  Future<HomeModel> getHomdProducts() async {
    final response = await client.get(
      Uri.parse(_baseUrl + 'home'),
      headers: {'Content-Type': 'application/json', 'lang': 'en'},
    );
    if (response.statusCode == 200) {
      return HomeModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }
}
