import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:task1chatapp/helper/helperfunction.dart';
import 'package:task1chatapp/services/auth.dart';
import 'package:task1chatapp/services/database.dart';
import 'package:task1chatapp/widgets/widgets.dart';

import 'chatScreen.dart';

class SignIn extends StatefulWidget {
  final Function toggle;
  SignIn(this.toggle);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final formKey = GlobalKey<FormState>();
  AuthMethods authMethods = new AuthMethods();
  DataBaseMethods dataBaseMethods = new DataBaseMethods();
  TextEditingController emailTextController = new TextEditingController();
  TextEditingController passController = new TextEditingController();
  bool isLoading =false;
  late QuerySnapshot snapshot;

  late Map<String, dynamic> userMap;

  signIn() async {
    if (formKey.currentState!.validate()) {
      HelperFunctions.savedUserEmail(emailTextController.text);
      setState(() {
        isLoading = true;
      });
     await dataBaseMethods.getUserByUserEmail(emailTextController.text)
          .then((val){
            setState(() {
              snapshot = val;
              userMap = val.docs[0].data();
              isLoading = false;
            });
            print(userMap);
      });
       authMethods
          .signInWithEmailAndPassword(emailTextController.text, passController.text)
           .then((val) {
        print(val);

  if(val != null) {

    HelperFunctions.savedUserLoggedIn(true);
    Navigator.pushReplacement(

        context, MaterialPageRoute(builder: (context) => ChatScreen()));
  }
           });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SignIn Screen"),

      ),
      body: Container(
        child: Container(
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  child: Center(
                    child: Text(
                      "W E L C O M E ",
                      style: TextStyle(
                        color: Colors.amber,
                        fontSize: 25.0,

                        // fontFamily: 'assets/fonts/m2.otf',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Form(
                  key:formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (val) {
                          return RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(val!)
                              ? null
                              : "please enter a valid email";
                        },
                        controller: emailTextController,
                        style: textStyle(),
                        decoration: textFeildDecoration("email"),
                      ),
                      TextFormField(
                        obscureText: true,
                        validator: (val) {
                          return val!.length > 6
                              ? null
                              : "please enter password 6 digit";
                        },
                        controller:  passController,
                        style: textStyle(),
                        decoration: textFeildDecoration("Password"),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    child: Text(
                      "Forgot Password?",
                      style: textStyle(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    signIn();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 14),
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  child: Text(
                    "Sign In with google",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have account? ",
                      style: textStyle(),
                    ),
                    GestureDetector(
                      onTap: () {
                        widget.toggle();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          "Register here",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
