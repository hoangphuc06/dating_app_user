import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app_user/src/page/init_info/init_completed_page.dart';
import 'package:dating_app_user/src/widgets/buttons/main_button.dart';
import 'package:dating_app_user/src/widgets/dialogs/loading_dialog.dart';
import 'package:dating_app_user/src/widgets/dialogs/msg_dilog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class InitFilterSexPage extends StatefulWidget {
  const InitFilterSexPage({Key? key}) : super(key: key);

  @override
  _InitFilterSexPageState createState() => _InitFilterSexPageState();
}

class _InitFilterSexPageState extends State<InitFilterSexPage> {
  bool btnMale = false;
  bool btnFeMale = false;
  bool btnOther = false;
  String _myChoice = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50,),
                Text(
                  "Ai là người mà \nbạn cảm thấy thích? 🙄",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      color: Colors.black
                  ),
                ),
                SizedBox(height: 20,),
                _description("Bạn có thể thay đổi thông tin này khi dùng app."),
              ],
            ),
            Column(
              children: [
                _roundedButtonFilter(
                        () {
                      setState(() {
                        btnMale = true;
                        btnFeMale = false;
                        btnOther = false;
                        _myChoice = "Nam";
                      });
                    },
                    btnMale,
                    'Nam '
                ),
                SizedBox(height: 10,),
                _roundedButtonFilter(
                        () {
                      setState(() {
                        btnMale = false;
                        btnFeMale = true;
                        btnOther = false;
                        _myChoice = "Nữ";
                      });
                    },
                    btnFeMale,
                    'Nữ'
                ),
                SizedBox(height: 10,),
                _roundedButtonFilter(
                        () {
                      setState(() {
                        btnMale = false;
                        btnFeMale = false;
                        btnOther = true;
                        _myChoice = "Mọi người";
                      });
                    },
                    btnOther,
                    'Mọi người'
                ),
              ],
            ),
            MainButton(name: "Lưu", onpressed: (){
              onClick();
            })
          ],
        ),
      ),
    );
  }

  void onClick() {

    if (_myChoice == "") {
      MsgDialog.showMsgDialog(context, "Thông báo", "Vui lòng không bỏ trống.");
      return;
    }

    LoadingDialog.showLoadingDialog(context, "Đang lưu...");

    FirebaseFirestore.instance.collection("FILTER").doc(FirebaseAuth.instance.currentUser!.uid).set({
      "uid": FirebaseAuth.instance.currentUser!.uid,
      "sex": _myChoice,
      "age_from": "18",
      "age_to": "30",
      "distance_from": "0",
      "distance_to": "50",
    }).then((value) => {

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => InitCompletedPage())),

    });
  }

  _description(String description) => Text(
    description,
    style: TextStyle(
        color: Colors.black.withOpacity(0.5),
        fontWeight: FontWeight.w400
    ),
    textAlign: TextAlign.justify,
  );
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
