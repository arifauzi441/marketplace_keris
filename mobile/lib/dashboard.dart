import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile/add_item.dart';
import 'package:mobile/detail_item.dart';
import 'package:mobile/edit_item.dart';
import 'package:mobile/edit_password.dart';
import 'package:mobile/edit_profil.dart';
import 'package:mobile/login.dart';
import 'package:mobile/model/product_api.dart';
import 'package:mobile/model/user_api.dart';

class Dashboard extends StatefulWidget {
  final String? token;

  Dashboard({super.key, required this.token});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  static final api = dotenv.env['API_URL'] ?? "";
  UserApi? user;
  bool _burgerMenu = false;
  late String? token;

  @override
  void initState() {
    super.initState();
    token = widget.token;
    fetchUser();
  }

  Future<void> fetchUser() async {
    try {
      UserApi? fetchedUser = await UserApi.getUser(token ?? "");
      if (!mounted) return;
      setState(() {
        user = fetchedUser;
      });
      print("fetching ....");
    } catch (e) {
      print("Error fetching user: $e");
    }
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
                                  : Image.network(
                                      "$api/${user?.sellerPhoto}",
                                      width: 40.0,
                                      height: 40.0,
                                      fit: BoxFit.cover,
                                    ),
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
                                  : Image.network(
                                      "$api/${user?.sellerPhoto}",
                                      width: 40.0,
                                      height: 40.0,
                                      fit: BoxFit.cover,
                                    ),
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
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 110),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 0.45,
                  ),
                  itemCount: user?.product.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
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
                        height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Color(0xFF53c737), width: 2.0),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      0.5 *
                                      0.5,
                                  height: MediaQuery.of(context).size.width *
                                      0.5 *
                                      0.5 *
                                      0.3,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      try {
                                        var response = await ProductApi
                                            .changeProductStatus(
                                                user?.product[index]
                                                        .idProduct ??
                                                    0,
                                                token ?? "");
                                        if (response['status'] == 200) {
                                          fetchUser();
                                        }
                                        print(response);
                                      } catch (e) {
                                        print(e);
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: (user?.product[index]
                                                    .productStatus ==
                                                'aktif')
                                            ? Color(0xFFFF3636)
                                            : Color(0xFF53c737),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 0.1)),
                                    child: Center(
                                      child: Text(
                                        (user?.product[index].productStatus ==
                                                'aktif')
                                            ? "nonaktifkan"
                                            : "aktifkan",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5 *
                                                0.5 *
                                                0.3 *
                                                0.45),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: AspectRatio(
                                aspectRatio: 1,
                                child:
                                    (user?.product[index].productPict.isEmpty ??
                                            true)
                                        ? Image.asset(
                                            'images/potrait.png',
                                            fit: BoxFit.cover,
                                          )
                                        : Image.network(
                                            user?.product[index].productPict[0]
                                                    .path ??
                                                "",
                                            fit: BoxFit.cover,
                                          ),
                              ),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 50,
                                    child: Text(
                                      user?.product[index].productName ?? "",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    user?.product[index].productPrice ?? "",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    'Stock: ${user?.product[index].productStock ?? ""}',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      0.4 *
                                      0.4,
                                  height: MediaQuery.of(context).size.width *
                                      0.5 *
                                      0.5 *
                                      0.3,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      var response = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => EditItem(
                                                  token: token ?? "",
                                                  product:
                                                      user?.product[index])));
                                      if (mounted && response == true) {
                                        fetchUser();
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xFF53c737),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 0.1)),
                                    child: Center(
                                      child: Text(
                                        "ubah",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5 *
                                                0.5 *
                                                0.3 *
                                                0.45),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      0.4 *
                                      0.4,
                                  height: MediaQuery.of(context).size.width *
                                      0.5 *
                                      0.5 *
                                      0.3,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      try {
                                        var response =
                                            await ProductApi.deleteProduct(
                                                user?.product[index]
                                                        .idProduct ??
                                                    0,
                                                token ?? "");
                                        if (response['status'] == 200) {
                                          fetchUser();
                                        }
                                        print(response);
                                      } catch (e) {
                                        print(e);
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xFFFF3636),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 0.1)),
                                    child: Center(
                                      child: Text(
                                        "hapus",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5 *
                                                0.5 *
                                                0.3 *
                                                0.45),
                                        textAlign: TextAlign.center,
                                      ),
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
