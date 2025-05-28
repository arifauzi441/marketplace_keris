import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class UserApi {
  static final api = dotenv.env['API_URL'];
  int? idSeller;
  int? idAdmin;
  String? username;
  String? password;
  String? name;
  String? address;
  String? photo;
  String? phone;
  String? status;

  UserApi({
    required this.idSeller,
    required this.idAdmin,
    required this.username,
    required this.password,
    required this.name,
    required this.address,
    required this.phone,
    required this.photo,
    required this.status,
  });

  factory UserApi.createUserApi(Map<String, dynamic> object) {
    var data = object;
    if (data.containsKey('id_admin')) {
      return UserApi(
        idAdmin: data['id_admin'],
        idSeller: null,
        username: data['username'],
        password: data['password'],
        name: data['admin_name'],
        address: data['admin_address'],
        phone: data['admin_phone'],
        photo: data['admin_photo'],
        status: data['status'],
      );
    }

    return UserApi(
      idSeller: data['id_seller'],
      idAdmin: null,
      username: data['username'],
      password: data['password'],
      name: data['seller_name'],
      address: data['seller_address'],
      phone: data['seller_phone'],
      photo: data['seller_photo'],
      status: data['status'],
    );
  }

  static Future<UserApi> getUser(String token) async {
    String apiURL = '$api/users/admin';
    var apiResult = await http
        .get(Uri.parse(apiURL), headers: {"Authorization": "Bearer $token"});
    var userResult = json.decode(apiResult.body);
    print(userResult);
    return UserApi.createUserApi(userResult['data']);
  }

  static Future<Map<String, dynamic>> forgotPassword(String adminPhone) async {
    try {
      String apiURL = '$api/auth/forgotPassword';
      var apiResult = await http.post(Uri.parse(apiURL),
          body: {"role": "admin", "phone_number": adminPhone});

      var passResult = json.decode(apiResult.body);

      return {
        "msg": passResult['msg'],
        "status": apiResult.statusCode,
      };
    } catch (e) {
      print(e);
      return {"msg": e};
    }
  }

  static Future<Map<String, dynamic>> verifyCode(
      String codeVerification, String adminPhone) async {
    try {
      String apiURL = '$api/auth/verifyCode';
      var apiResult = await http.post(Uri.parse(apiURL), body: {
        "role": "admin",
        "phone_number": adminPhone,
        "verification_code": codeVerification
      });

      var passResult = json.decode(apiResult.body);

      return {
        "msg": passResult['msg'],
        "status": apiResult.statusCode,
        "token": passResult["token"]
      };
    } catch (e) {
      print(e);
      return {"msg": e};
    }
  }

  static Future<Map<String, dynamic>> ResetPassword(
      String token, String password, String confirmPassword) async {
    try {
      String apiURL = '$api/auth/changePassword';
      var apiResult = await http.post(Uri.parse(apiURL),
          body: {"password": password, "confirm_password": confirmPassword},
          headers: {"Authorization": "Bearer $token"});

      var passResult = json.decode(apiResult.body);

      return {
        "msg": passResult['msg'],
        "status": apiResult.statusCode,
      };
    } catch (e) {
      print(e);
      return {"msg": e};
    }
  }

  static Future<List<UserApi>> getAllUser(String token, String search) async {
    String apiURL = '$api/users/all-users?search=$search';
    var apiResult = await http.get(
      Uri.parse(apiURL),
      headers: {"Authorization": "Bearer $token"},
    );
    var userResult = json.decode(apiResult.body);

    List<UserApi> datas = (userResult['data'] as List)
        .map((data) => UserApi.createUserApi(data as Map<String, dynamic>))
        .toList();

    return datas;
  }

  static Future<Map<String, dynamic>> changeStatus(
      String token, String role, int id) async {
    String apiUrl = '$api/users/change-status/$role/$id';
    var apiResult =
        await http.get(Uri.parse(apiUrl), headers: {"Authorization": token});

    var statusResult = json.decode(apiResult.body);
    return {"msg": statusResult['msg'], 'status': apiResult.statusCode};
  }

  static Future<Map<String, dynamic>> changePassword(
      String token, String currPass, newPass, newPass2) async {
    try {
      String apiURL = '$api/users/change-password';
      var apiResult = await http.patch(Uri.parse(apiURL), body: {
        "oldPasswordInput": currPass,
        "newPasswordInput": newPass,
        "newPasswordInput2": newPass2
      }, headers: {
        "Authorization": token
      });

      var passResult = json.decode(apiResult.body);
      return {"msg": passResult['msg'], "status": apiResult.statusCode};
    } catch (e) {
      print(e);
      return {"msg": e};
    }
  }

  static Future<Map<String, dynamic>> updateUser(String token, File path,
      String name, String phone, String address) async {
    try {
      String apiURL = '$api/users/update';
      var apiResult = http.MultipartRequest("PATCH", Uri.parse(apiURL));
      apiResult.headers["Authorization"] = 'Bearer $token';
      apiResult.fields["seller_name"] = name;
      apiResult.fields["seller_address"] = address;
      apiResult.fields["seller_phone"] = phone;
      if (path.path.isNotEmpty) {
        String mimeType = lookupMimeType(path.path) ?? "";
        List<String> mimeParts = mimeType.split('/');
        apiResult.files.add(await http.MultipartFile.fromPath('path', path.path,
            contentType: MediaType(mimeParts[0], mimeParts[1])));
      }

      var response = await apiResult.send();
      var userResult = json.decode(await response.stream.bytesToString());

      return {"msg": userResult['msg'], "status": response.statusCode};
    } catch (e) {
      return {"msg": e};
    }
  }
}
