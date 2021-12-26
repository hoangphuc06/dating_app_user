import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app_user/src/widgets/buttons/main_button.dart';
import 'package:dating_app_user/src/widgets/dialogs/loading_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
        title: Text("Hình ảnh của tôi", style: TextStyle(color: Colors.deepPurple),),
        centerTitle: true,
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
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _image(0),
              SizedBox(width: 20,),
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
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: MainButton(name: "Lưu", onpressed: (){
              _saveImage();
            }),
          )
        ],
      ),
    ),
  );

  _image(int index) => GestureDetector(
    onTap: (){
      _selectImage(index);
    },
    child: Container(
      width: 150,
      height: 200,
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
  );

  _imageNull(int index) => GestureDetector(
    onTap: (){
      _selectImageNull(index);
    },
    child: Container(
      width: 150,
      height: 200,
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
  );

  Future _selectImageNull(int index) async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result == null) return;
    final path = result.files.single.path!;
    for (int i = 0; i <= index; i++) {
      if (_listUrl[i] == "" && _listFile[i] == null) {
        setState(() {
          _listFile[i] = File(path);
        });
        return;
      }
    }
  }

  Future _selectImage(int index) async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result == null) return;
    final path = result.files.single.path!;
    setState(() {
      _listFile[index] = File(path);
    });
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



}
