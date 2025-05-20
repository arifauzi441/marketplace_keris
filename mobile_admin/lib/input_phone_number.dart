import 'package:flutter/material.dart';
import 'package:mobile_admin/model/user_api.dart';
import 'package:mobile_admin/verification_code.dart';

class InputPhoneNumber extends StatefulWidget {
  const InputPhoneNumber({super.key});

  @override
  State<InputPhoneNumber> createState() => _InputPhoneNumberState();
}

class _InputPhoneNumberState extends State<InputPhoneNumber> {
  String errorMsg = '';
  bool _checkAgreement = false;
  final TextEditingController _phoneController =
      TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.38 +
                    MediaQuery.of(context).size.width * 0.15,
                width: MediaQuery.of(context).size.width * 0.80,
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
                          Text("No. Handphone"),
                          SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 0.5 * 0.10,
                            child: TextField(
                              controller: _phoneController,
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
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: 70,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                    "dengan melakukan ceklist anda menyetujui pihak kami untuk mengirimkan sms",
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ),
                                Checkbox(
                                    value: _checkAgreement,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _checkAgreement = value ?? false;
                                      });
                                    })
                              ],
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
                              color: (_checkAgreement)
                                  ? Colors.green
                                  : const Color.fromARGB(255, 132, 184, 134),
                              child: InkWell(
                                onTap: (_checkAgreement)
                                    ? () async {
                                        try {
                                          var result =
                                              await UserApi.forgotPassword(
                                                  _phoneController.text);
                                          if (!mounted) return;

                                          if (result['status'] == 200) {
                                            if (!mounted) return;
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        VerificationCode(
                                                          phone_admin:
                                                              _phoneController
                                                                  .text,
                                                        )));
                                          } else {
                                            setState(() {
                                              errorMsg = result["msg"];
                                            });
                                          }
                                        } catch (e) {
                                          print(e);
                                        }
                                      }
                                    : null,
                                child: Center(
                                  child: Text(
                                    "Kirim",
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
                        Container(
                          margin: EdgeInsets.all(10),
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
