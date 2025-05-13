import 'package:flutter/material.dart';
import 'package:mobile_pengguna/dashboard.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile_pengguna/detail_product.dart';
import 'package:mobile_pengguna/model/product_api.dart';
import 'package:mobile_pengguna/populer_product.dart';
import 'package:mobile_pengguna/product_empu.dart';

Future<void> main() async {
  await dotenv.load(fileName: 'assets/.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PopulerProduct(),
    );
  }
}
