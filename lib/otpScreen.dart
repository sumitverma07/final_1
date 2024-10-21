import 'dart:developer';

import 'package:final1/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Otp extends StatefulWidget {
  String verificationId;
  Otp({super.key, required this.verificationId});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return OtpState();
  }
}

class OtpState extends State<Otp> {
  TextEditingController otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("OTP Screen"),
      ),
      body: Column(
        children: [
          TextField(
            controller: otpController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                hintText: "Enter OTP",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                )),
          ),
          SizedBox(
            height: 15,
          ),
          ElevatedButton(
              onPressed: () async {
                try {
                  PhoneAuthCredential credential =
                      await PhoneAuthProvider.credential(
                          verificationId: widget.verificationId,
                          smsCode: otpController.text.toString());
                  FirebaseAuth.instance
                      .signInWithCredential(credential)
                      .then((value) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                MyHomePage(title: ("MyHomePage"))));
                  });
                } catch (ex) {
                  log(ex.toString());
                }
              },
              child: Text("Submit"))
        ],
      ),
    );
  }
}
