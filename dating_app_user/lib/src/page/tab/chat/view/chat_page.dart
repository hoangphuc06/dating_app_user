import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app_user/src/page/chat_room/chat_room_page.dart';
import 'package:dating_app_user/src/widgets/buttons/main_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

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

  // Widget getBody() {
  //   var size = MediaQuery.of(context).size;
  //   return ListView(
  //     children: [
  //       Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Padding(
  //             padding: const EdgeInsets.only(left: 16),
  //             child: Text(
  //               "Story",
  //               style: TextStyle(
  //                   fontSize: 15, fontWeight: FontWeight.w500, color: Colors.pink),
  //             ),
  //           ),
  //           SizedBox(height: 20,),
  //           SingleChildScrollView(
  //             scrollDirection: Axis.horizontal,
  //             child: Padding(
  //               padding: const EdgeInsets.only(left: 16),
  //               child: Row(
  //                 children: List.generate(chats_json.length, (index) {
  //                   return Padding(
  //                     padding: const EdgeInsets.only(right: 20),
  //                     child: Column(
  //                       children: <Widget>[
  //                         Container(
  //                           width: 70,
  //                           height: 70,
  //                           child: Stack(
  //                             children: <Widget>[
  //                               chats_json[index]['story'] ?
  //                               Container(
  //                                 decoration: BoxDecoration(
  //                                     shape: BoxShape.circle,
  //                                     border: Border.all(
  //                                         color: Colors.pink, width: 3)
  //                                 ),
  //                                 child: Padding(
  //                                   padding: const EdgeInsets.all(3.0),
  //                                   child: Container(
  //                                     width: 70,
  //                                     height: 70,
  //                                     decoration: BoxDecoration(
  //                                         shape: BoxShape.circle,
  //                                         image: DecorationImage(
  //                                             image: NetworkImage(
  //                                                 chats_json[index]['img']),
  //                                             fit: BoxFit.cover)),
  //                                   ),
  //                                 ),
  //                               )
  //                               : Container(
  //                                 width: 65,
  //                                 height: 65,
  //                                 decoration: BoxDecoration(
  //                                     shape: BoxShape.circle,
  //                                     image: DecorationImage(
  //                                         image: NetworkImage(
  //                                             chats_json[index]['img']),
  //                                         fit: BoxFit.cover)),
  //                               ),
  //                               chats_json[index]['online'] ?
  //                               Positioned(
  //                                 top: 48,
  //                                 left: 52,
  //                                 child: Container(
  //                                   width: 20,
  //                                   height: 20,
  //                                   decoration: BoxDecoration(
  //                                       color: Colors.green,
  //                                       shape: BoxShape.circle,
  //                                       border: Border.all(
  //                                           color: Colors.white, width: 3)),
  //                                 ),
  //                               )
  //                               : Container()
  //                             ],
  //                           ),
  //                         ),
  //                         SizedBox(height: 10,),
  //                         SizedBox(
  //                           width: 70,
  //                           child: Align(
  //                             child: Text(
  //                               chats_json[index]['name'],
  //                               overflow: TextOverflow.ellipsis,
  //                             )
  //                           ),
  //                         )
  //                       ],
  //                     ),
  //                   );
  //                 })
  //               ),
  //             ),
  //           ),
  //           SizedBox(height: 30,),
  //           Padding(
  //             padding: const EdgeInsets.only(left: 16),
  //             child: Text(
  //               "Tin nhắn",
  //               style: TextStyle(
  //                   fontSize: 15, fontWeight: FontWeight.w500, color: Colors.pink),
  //             ),
  //           ),
  //           SizedBox(height: 20,),
  //           Padding(
  //             padding: const EdgeInsets.only(left: 16),
  //             child: Column(
  //               children: List.generate(userMessages.length, (index) {
  //                 return Padding(
  //                   padding: const EdgeInsets.only(bottom: 20),
  //                   child: Row(
  //                     children: <Widget>[
  //                       Container(
  //                         width: 70,
  //                         height: 70,
  //                         child: Stack(
  //                           children: <Widget>[
  //                             userMessages[index]['story']
  //                                 ? Container(
  //                               decoration: BoxDecoration(
  //                                   shape: BoxShape.circle,
  //                                   border: Border.all(
  //                                       color: Colors.pink, width: 3)),
  //                               child: Padding(
  //                                 padding: const EdgeInsets.all(3.0),
  //                                 child: Container(
  //                                   width: 70,
  //                                   height: 70,
  //                                   decoration: BoxDecoration(
  //                                       shape: BoxShape.circle,
  //                                       image: DecorationImage(
  //                                           image: NetworkImage(
  //                                               userMessages[index]
  //                                               ['img']),
  //                                           fit: BoxFit.cover)),
  //                                 ),
  //                               ),
  //                             )
  //                                 : Container(
  //                               width: 65,
  //                               height: 65,
  //                               decoration: BoxDecoration(
  //                                   shape: BoxShape.circle,
  //                                   image: DecorationImage(
  //                                       image: NetworkImage(
  //                                           userMessages[index]['img']),
  //                                       fit: BoxFit.cover)),
  //                             ),
  //                             userMessages[index]['online']
  //                                 ? Positioned(
  //                               top: 48,
  //                               left: 52,
  //                               child: Container(
  //                                 width: 20,
  //                                 height: 20,
  //                                 decoration: BoxDecoration(
  //                                     color: Colors.green,
  //                                     shape: BoxShape.circle,
  //                                     border: Border.all(
  //                                         color: Colors.white, width: 3)),
  //                               ),
  //                             )
  //                                 : Container()
  //                           ],
  //                         ),
  //                       ),
  //                       SizedBox(
  //                         width: 20,
  //                       ),
  //                       Column(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: <Widget>[
  //                           Text(
  //                             userMessages[index]['name'],
  //                             style: TextStyle(
  //                                 fontSize: 17, fontWeight: FontWeight.w500),
  //                           ),
  //                           SizedBox(
  //                             height: 5,
  //                           ),
  //                           SizedBox(
  //                             width: MediaQuery.of(context).size.width - 135,
  //                             child: Text(
  //                               userMessages[index]['message'] +
  //                                   " - " +
  //                                   userMessages[index]['created_at'],
  //                               style: TextStyle(
  //                                   fontSize: 15,
  //                                   color: Colors.grey),
  //                               overflow: TextOverflow.ellipsis,
  //                             ),
  //                           )
  //                         ],
  //                       )
  //                     ],
  //                   ),
  //                 );
  //               }),
  //             ),
  //           ),
  //           SizedBox(height: 50,),
  //         ],
  //       )
  //     ],
  //   );
  // }

}


