import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app_user/src/page/init_info/init_avatar_page.dart';
import 'package:dating_app_user/src/widgets/buttons/main_button.dart';
import 'package:dating_app_user/src/widgets/dialogs/loading_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class InitSexPage extends StatefulWidget {
  const InitSexPage({Key? key}) : super(key: key);

  @override
  _InitSexPageState createState() => _InitSexPageState();
}

class _InitSexPageState extends State<InitSexPage> {

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
                  "Giới tính\ncủa bạn là gì? 🧐",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      color: Colors.black
                  ),
                ),
                SizedBox(height: 20,),
                _description("Để giữ được tính chân thật cho cộng đồng iLove, giới tính sẽ không thể thay đổi."),
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
                        _myChoice = "Khác";
                      });
                    },
                    btnOther,
                    'Khác'
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

    LoadingDialog.showLoadingDialog(context, "Đang lưu...");

    FirebaseFirestore.instance.collection("USER").doc(FirebaseAuth.instance.currentUser!.uid).update({
      "sex": _myChoice,
    }).then((value) => {

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => InitAvatarPage())),

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
