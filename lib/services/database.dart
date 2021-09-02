import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseMethods {
  getUserByUsername(String username) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("uname", isEqualTo: username)
        .get();
  }

  getUserByUserEmail(String userEmail) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: userEmail)
        .get();
  }

  uploadUsers(usersMap) {
    FirebaseFirestore.instance
        .collection("users")
        .add(usersMap)
        .catchError((e) {
      print(e.toString());
    });
  }

   creatChatRoom(String chatRoomId, chatRoomMap) {
    FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatRoomId)
        .set(chatRoomMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  searchByName(String searchField) {
    return FirebaseFirestore.instance
        .collection("users")
        .where('userName', isEqualTo: searchField)
        .get();
  }
}

// void creatChatRoom(chatRoomId, chatRoomMap) {
 
// }


