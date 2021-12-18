import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app_user/src/page/tab/dating/view/is_dating_page.dart';
import 'package:dating_app_user/src/page/tab/dating/view/non_dating_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DatingPage extends StatefulWidget {
  const DatingPage({Key? key}) : super(key: key);

  @override
  _DatingPageState createState() => _DatingPageState();
}

class _DatingPageState extends State<DatingPage> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("Hẹn hò", style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),),
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
            if (x["dating"]=="false")
              return NonDatingPage();
            else
              return IsDatingPage();
          }
        },
      ),
    );
  }
}
