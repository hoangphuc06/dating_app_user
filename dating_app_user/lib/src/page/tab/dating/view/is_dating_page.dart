import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app_user/src/page/chat_room/chat_room_page.dart';
import 'package:dating_app_user/src/widgets/buttons/main_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class IsDatingPage extends StatefulWidget {
  const IsDatingPage({Key? key}) : super(key: key);

  @override
  _IsDatingPageState createState() => _IsDatingPageState();
}

class _IsDatingPageState extends State<IsDatingPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Map<String, dynamic>? userMap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("Chat", style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MainButton(name: "Go to chat", onpressed: () async {
              await _firestore.collection('USER').where("email", isEqualTo: "hung@gmail.com").get().then((value) {
                setState(() {
                  userMap = value.docs[0].data();
                });
                print(userMap);
              });
              String roomId = chatRoomId(_auth.currentUser!.uid, userMap!['uid']);
              print(roomId);
              Navigator.push(context, MaterialPageRoute(builder: (context) => ChatRoomPage(
                  chatRoomId: roomId,
                  userMap: userMap!
              )));
            }),
          ],
        ),
      ),
    );
  }

  String chatRoomId(String user1, String user2) {
    if (user1[0].toLowerCase().codeUnits[0] >
        user2.toLowerCase().codeUnits[0]) {
      return "$user1$user2";
    } else {
      return "$user2$user1";
    }
  }
}
