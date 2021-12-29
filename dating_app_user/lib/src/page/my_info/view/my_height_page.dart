import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app_user/src/widgets/buttons/main_button.dart';
import 'package:dating_app_user/src/widgets/dialogs/loading_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyHeightPage extends StatefulWidget {
  final String height;
  const MyHeightPage({Key? key, required this.height}) : super(key: key);

  @override
  _MyHeightPageState createState() => _MyHeightPageState();
}

class _MyHeightPageState extends State<MyHeightPage> {

  TextEditingController _heightController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _heightController.text = widget.height;
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
                  "Chiều cao\ncủa bạn bao nhiêu ? 🤭",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      color: Colors.black
                  ),
                ),
                SizedBox(height: 20,),
                _description("Nhập đúng chiều cao của bạn vào để mọi người có thể biết thêm về bạn."),
              ],
            ),
            TextFormField(
              controller: _heightController,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: "Nhập chiều cao (cm)",
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

    String height = _heightController.text.trim();

    LoadingDialog.showLoadingDialog(context, "Đang lưu...");

    FirebaseFirestore.instance.collection("USER").doc(FirebaseAuth.instance.currentUser!.uid).update({
      "height": height,
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
