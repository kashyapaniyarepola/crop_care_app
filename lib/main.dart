import 'package:flutter/material.dart';

// screens
import 'package:crop_care_app/screens/home_page.dart';
import 'package:crop_care_app/screens/signup.dart';
import 'package:crop_care_app/screens/signin.dart';

// firebase
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
  
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Email And Password Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: Initializer.routeName,
      routes: {
        Initializer.routeName: (context) => Initializer(),
        SignIn.routeName: (context) => SignIn(),
        HomePage.routName: (context) => HomePage(),
      },
    );
  }
}

class Initializer extends StatefulWidget {
  static const routeName = '/initializer';
  const Initializer({Key? key}) : super(key: key);

  @override
  _InitializerState createState() => _InitializerState();
}

class _InitializerState extends State<Initializer> {
  late FirebaseAuth _auth;
  late User? _user;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    _user = _auth.currentUser;
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : _user == null
            ? SignIn()
            : HomePage();
  }
}