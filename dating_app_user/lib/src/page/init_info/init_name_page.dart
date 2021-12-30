import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app_user/src/page/init_info/init_birthday_page.dart';
import 'package:dating_app_user/src/widgets/buttons/main_button.dart';
import 'package:dating_app_user/src/widgets/dialogs/loading_dialog.dart';
import 'package:dating_app_user/src/widgets/dialogs/msg_dilog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class InitNamePage extends StatefulWidget {
  const InitNamePage({Key? key}) : super(key: key);

  @override
  _InitNamePageState createState() => _InitNamePageState();
}

class _InitNamePageState extends State<InitNamePage> {

  TextEditingController _nameController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50,),
                Text(
                  "Họ và tên\ncủa bạn là gì ? 😄",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      color: Colors.black
                  ),
                ),
                SizedBox(height: 20,),
                _description("Để giữ được tính chân thật cho cộng đồng iLove, họ và tên sẽ không thể thay đổi."),
              ],
            ),
            TextFormField(
              controller: _nameController,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: "Nhập họ và tên",
                hintStyle: TextStyle(
                    color: Colors.grey.withOpacity(0.5),
                    fontWeight: FontWeight.w500,
                    fontSize: 20
                ),
                border: InputBorder.none
              ),
              style: TextStyle(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.w500,
                  fontSize: 20
              ),
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

    String name = _nameController.text.trim();

    if (name == "") {
      MsgDialog.showMsgDialog(context, "Thông báo", "Vui lòng không bỏ trống.");
      return;
    }

    LoadingDialog.showLoadingDialog(context, "Đang lưu...");

    FirebaseFirestore.instance.collection("USER").doc(FirebaseAuth.instance.currentUser!.uid).update({
      "name": name,
    }).then((value) => {

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => InitBirthdayPage())),

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
