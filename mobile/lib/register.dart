import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:mobile/login.dart';
import 'package:mobile/model/register_api.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _obscureText = true;
  final TextEditingController _sellerNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  RegisterApi register = RegisterApi(msg: '', statusCode: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.3,
                child: Image(
                  image: AssetImage('assets/images/bg-auth.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 90,
                              width: 110,
                              child: Image(
                                image: AssetImage('assets/images/logo-keris.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Color(0xFF53C737), width: 3),
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
                                        color: Color(0xFF53C737),
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.zero,
                                            bottom: Radius.circular(20))),
                                    child: Center(
                                      child: Text(
                                        "Register",
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
                                      (register.msg.isNotEmpty)
                                          ? Text(
                                              register.msg,
                                              style: (register.statusCode != 201)
                                                  ? TextStyle(color: Colors.red)
                                                  : TextStyle(
                                                      color: Color(0xFF53C737)),
                                              textAlign: TextAlign.center,
                                            )
                                          : SizedBox(
                                              height: 0,
                                            ),
                                      getTextField(context, "Name"),
                                      getTextField(context, "Username"),
                                      getTextField(context, "Password"),
                                      getTextField(context, "Phone"),
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
                                            color: Color(0xFF53C737),
                                            child: InkWell(
                                              onTap: () async {
                                                try {
                                                  var result =
                                                      await RegisterApi.register(
                                                          _usernameController.text,
                                                          _passwordController.text,
                                                          _sellerNameController
                                                              .text,
                                                          _phoneController.text);
                
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text("Sudah punya akun ? "),
                                              InkWell(
                                                  onTap: () => {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        Login()))
                                                      },
                                                  child: Text(
                                                    "Login",
                                                    style: TextStyle(
                                                        color: Color(0xFF53C737)),
                                                  ))
                                            ]),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                                height: MediaQuery.of(context).size.height * 0.2 -
                                    MediaQuery.of(context).size.width * 0.1)
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
            ),
          ],
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
              obscureText: (label != "Password") ? false : _obscureText,
              keyboardType: (label == "Phone")
                  ? TextInputType.number
                  : TextInputType.text,
              inputFormatters: (label == "Phone")
                  ? [FilteringTextInputFormatter.digitsOnly]
                  : [],
              controller: (label == 'Username')
                  ? _usernameController
                  : (label == 'Password')
                      ? _passwordController
                      : (label == "Phone")
                          ? _phoneController
                          : _sellerNameController,
              cursorColor: Color(0xFF53C737),
              decoration: InputDecoration(
                  suffixIcon: (label == 'Password')
                      ? (!_obscureText)
                          ? IconButton(
                              onPressed: () => setState(() {
                                    _obscureText = true;
                                  }),
                              icon: Icon(Icons.visibility_off))
                          : IconButton(
                              onPressed: () => setState(() {
                                    _obscureText = false;
                                  }),
                              icon: Icon(Icons.visibility))
                      : (label == "Username")
                          ? Icon(Icons.person)
                          : (label == "Phone")
                              ? Icon(Icons.phone)
                              : Icon(Icons.account_circle),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF53C737), width: 2.0),
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
