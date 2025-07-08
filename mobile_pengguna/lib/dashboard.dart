import 'dart:convert';
import 'dart:typed_data';

import 'package:shimmer/shimmer.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_mobile/daftar_empu.dart';
import 'package:flutter_application_mobile/detail_product.dart';
import 'package:flutter_application_mobile/model/product_api.dart';
import 'package:flutter_application_mobile/model/user_api.dart';
import 'package:flutter_application_mobile/product_empu.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String? fcmToken;
  final String api = dotenv.env['API_URL'] ?? "";
  List<UserApi>? users;
  List<ProductApi>? popularProduct;
  @override
  void initState() {
    super.initState();
    fetchAllUsers('');
    fetchPopularProduct('');
    Future.delayed(Duration(milliseconds: 700), () {
      setupFCM();
    });
  }

  Future<void> setupFCM() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // Request permission (iOS)
    await messaging.requestPermission();

    // Dapatkan token
    String? token = await messaging.getToken();
    setState(() {
      fcmToken = token;
    });
    print("FCM Token: $token");

    // Kirim token ke backend
    if (token != null) {
      print("hai");
      await sendTokenToServer(token);
    }

    // Handle notifikasi saat app di foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received message in foreground: ${message.notification?.title}');
      // Bisa tampilkan notifikasi lokal di sini jika mau
    });
  }

  Future<void> sendTokenToServer(String token) async {
    final url = Uri.parse('$api/users/save-token');
    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'token': token}));
    if (response.statusCode == 200) {
      print("Token saved on server");
    } else {
      print("Failed to save token");
    }
  }

  Future<void> fetchAllUsers(String search) async {
    try {
      print("fetching...");
      Future.delayed(Duration(seconds: 0), () async {
        var response = await UserApi.getAllSeller(search);
        setState(() {
          users = response;
        });
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchPopularProduct(String search) async {
    try {
      Future.delayed(Duration(seconds: 0), () async {
        var response = await ProductApi.getPopularProduct(search);
        setState(() {
          popularProduct = response;
        });
      });
    } catch (e) {
      print(e);
    }
  }

  // Future<Uint8List?> fetchImageBytes(String url) async {
  //   final response = await http
  //       .get(Uri.parse(url));
  //   if (response.statusCode == 200) {
  //     return response.bodyBytes; // <-- Ini kembalian berupa Uint8List
  //   } else {
  //     return null;
  //   }
  // }

  Future<void> _refreshData() async {
    await Future.delayed(Duration(seconds: 2)); // simulasi delay
    setState(() {
      fetchAllUsers('');
      fetchPopularProduct('');
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
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        double screenWidth = MediaQuery.of(context).size.width;
                        double logoSize;
                        double fontSize;
                        double searchWidth;

                        if (screenWidth <= 320) {
                          logoSize = 45;
                          fontSize = 14;
                          searchWidth = screenWidth * 0.4;
                        } else if (screenWidth <= 375) {
                          logoSize = 45;
                          fontSize = 14;
                          searchWidth = screenWidth * 0.4;
                        } else if (screenWidth <= 425) {
                          logoSize = 45;
                          fontSize = 14;
                          searchWidth = screenWidth * 0.4;
                        } else if (screenWidth <= 600) {
                          logoSize = 45;
                          fontSize = 18;
                          searchWidth = screenWidth * 0.4;
                        } else {
                          logoSize = 50;
                          fontSize = 20;
                          searchWidth = screenWidth * 0.6;
                        }

                        return Container(
                          height: 70,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Colors.black, width: 1),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/images/logo-keris.png',
                                    width: logoSize,
                                    height: logoSize,
                                  ),
                                  Text(
                                    "KerisSumenep",
                                    style: TextStyle(
                                      fontSize: fontSize,
                                    ),
                                  ),
                                ],
                              ), 
                              Container(
                                height: 35,
                                width: searchWidth,
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: "Search",
                                    border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 0),
                                  ),
                                  onChanged: (value) => setState(() {
                                    users = null;
                                    popularProduct = null;
                                    fetchAllUsers(value);
                                    fetchPopularProduct(value);
                                  }),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Daftar Nama Empu",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.5 *
                                            0.5 *
                                            0.45 *
                                            0.45,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DaftarEmpu()));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF53C737),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 7),
                                  ),
                                  child: Text(
                                    "Selengkapnya",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.5 *
                                              0.5 *
                                              0.35 *
                                              0.45,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 150,
                            child: GridView.builder(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              scrollDirection: Axis.horizontal,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                childAspectRatio: 1.0,
                              ),
                              itemCount: users != null ? users?.length : 4,
                              itemBuilder: (context, index) {
                                print(users?.length);
                                return (users != null)
                                    ? GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ProductEmpu(
                                                  users: users?[index]),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.black),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          padding: EdgeInsets.all(2.0),
                                          child: Builder(
                                            builder: (context) {
                                              double screenWidth =
                                                  MediaQuery.of(context)
                                                      .size
                                                      .width;
                                              double nameFontSize;
                                              double nameFontSize2;
                                              if (screenWidth <= 320) {
                                                nameFontSize = 15;
                                                nameFontSize2 = 14;
                                              } else if (screenWidth <= 375) {
                                                nameFontSize = 15;
                                                nameFontSize2 = 14;
                                              } else if (screenWidth <= 425) {
                                                nameFontSize = 16;
                                                nameFontSize2 = 14;
                                              } else if (screenWidth <= 575) {
                                                nameFontSize = 18;
                                                nameFontSize2 = 15;
                                              } else if (screenWidth <= 800) {
                                                nameFontSize = 20;
                                                nameFontSize2 = 16;
                                              } else {
                                                nameFontSize = 20;
                                                nameFontSize2 = 20;
                                              }
                                              return Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  (users?[index].sellerPhoto ==
                                                          null)
                                                      ? ClipOval(
                                                          child: Image.asset(
                                                            "images/account.png",
                                                            width: 80.0,
                                                            height: 80.0,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        )
                                                      : ClipOval(
                                                          child: Image.network(
                                                          "$api/${users?[index].sellerPhoto}",
                                                          width: 80.0,
                                                          height: 80.0,
                                                          fit: BoxFit.cover,
                                                        )
                                                          //     FutureBuilder<Uint8List?>(
                                                          //   future: fetchImageBytes(
                                                          //       "$api/${users?[index].sellerPhoto}"),
                                                          //   builder:
                                                          //       (context, snapshot) {
                                                          //     if (snapshot
                                                          //             .connectionState ==
                                                          //         ConnectionState
                                                          //             .waiting) {
                                                          //       return CircularProgressIndicator();
                                                          //     } else if (snapshot
                                                          //         .hasData) {
                                                          //       return Image.memory(
                                                          //           snapshot.data!,
                                                          //           width: 80.0,
                                                          //           height: 80.0,
                                                          //           fit: BoxFit
                                                          //               .cover); // <-- Tampilkan gambar
                                                          //     } else {
                                                          //       return Text(
                                                          //           "Gagal memuat gambar");
                                                          //     }
                                                          //   },
                                                          // ),
                                                          ),
                                                  SizedBox(height: 6),
                                                  Text(
                                                    "${users?[index].sellerName}",
                                                    style: TextStyle(
                                                        fontSize: nameFontSize,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        overflow: TextOverflow
                                                            .ellipsis),
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                      )
                                    : Shimmer.fromColors(
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey.shade100,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.black),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            color: Colors
                                                .white, // tambahkan warna agar shimmer terlihat
                                          ),
                                          padding: EdgeInsets.all(2.0),
                                          child: Builder(
                                            builder: (context) {
                                              double screenWidth =
                                                  MediaQuery.of(context)
                                                      .size
                                                      .width;
                                              double nameFontSize;
                                              if (screenWidth <= 320) {
                                                nameFontSize = 15;
                                              } else if (screenWidth <= 375) {
                                                nameFontSize = 15;
                                              } else if (screenWidth <= 425) {
                                                nameFontSize = 16;
                                              } else if (screenWidth <= 575) {
                                                nameFontSize = 18;
                                              } else if (screenWidth <= 800) {
                                                nameFontSize = 20;
                                              } else {
                                                nameFontSize = 20;
                                              }

                                              return Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  // Skeleton gambar bulat
                                                  Container(
                                                    width: 80.0,
                                                    height: 80.0,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      shape: BoxShape.circle,
                                                    ),
                                                  ),
                                                  SizedBox(height: 6),
                                                  // Skeleton nama
                                                  Container(
                                                    width: screenWidth * 0.5,
                                                    height: nameFontSize + 6,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4.0),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                      );
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Produk Terlaris",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.5 *
                                            0.5 *
                                            0.48 *
                                            0.45,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: StaggeredGrid.extent(
                              maxCrossAxisExtent: 200,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              children: List.generate(4, (index) {
                                int length = popularProduct != null
                                    ? popularProduct?.length ?? 0
                                    : 4;
                                return (popularProduct != null)
                                    ? (index.toInt() < length)
                                        ? Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: Color(0xFF2E6C25),
                                                  width: 2),
                                            ),
                                            padding: EdgeInsets.all(5),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                    width: 200,
                                                    height: 150,
                                                    child: (popularProduct?[
                                                                    index]
                                                                .productPict
                                                                .isEmpty ??
                                                            true)
                                                        ? Image.asset(
                                                            'assets/images/keris-sketsa.png',
                                                            fit: BoxFit.cover)
                                                        : Image.network(
                                                            '${popularProduct?[index].productPict[0].path}',
                                                            fit: BoxFit.cover)

                                                    // : FutureBuilder<Uint8List?>(
                                                    //     future: fetchImageBytes(
                                                    //         '${popularProduct?[index].productPict[0].path}'),
                                                    //     builder:
                                                    //         (context, snapshot) {
                                                    //       if (snapshot
                                                    //               .connectionState ==
                                                    //           ConnectionState
                                                    //               .waiting) {
                                                    //         return Center(
                                                    //             child:
                                                    //                 CircularProgressIndicator());
                                                    //       } else if (snapshot
                                                    //           .hasData) {
                                                    //         return Image.memory(
                                                    //           snapshot.data!,
                                                    //           fit: BoxFit.cover,
                                                    //         );
                                                    //       } else {
                                                    //         return Text(
                                                    //             "Gagal memuat gambar");
                                                    //       }
                                                    //     },
                                                    //   ),
                                                    ),
                                                SizedBox(height: 5),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "${popularProduct?[index].productName}",
                                                      style: TextStyle(
                                                          fontSize: 16),
                                                    ),
                                                    Text(
                                                      "${popularProduct?[index].productPrice}",
                                                      style: TextStyle(
                                                          color: Colors.red),
                                                    ),
                                                    SizedBox(height: 20),
                                                    Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        child: Container(
                                                          width: 200,
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.04,
                                                          color:
                                                              Color(0xFF53C737),
                                                          child: Material(
                                                            color: Colors
                                                                .transparent,
                                                            child: InkWell(
                                                              onTap: () {
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder: (context) =>
                                                                        DetailProduct(
                                                                            product:
                                                                                popularProduct?[index]),
                                                                  ),
                                                                );
                                                              },
                                                              child: Center(
                                                                child: Text(
                                                                  "Beli",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
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
                                          )
                                        : SizedBox()
                                    : Shimmer.fromColors(
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey.shade100,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: Color(0xFF2E6C25),
                                                width: 2),
                                          ),
                                          padding: EdgeInsets.all(5),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 200,
                                                height: 150,
                                              ),
                                              SizedBox(height: 5),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "",
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  ),
                                                  Text(
                                                    "",
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  ),
                                                  SizedBox(height: 20),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: Container(
                                                        width: 200,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.04,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                              }),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Produk Terbaru",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.5 *
                                            0.5 *
                                            0.48 *
                                            0.45,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 10, 20, 100),
                            child: StaggeredGrid.extent(
                              maxCrossAxisExtent: 200,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              children: List.generate(
                                  (popularProduct != null)
                                      ? popularProduct?.length ?? 0
                                      : 4, (index) {
                                return (popularProduct != null)
                                    ? Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: Color(0xFF2E6C25),
                                              width: 2),
                                        ),
                                        padding: EdgeInsets.all(5),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                width: 200,
                                                height: 150,
                                                child: (popularProduct?[index]
                                                            .productPict
                                                            .isEmpty ??
                                                        true)
                                                    ? Image.asset(
                                                        'assets/images/keris-sketsa.png',
                                                        fit: BoxFit.cover)
                                                    : Image.network(
                                                        '${popularProduct?[index].productPict[0].path}',
                                                        fit: BoxFit.cover)
                                                // : FutureBuilder<Uint8List?>(
                                                //     future: fetchImageBytes(
                                                //         '${popularProduct?[index].productPict[0].path}'),
                                                //     builder: (context, snapshot) {
                                                //       if (snapshot.connectionState ==
                                                //           ConnectionState.waiting) {
                                                //         return Center(
                                                //             child:
                                                //                 CircularProgressIndicator());
                                                //       } else if (snapshot.hasData) {
                                                //         return Image.memory(
                                                //           snapshot.data!,
                                                //           fit: BoxFit.cover,
                                                //         );
                                                //       } else {
                                                //         return Text(
                                                //             "Gagal memuat gambar");
                                                //       }
                                                //     },
                                                //   ),
                                                ),
                                            SizedBox(height: 5),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${popularProduct?[index].productName}",
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                ),
                                                Text(
                                                  "${popularProduct?[index].productPrice}",
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ),
                                                SizedBox(height: 20),
                                                Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: Container(
                                                      width: 200,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.04,
                                                      color: Color(0xFF53C737),
                                                      child: Material(
                                                        color:
                                                            Colors.transparent,
                                                        child: InkWell(
                                                          onTap: () {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (context) =>
                                                                    DetailProduct(
                                                                        product:
                                                                            popularProduct?[index]),
                                                              ),
                                                            );
                                                          },
                                                          child: Center(
                                                            child: Text(
                                                              "Beli",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
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
                                      )
                                    : Shimmer.fromColors(
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey.shade100,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: Color(0xFF2E6C25),
                                                width: 2),
                                          ),
                                          padding: EdgeInsets.all(5),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 200,
                                                height: 150,
                                              ),
                                              SizedBox(height: 5),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "",
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  ),
                                                  Text(
                                                    "",
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  ),
                                                  SizedBox(height: 20),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: Container(
                                                        width: 200,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.04,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                              }),
                            ),
                          ),
                        ],
                      ),
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
