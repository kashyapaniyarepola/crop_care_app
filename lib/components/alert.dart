import 'package:flutter/material.dart';
import 'package:crop_care_app/services/authentication.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:crop_care_app/constant/constant.dart';

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
                  await authentication
                      .sendCodeAgain(
                    mobileNo.toString(),
                    context,
                    smsController,
                  )
                      .then((value) {
                    Fluttertoast.showToast(msg: 'New code requested!');
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //     SnackBar(content: Text("New code requested!")));
                  });
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
              style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.green)
                     ),
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

displayDialog(BuildContext context, String message) async {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Container(
            height: 240,
            width: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('WARNING',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Icon(Icons.warning_amber_rounded,
                    color: Colors.orange, size: 60),
                SizedBox(height: 10),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 17,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: 200,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.green)
                    ),
                    child: Text('CLOSE'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                )
              ],
            ),
          ),
        );
      });
}