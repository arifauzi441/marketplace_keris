import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:mobile/model/product_api.dart';

class UserApi {
  static final api = dotenv.env['API_URL'];
  int? idSeller;
  String? email;
  String? password;
  String? sellerName;
  String? sellerAddress;
  String? sellerPhoto;
  String? sellerPhone;
  List<ProductApi> product;

  UserApi(
      {required this.idSeller,
      required this.email,
      required this.password,
      required this.sellerName,
      required this.sellerAddress,
      required this.sellerPhone,
      required this.sellerPhoto,
      required this.product});

  factory UserApi.createUserApi(Map<String, dynamic> object) {
    var data = object['data'];
    List<dynamic> temp = data['Products'] ?? [];

    return UserApi(
        idSeller: data['id_seller'],
        email: data['email'],
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
    var apiResult = await http
        .get(Uri.parse(apiURL), headers: {"Authorization": "Bearer $token"});

    var userResult = json.decode(apiResult.body);
    return UserApi.createUserApi(userResult);
  }

  static Future<Map<String, dynamic>> updateUser(String token, File path,
      String name, String phone, String address) async {
    String mime = '';
    try {
      String apiURL = '$api/users/update';
      var apiResult = http.MultipartRequest("PATCH", Uri.parse(apiURL));
      apiResult.headers["Authorization"] = 'Bearer $token';
      apiResult.fields["seller_name"] = name;
      apiResult.fields["seller_address"] = address;
      apiResult.fields["seller_phone"] = phone;
      if (path.path.isNotEmpty) {
        String mimeType = lookupMimeType(path.path) ?? "";
        String mime = mimeType;
        List<String> mimeParts = mimeType.split('/');
        apiResult.files.add(await http.MultipartFile.fromPath('path', path.path,
            contentType: MediaType(mimeParts[0], mimeParts[1])));
      }

      var response = await apiResult.send();
      var userResult = json.decode(await response.stream.bytesToString());

      return {"msg": userResult['msg'], "status": response.statusCode};
    } catch (e) {
      return {"msg": lookupMimeType(path.path)};
    }
  }
}
