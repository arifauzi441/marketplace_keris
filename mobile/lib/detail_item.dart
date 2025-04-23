import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile/model/product_api.dart';
import 'package:mobile/model/user_api.dart';

class DetailItem extends StatefulWidget {
  final String? token;
  final ProductApi? product;

  const DetailItem({super.key, required this.token, required this.product});

  @override
  _DetailItemState createState() => _DetailItemState();
}

class _DetailItemState extends State<DetailItem> {
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
    } catch (e) {
      print("Error fetching user: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.menu, size: 40.0),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              user?.email ?? 'Nama Empu',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(width: 8),
                          ClipOval(
                            child: (user?.sellerPhoto == null)
                                ? Image.asset("images/account.png",
                                    width: 40, height: 40, fit: BoxFit.cover)
                                : Image.network("$api/${user?.sellerPhoto}",
                                    width: 40, height: 40, fit: BoxFit.cover),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(thickness: 1, color: Colors.black),
              Padding(
                padding: EdgeInsets.only(top: 20.0, left: 20.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF53c737)),
                    child: Text(
                      'Kembali',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
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
                  child: (widget.product?.productPict.isEmpty??true)
                      ? Image.asset(
                          'images/potrait.png',
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          widget.product?.productPict as String,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    4,
                    (index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: (user?.product[0].productPict.isEmpty ?? true)
                            ? Image.asset(
                                'images/2.png',
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              )
                            : SizedBox.shrink(),
                      ),
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
                          Text(
                            widget.product?.productName ?? "",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.product?.productPrice ?? "",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ],
                      )
                    : SizedBox.shrink(),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child:
                      (widget.product?.productDescription?.isNotEmpty ?? false)
                          ? Text(
                              widget.product?.productDescription ?? "",
                              textAlign: TextAlign.justify,
                              style: TextStyle(fontSize: 14),
                            )
                          : SizedBox.shrink(),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
