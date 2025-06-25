import 'package:flutter/material.dart';
import 'package:mobile/model/user_api.dart';

class EditPassword extends StatefulWidget {
  final String? token;
  const EditPassword({super.key, required this.token});

  @override
  State<EditPassword> createState() => _EditPasswordState();
}

class _EditPasswordState extends State<EditPassword> {
  String msg = '';
  late String token;
  final TextEditingController _currPasswordController =
      TextEditingController(text: '');
  final TextEditingController _newPasswordController =
      TextEditingController(text: '');
  final TextEditingController _newPassword2Controller =
      TextEditingController(text: '');

  @override
  void initState() {
    super.initState();
    token = widget.token ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Edit Password", style: TextStyle(fontSize: 20)),
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
                        (msg != "Berhasil mengubah password")
                            ? Center(
                                child: Text(
                                  msg,
                                  style: TextStyle(color: Colors.red),
                                ),
                              )
                            : SizedBox(
                                width: 0,
                                height: 0,
                              ),
                        SizedBox(
                          height: 20,
                        ),
                        _getTextField(context, "Password lama"),
                        SizedBox(
                          height: 10,
                        ),
                        _getTextField(context, "Password baru"),
                        SizedBox(
                          height: 15,
                        ),
                        _getTextField(context, "Konfirmasi password baru"),
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
                                            await UserApi.changePassword(
                                                widget.token.toString(),
                                                _currPasswordController.text,
                                                _newPasswordController.text,
                                                _newPassword2Controller.text);
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
            controller: (text == 'Password lama')
                ? _currPasswordController
                : (text == 'Konfirmasi password baru')
                    ? _newPasswordController
                    : _newPassword2Controller,
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
}
