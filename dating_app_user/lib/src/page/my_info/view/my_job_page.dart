import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app_user/src/widgets/buttons/main_button.dart';
import 'package:dating_app_user/src/widgets/dialogs/loading_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyJobPage extends StatefulWidget {
  final String job;
  const MyJobPage({Key? key, required this.job}) : super(key: key);

  @override
  _MyJobPageState createState() => _MyJobPageState();
}

class _MyJobPageState extends State<MyJobPage> {

  TextEditingController _jobController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _jobController.text = widget.job;
  }

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
                  "Nghề nghiệp\ncủa bạn là gì ? 👨‍🔧",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      color: Colors.black
                  ),
                ),
                SizedBox(height: 20,),
                _description("Nhập đúng nghề nghiệp của bạn vào để mọi người có thể biết thêm về bạn."),
              ],
            ),
            TextFormField(
              controller: _jobController,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                  hintText: "Nhập nghề nghiệp",
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

    String job = _jobController.text.trim();

    LoadingDialog.showLoadingDialog(context, "Đang lưu...");

    FirebaseFirestore.instance.collection("USER").doc(FirebaseAuth.instance.currentUser!.uid).update({
      "job": job,
    }).then((value) => {

      LoadingDialog.hideLoadingDialog(context),
      Navigator.pop(context),

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
