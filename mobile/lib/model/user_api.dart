import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:mobile/model/product_api.dart';

class UserApi {
  static final api = dotenv.env['API_URL'];
  int? idSeller;
  String? username;
  String? password;
  String? sellerName;
  String? sellerAddress;
  String? sellerPhoto;
  String? sellerPhone;
  List<ProductApi> product;

  UserApi(
      {required this.idSeller,
      required this.username,
      required this.password,
      required this.sellerName,
      required this.sellerAddress,
      required this.sellerPhone,
      required this.sellerPhoto,
      required this.product});

  factory UserApi.createUserApi(Map<String, dynamic> object) {
    var data = object['data'];
    if (data == null) {
      throw Exception("Response tidak memiliki key 'data'");
    }
    List<dynamic> temp = data['products'] ?? [];

    return UserApi(
        idSeller: data['id_seller'],
        username: data['username'],
        password: data['password'],
        sellerName: data['seller_name'],
        sellerAddress: data['seller_address'],
        sellerPhone: data['seller_phone'],
        sellerPhoto: data['seller_photo'],
        product:
            temp.map((prod) => ProductApi.createProductApi(prod)).toList());
  }

  static Future<UserApi> getUser(String token) async {
    String apiURL = '$api/users/seller';
    var apiResult = await http.get(Uri.parse(apiURL), headers: {
      "Authorization": "Bearer $token",
      'ngrok-skip-browser-warning': 'true'
    });
    var userResult = json.decode(apiResult.body);
    print(userResult);
    if (userResult['data'] == null) {
      return UserApi(
          idSeller: null,
          username: null,
          password: null,
          sellerName: null,
          sellerAddress: null,
          sellerPhone: null,
          sellerPhoto: null,
          product: []);
    }
    return UserApi.createUserApi(userResult);
  }

  static Future<Map<String, dynamic>> forgotPassword(String sellerPhone) async {
    try {
      String apiURL = '$api/auth/forgotPassword';
      var apiResult = await http.post(Uri.parse(apiURL),
          body: {"role": "seller", "phone_number": sellerPhone},
          headers: {'ngrok-skip-browser-warning': 'true'});

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
      String codeVerification, String sellerPhone) async {
    try {
      String apiURL = '$api/auth/verifyCode';
      var apiResult = await http.post(Uri.parse(apiURL), body: {
        "role": "seller",
        "phone_number": sellerPhone,
        "verification_code": codeVerification
      }, headers: {
        'ngrok-skip-browser-warning': 'true'
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
      var apiResult = await http.post(Uri.parse(apiURL), body: {
        "password": password,
        "confirm_password": confirmPassword
      }, headers: {
        "Authorization": "Bearer $token",
        'ngrok-skip-browser-warning': 'true'
      });

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

  static Future<Map<String, dynamic>> changePassword(
      String token, String currPass, newPass, newPass2) async {
    try {
      String apiURL = '$api/users/change-password';
      var apiResult = await http.patch(Uri.parse(apiURL), body: {
        "oldPasswordInput": currPass,
        "newPasswordInput": newPass,
        "newPasswordInput2": newPass2
      }, headers: {
        "Authorization": token,
        'ngrok-skip-browser-warning': 'true'
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
      apiResult.headers['ngrok-skip-browser-warning'] = 'true';
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
      print(response.statusCode);
      var userResult = json.decode(await response.stream.bytesToString());
      return {"msg": userResult['msg'], "status": response.statusCode};
    } catch (e) {
      print(e.toString());
      return {"msg": e.toString()};
    }
  }
}
