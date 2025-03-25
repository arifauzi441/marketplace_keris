class ProductPictApi {
  String? path;
  int? idProductPict;

  ProductPictApi({required this.path, required this.idProductPict});

  factory ProductPictApi.createProductPictApi(Map<String, dynamic> object) {
    return ProductPictApi(
        path: "http://localhost:3000/${object['path']}",
        idProductPict: object['id_product_pict']);
  }
}
