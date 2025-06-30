import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_application_mobile/model/user_api.dart';
import 'package:flutter_application_mobile/product_empu.dart';
import 'package:http/http.dart' as http;

class DaftarEmpu extends StatefulWidget {
  const DaftarEmpu({super.key});

  @override
  _DaftarEmpuState createState() => _DaftarEmpuState();
}

class _DaftarEmpuState extends State<DaftarEmpu> {
  final String api = dotenv.env['API_URL'] ?? "";
  List<UserApi>? users;

  @override
  void initState() {
    super.initState();
    fetchAllUsers('');
  }

  Future<void> fetchAllUsers(String search) async {
    try {
      var response = await UserApi.getAllSeller(search);
      setState(() {
        users = response;
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

  Future<void> _refreshData() async {
    await Future.delayed(Duration(seconds: 2)); // simulasi delay
    setState(() {
      fetchAllUsers('');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            RefreshIndicator(
              onRefresh: _refreshData,
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Center(
                            child: Row(
                              children: [
                                Image(
                                  image: AssetImage(
                                      'assets/images/logo-keris.png'),
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
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 10)),
                                onChanged: (value) => setState(() {
                                  fetchAllUsers(value);
                                }),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 20.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  width: MediaQuery.of(context).size.width *
                                      0.5 *
                                      0.5,
                                  height: MediaQuery.of(context).size.height *
                                          0.04 +
                                      MediaQuery.of(context).size.width *
                                          0.5 *
                                          0.01,
                                  color: Color(0xFF53C737),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                        onTap: () => Navigator.pop(context),
                                        child: Center(
                                          child: Text(
                                            "Kembali",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        )),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 45.0),
                            decoration: BoxDecoration(
                              color: Color(0xFF2E7D32),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "DAFTAR EMPU",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline,
                                      decorationColor: Colors.white,
                                      decorationThickness: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GridView.builder(
                            padding: EdgeInsets.fromLTRB(20, 10, 20, 100),
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              childAspectRatio: 0.58,
                            ),
                            itemCount: users?.length ?? 1,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ProductEmpu(users: users?[index]),
                                    ),
                                  );
                                },
                                child: LayoutBuilder(
                                  builder: (context, constraints) {
                                    double imageSize =
                                        constraints.maxWidth * 0.9;
                                    return Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      padding: EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Center(
                                            child: ClipOval(
                                              child: (users?[index]
                                                          .sellerPhoto ==
                                                      null)
                                                  ? Image.asset(
                                                      "images/account.png",
                                                      height: imageSize,
                                                      width: imageSize,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : FutureBuilder<Uint8List?>(
                                                      future: fetchImageBytes(
                                                          "$api/${users?[index].sellerPhoto}"),
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot
                                                                .connectionState ==
                                                            ConnectionState
                                                                .waiting) {
                                                          return CircularProgressIndicator();
                                                        } else if (snapshot
                                                            .hasData) {
                                                          return Image.memory(
                                                              snapshot.data!,
                                                              width: imageSize,
                                                              height: imageSize,
                                                              fit: BoxFit
                                                                  .cover); // <-- Tampilkan gambar
                                                        } else {
                                                          return Text(
                                                              "Gagal memuat gambar");
                                                        }
                                                      },
                                                    ),
                                            ),
                                          ),
                                          Spacer(),
                                          Align(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "${users?[index].sellerName}",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                Text(
                                                  "${users?[index].sellerPhone}",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Spacer(),
                                          Align(
                                            alignment: Alignment.center,
                                            child: ElevatedButton(
                                              onPressed: () {},
                                              style: ElevatedButton.styleFrom(
                                                elevation: 0,
                                                backgroundColor:
                                                    Colors.transparent,
                                                shadowColor: Colors.transparent,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.zero),
                                                padding: EdgeInsets.zero,
                                              ),
                                              child: Text(
                                                "Lihat Produk",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          offset: Offset(0, -1),
                          spreadRadius: 1,
                        ),
                      ],
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
