import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      print("hai");
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
      print("hai");
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipOval(
                      child: Image.asset(
                        "images/potrait.png",
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              "KerisSumenep",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          SizedBox(width: 10),
                          ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: 200),
                            child: Container(
                              height: 30,
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: TextField(
                                decoration: InputDecoration(
                                    hintText: "Search..",
                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 10)),
                                onChanged: (value) => Future.delayed(
                                    Duration(milliseconds: 500),
                                    () => setState(() {
                                          fetchAllUsers(value);
                                          fetchPopularProduct(value);
                                        })),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(thickness: 1, color: Colors.black),
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
                                fontSize: 18.0,
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
                                backgroundColor: Colors.green,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 7, vertical: 7),
                              ),
                              child: Text(
                                "Selengkapnya",
                                style: TextStyle(color: Colors.white),
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
                                padding: EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    (users?[index].sellerPhoto == null)
                                        ? ClipOval(
                                            child: Image.asset(
                                              "images/potrait.png",
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
                                    Text("${users?[index].sellerName}"),
                                    Text("${users?[index].sellerPhone}"),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
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
                                fontSize: 18.0,
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
                                backgroundColor: Colors.green,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 7, vertical: 7),
                              ),
                              child: Text(
                                "Selengkapnya",
                                style: TextStyle(color: Colors.white),
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
                                                "images/potrait.png",
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
                                      ),
                                      Text(
                                        "${popularProduct?[index].productPrice}",
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Spacer(),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.green,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 8),
                                            textStyle: TextStyle(fontSize: 14),
                                          ),
                                          child: Text(
                                            "Beli",
                                            style:
                                                TextStyle(color: Colors.white),
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
                child: Align(
                  alignment: Alignment(0, 0.9),
                  child: Row(
                    children: [
                      Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Dashboard()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero),
                          padding: EdgeInsets.zero,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.network(
                              'https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/icons/house.svg',
                              width: 24,
                              height: 24,
                            ),
                            SizedBox(height: 5),
                            Text(
                              "E-Tour",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      SizedBox(
                        height: 40,
                        child: VerticalDivider(
                          color: Colors.grey,
                          thickness: 1,
                        ),
                      ),
                      Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Dashboard()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero),
                          padding: EdgeInsets.zero,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.network(
                              'https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/icons/bag-check.svg',
                              width: 24,
                              height: 24,
                            ),
                            SizedBox(height: 5),
                            Text(
                              "Toko",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
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
