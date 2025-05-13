import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mime/mime.dart';
import 'package:mobile_pengguna/model/product_pict_api.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:intl/intl.dart';
import 'package:mobile_pengguna/model/user_api.dart';

class ProductApi {
  static final api = dotenv.env['API_URL'] ?? "";
  int? idProduct;
  String? productName;
  String? productPrice;
  String? productStock;
  String? productDescription;
  String? productStatus;
  List<ProductPictApi> productPict;
  UserApi? seller;

  ProductApi(
      {required this.idProduct,
      required this.productName,
      required this.productDescription,
      required this.productPrice,
      required this.productStock,
      required this.productStatus,
      required this.productPict,
      this.seller});

  factory ProductApi.createProductApi(Map<String, dynamic> object) {
    List<dynamic> temp = object['ProductPicts'] ?? [];

    return ProductApi(
        idProduct: object['id_product'],
        productName: object['product_name'],
        productDescription: object['product_description'],
        productStatus: object['product_status'],
        productPrice: NumberFormat.currency(
                locale: 'id_ID', symbol: 'Rp', decimalDigits: 0)
            .format(object['product_price']),
        productStock: object['product_stock'].toString(),
        productPict: temp
            .map((prodpict) => ProductPictApi.createProductPictApi(prodpict))
            .toList(),
        seller: UserApi.createUserApi({"data": object['Seller']}));
  }

  static Future<List<ProductApi>> getPopularProduct(String search) async {
    String apiURL = '$api/product/populer-product?search=$search';
    var apiResult = await http.get(
      Uri.parse(apiURL),
    );
    var userResult = json.decode(apiResult.body);

    List<ProductApi> datas = (userResult['product'] as List)
        .map(
            (data) => ProductApi.createProductApi(data as Map<String, dynamic>))
        .toList();

    return datas;
  }

  static Future<List<ProductApi>> getProductbySeller(int sellerId) async {
    String apiURL = '$api/product/seller/$sellerId';
    var apiResult = await http.get(
      Uri.parse(apiURL),
    );
    var userResult = json.decode(apiResult.body);

    List<ProductApi> datas = (userResult['product']['Products'] as List)
        .map((data) => ProductApi.createProductApi({"Seller":
              {"seller_name": userResult['product']['seller_name'],
              "seller_phone": userResult['product']['seller_phone'],
              "seller_photo": userResult['product']['seller_photo'],},
              ...data as Map<String, dynamic>
            }))
        .toList();

    return datas;
  }
}
