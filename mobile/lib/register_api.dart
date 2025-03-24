import 'dart:convert';

import 'package:http/http.dart' as http;

class RegisterApi {
  String msg = '';
  int statusCode = 0;

  RegisterApi({required this.msg, required this.statusCode});

  factory RegisterApi.createRegisterApi(Map<String, dynamic> object) {
    return RegisterApi(msg: object['msg'], statusCode: object['statusCode']);
  }

  static Future<RegisterApi> register(email, password, alamat) async {
    String apiURL = "http://192.168.113.10:3000/auth/register";
    var apiResult = await http.post(Uri.parse(apiURL),
        body: {"email": email, "password": password, "alamat": alamat});

    var registerResult = json.decode(apiResult.body);

    return RegisterApi.createRegisterApi(
        {...registerResult, "statusCode": apiResult.statusCode});
  }
}
