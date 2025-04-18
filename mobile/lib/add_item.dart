import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/product_api.dart';

class AddItem extends StatefulWidget {
  final String? token;
  const AddItem({super.key, required this.token});

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  String msg = '';
  final List<File> _image = List.filled(4, File(''));
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();

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
                                          await ProductApi.storeProduct(
                                              _nameController.text,
                                              _descriptionController.text,
                                              int.parse(_priceController.text),
                                              int.parse(_stockController.text),
                                              _image,
                                              widget.token.toString());
                                      if (!mounted) return;

                                      if (result['status'] == 201) {
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
      width: MediaQuery.of(context).size.width * 0.15,
      height: MediaQuery.of(context).size.width * 0.15,
      child: (_image[index].path.isNotEmpty)
          ? Image.file(
              _image[index],
              fit: BoxFit.cover,
            )
          : Stack(
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
                    style: TextStyle(fontSize: 35),
                    textAlign: TextAlign.center,
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => {_pickImageFromGallery(index)},
                  ),
                )
              ],
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
