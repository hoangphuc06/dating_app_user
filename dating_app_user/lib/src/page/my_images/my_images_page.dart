import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app_user/src/widgets/buttons/main_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyImagesPage extends StatefulWidget {
  const MyImagesPage({Key? key}) : super(key: key);

  @override
  _MyImagesPageState createState() => _MyImagesPageState();
}

class _MyImagesPageState extends State<MyImagesPage> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
              _image(x["images"][0]),
              SizedBox(width: 20,),
              x["images"][1] == "" ? _imageNull() : _image(x["images"][1]),
            ],
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              x["images"][2] == "" ? _imageNull() : _image(x["images"][2]),
              SizedBox(width: 20,),
              x["images"][3] == "" ? _imageNull() : _image(x["images"][3]),
            ],
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              x["images"][4] == "" ? _imageNull() : _image(x["images"][4]),
              SizedBox(width: 20,),
              x["images"][5] == "" ? _imageNull() : _image(x["images"][5]),
            ],
          ),
          SizedBox(height: 20,),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: MainButton(name: "Lưu", onpressed: (){

            }),
          )
        ],
      ),
    ),
  );

  _image(String url) => GestureDetector(
    onTap: (){

    },
    child: Container(
      width: 150,
      height: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          image: DecorationImage(
              image: NetworkImage(url),
              fit: BoxFit.cover
          )
      ),
    ),
  );

  _imageNull() => GestureDetector(
    onTap: (){

    },
    child: Container(
      width: 150,
      height: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.grey[200]
      ),
      child: Center(
        child: Icon(Icons.add_circle, color: Colors.deepPurple, size: 30,),
      ),
    ),
  );
}
