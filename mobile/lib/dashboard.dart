import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile/add_item.dart';
import 'package:mobile/edit_item.dart';
import 'package:mobile/edit_profil.dart';
import 'package:mobile/model/product_api.dart';
import 'package:mobile/model/user_api.dart';

class Dashboard extends StatefulWidget {
  final String? token;

  const Dashboard({super.key, required this.token});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  static final api = dotenv.env['API_URL'] ?? "";
  UserApi? user;

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  Future<void> fetchUser() async {
    try {
      UserApi? fetchedUser = await UserApi.getUser(widget.token ?? "");
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
      return Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 20.0, left: 5.0),
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
                    Text(
                      user?.email ?? '',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () async {
                    var response = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                EditProfil(token: widget.token, user: user)));
                    print(response);
                    if (mounted && response == true) fetchUser();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF53c737),
                  ),
                  child: Text(
                    "Edit Profil",
                    style: TextStyle(color: Colors.white),
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
                          builder: (context) =>
                              AddItem(token: widget.token))).then((value) => {
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
              SizedBox(height: 10),
              Text(
                "Anda belum menambahkan produk!",
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
            ],
          ),
          Spacer(),
        ],
      );
    } else {
      return Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
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
                      Expanded(
                        child: Text(
                          user?.email ?? '',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    var response = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                EditProfil(token: widget.token, user: user)));

                    if (mounted && response == true) fetchUser();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF53c737),
                  ),
                  child: Text(
                    "Edit Profil",
                    style: TextStyle(color: Colors.white),
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
          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddItem(
                                    token: widget.token,
                                  ))).then((value) => {
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
                ),
              ),
            ],
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
              padding: EdgeInsets.all(20),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 0.55,
              ),
              itemCount: user?.product.length,
              itemBuilder: (context, index) {
                return Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.5,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFF53c737), width: 2.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: (user?.product[index].productPict.isEmpty ??
                                true)
                            ? Image.asset(
                                'images/account.png',
                                fit: BoxFit.contain,
                              )
                            : Image.network(
                                user?.product[index].productPict[0].path ?? ""),
                      ),
                      Spacer(),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 40,
                              child: Text(
                                user?.product[index].productName ?? "",
                                style: TextStyle(fontWeight: FontWeight.bold),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              user?.product[index].productPrice ?? "",
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditItem(
                                            token: widget.token ?? "",
                                            product: user?.product[index])));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF53c737),
                                padding: EdgeInsets.symmetric(vertical: 8),
                              ),
                              child: Text(
                                "Ubah",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () async {
                                try {
                                  var response = await ProductApi.deleteProduct(
                                      user?.product[index].idProduct ?? 0,
                                      widget.token ?? "");
                                  if (response['status'] == 200) {
                                    fetchUser();
                                  }
                                  print(response);
                                } catch (e) {
                                  print(e);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF53c737),
                                padding: EdgeInsets.symmetric(vertical: 8),
                              ),
                              child: Text(
                                "Hapus",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
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
