import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app_user/src/page/init_info/init_sex_page.dart';
import 'package:dating_app_user/src/widgets/buttons/main_button.dart';
import 'package:dating_app_user/src/widgets/dialogs/loading_dialog.dart';
import 'package:dating_app_user/src/widgets/dialogs/msg_dilog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class InitBirthdayPage extends StatefulWidget {
  const InitBirthdayPage({Key? key}) : super(key: key);

  @override
  _InitBirthdayPageState createState() => _InitBirthdayPageState();
}

class _InitBirthdayPageState extends State<InitBirthdayPage> {

  TextEditingController _dateController = TextEditingController();

  DateTime selectedDate = DateTime.now();

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
                  "Ngày sinh\ncủa bạn khi nào ? 🎂",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      color: Colors.black
                  ),
                ),
                SizedBox(height: 20,),
                _description("Để giữ được tính chân thật cho cộng đồng iLove, ngày sinh sẽ không thể thay đổi."),
              ],
            ),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: AbsorbPointer(
                child: TextFormField(
                  onSaved: (val) {
                    _dateController.text = val!;
                  },
                  controller: _dateController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      hintText: "Nhập ngày sinh",
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

    String date = _dateController.text.trim();

    if (date == "") {
      MsgDialog.showMsgDialog(context, "Thông báo", "Vui lòng không bỏ trống.");
      return;
    }

    LoadingDialog.showLoadingDialog(context, "Đang lưu...");

    FirebaseFirestore.instance.collection("USER").doc(FirebaseAuth.instance.currentUser!.uid).update({
      "birthday": date,
    }).then((value) => {

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => InitSexPage())),

    });


  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100)
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        var date =
            "${picked.toLocal().day}/${picked.toLocal().month}/${picked.toLocal().year}";
        _dateController.text = date;
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
