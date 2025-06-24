import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile_pengguna/detail_product.dart';
import 'package:mobile_pengguna/model/product_api.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:http/http.dart' as http;

class PopulerProduct extends StatefulWidget {
  const PopulerProduct({super.key});

  @override
  State<PopulerProduct> createState() => _PopulerProductState();
}

class _PopulerProductState extends State<PopulerProduct> {
  final String api = dotenv.env['API_URL'] ?? "";
  List<ProductApi>? popularProduct;

  @override
  void initState() {
    super.initState();
    fetchPopularProduct('');
  }

  Future<void> fetchPopularProduct(String search) async {
    try {
      var response = await ProductApi.getPopularProduct(search);
      setState(() {
        popularProduct = response;
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
                              fetchPopularProduct(value);
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
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  height: MediaQuery.of(context).size.width * 0.25,
                  child: Stack(
                    children: [
                      Positioned.fill(
                          child: Image(
                        image: AssetImage('assets/images/heropt.png'),
                        fit: BoxFit.fitWidth,
                      )),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AutoSizeText(
                                      "Simbol Keagungan dan Warisan Budaya",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5 *
                                              0.1,
                                          fontWeight: FontWeight.w600),
                                      maxFontSize: 30,
                                      minFontSize: 16,
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    AutoSizeText(
                                      "Miliki koleksi keris eksklusif dengan ukiran khas dan desain elegan. Setiap bilah mencerminkan keindahan seni tradisional yang penuh makna.",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5 *
                                              0.03),
                                      maxFontSize: 16,
                                      minFontSize: 7,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
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
                        "Produk Terlaris",
                        style: TextStyle(fontSize: 16), // opsional
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 0.6),
                        itemCount: popularProduct?.length ?? 1,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: Color(0xFF2E6C25), width: 2)),
                            padding: EdgeInsets.all(5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    flex: 5,
                                    child: Container(
                                      child: (popularProduct?[index]
                                                  .productPict
                                                  .isEmpty ??
                                              true)
                                          ? Image(
                                              image: AssetImage('images/2.png'),
                                              fit: BoxFit.cover,
                                            )
                                          : FutureBuilder<Uint8List?>(
                                              future: fetchImageBytes(
                                                  '${popularProduct?[index].productPict[0].path}'),
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return CircularProgressIndicator();
                                                } else if (snapshot.hasData) {
                                                  return Image.memory(
                                                    snapshot.data!,
                                                    fit: BoxFit.cover,
                                                    width: double.infinity,
                                                  ); // <-- Tampilkan gambar
                                                } else {
                                                  return Text(
                                                      "Gagal memuat gambar");
                                                }
                                              },
                                            ),
                                    )),
                                SizedBox(
                                  height: 5,
                                ),
                                Expanded(
                                    flex: 2,
                                    child: Text(
                                        "${popularProduct?[index].productName}")),
                                Text("${popularProduct?[index].productPrice}"),
                                SizedBox(
                                  height: 10,
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.5 *
                                          0.5,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.04,
                                      color: Color(0xFF53C737),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                            onTap: () async {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DetailProduct(
                                                              product:
                                                                  popularProduct?[
                                                                      index])));
                                            },
                                            child: Center(
                                              child: Text(
                                                "Beli",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            )),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        })
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
