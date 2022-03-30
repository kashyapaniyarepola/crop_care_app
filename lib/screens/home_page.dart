import 'package:crop_care_app/screens/signin.dart';
import 'package:crop_care_app/screens/form_handler.dart';
import 'package:crop_care_app/screens/claim_status.dart';
import 'package:crop_care_app/screens/messages/govt_messages.dart';
import 'package:flutter/material.dart';

import 'package:crop_care_app/services/notification.dart';
import 'package:crop_care_app/services/authentication.dart';
import 'package:crop_care_app/services/form_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  static const routName = '/home';
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _auth = FirebaseAuth.instance;
  FormService formService = FormService();
  final FirebaseMessaging fcm = FirebaseMessaging.instance;
  final Authentication authentication = Authentication();

  @override
  void initState() {
    super.initState();
    formService.newFetchForm();
    authentication.updateToken();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification notification = message.notification!;
      // AndroidNotification android = message.notification!.android!;

      await _showNotification(notification);
    });
  }

  Future<void> _showNotification(RemoteNotification notification) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
            'high_importance_channel', 'High Importance Notifications',
            channelDescription:
                'This channel is used for important notifications.',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, notification.title, notification.body, platformChannelSpecifics,
        payload: 'item x');
  }

  Future<void> signOut() async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("  Do you want to Logout?"),
        content: Container(
          height: 70,
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 245, 120, 62))),
                    onPressed: () async {
                      await _auth.signOut();
                      Navigator.of(context).pop();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignIn(),
                        ),
                      );
                    },
                    child: Text("Yes")),
              ),
              Expanded(flex: 1, child: Container()),
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.green)
                      ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("No")),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  Future<bool> _exitApp() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("  Do you want to exit?"),
            content: Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red)),
                        onPressed: () {
                          // SystemNavigator.pop();
                        },
                        child: Text("Yes")),
                  ),
                  Expanded(flex: 1, child: Container()),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.green)
                      ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("No")),
                  ),
                ],
              ),
            ),
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _exitApp(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 80, 141, 82),
          centerTitle: true,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  signOut();
                },
                icon: Icon(Icons.logout)),
          
          ],
          title: Text("CropCare"),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 50,
                  width: 200,
                  child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                      ),
                      onPressed: () {
                       Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FormHandler()));
                      },
                      child: Text("Submit New Claim")),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 50,
                  width: 200,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ClaimStatus()));
                        
                      },
                      child: const Text("View My Claims")),
                ),
                const SizedBox(height: 20),
                // Container(
                //   height: 40,
                //   width: 200,
                //   child: ElevatedButton(
                //       onPressed: () {
                //         Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //                 builder: (context) => Messages()
                //                 ));
                        
                //       },
                //       child: const Text("Government Messages")),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
