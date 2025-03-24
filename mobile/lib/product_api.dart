import 'dart:convert';
import 'dart:io';

import 'package:mime/mime.dart';
import 'package:mobile/product_pict_api.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:intl/intl.dart';

class ProductApi {
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
      String description, int price, List<File> path, String token) async {
    String apiUrl = 'http://192.168.113.10:3000/product/store';
    print(path.toString());
    var apiResult = await http.MultipartRequest('POST', Uri.parse(apiUrl));
    apiResult.headers['Authorization'] = "Bearer $token";
    apiResult.fields['product_name'] = name;
    apiResult.fields['product_price'] = price.toString();
    apiResult.fields['product_description'] = description.toString();
    for (var p in path) {
      print(p.path);
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
}
