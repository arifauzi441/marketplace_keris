import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_pengguna/daftar_empu.dart';
import 'package:mobile_pengguna/detail_product.dart';
import 'package:mobile_pengguna/model/product_api.dart';
import 'package:mobile_pengguna/model/user_api.dart';
import 'package:mobile_pengguna/populer_product.dart';
import 'package:mobile_pengguna/product_empu.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final String api = dotenv.env['API_URL'] ?? "";
  List<UserApi>? users;
  List<ProductApi>? popularProduct;
  @override
  void initState() {
    super.initState();
    fetchAllUsers('');
    fetchPopularProduct('');
  }

  Future<void> fetchAllUsers(String search) async {
    try {
      var response = await UserApi.getAllSeller(search);
      setState(() {
        users = response;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchPopularProduct(String search) async {
    try {
      var response = await ProductApi.getPopularProduct(search);
      setState(() {
        popularProduct = response;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
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
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                              ),
                              onChanged: (value) => setState(() {
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Daftar Nama Empu",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: MediaQuery.of(context).size.width *
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
                                        builder: (context) => DaftarEmpu()));
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
                                  fontSize: MediaQuery.of(context).size.width *
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
                          itemCount: users?.length,
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
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                padding: EdgeInsets.all(2.0),
                                child: Builder(
                                  builder: (context) {
                                    double screenWidth =
                                        MediaQuery.of(context).size.width;
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
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        (users?[index].sellerPhoto == null)
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
                                                ),
                                              ),
                                        SizedBox(height: 6),
                                        Text(
                                          "${users?[index].sellerName}",
                                          style: TextStyle(
                                            fontSize: nameFontSize,
                                            fontWeight: FontWeight.normal,
                                            overflow: TextOverflow.ellipsis
                                          ),
                                        ),
                                        Text(
                                          "${users?[index].sellerPhone}",
                                          style: TextStyle(
                                              fontSize: nameFontSize2,
                                              fontWeight: FontWeight.normal,
                                              overflow: TextOverflow.ellipsis
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
                                fontSize: MediaQuery.of(context).size.width *
                                    0.5 *
                                    0.5 *
                                    0.48 *
                                    0.45,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () => {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PopulerProduct()))
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
                                  fontSize: MediaQuery.of(context).size.width *
                                      0.5 *
                                      0.5 *
                                      0.35 *
                                      0.45,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      GridView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 0.58,
                        ),
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailProduct(
                                    product: popularProduct?[index],
                                  ),
                                ),
                              );
                            },
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                double imageSize = constraints.maxWidth * 0.9;
                                return Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  padding: EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      (popularProduct?[index]
                                                  .productPict
                                                  .isEmpty ??
                                              true)
                                          ? Center(
                                              child: Image.asset(
                                                "images/bg.jpg",
                                                height: imageSize,
                                                width: imageSize,
                                                fit: BoxFit.cover,
                                              ),
                                            )
                                          : Center(
                                              child: Image.network(
                                                "${popularProduct?[index].productPict[0].path}",
                                                height: imageSize,
                                                width: imageSize,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                      Spacer(),
                                      Text(
                                        "${popularProduct?[index].productName}",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.5 *
                                              0.5 *
                                              0.3 *
                                              0.45,
                                        ),
                                      ),
                                      Text(
                                        "${popularProduct?[index].productPrice}",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.5 *
                                              0.5 *
                                              0.3 *
                                              0.45,
                                        ),
                                      ),
                                      Spacer(),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Color(0xFF53C737),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 3),
                                            textStyle: TextStyle(fontSize: 14),
                                          ),
                                          child: Text(
                                            "Beli",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.5 *
                                                  0.5 *
                                                  0.4 *
                                                  0.45,
                                            ),
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
                              "Produk Terbaru",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: MediaQuery.of(context).size.width *
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
                      GridView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 0.58,
                        ),
                        itemCount: popularProduct?.length ?? 1,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailProduct(
                                    product: popularProduct?[index],
                                  ),
                                ),
                              );
                            },
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                double imageSize = constraints.maxWidth * 0.9;
                                return Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  padding: EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      (popularProduct?[index]
                                                  .productPict
                                                  .isEmpty ??
                                              true)
                                          ? Center(
                                              child: Image.asset(
                                                "images/bg.jpg",
                                                height: imageSize,
                                                width: imageSize,
                                                fit: BoxFit.cover,
                                              ),
                                            )
                                          : Center(
                                              child: Image.network(
                                                "${popularProduct?[index].productPict[0].path}",
                                                height: imageSize,
                                                width: imageSize,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                      Spacer(),
                                      Text(
                                        "${popularProduct?[index].productName}",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5 *
                                              0.5 *
                                              0.3 *
                                              0.45,
                                        ),
                                      ),
                                      Text(
                                        "${popularProduct?[index].productPrice}",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5 *
                                              0.5 *
                                              0.3 *
                                              0.45,
                                        ),
                                      ),
                                      Spacer(),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Color(0xFF53C737),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 8),
                                            textStyle: TextStyle(fontSize: 14),
                                          ),
                                          child: Text(
                                            "Beli",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.5 *
                                                  0.5 *
                                                  0.4 *
                                                  0.45,  
                                            ),
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
            ],
          ),
        ],
      ),
    );
  }
}
