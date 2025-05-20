import 'package:flutter/material.dart';
import 'package:mobile/login.dart';
import 'package:mobile/model/user_api.dart';

class ResetPassword extends StatefulWidget {
  final String token;
  const ResetPassword({super.key, required this.token});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  String errorMsg = '';
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    String token = widget.token;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.45 +
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
                          "Reset Password",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        (errorMsg.isNotEmpty)
                            ? Text(
                                errorMsg,
                                style: TextStyle(color: Colors.red),
                                textAlign: TextAlign.center,
                              )
                            : SizedBox(
                                height: 0,
                              ),
                        getTextField(context, "Password"),
                        getTextField(context, "Confirm Password"),
                      ],
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
                                    var result = await UserApi.ResetPassword(
                                      token,
                                        _confirmNewPasswordController.text,
                                        _newPasswordController.text);
                                    if (!mounted) return;

                                    if (result['status'] == 200) {
                                      if (!mounted) return;
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Login()));
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
                                    "Masuk",
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

  Container getTextField(BuildContext context, String label) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: MediaQuery.of(context).size.width * 0.8 * 0.8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5 * 0.10,
            child: TextField(
              controller: (label == 'Password')
                  ? _newPasswordController
                  : _confirmNewPasswordController,
              cursorColor: Colors.green,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 2.0),
                      borderRadius: BorderRadius.circular(20)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 5, horizontal: 10)),
            ),
          )
        ],
      ),
    );
  }
}
