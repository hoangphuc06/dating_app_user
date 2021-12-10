import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app_user/src/page/tab/tab_page.dart';
import 'package:dating_app_user/src/widgets/buttons/main_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class InitCompletedPage extends StatefulWidget {
  const InitCompletedPage({Key? key}) : super(key: key);

  @override
  _InitCompletedPageState createState() => _InitCompletedPageState();
}

class _InitCompletedPageState extends State<InitCompletedPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(height: size.height * 0.05,),
                Row(
                  children: [
                    Text(
                      "Xin chào bạn tới với ",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.black
                      ),
                    ),
                    Text(
                      "iLove",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10,),
                Text(
                  "Cùng tuân thủ những quy định dưới đây để có trải nghiệm tuyệt vời nhé.",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.black
                  ),
                ),
              ],
            ),
            Wrap(
              runSpacing: 10,
              spacing: 10,
              children: [
                _item(size, "1", "Cư xử tử tế"),
                _item(size, "2", "Thật lòng"),
                _item(size, "3", "Hãy khác biệt"),
                _item(size, "4", "Vui vẻ không quạu")
              ],
            ),
            MainButton(name: "Đã rõ!", onpressed: (){
              onClick();
            })
          ],
        ),
      ),
    );
  }

  void onClick() {
    FirebaseFirestore.instance.collection("USER").doc(FirebaseAuth.instance.currentUser!.uid).update({
      "info": "nofull",
    }).then((value) => {

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TabPage())),

    });
  }

  _item(Size size, String num, String descr) => Container(
    width: (size.width - 64 - 10) / 2,
    height: (size.width - 64 - 10) / 2,
    child: Column(
      children: [
        Container(
          alignment: Alignment.center,
          width: (size.width - 64 - 10) / 4,
          height: (size.width - 64 - 10) / 4,
          decoration: BoxDecoration(
            color: Colors.deepPurple,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            num,
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white
            ),
          ),
        ),
        SizedBox(height: 10,),
        Text(
          descr,
          style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w400,
              color: Colors.black
          ),
        ),
      ],
    ),
  );
}
