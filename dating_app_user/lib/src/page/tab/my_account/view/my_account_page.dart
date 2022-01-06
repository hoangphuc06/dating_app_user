import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({Key? key}) : super(key: key);

  @override
  _MyAccountPageState createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 20,),

              StreamBuilder(
                stream: _firestore.collection("USER").where("uid", isEqualTo: _auth.currentUser!.uid).snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
                  if (!snapshot.hasData) {
                    return Column(
                      children: [
                        //avatar
                        Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey[100]
                          ),
                        ),

                        //Tên
                        SizedBox(height: 20,),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 25,
                          width: 150,
                        ),

                        SizedBox(height: 5,),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 25,
                          width: 250,
                        ),
                      ],
                    );
                  }
                  else {
                    QueryDocumentSnapshot x = snapshot.data!.docs[0];
                    return Column(
                      children: [
                        //avatar
                        Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(x["images"][0]),
                                  fit: BoxFit.cover)),
                        ),

                        //Tên
                        SizedBox(height: 20,),
                        Text(
                          x["name"] + ", " + (DateTime.now().year - int.parse(x["birthday"].toString().substring(x["birthday"].toString().length - 4))).toString(),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w500
                          ),
                        ),

                        //Châm ngôn sống
                        SizedBox(height: 5,),
                        Container(
                          padding: EdgeInsets.only(left: 36, right: 36),
                          child: Text(
                            x["bio"],
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                height: 1.3
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),

              Padding(padding: EdgeInsets.only(left: 16, right: 16),
              child: Column(
                children: [
                  SizedBox(height: 15,),
                  _tab_detail("Chỉnh sửa thông tin", (){
                    Navigator.pushNamed(context, "my_info_page");
                  }),

                  SizedBox(height: 15,),
                  _tab_detail("Cài đặt", (){
                    Navigator.pushNamed(context, "setting_page");
                  }),

                  SizedBox(height: 15,),
                  _tab_detail("Mời bạn bè", (){

                  }),

                  SizedBox(height: 15,),
                  _tab_detail("Giới thiệu", (){

                  }),

                  SizedBox(height: 15,),
                  _tab_detail("Đăng xuất", (){
                    setStatus("Offline");
                    FirebaseAuth.instance.signOut().then((value) => {
                      Navigator.pushNamedAndRemoveUntil(context, "welcome_page", (Route<dynamic> route) => false),
                    });
                  }),
                ],
              ),)

            ],
          ),
        ),
      ),
    );
  }

  _tab_detail(String name, Function funtion) => GestureDetector(
    onTap: (){
      funtion();
    },
    child: Container(
      padding: EdgeInsets.only(top: 8, bottom: 8, left: 12, right: 12),
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.grey.withOpacity(0.1)
      ),
      child: Row(
        children: [
          Text(
            name,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold
            ),
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios_rounded, size: 15,)
        ],
      ),
    ),
  );

  void setStatus(String status) async {
    await _firestore.collection('USER').doc(_auth.currentUser!.uid).update({
      "status": status,
    });
  }
}
