import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mobile_admin/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(
        Duration(seconds: 2),
        () => Navigator.pushReplacement(
            context,
            PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    Login(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
                transitionDuration: Duration(milliseconds: 700))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: Column(
            children: [
              AutoSizeText(
                "Selamat Datang di Keris Sumenep",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.075,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E6C25)),
                textAlign: TextAlign.center,
                minFontSize: 20,
                maxFontSize: 40,
              ),
              Container(
                margin: EdgeInsets.only(top: 50),
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.4 +
                    MediaQuery.of(context).size.width * 0.1,
                child: Column(
                  children: [
                    Expanded(
                        flex: 4,
                        child: Container(
                          child:
                              Image(image: AssetImage('assets/images/logo-keris.png')),
                        )),
                    Expanded(
                        flex: 3,
                        child: Text(
                          'Warisan keahlian menempa keris kini hadir di dunia digital. Jika Anda adalah seorang empu dari Desa Aengtongtong, Sumenep, kami mengundang Anda untuk bergabung dan memperkenalkan karya Anda kepada para pecinta keris.',
                          textAlign: TextAlign.center,
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
