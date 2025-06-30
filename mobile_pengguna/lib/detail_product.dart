import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_application_mobile/model/product_api.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class DetailProduct extends StatefulWidget {
  final ProductApi? product;

  const DetailProduct({super.key, required this.product});

  @override
  _DetailProductState createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  final String api = dotenv.env['API_URL'] ?? "";
  late String _mainProductPict;

  @override
  void initState() {
    super.initState();
    _mainProductPict = (widget.product!.productPict.isNotEmpty)
        ? widget.product?.productPict[0].path ?? ""
        : "";
  }

  void openWhatsApp(String productName, String phoneNumber) async {
    String intPhoneNumber =
        (phoneNumber[0] == '0') ? '62${phoneNumber.substring(1)}' : phoneNumber;

    String message =
        'Nama: \nNo hp: \nJenis: $productName \njumlah keris: \nAlamat Lengkap: ';
    if (kIsWeb) {
      // Jika Web, langsung buka url WA
      final Uri url = Uri.parse(
          'https://wa.me/$intPhoneNumber?text=${Uri.encodeComponent(message)}');
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'Tidak dapat membuka WhatsApp';
      }
    } else if (Platform.isAndroid) {
      final intent = AndroidIntent(
        action: 'action_view',
        data:
            'https://wa.me/$intPhoneNumber?text=${Uri.encodeComponent(message)}',
        package: 'com.whatsapp',
      );

      await intent.launch();
    } else {
      // Untuk iOS, fallback ke url_launcher
      final Uri url = Uri.parse(
          'https://wa.me/$intPhoneNumber?text=${Uri.encodeComponent(message)}');
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'Tidak dapat membuka WhatsApp';
      }
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
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.black, width: 1)),
                  ),
                  child: Center(
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
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Detail Produk",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.86,
                    height: MediaQuery.of(context).size.width * 0.86 * 0.75,
                    color: Colors.white,
                    child: (widget.product!.productPict.isEmpty ||
                            _mainProductPict == "")
                        ? Image.asset(
                            'assets/images/bg.jpg',
                            fit: BoxFit.cover,
                          )
                        : FutureBuilder<Uint8List?>(
                            future: fetchImageBytes(_mainProductPict),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              } else if (snapshot.hasData) {
                                return Image.memory(snapshot.data!,
                                    fit:
                                        BoxFit.contain); // <-- Tampilkan gambar
                              } else {
                                return Text("Gagal memuat gambar");
                              }
                            },
                          ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.86,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      4,
                      (index) => ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: (widget.product!.productPict.length <=
                                      index) ? () {} : () {
                                setState(() {
                                  _mainProductPict =
                                      (widget.product!.productPict.length <=
                                              index)
                                          ? ""
                                          : widget.product?.productPict[index]
                                                  .path ??
                                              "";
                                });
                              },
                              child: (widget.product!.productPict.length <=
                                      index)
                                  ? Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.86 *
                                          0.2,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.86 *
                                              0.2,
                                    )
                                  : FutureBuilder<Uint8List?>(
                                      future: fetchImageBytes(widget.product
                                              ?.productPict[index].path ??
                                          ""),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return CircularProgressIndicator();
                                        } else if (snapshot.hasData) {
                                          return Image.memory(snapshot.data!,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.86 *
                                                  0.2,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.86 *
                                                  0.2,
                                              fit: BoxFit
                                                  .cover); // <-- Tampilkan gambar
                                        } else {
                                          return Text("Gagal memuat gambar");
                                        }
                                      },
                                    ),
                            ),
                          )),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: (widget.product?.productName?.isNotEmpty ?? false) &&
                        (widget.product?.productPrice?.isNotEmpty ?? false)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Text(
                              widget.product?.productName ?? "",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(
                            widget.product?.productPrice ?? "",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500, color: Colors.red),
                          ),
                        ],
                      )
                    : SizedBox.shrink(),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    (widget.product?.seller?.sellerPhoto != null)
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(999),
                            child: Container(
                              width: 50,
                              height: 50,
                              child: FutureBuilder<Uint8List?>(
                                future: fetchImageBytes(
                                    "$api/${widget.product?.seller?.sellerPhoto}"),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return CircularProgressIndicator();
                                  } else if (snapshot.hasData) {
                                    return Image.memory(snapshot.data!,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.86 *
                                                0.2,
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.86 *
                                                0.2,
                                        fit: BoxFit
                                            .cover); // <-- Tampilkan gambar
                                  } else {
                                    return Text("Gagal memuat gambar");
                                  }
                                },
                              ),
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(999),
                            child: Container(
                              width: 50,
                              height: 50,
                              child: Image(
                                image: AssetImage('images/account.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "${widget.product?.seller?.sellerName}",
                      style: TextStyle(fontSize: 15),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  height: 30,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.black))),
                  child: Text(
                    "Deskripsi",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: (widget.product?.productDescription != null)
                      ? Text(
                          widget.product?.productDescription ?? "",
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 14),
                        )
                      : SizedBox.shrink(),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.5 * 0.8,
                    height: MediaQuery.of(context).size.height * 0.05,
                    color: Color(0xFF53C737),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                          onTap: () => openWhatsApp(
                            widget.product?.productName ?? "",
                              widget.product?.seller?.sellerPhone ?? ""),
                          child: Center(
                            child: Text(
                              "Hubungi WhatsApp",
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
