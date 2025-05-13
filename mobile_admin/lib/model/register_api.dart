import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class RegisterApi {
  static final api = dotenv.env['API_URL'];
  String msg = '';
  int statusCode = 0;

  RegisterApi({required this.msg, required this.statusCode});

  factory RegisterApi.createRegisterApi(Map<String, dynamic> object) {
    return RegisterApi(msg: object['msg'], statusCode: object['statusCode']);
  }

  static Future<RegisterApi> register(username, password, phone) async {
    String apiURL = "$api/auth/register-admin";
    var apiResult = await http.post(Uri.parse(apiURL),
        body: {"username": username, "password": password, "admin_phone": phone});

    var registerResult = json.decode(apiResult.body);

    return RegisterApi.createRegisterApi(
        {...registerResult, "statusCode": apiResult.statusCode});
  }
}
