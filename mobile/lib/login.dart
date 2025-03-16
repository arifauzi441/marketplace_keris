import 'package:flutter/material.dart';
import 'package:mobile/dashboard.dart';
import 'package:mobile/register.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () => {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Dashboard()))
                  },
              child: Text("Halaman Dashboard")),
          ElevatedButton(
              onPressed: () => {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Register()))
                  },
              child: Text("Halaman Register"))
        ],
      ),
    );
  }
}
