import 'package:flutter/material.dart';
import 'package:mobile_pengguna/detail_produk.dart';
import 'package:mobile_pengguna/model/product_api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DetailProduk(
        token: "hai",
        product: ProductApi(
            idProduct: null,
            productName: null,
            productDescription: null,
            productPrice: null,
            productStock: null,
            productStatus: null,
            productPict: []),
      ),
    );
  }
}
