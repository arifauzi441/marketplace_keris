import 'package:flutter_dotenv/flutter_dotenv.dart';

class ProductPictApi {
  static final api = dotenv.env['API_URL'];
  String? path;
  int? idProductPict;

  ProductPictApi({required this.path, required this.idProductPict});

  factory ProductPictApi.createProductPictApi(Map<String, dynamic> object) {
    return ProductPictApi(
        path: "$api/${object['path']}",
        idProductPict: object['id_product_pict']);
  }
}
