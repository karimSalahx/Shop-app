import 'package:flutter/cupertino.dart';
import '../../domain/entity/logout_entity.dart';

class LogoutModel extends LogoutEntity {
  LogoutModel({
    @required bool status,
    @required String message,
  }) : super(status: status, message: message);

  factory LogoutModel.fromJson(Map<String, dynamic> jsonMap) =>
      LogoutModel(status: jsonMap['status'], message: jsonMap['message']);
}
