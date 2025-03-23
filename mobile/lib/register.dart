import 'package:flutter/material.dart';
import 'package:mobile/login.dart';
import 'package:mobile/register_api.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String email = '';
  String password = '';
  String alamat = '';

  RegisterApi register = RegisterApi(msg: '', statusCode: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
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
                          "Register",
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
                        (register.msg.isNotEmpty)
                            ? Text(
                                register.msg,
                                style: (register.statusCode != 201)
                                    ? TextStyle(color: Colors.red)
                                    : TextStyle(color: Colors.green),
                                textAlign: TextAlign.center,
                              )
                            : SizedBox(
                                height: 0,
                              ),
                        getTextField(context, "Email"),
                        getTextField(context, "Password"),
                        getTextField(context, "Alamat"),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 25),
                          width: 110,
                          height: 35,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Material(
                              color: Colors.green,
                              child: InkWell(
                                onTap: () async {
                                  try {
                                    var result = await RegisterApi.register(
                                        email, password, alamat);

                                    setState(() {
                                      register = result;
                                    });
                                  } catch (e) {
                                    print(e);
                                  }
                                },
                                child: Center(
                                  child: Text(
                                    "Daftar",
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
                                Text("Sudah punya akun ? "),
                                InkWell(
                                    onTap: () => {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Login()))
                                        },
                                    child: Text(
                                      "Login",
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
      margin: EdgeInsets.symmetric(vertical: 5),
      width: MediaQuery.of(context).size.width * 0.8 * 0.8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5 * 0.10,
            child: TextField(
              onChanged: (value) => setState(() {
                if (label == "Email") {
                  email = value;
                } else if (label == "Password") {
                  password = value;
                } else {
                  alamat = value;
                }
              }),
              cursorColor: Colors.green,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 2.0),
                      borderRadius: BorderRadius.circular(20)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 8, horizontal: 10)),
            ),
          )
        ],
      ),
    );
  }
}
