import 'package:flutter/material.dart';
import 'package:mobile/model/product_api.dart';

class DetailItem extends StatefulWidget {
  final String? token;
  final ProductApi? product;

  const DetailItem({super.key, required this.token, required this.product});

  @override
  _DetailItemState createState() => _DetailItemState();
}

class _DetailItemState extends State<DetailItem> {
  late String _mainProductPict;

  @override
  void initState() {
    super.initState();
    _mainProductPict = (widget.product!.productPict.isNotEmpty)
        ? widget.product?.productPict[0].path ?? ""
        : "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 30.0, left: 20.0),
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
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.86,
                    height: MediaQuery.of(context).size.width * 0.86 * 0.75,
                    color: Colors.white,
                    child: (widget.product!.productPict.isEmpty ||
                            _mainProductPict == "")
                        ? Image.asset(
                            'assets/images/bg.jpg',
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            _mainProductPict,
                            fit: BoxFit.contain,
                          ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.86,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      4,
                      (index) => ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _mainProductPict =
                                      (widget.product!.productPict.length <=
                                              index)
                                          ? ""
                                          : widget.product?.productPict[index]
                                                  .path ??
                                              "";
                                });
                              },
                              child: (widget.product!.productPict.length <=
                                      index)
                                  ? Ink.image(
                                      image: AssetImage('assets/images/bg.jpg'),
                                      width: MediaQuery.of(context).size.width *
                                          0.86 *
                                          0.2,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.86 *
                                              0.2,
                                      fit: BoxFit.cover,
                                    )
                                  : Ink.image(
                                      image: NetworkImage(widget.product
                                              ?.productPict[index].path ??
                                          ""),
                                      width: MediaQuery.of(context).size.width *
                                          0.86 *
                                          0.2,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.86 *
                                              0.2,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          )),
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
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Text(
                              widget.product?.productName ?? "",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
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
