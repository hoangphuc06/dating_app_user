import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app_user/src/widgets/buttons/main_button.dart';
import 'package:dating_app_user/src/widgets/dialogs/loading_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyBioPage extends StatefulWidget {
  final String bio;
  const MyBioPage({Key? key, required this.bio}) : super(key: key);

  @override
  _MyBioPageState createState() => _MyBioPageState();
}

class _MyBioPageState extends State<MyBioPage> {

  TextEditingController _bioController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bioController.text = widget.bio;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.deepPurple, //change your color here
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 32, right: 32, bottom: 32, top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Miêu tả về bạn ? 🤹‍♀️",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      color: Colors.black
                  ),
                ),
                SizedBox(height: 10,),
                _description("Miêu tả một chút về bản thân để mọi người hiểu hơn về bạn nào."),
              ],
            ),
            TextFormField(
              minLines: 1,
              maxLines: 5,
              controller: _bioController,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                  hintText: "Nhập miêu tả về bạn",
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

    String bio = _bioController.text.trim();

    LoadingDialog.showLoadingDialog(context, "Đang lưu...");

    FirebaseFirestore.instance.collection("USER").doc(FirebaseAuth.instance.currentUser!.uid).update({
      "bio": bio,
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
