import 'package:flutter/material.dart';
import 'package:crop_care_app/services/authentication.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

Authentication authentication = Authentication();

Widget otpScreen(BuildContext context, TextEditingController smsController,
    String verificationId, Function signInWithCredential, String mobileNo) {
  return Container(
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.grey,
          offset: Offset(0.0, 1.0),
          blurRadius: 6.0,
        ),
      ],
    ),
    width: 350,
    child: Center(
      child: Column(
        children: [
          Text("Mobile Verification"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Enter Code"),
              TextButton(
                onPressed: () async {
                  // await authentication
                  //     .sendCodeAgain(
                  //   mobileNo.toString(),
                  //   context,
                  //   smsController,
                  // )
                  //     .then((value) {
                  //   Fluttertoast.showToast(msg: 'New code requested!');
                  //   // ScaffoldMessenger.of(context).showSnackBar(
                  //   //     SnackBar(content: Text("New code requested!")));
                  // });
                },
                child: Text("Resend Code"),
              ),
            ],
          ),
          TextField(
            controller: smsController,
            // decoration: inputDecoration,
          ),
          SizedBox(height: 10),
          Container(
            width: 300,
            child: ElevatedButton(
              child: Text('SUBMIT'),
              onPressed: () async {
                PhoneAuthCredential credential = PhoneAuthProvider.credential(
                  verificationId: verificationId,
                  smsCode: smsController.text.trim(),
                );
                await signInWithCredential(credential);
              },
            ),
          )
        ],
      ),
    ),
  );
}