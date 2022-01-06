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
  Map<String, dynamic>? myMap;
  Map<String, dynamic>? datingMap;
  Map<String, dynamic>? herDatingMap;
  String herid = "";
  bool isLoad = true;

  bool lydo1 = true;
  bool lydo2 = false;
  bool lydo3 = false;
  bool lydo4 = false;
  bool lydo5 = false;

  void setWhoDating() async {
    await _firestore.collection('DATING').where("uid", isEqualTo: _auth.currentUser!.uid).where("status", isEqualTo: "dating").get().then((value) {
      setState(() {
        herid = value.docs[0].data()["herid"];
        datingMap = value.docs[0].data();
        print(datingMap!["id"]);
      });
    });
    await _firestore.collection('DATING').where("uid", isEqualTo: herid).where("status", isEqualTo: "dating").get().then((value) {
      setState(() {
        herDatingMap = value.docs[0].data();
        print(herDatingMap!["id"]);
      });
    });
    await _firestore.collection('USER').where("uid", isEqualTo: _auth.currentUser!.uid).get().then((value) {
      setState(() {
        myMap = value.docs[0].data();
      });
      print(myMap);
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
            Container(
              width: double.infinity,
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: size.width * 0.13),
                    width: double.infinity,
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: size.width * 0.4,
                      height: size.width * 0.4,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(myMap!["images"][0]),
                          fit: BoxFit.cover
                        ),
                        border: Border.all(color: Colors.deepPurple, width: 3)
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: size.width * 0.13),
                    width: double.infinity,
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: size.width * 0.4,
                      height: size.width * 0.4,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(userMap!["images"][0]),
                              fit: BoxFit.cover
                          ),
                          border: Border.all(color: Colors.deepPurple, width: 3)
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),
            Text(
              myMap!["name"] + ", " + (DateTime.now().year - int.parse(myMap!["birthday"].toString().substring(myMap!["birthday"].toString().length - 4))).toString() +
                  " - " +
                  userMap!["name"]+ ", " + (DateTime.now().year - int.parse(userMap!["birthday"].toString().substring(userMap!["birthday"].toString().length - 4))).toString(),
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: Colors.deepPurple
              ),
            ),
            SizedBox(height: 20,),
            Text(
              datingMap!["time_start"],
              style: TextStyle(
                fontSize: 17,
                color: Colors.black
              ),
            ),
            SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.only(left: 32.0, right: 32.0),
              child: MainButton(name: "Trò chuyện", onpressed: () async {
                String roomId = chatRoomId(_auth.currentUser!.uid, userMap!['uid']);
                print(roomId);
                Navigator.push(context, MaterialPageRoute(builder: (context) => ChatRoomPage(
                    chatRoomId: roomId,
                    userMap: userMap!
                )));
              }),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left: 32.0, right: 32),
              child: MainButton(name: "Xem thông tin", onpressed: () async {

              }),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left: 32.0, right: 32),
              child: MainButton(name: "Hủy hẹn hò", onpressed: () async {
                _showMyDialog();
              }),
            ),
          ],
        ),
      ) : Center(child: Container(
          height: size.height / 20,
          width: size.height / 20,
          child: CircularProgressIndicator(),
        )),
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


  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Hủy hẹn hò'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SingleChildScrollView(
                child: ListBody(
                  children: [
                    Text(
                        "Thật tiếc nhưng chúc bạn tìm được người phù hợp với mình."
                    ),
                    SizedBox(height: 10,),
                    Text(
                        "Trước khi kết thúc, bạn có thể cho chúng tôi biết lý do được không ?"
                    ),
                    SizedBox(height: 20,),
                    _roundedButtonFilter((){
                      setState(() {
                        lydo1 = true;
                        lydo2 = false;
                        lydo3 = false;
                        lydo4 = false;
                        lydo5 = false;
                      });
                    }, lydo1, "Không phù hợp"),
                    SizedBox(height: 10,),
                    _roundedButtonFilter((){
                      setState(() {
                        lydo1 = false;
                        lydo2 = true;
                        lydo3 = false;
                        lydo4 = false;
                        lydo5 = false;
                      });
                    }, lydo2, "Đối phương có vấn đề"),
                    SizedBox(height: 10,),
                    _roundedButtonFilter((){
                      setState(() {
                        lydo1 = false;
                        lydo2 = false;
                        lydo3 = true;
                        lydo4 = false;
                        lydo5 = false;
                      });
                    }, lydo3, "Lừa đảo"),
                    SizedBox(height: 10,),
                    _roundedButtonFilter((){
                      setState(() {
                        lydo1 = false;
                        lydo2 = false;
                        lydo3 = false;
                        lydo4 = true;
                        lydo5 = false;
                      });
                    }, lydo4, "Không tiện nói"),
                  ],
                ),
              );
            }
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Xác nhận'),
              onPressed: () {
                _breakUpFunc();
              },
            ),
          ],
        );
      },
    );
  }

  void _breakUpFunc() async {
    String lydo = "";
    if (lydo1 == true) lydo = "Không phù hợp";
    else if (lydo2 == true)  lydo = "Đối phương có vấn đề";
    else if (lydo3 == true) lydo = "Lừa đảo";
    else if (lydo4 == true) lydo == "Không tiện nói";

    await _firestore.collection("USER").doc(myMap!["uid"]).update({
      "dating" : "false",
    });
    await _firestore.collection("USER").doc(userMap!["uid"]).update({
      "dating" : "false",
    });
    await _firestore.collection("DATING").doc(datingMap!["id"]).update({
      "status" : "break up",
      "time_end": new DateTime.now().day.toString() + "/" + new DateTime.now().month.toString() + "/" + new DateTime.now().year.toString(),
      "who_end": myMap!["uid"],
      "why_end": lydo,
    });
    await _firestore.collection("DATING").doc(herDatingMap!["id"]).update({
      "status" : "break up",
      "time_end": new DateTime.now().day.toString() + "/" + new DateTime.now().month.toString() + "/" + new DateTime.now().year.toString(),
      "who_end": myMap!["uid"],
      "why_end": lydo,
    });
    String roomId = chatRoomId(_auth.currentUser!.uid, userMap!['uid']);
    await _firestore.collection("CHAT").doc(roomId).delete().then((value) => {
      print("OK"),
    });

    lydo1 = true;
    lydo2 = false;
    lydo3 = false;
    lydo4 = false;

    Navigator.pop(context);
  }
}


Widget _roundedButtonFilter(func, bool isActive, String labelText) {
  return ButtonTheme(
    minWidth: 200,
    height: 50,
    child: RaisedButton(
      onPressed: func,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: isActive ? Colors.deepPurple : Color(0xFFF2F2F2),
      elevation: 0,
      child: Text(
        labelText,
        style: TextStyle(
          color: isActive ? Colors.white : Colors.black,
        ),
      ),
    ),
  );
}
