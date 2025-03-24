import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile/product_api.dart';

class UserApi {
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
    String apiURL = 'http://192.168.113.10:3000/users/seller';
    var apiResult = await http
        .get(Uri.parse(apiURL), headers: {"Authorization": "Bearer $token"});

    var userResult = json.decode(apiResult.body);
    return UserApi.createUserApi(userResult);
  }
}
