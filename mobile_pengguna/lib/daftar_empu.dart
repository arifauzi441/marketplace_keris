import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_pengguna/dashboard.dart';
import 'package:mobile_pengguna/model/user_api.dart';

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
                            constraints: BoxConstraints(
                              maxWidth:
                                  MediaQuery.of(context).size.width * 0.55,
                              minWidth: 100,
                            ),
                            child: SearchAnchor(
                              builder: (BuildContext context,
                                  SearchController controller) {
                                return SearchBar(
                                  controller: controller,
                                  hintText: "Cari...",
                                  padding: WidgetStateProperty.all(
                                    EdgeInsets.symmetric(horizontal: 10.0),
                                  ),
                                  onTap: () => controller.openView(),
                                  onChanged: (_) => controller.openView(),
                                  leading: const Icon(Icons.search, size: 20),
                                );
                              },
                              suggestionsBuilder: (BuildContext context,
                                  SearchController controller) {
                                return List<ListTile>.generate(10, (int index) {
                                  final String item = 'item $index';
                                  return ListTile(
                                    title: Text(item),
                                    onTap: () {
                                      controller.closeView(item);
                                    },
                                  );
                                });
                              },
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
                child: Divider(thickness: 1, color: Colors.black),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 120,
                              height: 25,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Dashboard()));
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 1),
                                ),
                                child: Text(
                                  "Kembali",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15.0),
                                ),
                              ),
                            ),
                          ],
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
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                                  builder: (context) => DaftarEmpu(),
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
                                      Center(
                                        child: ClipOval(
                                          child: (users?[index].sellerPhoto ==
                                                  null)
                                              ? Image.asset(
                                                  "images/potrait.png",
                                                  height: imageSize,
                                                  width: imageSize,
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.network(
                                                  "$api/${users?[index].sellerPhoto}",
                                                  height: imageSize,
                                                  width: imageSize,
                                                  fit: BoxFit.cover,
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
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              "${users?[index].sellerPhone}",
                                              overflow: TextOverflow.ellipsis,
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
                                            backgroundColor: Colors.transparent,
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
                                                fontWeight: FontWeight.normal),
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
        ],
      ),
    );
  }
}
