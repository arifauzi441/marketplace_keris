import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_application_mobile/detail_product.dart';
import 'package:flutter_application_mobile/model/product_api.dart';
import 'package:flutter_application_mobile/model/user_api.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ProductEmpu extends StatefulWidget {
  final UserApi? users;
  const ProductEmpu({super.key, required this.users});

  @override
  State<ProductEmpu> createState() => _ProductEmpuState();
}

class _ProductEmpuState extends State<ProductEmpu> {
  final String api = dotenv.env['API_URL'] ?? "";
  List<ProductApi>? sellerProduct;

  @override
  void initState() {
    super.initState();
    fetchSellerProduct('');
  }

  Future<void> fetchSellerProduct(String search) async {
    try {
      var response = await ProductApi.getProductbySeller(
          widget.users?.idSeller ?? 1, search);
      setState(() {
        sellerProduct = response;
      });
    } catch (e) {
      print("hai");
      print(e);
    }
  }

  Future<Uint8List?> fetchImageBytes(String url) async {
    final response = await http
        .get(Uri.parse(url), headers: {'ngrok-skip-browser-warning': 'true'});

    if (response.statusCode == 200) {
      return response.bodyBytes; // <-- Ini kembalian berupa Uint8List
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.black, width: 1)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Center(
                        child: Row(
                          children: [
                            Image(
                              image: AssetImage('assets/images/logo-keris.png'),
                              width: 50,
                              height: 50,
                            ),
                            Text("KerisSumenep")
                          ],
                        ),
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 200),
                        child: Container(
                          height: 30,
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: "Search",
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(20)),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10)),
                            onChanged: (value) => setState(() {
                              fetchSellerProduct(value);
                            }),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.5 * 0.5,
                      height: MediaQuery.of(context).size.height * 0.04 +
                          MediaQuery.of(context).size.width * 0.5 * 0.01,
                      color: Color(0xFF53C737),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                            onTap: () => Navigator.pop(context),
                            child: Center(
                              child: Text(
                                "Kembali",
                                style: TextStyle(color: Colors.white),
                              ),
                            )),
                      ),
                    ),
                  ),
                ),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(minHeight: 150),
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  padding: EdgeInsets.all(10),
                  height: MediaQuery.of(context).size.width * 0.25,
                  color: Color(0xFF2E6C25),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${widget.users?.sellerName}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                            ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: 200),
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 2),
                                height: 1,
                                width: MediaQuery.of(context).size.width * 0.30,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "${widget.users?.sellerPhone}",
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(999),
                          child: Container(
                            height: MediaQuery.of(context).size.width * 0.25,
                            width: MediaQuery.of(context).size.width * 0.25,
                            child: (widget.users?.sellerPhoto == null)
                                ? Image(
                                    image: AssetImage('images/account.png'),
                                    fit: BoxFit.cover,
                                  )
                                : FutureBuilder<Uint8List?>(
                                    future: fetchImageBytes(
                                        '$api/${widget.users?.sellerPhoto}'),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return CircularProgressIndicator();
                                      } else if (snapshot.hasData) {
                                        return Image.memory(
                                          snapshot.data!,
                                          fit: BoxFit.cover,
                                        ); // <-- Tampilkan gambar
                                      } else {
                                        return Text("Gagal memuat gambar");
                                      }
                                    },
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "keris Empu Sepuh",
                        style: TextStyle(fontSize: 16), // opsional
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    StaggeredGrid.extent(
                      maxCrossAxisExtent: 200,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      children:
                          List.generate(sellerProduct?.length ?? 1, (index) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(color: Color(0xFF2E6C25), width: 2),
                          ),
                          padding: EdgeInsets.all(5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 200,
                                height: 150,
                                child: (sellerProduct?[index]
                                            .productPict
                                            .isEmpty ??
                                        true)
                                    ? Image.asset('images/2.png',
                                        fit: BoxFit.cover)
                                    : FutureBuilder<Uint8List?>(
                                        future: fetchImageBytes(
                                            '${sellerProduct?[index].productPict[0].path}'),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return Center(
                                                child:
                                                    CircularProgressIndicator());
                                          } else if (snapshot.hasData) {
                                            return Image.memory(
                                              snapshot.data!,
                                              fit: BoxFit.cover,
                                            );
                                          } else {
                                            return Text("Gagal memuat gambar");
                                          }
                                        },
                                      ),
                              ),
                              SizedBox(height: 5),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${sellerProduct?[index].productName}", style: TextStyle(fontSize: 16),),
                                  Text("${sellerProduct?[index].productPrice}"),
                                  SizedBox(height: 20),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Container(
                                        width: 200,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.04,
                                        color: Color(0xFF53C737),
                                        child: Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailProduct(
                                                          product:
                                                              sellerProduct?[
                                                                  index]),
                                                ),
                                              );
                                            },
                                            child: Center(
                                              child: Text(
                                                "Beli",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      }),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
