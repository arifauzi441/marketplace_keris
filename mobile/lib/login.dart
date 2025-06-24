import 'package:flutter/material.dart';
import 'package:mobile/dashboard.dart';
import 'package:mobile/input_phone_number.dart';
import 'package:mobile/model/login_api.dart';
import 'package:mobile/register.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _obscureText = true;
  String errorMsg = '';
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            LayoutBuilder(builder: (context, constraints) {
              return SingleChildScrollView(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
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
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: 400,
                            ),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.5 +
                                  MediaQuery.of(context).size.width * 0.1,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                              style:
                                                  TextStyle(color: Colors.red),
                                              textAlign: TextAlign.center,
                                            )
                                          : SizedBox(
                                              height: 0,
                                            ),
                                      getTextField(context, "Username"),
                                      getTextField(context, "Password"),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.8 *
                                                0.8,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            InkWell(
                                              onTap: () => Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          InputPhoneNumber())),
                                              child: Text(
                                                "Lupa Password?",
                                                style: TextStyle(
                                                    color: Colors.blue),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 110,
                                        height: 35,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Material(
                                            color: Color(0xFF53C737),
                                            child: InkWell(
                                              onTap: () async {
                                                try {
                                                  var result =
                                                      await LoginApi.login(
                                                          _usernameController
                                                              .text,
                                                          _passwordController
                                                              .text);
                                                  if (!mounted) return;

                                                  if (result.token.isNotEmpty) {
                                                    if (!mounted) return;
                                                    Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                Dashboard(
                                                                    token: result
                                                                        .token)));
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
                                        padding:
                                            EdgeInsets.fromLTRB(0, 10, 0, 30),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text("Belum punya akun ? "),
                                              InkWell(
                                                  onTap: () => {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        Register()))
                                                      },
                                                  child: Text(
                                                    "Daftar",
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFF53C737)),
                                                  ))
                                            ]),
                                      )
                                    ],
                                  )
                                ],
                              ),
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
            }),
          ],
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
              key: Key(label),
              controller: (label == 'Username')
                  ? _usernameController
                  : _passwordController,
              cursorColor: Color(0xFF53C737),
              obscureText: (label == "Username") ? false : _obscureText,
              decoration: InputDecoration(
                  suffixIcon: (label == 'Username')
                      ? Icon(Icons.person)
                      : (!_obscureText)
                          ? IconButton(
                              onPressed: () => setState(() {
                                    print(_obscureText);
                                    _obscureText = true;
                                  }),
                              icon: Icon(Icons.visibility_off))
                          : IconButton(
                              onPressed: () => setState(() {
                                    print(_obscureText);
                                    _obscureText = false;
                                  }),
                              icon: Icon(Icons.visibility)),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF53C737), width: 2.0),
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
