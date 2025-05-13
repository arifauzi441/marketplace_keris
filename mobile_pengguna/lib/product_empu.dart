import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile_pengguna/detail_product.dart';
import 'package:mobile_pengguna/model/product_api.dart';
import 'package:mobile_pengguna/model/user_api.dart';

class ProductEmpu extends StatefulWidget {
  final UserApi? users;
  const ProductEmpu({super.key, required this.users});

  @override
  State<ProductEmpu> createState() => _ProductEmpuState();
}

class _ProductEmpuState extends State<ProductEmpu> {
  final String api = dotenv.env['API_URL'] ?? "";
  List<ProductApi>? sellerProduct;

  @override
  void initState() {
    super.initState();
    fetchSellerProduct('');
  }

  Future<void> fetchSellerProduct(String search) async {
    try {
      var response =
          await ProductApi.getProductbySeller(widget.users?.idSeller ?? 1);
      setState(() {
        sellerProduct = response;
      });
    } catch (e) {
      print("hai");
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                              image: AssetImage('assets/images/logo-keris.png'),
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
                                    borderSide: BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(20)),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10)),
                            onChanged: (value) => setState(() {}),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.0),
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
              ConstrainedBox(
                constraints: BoxConstraints(minHeight: 150),
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  padding: EdgeInsets.all(10),
                  height: MediaQuery.of(context).size.width * 0.25,
                  color: Color(0xFF2E6C25),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${widget.users?.sellerName}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                            ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: 200),
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 2),
                                height: 1,
                                width: MediaQuery.of(context).size.width * 0.30,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "${widget.users?.sellerPhone}",
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(999),
                          child: Container(
                              height: MediaQuery.of(context).size.width * 0.25,
                              width: MediaQuery.of(context).size.width * 0.25,
                              child: (widget.users?.sellerPhoto == null)
                                  ? Image(
                                      image: AssetImage('images/potrait.png'),
                                      fit: BoxFit.cover,
                                    )
                                  : Image(
                                      image: NetworkImage(
                                          '$api/${widget.users?.sellerPhoto}'),
                                      fit: BoxFit.cover,
                                    )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "keris Empu Sepuh",
                        style: TextStyle(fontSize: 16), // opsional
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 0.6),
                        itemCount: sellerProduct?.length ?? 1,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: Color(0xFF2E6C25), width: 2)),
                            padding: EdgeInsets.all(5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    flex: 5,
                                    child: Container(
                                      color: Colors.lightGreen,
                                      child: (sellerProduct?[index]
                                                  .productPict
                                                  .isEmpty ??
                                              true)
                                          ? Image(
                                              image: AssetImage('images/2.png'),
                                              fit: BoxFit.cover,
                                            )
                                          : Image(
                                              image: NetworkImage(
                                                  '${sellerProduct?[index].productPict[0].path}'),
                                              fit: BoxFit.cover,
                                              width: double.infinity,
                                            ),
                                    )),
                                SizedBox(
                                  height: 5,
                                ),
                                Expanded(
                                    flex: 2,
                                    child: Text(
                                        "${sellerProduct?[index].productName}")),
                                Text("${sellerProduct?[index].productPrice}"),
                                SizedBox(
                                  height: 10,
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.5 *
                                          0.5,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.04,
                                      color: Color(0xFF53C737),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                            onTap: () async {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DetailProduct(
                                                              product:
                                                                  sellerProduct?[
                                                                      index])));
                                            },
                                            child: Center(
                                              child: Text(
                                                "Beli",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            )),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        })
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
