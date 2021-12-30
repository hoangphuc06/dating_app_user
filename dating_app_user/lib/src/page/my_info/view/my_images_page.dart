import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app_user/src/widgets/buttons/main_button.dart';
import 'package:dating_app_user/src/widgets/dialogs/loading_dialog.dart';
import 'package:dating_app_user/src/widgets/dialogs/msg_dilog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class MyImagesPage extends StatefulWidget {
  const MyImagesPage({Key? key}) : super(key: key);

  @override
  _MyImagesPageState createState() => _MyImagesPageState();
}

class _MyImagesPageState extends State<MyImagesPage> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<String> _listUrl = ["", "", "", "", "", ""];

  List<File?> _listFile = [null, null, null, null, null, null];

  List<bool> _listLoad = [false, false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.deepPurple, //change your color here
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: StreamBuilder(
        stream: _firestore.collection("USER").where("uid", isEqualTo: _auth.currentUser!.uid).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
          if (!snapshot.hasData) {
            return Center(
              child: Container(
                height: size.height / 20,
                width: size.height / 20,
                child: CircularProgressIndicator(),
              ),
            );
          }
          else {
            QueryDocumentSnapshot x = snapshot.data!.docs[0];
            _listUrl[0] = x["images"][0];
            _listUrl[1] = x["images"][1];
            _listUrl[2] = x["images"][2];
            _listUrl[3] = x["images"][3];
            _listUrl[4] = x["images"][4];
            _listUrl[5] = x["images"][5];
            return _getBody(x);
          }
        },
      ),
    );
  }

  _getBody(QueryDocumentSnapshot x) => SingleChildScrollView(
    child: Container(
      padding: EdgeInsets.only(left: 32, right: 32, bottom: 32, top: 16),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hình ảnh của bạn ? 📷",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Colors.black
                ),
              ),
              SizedBox(height: 10,),
              _description("Cập nhật đúng vị trí của bạn để có thể tìm ra những người phù hợp gần bạn nhất."),
              SizedBox(height: 10,),
              GestureDetector(
                onTap: (){
                  _showBottomSheet(MediaQuery.of(context).size);
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
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _image(0),
              _listUrl[1] == "" ? _imageNull(1) : _image(1),
            ],
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _listUrl[2] == "" ? _imageNull(2) : _image(2),
              SizedBox(width: 20,),
              _listUrl[3] == "" ? _imageNull(3) : _image(3),
            ],
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _listUrl[4] == "" ? _imageNull(4) : _image(4),
              SizedBox(width: 20,),
              _listUrl[5] == "" ? _imageNull(5) : _image(5),
            ],
          ),
          SizedBox(height: 20,),
          MainButton(name: "Lưu", onpressed: (){
            _saveImage();
          })
        ],
      ),
    ),
  );

  _image(int index) => _listLoad[index] == false ? GestureDetector(
    onTap: (){
      _selectImage(index);
    },
    child: Container(
      width: (MediaQuery.of(context).size.width - 64 - 20) /2,
      height: 220,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          image: _listFile[index] == null ? DecorationImage(
              image: NetworkImage(_listUrl[index]),
              fit: BoxFit.cover)
          : DecorationImage(
              image: FileImage(_listFile[index]!),
              fit: BoxFit.cover
          )
      ),
      child: _listFile[index] != null ? Container(
        padding: EdgeInsets.all(8),
        alignment: Alignment.bottomRight,
        child: Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.5)
          ),
          child: IconButton(
            icon: Icon(Icons.delete, color: Colors.deepPurple,),
            onPressed: (){
              _deleleImage(index);
            },
          ),
        ),
      ) : null
    )
  ) : Container(
    width: (MediaQuery.of(context).size.width - 64 - 20) /2,
    height: 220,
    child: Center(
      child: Container(
        height: MediaQuery.of(context).size.height / 20,
        width: MediaQuery.of(context).size.height / 20,
        child: CircularProgressIndicator(),
      ),
    ),
  );

  _imageNull(int index) => _listLoad[index] == false ? GestureDetector(
    onTap: (){
      _selectImageNull(index);
    },
    child: Container(
      width: (MediaQuery.of(context).size.width - 64 - 20) /2,
      height: 220,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.grey[200],
          image: _listFile[index] == null ? null : DecorationImage(
              image: FileImage(_listFile[index]!),
              fit: BoxFit.cover
          )
      ),
      child: _listFile[index] != null ? Container(
        padding: EdgeInsets.all(8),
        alignment: Alignment.bottomRight,
        child: Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.5)
          ),
          child: IconButton(
            icon: Icon(Icons.delete, color: Colors.deepPurple.withOpacity(1),),
            onPressed: (){
              _deleleImage(index);
            },
          ),
        ),
      ) : Center(
        child:  Icon(Icons.add_circle, color: Colors.deepPurple, size: 30,),
      ),
    ),
  ) : Container(
    width: (MediaQuery.of(context).size.width - 64 - 20) /2,
    height: 220,
    child: Center(
      child: Container(
        height: MediaQuery.of(context).size.height / 20,
        width: MediaQuery.of(context).size.height / 20,
        child: CircularProgressIndicator(),
      ),
    ),
  );

  Future _selectImageNull(int index) async {

    for (int i = 0; i <= index; i++) {
      if (_listUrl[i] == "" && _listFile[i] == null) {

        final result = await FilePicker.platform.pickFiles(allowMultiple: false);

        setState(() {
          _listLoad[i]  = true;
        });

        if (result == null) {
          setState(() {
            _listLoad[i]  = false;
          });
          return;
        }

        final path = result.files.single.path!;

        final image = FirebaseVisionImage.fromFile(File(path));
        final faceDetector = FirebaseVision.instance.faceDetector();
        List<Face> faces = await faceDetector.processImage(image);

        if (mounted) {
          if(faces.length==1) {
            setState(() {
              _listLoad[i]  = false;
              _listFile[i] = File(path);
            });
          }
          else {
            setState(() {
              _listLoad[i]  = false;
            });
            MsgDialog.showMsgDialog(context, "Sai quy tắc", "Bức ảnh của bạn không phù hợp với cộng đồng iLove, vui lòng sử dụng ảnh khác.");
          }
        }

        return;
      }
    }
  }

  Future _selectImage(int index) async {

    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    setState(() {
      _listLoad[index]  = true;
    });

    if (result == null) {
      setState(() {
        _listLoad[index]  = false;
      });
      return;
    }

    final path = result.files.single.path!;

    final image = FirebaseVisionImage.fromFile(File(path));
    final faceDetector = FirebaseVision.instance.faceDetector();
    List<Face> faces = await faceDetector.processImage(image);

    if (mounted) {
      if(faces.length==1) {
        setState(() {
          _listLoad[index]  = false;
          _listFile[index] = File(path);
        });
      }
      else {
        setState(() {
          _listLoad[index]  = false;
        });
        MsgDialog.showMsgDialog(context, "Sai quy tắc", "Bức ảnh của bạn không phù hợp với cộng đồng iLove, vui lòng sử dụng ảnh khác.");
      }
    }
  }

  void _deleleImage(int index) {
    setState(() {
      _listFile[index] = null;
    });
  }

  Future<void> _saveImage() async {

    LoadingDialog.showLoadingDialog(context, "Đang lưu...");

    for (int i=0; i<6; i++) {
      if (_listFile[i] != null) {

        String filename = DateTime.now().millisecondsSinceEpoch.toString();

        Reference ref = FirebaseStorage.instance.ref().child("AVATAR").child(FirebaseAuth.instance.currentUser!.uid).child("post_$filename");

        await ref.putFile(_listFile[i]!);

        _listUrl[i] = await ref.getDownloadURL();
      }
    }

    await FirebaseFirestore.instance.collection("USER").doc(FirebaseAuth.instance.currentUser!.uid).update({
      "images": _listUrl,
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
          SizedBox(height: 10,),
          Row(
            children: [
              Icon(Icons.group, size: 20,),
              SizedBox(width: 10,),
              Text(
                "Không dùng ảnh không có quá nhiều người",
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
                      "assets/image/example/shadow.jpg",
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
                      "assets/image/example/group.jpg",
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

}
