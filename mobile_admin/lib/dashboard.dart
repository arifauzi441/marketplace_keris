import 'dart:convert';
import 'dart:typed_data';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile_admin/login.dart';
import 'package:mobile_admin/model/user_api.dart';
import 'package:http/http.dart' as http;

class Dashboard extends StatefulWidget {
  final String token;
  const Dashboard({super.key, required this.token});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String? fcmToken;
  final String api = dotenv.env['API_URL'] ?? "";
  UserApi? user;
  List<UserApi>? users;
  late String token = widget.token;

  @override
  void initState() {
    super.initState();
    fetchUser();
    fetchAllUsers('');
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
    final url = Uri.parse('$api/users/admin/save-token');
    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(
            {'token': token, 'id_admin': user?.idAdmin}) // misal admin_id 1
        );
    if (response.statusCode == 200) {
      print("Token saved on server");
    } else {
      print("Failed to save token");
    }
  }

  Future<void> fetchUser() async {
    try {
      UserApi? fetchedUser = await UserApi.getUser(token);
      if (!mounted) return;
      setState(() {
        user = fetchedUser;
        print(fetchedUser.idAdmin);
      });
      print("fetching ....");
    } catch (e) {
      print("Error fetching user: $e");
    }
  }

  Future<void> fetchAllUsers(String search) async {
    try {
      var response = await UserApi.getAllUser(token, search);
      setState(() {
        users = response;
      });
    } catch (e) {
      print("haiii");
      print(e);
    }
  }

  Future<Uint8List?> fetchImageBytes(String url) async {
    final response = await http
        .get(Uri.parse(url), headers: {'ngrok-skip-browser-warning': 'true'});

    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      return null;
    }
  }

  Future<void> _refreshData() async {
    await Future.delayed(Duration(seconds: 2)); // simulasi delay
    setState(() {
      fetchUser();
      fetchAllUsers('');
      Future.delayed(Duration(milliseconds: 700), () {
        setupFCM();
      });
    });
  }

  void showDeleteConfirmationDialog(
      BuildContext context, VoidCallback onConfirmDelete) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Konfirmasi Hapus"),
          content: Text("Apakah kamu yakin ingin menghapus user ini?"),
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

  @override
  Widget build(BuildContext context) {
    users?.sort((a, b) {
      int statusCompare = (a.status == 'belum diterima' ? 0 : 1)
          .compareTo(b.status == 'belum diterima' ? 0 : 1);
      if (statusCompare != 0) return statusCompare;

      DateTime dateA = a.createdAt ?? DateTime(2000);
      DateTime dateB = b.createdAt ?? DateTime(2000);

      return dateB.compareTo(dateA);
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 15),
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.black, width: 1),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.5 * 0.4,
                          height: MediaQuery.of(context).size.height * 0.05,
                          color: Color(0xFF3B8D28),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  token = '';
                                });
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Login(),
                                  ),
                                );
                              },
                              child: Center(
                                child: Text(
                                  "logout",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            user?.username ?? 'Ari',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 10.0, left: 15.0),
                            child: ClipOval(
                              child: (user?.photo == null)
                                  ? Image.asset(
                                      "assets/images/account.png",
                                      width: 40.0,
                                      height: 40.0,
                                      fit: BoxFit.cover,
                                    )
                                  : FutureBuilder<Uint8List?>(
                                      future: fetchImageBytes(
                                          "$api/${user?.photo}"),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return CircularProgressIndicator();
                                        } else if (snapshot.hasData) {
                                          return Image.memory(snapshot
                                              .data!); // <-- Tampilkan gambar
                                        } else {
                                          return Text("Gagal memuat gambar");
                                        }
                                      },
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Daftar Akun",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                      ),
                      child: Column(
                        children: [
                          // Search Box
                          Container(
                            height: 70,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.black,
                            child: Align(
                              alignment: Alignment(0, 0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  color: Colors.white,
                                  height: 30,
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: TextField(
                                    onChanged: (value) {
                                      Future.delayed(
                                          Duration(milliseconds: 500), () {
                                        setState(() {
                                          fetchAllUsers(value);
                                        });
                                      });
                                    },
                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                      hintText: "Cari...",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 7, horizontal: 10),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 7),
                            color: Color(0xFF2E6C25),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Center(
                                    child: Text("ID",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Center(
                                    child: Text("Role",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Center(
                                    child: Text("Username",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Center(
                                    child: Text("Phone",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Center(
                                    child: Text("Status",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          users == null
                              ? Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: CircularProgressIndicator(),
                                )
                              : Expanded(
                                  child: ListView.builder(
                                    itemCount: users!.length,
                                    itemBuilder: (context, index) {
                                      final user = users![index];
                                      return Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 7, horizontal: 5),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Center(
                                                child: Text(
                                                  '${index + 1}',
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Center(
                                                child: Text(
                                                  (user.idAdmin.toString() !=
                                                          "null")
                                                      ? "admin"
                                                      : "seller",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Center(
                                                child: Text(
                                                  user. username?? "",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Center(
                                                child: Text(
                                                  user.phone ?? "",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Center(
                                                  child: Column(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.5 *
                                                              0.4,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.05,
                                                      color: (user.status ==
                                                              "belum diterima")
                                                          ? Color(0xFF3B8D28)
                                                          : Colors.orange,
                                                      child: Material(
                                                        color:
                                                            Colors.transparent,
                                                        child: InkWell(
                                                          onTap: () async {
                                                            try {
                                                              var response = (user
                                                                          .idAdmin ==
                                                                      null)
                                                                  ? await UserApi
                                                                      .changeStatus(
                                                                          token,
                                                                          "seller",
                                                                          user.idSeller ??
                                                                              0)
                                                                  : await UserApi
                                                                      .changeStatus(
                                                                          token,
                                                                          "admin",
                                                                          user.idAdmin ??
                                                                              0);
                                                              if (response[
                                                                      'status'] ==
                                                                  200)
                                                                fetchAllUsers(
                                                                    '');
                                                            } catch (e) {
                                                              print(e);
                                                            }
                                                          },
                                                          child: Center(
                                                            child: Text(
                                                              (user.status ==
                                                                      "belum diterima")
                                                                  ? "terima"
                                                                  : "tolak",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.5 *
                                                              0.4,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.05,
                                                      color: Colors.red,
                                                      child: Material(
                                                        color:
                                                            Colors.transparent,
                                                        child: InkWell(
                                                          onTap: () async {
                                                            showDeleteConfirmationDialog(
                                                                context,
                                                                () async {
                                                              try {
                                                                var response = (user
                                                                            .idAdmin ==
                                                                        null)
                                                                    ? await UserApi.deleteUser(
                                                                        token,
                                                                        "seller",
                                                                        user.idSeller ??
                                                                            0)
                                                                    : await UserApi.deleteUser(
                                                                        token,
                                                                        "admin",
                                                                        user.idAdmin ??
                                                                            0);
                                                                if (response[
                                                                        'status'] ==
                                                                    200)
                                                                  fetchAllUsers(
                                                                      '');
                                                              } catch (e) {
                                                                print(e);
                                                              }
                                                            });
                                                          },
                                                          child: Center(
                                                            child: Text(
                                                              "hapus",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
