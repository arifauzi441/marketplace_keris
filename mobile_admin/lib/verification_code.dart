import 'package:flutter/material.dart';
import 'package:mobile_admin/model/user_api.dart';
import 'package:mobile_admin/reset_password.dart';

class VerificationCode extends StatefulWidget {
  final String phone_admin;
  const VerificationCode({super.key, required this.phone_admin});

  @override
  State<VerificationCode> createState() => _VerificationCodeState();
}

class _VerificationCodeState extends State<VerificationCode> {
  String errorMsg = '';
  final TextEditingController _codeController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.35 +
                    MediaQuery.of(context).size.width * 0.1,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.green, width: 3),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          spreadRadius: 5,
                          blurRadius: 3,
                          offset: Offset(12, 12))
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.vertical(
                              top: Radius.zero, bottom: Radius.circular(20))),
                      child: Center(
                        child: Text(
                          "Verifikasi Kode",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    (errorMsg != '')
                        ? Text(
                            errorMsg,
                            style: TextStyle(color: Colors.red),
                          )
                        : SizedBox(
                            height: 0,
                          ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      width: MediaQuery.of(context).size.width * 0.8 * 0.8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Kode Verifikasi"),
                          SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 0.5 * 0.10,
                            child: TextField(
                              controller: _codeController,
                              cursorColor: Colors.green,
                              decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.green, width: 2.0),
                                      borderRadius: BorderRadius.circular(20)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10)),
                            ),
                          )
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 110,
                          height: 35,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Material(
                              color: Colors.green,
                              child: InkWell(
                                onTap: () async {
                                  try {
                                    var result = await UserApi.verifyCode(
                                      _codeController.text,
                                      widget.phone_admin,
                                    );
                                    if (!mounted) return;

                                    print(result['status'] == 200);
                                    if (result['status'] == 200) {
                                      if (!mounted) return;

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ResetPassword(
                                                    token: result['token'],
                                                  )));
                                    }

                                    setState(() {
                                      errorMsg = result['msg'];
                                    });
                                  } catch (e) {
                                    print(e);
                                  }
                                },
                                child: Center(
                                  child: Text(
                                    "Submit",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 30),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                    onTap: () => {Navigator.pop(context)},
                                    child: Text(
                                      "Kembali",
                                      style: TextStyle(color: Colors.green),
                                    ))
                              ]),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
