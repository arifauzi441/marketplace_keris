import 'package:flutter/material.dart';
import 'package:mobile_admin/dashboard.dart';
import 'package:mobile_admin/model/login_api.dart';
import 'package:mobile_admin/register.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String errorMsg = '';
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
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
                      width: 100,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.vertical(
                              top: Radius.zero, bottom: Radius.circular(20))),
                      child: Center(
                        child: Text(
                          "Login",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
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
                        getTextField(context, "Username"),
                        getTextField(context, "Password"),
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
                                    var result = await LoginApi.login(
                                        _usernameController.text,
                                        _passwordController.text);
                                    print("hai");
                                    if (!mounted) return;

                                    if (result.token.isNotEmpty) {
                                      if (!mounted) return;
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Dashboard(
                                                  token: result.token)));
                                    }

                                    setState(() {
                                      errorMsg = result.msg;
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
                                Text("Belum punya akun ? "),
                                InkWell(
                                    onTap: () => {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Register()))
                                        },
                                    child: Text(
                                      "Daftar",
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
              controller:
                  (label == 'Username') ? _usernameController : _passwordController,
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
