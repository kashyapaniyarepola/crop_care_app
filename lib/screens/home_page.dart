import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const routName = '/home';
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

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
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  
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
                  height: 40,
                  width: 200,
                  child: ElevatedButton(
                      style: ButtonStyle(),
                      onPressed: () {
                       Navigator.pop(context);
                      },
                      child: Text("Submit New Claim")),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 40,
                  width: 200,
                  child: ElevatedButton(
                      onPressed: () {
                        
                      },
                      child: const Text("View My Claims")),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 40,
                  width: 200,
                  child: ElevatedButton(
                      onPressed: () {
                        
                      },
                      child: const Text("Government Messages")),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
