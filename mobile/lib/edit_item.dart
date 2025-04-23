import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:mobile/model/product_api.dart';

class EditItem extends StatefulWidget {
  final String? token;
  final ProductApi? product;
  const EditItem({super.key, required this.token, required this.product});

  @override
  State<EditItem> createState() => _EditItemState();
}

class _EditItemState extends State<EditItem> {
  final api = dotenv.env['API_URL'] ?? "";
  String msg = '';
  final List<File> _image = List.filled(4, File(''));
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  late TextEditingController _stockController;

  Future<void> urlToFile(String imageUrl, int index) async {
    try {
      print(imageUrl);
      final uri = Uri.parse(imageUrl);
      final response = await http.get(uri);

      if (response.statusCode != 200) {
        throw Exception('Gagal download gambar: ${response.statusCode}');
      }
      print(response.bodyBytes.length);

      final tempDir = await getApplicationDocumentsDirectory();
      final fileName = "product${widget.product?.idProduct}Photo${DateTime.now().millisecondsSinceEpoch}";
      final file = File('${tempDir.path}/$fileName.png');

      await file.writeAsBytes(response.bodyBytes);

      setState(() {
        _image[index] = file;
        print(_image[index].path);
      });
    } catch (e) {
      setState(() {
        msg = e.toString();
      });
    }
  }

  void _initAsync() async {
    for (var i = 0; i < widget.product!.productPict.length; i++) {
      if (widget.product?.productPict[i] != null) {
        await urlToFile("${widget.product?.productPict[i].path}", i);
        ;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _nameController =
        TextEditingController(text: widget.product?.productName ?? '');
    _descriptionController =
        TextEditingController(text: widget.product?.productDescription ?? '');
    _priceController = TextEditingController(
        text: widget.product?.productPrice?.replaceAll(RegExp(r'[^0-9]'), '') ??
            "0");
    _stockController =
        TextEditingController(text: widget.product?.productStock ?? "");
    print(widget.product?.productStock);
    _initAsync();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Tambah Produk Baru", style: TextStyle(fontSize: 20)),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  width: 100,
                  height: 30,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Material(
                      color: Colors.green,
                      child: InkWell(
                        child: Center(
                          child: Text(
                            "Kembali",
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        onTap: () => {Navigator.pop(context)},
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.green, width: 3)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Informasi Produk",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      _getTextField(context, "Nama Produk"),
                      SizedBox(
                        height: 10,
                      ),
                      _getTextField(context, "Harga Produk"),
                      SizedBox(
                        height: 15,
                      ),
                      _getTextField(context, "Stok Produk"),
                      SizedBox(
                        height: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Foto Produk"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _getImageInput(context, 0),
                              _getImageInput(context, 1),
                              _getImageInput(context, 2),
                              _getImageInput(context, 3),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("description"),
                          Text(
                            msg,
                            style: TextStyle(color: Colors.red),
                          ),
                          TextField(
                            maxLines: 4,
                            controller: _descriptionController,
                            cursorColor: Colors.green,
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.green, width: 2.0),
                                    borderRadius: BorderRadius.circular(20)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 10)),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.6,
                            height: 35,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Material(
                                color: Colors.green,
                                child: InkWell(
                                  onTap: () async {
                                    try {
                                      var result =
                                          await ProductApi.updateProduct(
                                              _nameController.text,
                                              _descriptionController.text,
                                              _priceController.text,
                                              _stockController.text,
                                              _image,
                                              widget.token.toString(),
                                              widget.product!.idProduct ?? 999999);
                                      if (!mounted) return;

                                      if (result['status'] == 200) {
                                        if (!mounted) return;
                                        Navigator.pop(context, true);
                                      }

                                      setState(() {
                                        msg = result['msg'];
                                      });
                                    } catch (e) {
                                      setState(() {
                                        msg = e.toString();
                                      });
                                      print(e);
                                    }
                                  },
                                  child: Center(
                                    child: Text(
                                      "Selesai",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox _getImageInput(BuildContext context, int index) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.17,
      height: MediaQuery.of(context).size.width * 0.17,
      child: (_image[index].path.isNotEmpty)
          ? Stack(
              children: [
                Center(
                  child: Container(
                    color: Colors.lightBlue,
                    width: MediaQuery.of(context).size.width * 0.17 * 0.90,
                    height: MediaQuery.of(context).size.width * 0.17 * 0.90,
                    child: Stack(clipBehavior: Clip.none, children: [
                      Positioned.fill(
                        child: Image.file(
                          _image[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ]),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: SizedBox(
                      height:
                          MediaQuery.of(context).size.width * 0.17 * 0.9 * 0.25,
                      width:
                          MediaQuery.of(context).size.width * 0.17 * 0.9 * 0.25,
                      child: Material(
                        color: Colors.red,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _image[index] = File('');
                            });
                          },
                          child: Center(
                            child: Text(
                              "X",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: MediaQuery.of(context).size.width *
                                      0.17 *
                                      0.25 *
                                      0.5),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )
          : Center(
            child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.17 * 0.90,
                height: MediaQuery.of(context).size.width * 0.17 * 0.90,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned.fill(
                      child: Image(
                        image: AssetImage("assets/images/bg.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Center(
                      child: Text(
                        "+",
                        style: TextStyle(fontSize: 15),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => {_pickImageFromGallery(index)},
                      ),
                    ),
                  ],
                ),
              ),
          ),
    );
  }

  Column _getTextField(BuildContext context, String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.5 * 0.10,
          child: TextField(
            keyboardType: (text == 'Nama Produk')
                ? TextInputType.text
                : TextInputType.number,
            inputFormatters: (text == 'Harga Produk' || text == 'Stok Produk')
                ? [FilteringTextInputFormatter.digitsOnly]
                : [],
            controller: (text == 'Nama Produk')
                ? _nameController
                : (text == 'Harga Produk')
                    ? _priceController
                    : _stockController,
            cursorColor: Colors.green,
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 2.0),
                    borderRadius: BorderRadius.circular(20)),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 5, horizontal: 10)),
          ),
        )
      ],
    );
  }

  Future _pickImageFromGallery(int i) async {
    var result = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      _image[i] = File(result!.path);
      print(_image[i]);
    });
  }
}
