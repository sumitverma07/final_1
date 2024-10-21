import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'otpScreen.dart';

class Phone extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PhoneState();
  }
}

class PhoneState extends State<Phone> {
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future<String> registerUser(String phoneNumber) async {
      var completer = Completer<String>();
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          // Handle verification failure
        },
        codeSent: (String verificationId, int? resendToken) async {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Otp(verificationId: verificationId)),
          );

          completer.complete(verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
      return await completer.future;
    }

    return Scaffold(
      appBar: AppBar(title: Text("Phone Authetication")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  prefix: Text("+91"),
                  hintText: "Enter the phone number",
                  suffixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  )),
            ),
            SizedBox(
              height: 15,
            ),
            ElevatedButton(
                onPressed: () {
                  //   await FirebaseAuth.instance.verifyPhoneNumber(
                  //       verificationCompleted:
                  //           (PhoneAuthCredential credential) {},
                  //       verificationFailed: (FirebaseAuthException ex) {},
                  //       codeSent: (String verificationid, int? resendtoken) {
                  //         Navigator.push(
                  //             context,
                  //             MaterialPageRoute(
                  //                 builder: (context) =>
                  //                     Otp(verificationid: verificationid)));
                  //       },
                  //       codeAutoRetrievalTimeout: (String verificationid) {},
                  //       phoneNumber: phoneController.text.toString());
                  // ,
                  final verificationId =
                      registerUser("+91" + phoneController.text);
                },
                child: Text("Verify Phone Number"))
          ],
        ),
      ),
    );
  }
}
