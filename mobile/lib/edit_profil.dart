import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:mobile/model/user_api.dart';

class EditProfil extends StatefulWidget {
  final String? token;
  final UserApi? user;
  const EditProfil({super.key, required this.token, required this.user});

  @override
  State<EditProfil> createState() => _EditProfilState();
}

class _EditProfilState extends State<EditProfil> {
  final api = dotenv.env['API_URL'] ?? "";
  String msg = '';
  File _image = File('');
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;

  Future<void> urlToFile(String imageUrl) async {
    try {
      final uri = Uri.parse(imageUrl);
      final response = await http.get(uri);

      if (response.statusCode != 200) {
        throw Exception('Gagal download gambar: ${response.statusCode}');
      }
      print(response.bodyBytes.length);

      final tempDir = await getApplicationDocumentsDirectory();
      final fileName = "userPhoto${widget.user?.idSeller}";
      final file = File('${tempDir.path}/$fileName.png');

      await file.writeAsBytes(response.bodyBytes);

      setState(() {
        _image = file;
        print(_image.path);
      });
    } catch (e) {
      setState(() {
        msg = e.toString();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    print(widget.user);
    _nameController = TextEditingController(text: widget.user?.sellerName);
    _phoneController = TextEditingController(text: widget.user?.sellerPhone);
    _addressController =
        TextEditingController(text: widget.user?.sellerAddress);
    _initAsync();
  }

  void _initAsync() async {
    if (widget.user?.sellerPhoto != null) {
      await urlToFile("$api/${widget.user?.sellerPhoto}");
    }
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
                Text("Edit Profil", style: TextStyle(fontSize: 20)),
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
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Foto profil",
                              style: TextStyle(fontSize: 35),
                            ),
                            _getImageInput(context)
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      _getTextField(context, "Nama"),
                      SizedBox(
                        height: 10,
                      ),
                      _getTextField(context, "No. telepon"),
                      SizedBox(
                        height: 15,
                      ),
                      _getTextField(context, "Alamat"),
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
                                      var result = await UserApi.updateUser(
                                          widget.token.toString(),
                                          _image,
                                          _nameController.text,
                                          _phoneController.text,
                                          _addressController.text);
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

  Widget _getImageInput(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.35,
      height: MediaQuery.of(context).size.width * 0.35,
      child: (_image.path.isNotEmpty)
          ? Stack(
              children: [
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.35 * 0.85,
                    height: MediaQuery.of(context).size.width * 0.35 * 0.85,
                    child: Stack(children: [
                      Positioned.fill(
                        child: Image.file(
                          _image,
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
                          MediaQuery.of(context).size.width * 0.35 * 0.9 * 0.17,
                      width:
                          MediaQuery.of(context).size.width * 0.35 * 0.9 * 0.17,
                      child: Material(
                        color: Colors.red,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _image = File('');
                            });
                          },
                          child: Center(
                            child: Text(
                              "X",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: MediaQuery.of(context).size.width *
                                      0.30 *
                                      0.17 *
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
          : SizedBox(
              width: MediaQuery.of(context).size.width * 0.35 * 0.85,
              height: MediaQuery.of(context).size.width * 0.35 * 0.85,
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
                      msg,
                      style: TextStyle(fontSize: 10),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => {_pickImageFromGallery()},
                    ),
                  ),
                ],
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
            keyboardType: TextInputType.text,
            controller: (text == 'Nama')
                ? _nameController
                : (text == 'Alamat')
                    ? _addressController
                    : _phoneController,
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

  Future _pickImageFromGallery() async {
    var result = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      _image = File(result!.path);
      print(_image.path);
    });
  }
}
