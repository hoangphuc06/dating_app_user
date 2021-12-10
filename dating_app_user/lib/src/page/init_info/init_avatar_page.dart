import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app_user/src/page/init_info/init_filter_sex_page.dart';
import 'package:dating_app_user/src/widgets/buttons/main_button.dart';
import 'package:dating_app_user/src/widgets/dialogs/loading_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';

class InitAvatarPage extends StatefulWidget {
  const InitAvatarPage({Key? key}) : super(key: key);

  @override
  _InitAvatarPageState createState() => _InitAvatarPageState();
}

class _InitAvatarPageState extends State<InitAvatarPage> {

  File? file;

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50,),
                Text(
                  "Hãy chọn ảnh \ncó khuôn mặt bạn 📸",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      color: Colors.black
                  ),
                ),
                SizedBox(height: 20,),
                _description("Bức ảnh này là sẽ là ảnh đại diện của bạn, mọi người trong cộng đồng iLove sẽ thấy được nó."),
                SizedBox(height: 10,),
                GestureDetector(
                  onTap: (){
                    _showBottomSheet(size);
                  },
                  child: Text(
                    "Đọc hướng dẫn chọn ảnh của iLove",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.deepPurple
                    ),
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                _selectImage();
              },
              child: file == null ?
              Center(
                child: Container(
                  height: size.height * 0.3,
                  width: size.height * 0.2,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/image/gallery.png"),
                        fit: BoxFit.contain,
                      )
                  ),
                ),
              ):
              Center(
                child: Container(
                  height: size.height * 0.4,
                  width: size.height * 0.3,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      image: DecorationImage(
                          image: FileImage(file!),
                          fit: BoxFit.cover
                      )
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

  Future<void> onClick() async {

    LoadingDialog.showLoadingDialog(context, "Đang lưu...");

    String filename = DateTime.now().millisecondsSinceEpoch.toString();
    Reference ref = FirebaseStorage.instance.ref().child(FirebaseAuth.instance.currentUser!.uid).child("post_$filename");

    await ref.putFile(file!);

    String URL = await ref.getDownloadURL();

    await FirebaseFirestore.instance.collection("USER").doc(FirebaseAuth.instance.currentUser!.uid).update({
      "avatar": URL,
    }).then((value) => {

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => InitFilterSexPage())),

    });


  }

  _showBottomSheet(Size size) => showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (context) => _bodyBottomSheet(context,size)
  );

  _bodyBottomSheet(BuildContext context, Size size) => SingleChildScrollView(
    child: Container(
      padding: EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30,),
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: Text(
              "Bí kíp ảnh đẹp và chuẩn",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
                fontSize: 20
              ),
            ),
          ),

          //Nên
          SizedBox(height: 20,),
          Text(
            "Nên",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.pink,
                fontSize: 17
            ),
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              Icon(Icons.face, size: 20,),
              SizedBox(width: 10,),
              Text(
                "Chọn ảnh rõ mặt",
                style: TextStyle(
                    color: Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              Icon(Icons.access_time, size: 20,),
              SizedBox(width: 10,),
              Text(
                "Chọn ảnh được chụp gần đây",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              Icon(Icons.headphones, size: 20,),
              SizedBox(width: 10,),
              Text(
                "Chọn ảnh thể hiện được sở thích của bạn",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ],
          ),

          //Không nên
          SizedBox(height: 20,),
          Text(
            "Không nên",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.pink,
                fontSize: 17
            ),
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              Icon(Icons.clear, size: 20,),
              SizedBox(width: 10,),
              Text(
                "Không dùng ảnh chất lượng thấp",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              Icon(Icons.star, size: 20,),
              SizedBox(width: 10,),
              Text(
                "Không dùng ảnh có quá nhiều filter",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              Icon(Icons.search, size: 20,),
              SizedBox(width: 10,),
              Text(
                "Không dùng ảnh không có mặt bạn trong đó",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ],
          ),

          //Ví dụ
          SizedBox(height: 20,),
          Text(
            "Ví dụ",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.pink,
                fontSize: 17
            ),
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  Image.asset(
                    "assets/image/example/female_1.jpg",
                    fit: BoxFit.cover,
                    height: 250,
                    width: (size.width - 64 - 10) /2,
                  ),
                  Container(
                    height: 25,
                    width: 25,
                    margin: EdgeInsets.only(top: 5, right: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: Colors.green
                    ),
                    child: Icon(Icons.done, color: Colors.white, size: 15,),
                  )
                ]
              ),
              Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Image.asset(
                      "assets/image/example/male_1.jpg",
                      fit: BoxFit.cover,
                      height: 250,
                      width: (size.width - 64 - 10) /2,
                    ),
                    Container(
                      height: 25,
                      width: 25,
                      margin: EdgeInsets.only(top: 5, right: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          color: Colors.green
                      ),
                      child: Icon(Icons.done, color: Colors.white, size: 15,),
                    )
                  ]
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Image.asset(
                      "assets/image/example/female_2.jpg",
                      fit: BoxFit.cover,
                      height: 250,
                      width: (size.width - 64 - 10) /2,
                    ),
                    Container(
                      height: 25,
                      width: 25,
                      margin: EdgeInsets.only(top: 5, right: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          color: Colors.red
                      ),
                      child: Icon(Icons.clear, color: Colors.white, size: 15,),
                    )
                  ]
              ),
              Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Image.asset(
                      "assets/image/example/male_2.jpg",
                      fit: BoxFit.cover,
                      height: 250,
                      width: (size.width - 64 - 10) /2,
                    ),
                    Container(
                      height: 25,
                      width: 25,
                      margin: EdgeInsets.only(top: 5, right: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          color: Colors.red
                      ),
                      child: Icon(Icons.clear, color: Colors.white, size: 15,),
                    )
                  ]
              ),
            ],
          ),

          SizedBox(height: 20,),
          MainButton(name: "Tôi hiểu", onpressed: (){
            Navigator.pop(context);
          })
        ],
      ),
    ),
  );

  Future _selectImage() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result == null) return;
    final path = result.files.single.path!;
    setState(() {
      file = File(path);
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

