import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:shimmer/shimmer.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile/add_item.dart';
import 'package:mobile/detail_item.dart';
import 'package:mobile/edit_item.dart';
import 'package:mobile/edit_password.dart';
import 'package:mobile/edit_profil.dart';
import 'package:mobile/login.dart';
import 'package:mobile/model/product_api.dart';
import 'package:mobile/model/user_api.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Dashboard extends StatefulWidget {
  final String? token;

  Dashboard({super.key, required this.token});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String? fcmToken;
  static final api = dotenv.env['API_URL'] ?? "";
  UserApi? user;
  bool _burgerMenu = false;
  late String? token;
  final storage = FlutterSecureStorage();

  Future<void> deleteToken() async {
    print("hai");
    await storage.delete(key: 'jwt_token');
  }

  @override
  void initState() {
    super.initState();
    token = widget.token;
    fetchUser();
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
  }

  Future<void> sendTokenToServer(String token) async {
    final url = Uri.parse('$api/users/save-token');
    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(
            {'token': token, 'id_seller': user?.idSeller}) // misal admin_id 1
        );
    if (response.statusCode == 200) {
      print("Token saved on server");
    } else {
      print("Failed to save token");
    }
  }

  Future<void> fetchUser() async {
    try {
      UserApi? fetchedUser = await UserApi.getUser(token ?? "");
      if (!mounted) return;
      if (fetchedUser.idSeller == null) {
        deleteToken();
        Future.delayed(
            Duration(seconds: 0),
            () => Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        Login(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
                    transitionDuration: Duration(milliseconds: 0))));
      }
      Future.delayed(
          Duration(seconds: 0),
          () => {
                setState(() {
                  user = fetchedUser;
                }) 
              });
      print("fetching ....");
    } catch (e) {
      print("Error fetching user: $e");
    }
  }

  // Future<Uint8List?> fetchImageBytes(String url) async {
  //   final response = await http.get(Uri.parse(url));
  //   if (response.statusCode == 200) {
  //     return response.bodyBytes; // <-- Ini kembalian berupa Uint8List
  //   } else {
  //     return null;
  //   }
  // }

  Future<void> _refreshData() async {
    await Future.delayed(Duration(seconds: 2)); // simulasi delay
    setState(() {
      fetchUser();
    });
  }

  void showDeleteConfirmationDialog(
      BuildContext context, VoidCallback onConfirmDelete) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Konfirmasi Hapus"),
          content: Text("Apakah kamu yakin ingin menghapus produk ini?"),
          actions: [
            TextButton(
              child: Text("Batal"),
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
            ),
            ElevatedButton.icon(
              icon: Icon(Icons.delete, color: Colors.white),
              label: Text(
                "Hapus",
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog terlebih dahulu
                onConfirmDelete(); // Jalankan fungsi hapus
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildProductList() {
    if (user == null) {
      return Center(
        child: Text(""),
      );
    } else if (user?.product.isEmpty ?? true) {
      return Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.menu, size: 40.0, color: Colors.black),
                      onPressed: () {
                        setState(() {
                          _burgerMenu = true;
                        });
                      },
                    ),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              user?.username ?? '',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 10.0, left: 5.0),
                            child: ClipOval(
                              child: (user?.sellerPhoto == null)
                                  ? Image.asset(
                                      "images/account.png",
                                      width: 40.0,
                                      height: 40.0,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.network("$api/${user?.sellerPhoto}",
                                      width: 40.0,
                                      height: 40.0,
                                      fit: BoxFit.cover),
                              // : FutureBuilder<Uint8List?>(
                              //     future: fetchImageBytes(
                              //         "$api/${user?.sellerPhoto}"),
                              //     builder: (context, snapshot) {
                              //       if (snapshot.connectionState ==
                              //           ConnectionState.waiting) {
                              //         return CircularProgressIndicator();
                              //       } else if (snapshot.hasData) {
                              //         return Image.memory(snapshot.data!,
                              //             width: 40.0,
                              //             height: 40.0,
                              //             fit: BoxFit
                              //                 .cover); // <-- Tampilkan gambar
                              //       } else {
                              //         return Text("Gagal memuat gambar");
                              //       }
                              //     },
                              //   ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(
                  thickness: 1,
                  color: Colors.black,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Daftar Produk",
                    style: TextStyle(color: Colors.black, fontSize: 20.0),
                  ),
                ),
              ),
              Spacer(),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddItem(token: token)))
                          .then((value) => {
                                if (value == true)
                                  setState(() {
                                    fetchUser();
                                  })
                              });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF53c737),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      shadowColor: Colors.black,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.add, color: Colors.white),
                        SizedBox(width: 5),
                        Text(
                          "Tambah Produk",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Anda belum menambahkan produk!",
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ],
              ),
              Spacer(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: 150),
                height: MediaQuery.of(context).size.height,
                width:
                    (_burgerMenu) ? MediaQuery.of(context).size.width * 0.5 : 0,
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius:
                          BorderRadius.horizontal(right: Radius.circular(15)),
                      color: Color(0xFFE9F5EC)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 25),
                                width: MediaQuery.of(context).size.width *
                                    0.5 *
                                    0.2,
                                height: MediaQuery.of(context).size.width *
                                    0.5 *
                                    0.2,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    shape: BoxShape.circle),
                                child: Material(
                                  shape: CircleBorder(),
                                  color: Colors.transparent,
                                  child: InkWell(
                                    customBorder: CircleBorder(),
                                    onTap: () => {
                                      setState(() {
                                        _burgerMenu = false;
                                      })
                                    },
                                    child: Center(
                                      child: Center(
                                          child: Icon(
                                        Icons.arrow_back,
                                        color: Colors.white,
                                      )),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                width: MediaQuery.of(context).size.width *
                                    0.5 *
                                    0.8,
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                color: Color(0xFF3B8D28),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                      onTap: () async {
                                        var response = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    EditProfil(
                                                        token: token ?? "",
                                                        user: user)));
                                        if (mounted && response == true) {
                                          fetchUser();
                                        }
                                      },
                                      child: Center(
                                        child: Text(
                                          "Ubah Profil",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      )),
                                ),
                              ),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              width:
                                  MediaQuery.of(context).size.width * 0.5 * 0.8,
                              height: MediaQuery.of(context).size.height * 0.05,
                              color: Color(0xFF3B8D28),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                    onTap: () => {},
                                    child: Center(
                                      child: Text(
                                        "Tambah Produk",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    )),
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            width:
                                MediaQuery.of(context).size.width * 0.5 * 0.8,
                            height: MediaQuery.of(context).size.height * 0.05,
                            color: Color(0xFF3B8D28),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      token = '';
                                    });
                                    deleteToken();
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Login()));
                                  },
                                  child: Center(
                                    child: Text(
                                      "logout",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => setState(() {
                  _burgerMenu = false;
                }),
                child: Container(
                  color: Colors.transparent,
                  width: (_burgerMenu)
                      ? MediaQuery.of(context).size.width * 0.5
                      : 0,
                  height: MediaQuery.of(context).size.height,
                ),
              )
            ],
          )
        ],
      );
    } else {
      return RefreshIndicator(
        onRefresh: _refreshData,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          icon:
                              Icon(Icons.menu, size: 40.0, color: Colors.black),
                          onPressed: () {
                            setState(() {
                              _burgerMenu = true;
                            });
                          },
                        ),
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  user?.username ?? '',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(right: 10.0, left: 5.0),
                                child: ClipOval(
                                  child: (user?.sellerPhoto == null)
                                      ? Image.asset(
                                          "images/account.png",
                                          width: 40.0,
                                          height: 40.0,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.network(
                                          "$api/${user?.sellerPhoto}",
                                          width: 40.0,
                                          height: 40.0,
                                          fit: BoxFit.cover),
                                  // : FutureBuilder<Uint8List?>(
                                  //     future: fetchImageBytes(
                                  //         '$api/${user?.sellerPhoto}'),
                                  //     builder: (context, snapshot) {
                                  //       if (snapshot.connectionState ==
                                  //           ConnectionState.waiting) {
                                  //         return CircularProgressIndicator();
                                  //       } else if (snapshot.hasData) {
                                  //         return Image.memory(
                                  //           snapshot.data!,
                                  //           width: 40.0,
                                  //           height: 40.0,
                                  //           fit: BoxFit.cover,
                                  //         ); // <-- Tampilkan gambar
                                  //       } else {
                                  //         return Text("Gagal memuat gambar");
                                  //       }
                                  //     },
                                  //   ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Divider(
                      thickness: 1,
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Daftar Produk",
                        style: TextStyle(color: Colors.black, fontSize: 20.0),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
                    child: MasonryGridView.extent(
                      maxCrossAxisExtent: 200,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: user?.product.length ?? 4,
                      itemBuilder: (context, index) {
                        return (user != null)
                            ? GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailItem(
                                        token: token,
                                        product: user?.product[index],
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Color(0xFF2E6C25), width: 2),
                                  ),
                                  padding: EdgeInsets.all(5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 100,
                                        margin: EdgeInsets.only(bottom: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Container(
                                                  width: 100,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.04,
                                                  color: (user?.product[index]
                                                              .productStatus ==
                                                          'aktif')
                                                      ? Color(0xFFFF3636)
                                                      : Color(0xFF53c737),
                                                  child: Material(
                                                    color: Colors.transparent,
                                                    child: InkWell(
                                                      onTap: () async {
                                                        try {
                                                          var response = await ProductApi
                                                              .changeProductStatus(
                                                                  user?.product[index]
                                                                          .idProduct ??
                                                                      0,
                                                                  token ?? "");
                                                          if (response[
                                                                  'status'] ==
                                                              200) {
                                                            fetchUser();
                                                          }
                                                          print(response);
                                                        } catch (e) {
                                                          print(e);
                                                        }
                                                      },
                                                      child: Center(
                                                        child: Text(
                                                          (user?.product[index]
                                                                      .productStatus ==
                                                                  'aktif')
                                                              ? "nonaktifkan"
                                                              : "aktifkan",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 150,
                                        child: (user?.product[index].productPict
                                                    .isEmpty ??
                                                true)
                                            ? Image.asset(
                                                'assets/images/keris-sketsa.png',
                                                fit: BoxFit.cover)
                                            : Image.network(
                                                user?.product[index]
                                                        .productPict[0].path ??
                                                    "",
                                                fit: BoxFit.cover),
                                        // : FutureBuilder<Uint8List?>(
                                        //     future: fetchImageBytes(user
                                        //             ?.product[index]
                                        //             .productPict[0]
                                        //             .path ??
                                        //         ""),
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
                                        //         return Text("Gagal memuat gambar");
                                        //       }
                                        //     },
                                        //   ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        user?.product[index].productName ?? "",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      Text(
                                        user?.product[index].productPrice ?? "",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      Text(
                                          "stock: ${user?.product[index].productStock}"),
                                      SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Container(
                                                width: 60,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.04,
                                                color: Color(0xFF53C737),
                                                child: Material(
                                                  color: Colors.transparent,
                                                  child: InkWell(
                                                    onTap: () async {
                                                      var response = await Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) => EditItem(
                                                                  token:
                                                                      token ??
                                                                          "",
                                                                  product: user
                                                                          ?.product[
                                                                      index])));
                                                      if (mounted &&
                                                          response == true) {
                                                        fetchUser();
                                                      }
                                                    },
                                                    child: Center(
                                                      child: Text(
                                                        "Ubah",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Container(
                                                width: 60,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.04,
                                                color: Color(0xFFFF3636),
                                                child: Material(
                                                  color: Colors.transparent,
                                                  child: InkWell(
                                                    onTap: () async {
                                                      showDeleteConfirmationDialog(
                                                          context, () async {
                                                        try {
                                                          var response = await ProductApi
                                                              .deleteProduct(
                                                                  user?.product[index]
                                                                          .idProduct ??
                                                                      0,
                                                                  token ?? "");
                                                          if (response[
                                                                  'status'] ==
                                                              200) {
                                                            fetchUser();
                                                          }
                                                          print(response);
                                                        } catch (e) {
                                                          print(e);
                                                        }
                                                      });
                                                    },
                                                    child: Center(
                                                      child: Text(
                                                        "Hapus",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Color(0xFF2E6C25), width: 2),
                                  ),
                                  padding: EdgeInsets.all(5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 100,
                                        margin: EdgeInsets.only(bottom: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Container(
                                                  width: 100,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.04,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 150,
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        "",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      Text(
                                        "",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      Text(""),
                                      SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Container(
                                                width: 60,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.04,
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Container(
                                                width: 60,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.04,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment(0, 0.9),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddItem(token: token)))
                      .then((value) => {
                            if (value == true)
                              setState(() {
                                fetchUser();
                              })
                          });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF53c737),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  shadowColor: Colors.black,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.add, color: Colors.white),
                    SizedBox(width: 5),
                    Text(
                      "Tambah Produk",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 150),
                  height: MediaQuery.of(context).size.height,
                  width: (_burgerMenu)
                      ? MediaQuery.of(context).size.width * 0.5
                      : 0,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius:
                            BorderRadius.horizontal(right: Radius.circular(15)),
                        color: Color(0xFFE9F5EC)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 25),
                                  width: MediaQuery.of(context).size.width *
                                      0.5 *
                                      0.2,
                                  height: MediaQuery.of(context).size.width *
                                      0.5 *
                                      0.2,
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      shape: BoxShape.circle),
                                  child: Material(
                                    shape: CircleBorder(),
                                    color: Colors.transparent,
                                    child: InkWell(
                                      customBorder: CircleBorder(),
                                      onTap: () => {
                                        setState(() {
                                          _burgerMenu = false;
                                        })
                                      },
                                      child: Center(
                                        child: Center(
                                            child: Icon(
                                          Icons.arrow_back,
                                          color: Colors.white,
                                        )),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  width: MediaQuery.of(context).size.width *
                                      0.5 *
                                      0.8,
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  color: Color(0xFF3B8D28),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                        onTap: () async {
                                          var response = await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditProfil(
                                                          token: token ?? "",
                                                          user: user)));
                                          if (mounted && response == true) {
                                            fetchUser();
                                          }
                                        },
                                        child: Center(
                                          child: Text(
                                            "Ubah Profil",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        )),
                                  ),
                                ),
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                width: MediaQuery.of(context).size.width *
                                    0.5 *
                                    0.8,
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                color: Color(0xFF3B8D28),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                      onTap: () => {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditPassword(
                                                            token: token)))
                                          },
                                      child: Center(
                                        child: Text(
                                          "Ubah password",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      )),
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              width:
                                  MediaQuery.of(context).size.width * 0.5 * 0.8,
                              height: MediaQuery.of(context).size.height * 0.05,
                              color: Color(0xFF3B8D28),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        token = '';
                                      });
                                      deleteToken();
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Login()));
                                    },
                                    child: Center(
                                      child: Text(
                                        "logout",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    )),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => setState(() {
                    _burgerMenu = false;
                  }),
                  child: Container(
                    color: Colors.transparent,
                    width: (_burgerMenu)
                        ? MediaQuery.of(context).size.width * 0.5
                        : 0,
                    height: MediaQuery.of(context).size.height,
                  ),
                )
              ],
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _buildProductList(),
      ),
    );
  }
}
