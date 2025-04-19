import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mime/mime.dart';
import 'package:mobile/model/product_pict_api.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:intl/intl.dart';

class ProductApi {
  static final api = dotenv.env['API_URL'] ?? "";
  int? idProduct;
  String? productName;
  String? productPrice;
  String? productDescription;
  List<ProductPictApi> productPict;

  ProductApi(
      {required this.idProduct,
      required this.productName,
      required this.productDescription,
      required this.productPrice,
      required this.productPict});

  factory ProductApi.createProductApi(Map<String, dynamic> object) {
    List<dynamic> temp = object['ProductPicts'] ?? [];

    return ProductApi(
        idProduct: object['id_product'],
        productName: object['product_name'],
        productDescription: object['product_description'],
        productPrice: NumberFormat.currency(
                locale: 'id_ID', symbol: 'Rp', decimalDigits: 0)
            .format(object['product_price']),
        productPict: temp
            .map((prodpict) => ProductPictApi.createProductPictApi(prodpict))
            .toList());
  }

  static Future<Map<String, dynamic>> storeProduct(String name,
      String description, int price, int stock, List<File> path, String token) async {
    String apiUrl = '$api/product/store';
    var apiResult = http.MultipartRequest('POST', Uri.parse(apiUrl));
    apiResult.headers['Authorization'] = "Bearer $token";
    apiResult.fields['product_name'] = name;
    apiResult.fields['product_price'] = price.toString();
    apiResult.fields['product_stock'] = stock.toString();
    apiResult.fields['product_description'] = description.toString();
    for (var p in path) {
      if (p.path.isNotEmpty) {
        String mimeType = lookupMimeType(p.path) ?? "";
        List<String> mimeParts = mimeType.split('/');
        apiResult.files.add(await http.MultipartFile.fromPath('path', p.path,
            contentType: MediaType(mimeParts[0], mimeParts[1])));
      }
    }

    var response = await apiResult.send();
    var productResult = json.decode(await response.stream.bytesToString());
    return {"msg": productResult['msg'], "status": response.statusCode};
  }

  static Future<Map<String, dynamic>> updateProduct(String name, String description, int price, ) async{
    return await {"nama": 89};
  }

  static Future<Map<String, dynamic>> deleteProduct(int idProduct, String token) async {
    String apiURL = '$api/product/delete/$idProduct';
    var apiResult = await http.delete(Uri.parse(apiURL), headers: {"Authorization": token});

    var productResult = json.decode(apiResult.body);
    return {"msg": productResult['msg'], "status": apiResult.statusCode};
  }

}
