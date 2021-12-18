import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app_user/src/page/chat_room/chat_room_page.dart';
import 'package:dating_app_user/src/widgets/buttons/main_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IsDatingPage extends StatefulWidget {
  const IsDatingPage({Key? key}) : super(key: key);

  @override
  _IsDatingPageState createState() => _IsDatingPageState();
}

class _IsDatingPageState extends State<IsDatingPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Map<String, dynamic>? userMap;
  String herid = "";
  bool isLoad = true;

  void setWhoDating() async {
    await _firestore.collection('DATING').where("uid", isEqualTo: _auth.currentUser!.uid).get().then((value) {
      setState(() {
        herid = value.docs[0].data()["herid"];
      });
    });
    await _firestore.collection('USER').where("uid", isEqualTo: herid).get().then((value) {
      setState(() {
        userMap = value.docs[0].data();
        isLoad = false;
      });
      print(userMap);
    });
  }

  @override
  void initState() {
    setWhoDating();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoad == false? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // MainButton(name: "Go to chat", onpressed: () async {
            //   String roomId = chatRoomId(_auth.currentUser!.uid, userMap!['uid']);
            //   print(roomId);
            //   Navigator.push(context, MaterialPageRoute(builder: (context) => ChatRoomPage(
            //       chatRoomId: roomId,
            //       userMap: userMap!
            //   )));
            // }),
          ],
        ),
      ) : Center(child: Container(
          height: size.height / 20,
          width: size.height / 20,
          child: CircularProgressIndicator(),
        )),
      floatingActionButton: isLoad == false ? FloatingActionButton(
        onPressed: (){
          String roomId = chatRoomId(_auth.currentUser!.uid, userMap!['uid']);
          print(roomId);
          Navigator.push(context, MaterialPageRoute(builder: (context) => ChatRoomPage(
              chatRoomId: roomId,
              userMap: userMap!
          )));
        },
        child: FaIcon(FontAwesomeIcons.facebookMessenger),
      ) : null,
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
