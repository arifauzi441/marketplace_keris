import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_pengguna/model/product_api.dart';

class UserApi {
  static final api = dotenv.env['API_URL'];
  int? idSeller;
  String? username;
  String? sellerName;
  String? sellerAddress;
  String? sellerPhoto;
  String? sellerPhone;
  List<ProductApi>? product;

  UserApi(
      {this.idSeller,
      this.username,
      this.sellerName,
      this.sellerAddress,
      this.sellerPhone,
      this.sellerPhoto,
      this.product});

  factory UserApi.createUserApi(Map<String, dynamic> object) {
    var data = object['data'];
    if (data == null) {
      throw Exception("Response tidak memiliki key 'data'");
    }
    List<dynamic> temp = data['Products'] ?? [];

    return UserApi(
        idSeller: data['id_seller'],
        username: data['username'],
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
    return UserApi.createUserApi(userResult);
  }

  static Future<List<UserApi>> getAllSeller(String search) async {
    try {
      String apiURL = '$api/users/all-seller?search=$search';
      var apiResult = await http.get(Uri.parse(apiURL), headers: {
        'ngrok-skip-browser-warning': 'true'
      }).timeout(Duration(seconds: 5));

      var userResult = json.decode(apiResult.body);
      List<UserApi> datas = (userResult['data'] as List)
          .map((data) =>
              UserApi.createUserApi({"data": data as Map<String, dynamic>}))
          .toList();

      return datas;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
