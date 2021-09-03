import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task1chatapp/helper/authenticat.dart';
import 'package:task1chatapp/pages/chatroom.dart';
import 'package:task1chatapp/services/auth.dart';
import 'package:task1chatapp/widgets/widgets.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> with WidgetsBindingObserver {

  Map<String, dynamic>? userMap;
  bool isLoading = false;
  final TextEditingController _search = TextEditingController();
  final AuthMethods authMethods = new AuthMethods();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  @override
  void initState() {
    super.initState();
     WidgetsBinding.instance!.addObserver(this);
    setStatus("Online");
  }

  void setStatus(String status) async {
    await _firestore.collection('users').doc(_auth.currentUser!.uid).update({
      "status": status,
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // online
      setStatus("Online");
    } else {
      // offline
      setStatus("Offline");
    }
  }

  String chatRoomId(String user1, String user2) {
    if (user1[0].toLowerCase().codeUnits[0] >
        user2.toLowerCase().codeUnits[0]) {
      return "$user1$user2";
    } else {
      return "$user2$user1";
    }
  }

  void onSearch() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;

    setState(() {
      isLoading = true;
    });
    await _firestore
        .collection('users')
        .where("uname", isEqualTo: _search.text)
        .get()
        .then((value) {
      setState(() {
        userMap = value.docs[0].data();
        isLoading = false;
      });
      print(userMap);
    });
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Search Screen"),
        actions: [
          GestureDetector(
            onTap: () {
              authMethods.signOut();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Authenticate()));
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Icon(Icons.exit_to_app),
            ),
          )
        ],
      ),
      body: isLoading
          ? Center(
              child: Container(
                height: size.height / 20,
                width: size.width / 20,
                child: CircularProgressIndicator(),
              ),
            )
          : Column(
              children: [
                SizedBox(height: size.height / 20),
                Container(
                    alignment: Alignment.center,
                    height: size.height / 14,
                    width: size.width,
                    child: Container(
                      height: size.height / 14,
                      width: size.width / 1.15,
                      decoration: BoxDecoration(),
                      child:  Container(
                        decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.white12,
                                  blurRadius: 9.0,
                                  spreadRadius: 4.0
                              ),
                              BoxShadow(
                                  color: Colors.white12,
                                  blurRadius: 9.0,
                                  spreadRadius: 4.0
                              )
                            ]
                        ),
                        child: TextField(
                          controller: _search,
                          decoration: InputDecoration(

                              hintText: "Username",
                              border: OutlineInputBorder(
                                   borderSide: new BorderSide(color: Colors.teal),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                          ),
                        ),
                      ),

                    //   TextField(
                    //     controller: _search,
                    //     decoration: InputDecoration(
                    //       hintText: "Username",
                    //       hintStyle: TextStyle(
                    //         color: Colors.white24,
                    //       ),
                    //       border: OutlineInputBorder(
                    //         borderSide: new BorderSide(color: Colors.teal),
                    //         borderRadius: BorderRadius.circular(10),
                    //       ),
                    //     ),
                    //   ),
                    // )
                ),),
                SizedBox(
                  height: size.height / 30,
                ),
                ElevatedButton(
                    onPressed: onSearch,
                    child: Text("Search")),
                SizedBox(
                  height: size.height / 20,
                ),
                userMap != null
                  ? ListTile(
                  onTap: () {
                    String roomId = chatRoomId(
                        _auth.currentUser!.displayName!,
                        userMap!['uname']);

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ChatRoom(
                          chatRoomId: roomId,
                          userMap: userMap!,
                        ),
                      ),
                    );
                  },
                        leading: Icon(
                          Icons.account_box,
                          color: Colors.white,
                        ),
                        title: Text(
                          userMap!['uname'],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(
                          userMap!['email'],
                          style: textStyle(),
                        ),
                        trailing: Icon(
                          Icons.chat,
                          color: Colors.white,
                        ),
                      ) : Container(),
              ],
            ),
    );
  }
}



