import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:task1chatapp/helper/authenticat.dart';
import 'package:task1chatapp/helper/helperfunction.dart';
import 'package:task1chatapp/pages/chatScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
late bool userIsLoggedIn;
  @override
  void initState() {
    getLoggedInState();
    super.initState();
  }
  
  getLoggedInState() async {
    await HelperFunctions.getLoggedIn().then((value) {
      setState(() {
        userIsLoggedIn = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'task1 ChatApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black87,
        primarySwatch: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: userIsLoggedIn != null
          ? userIsLoggedIn
              ? ChatScreen()
              : Authenticate()
          : Container(
              child: Center(
                child: Authenticate(),
              ),
            ),
    );
  }
}



