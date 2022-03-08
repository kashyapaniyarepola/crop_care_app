import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:crop_care_app/models/user.dart';

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signIn(
    String phone,
    BuildContext context,
    TextEditingController smsController,
    Function changeState,
    Function changeShowLoading,
  ) async {
    try {
      changeShowLoading(true);
      await _auth.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (PhoneAuthCredential credential) async {
          changeShowLoading(false);
        },
        verificationFailed: (FirebaseAuthException exception) {
          changeShowLoading(false);
          final snackBar = SnackBar(
            duration: Duration(seconds: 10),
            content: Text(exception.message.toString()),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          print("There is an error ${exception.message}");
        },
        codeSent: (String verificationId, int? forceResendingToken) {
          changeState(verificationId);
        },
        codeAutoRetrievalTimeout: (value) {},
      );
    } catch (e) {
      Text("THIS IS THE ERROR $e");
    }
  }

  Future<void> signUp(UserData user) async {
    String userId = _auth.currentUser!.uid;

    user.uid = userId;

    Map<String, dynamic> form = {
      "userData": user.toMap(),
    };

    try {
      final userField =
          FirebaseFirestore.instance.collection("users").doc(userId);

      await userField.set(form);
    } catch (e) {
      Text("THIS IS THE ERROR $e");
    }
  }
  
}
