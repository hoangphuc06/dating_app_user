import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app_user/src/colors/colors.dart';
import 'package:dating_app_user/src/page/welcome/update_password_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
        title: Text("Cài đặt", style: TextStyle(color: Colors.deepPurple),),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //______________Thông tin cơ bản__________________________
              _title("Thông tin cơ bản"),

              SizedBox(height: 10,),

              _description("Để giữ được tính chân thật cho cộng đồng iLove, bạn sẽ không thể thay đổi các thông tin này."),

              SizedBox(height: 10,),

              StreamBuilder(
                stream: _firestore.collection("USER").where("uid", isEqualTo: _auth.currentUser!.uid).snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
                  if (!snapshot.hasData) {
                    return Column(
                      children: [
                        _detail("Tên", "", () {
                          print("2");
                        }),

                        SizedBox(height: 10,),
                        _detail("Ngày sinh", "", () {
                          print("2");
                        }),

                        SizedBox(height: 10,),

                        _detail("Giới tính", "", () {
                          print("2");
                        }),
                      ],
                    );
                  }
                  else {
                    QueryDocumentSnapshot x = snapshot.data!.docs[0];
                    return Column(
                      children: [
                        _detail("Tên", x["name"], () {
                          print("2");
                        }),

                        SizedBox(height: 10,),
                        _detail("Ngày sinh", x["birthday"], () {
                          print("2");
                        }),

                        SizedBox(height: 10,),

                        _detail("Giới tính", x["sex"], () {
                          print("2");
                        }),
                      ],
                    );
                  }
                },
              ),

              //_____________Thông tin khác______________________________
              SizedBox(height: 20,),

              _title("Thông tin khác"),

              SizedBox(height: 10,),

              _tab_detail("Hỗ trợ", (){
                print("2");
              }),

              SizedBox(height: 10,),

              _tab_detail("Điều khoản sử dụng dịch vụ", (){
                print("2");
              }),

              SizedBox(height: 10,),

              _tab_detail("Chính sách quyền riêng tư", (){
                print("2");
              }),

              SizedBox(height: 10,),

              _tab_detail("Ý kiến phản hồi", (){
                print("2");
              }),

              //______________Tài khoản_________________________________________

              SizedBox(height: 20,),

              _title("Tài khoản"),

              SizedBox(height: 10,),

              _tab_detail("Vô hiệu hóa tài khoản", (){
                print("2");
              }),

              SizedBox(height: 10,),

              _description("Vô hiệu hóa tài khoản đồng nghĩa bạn sẽ không hiện trên trang tìm kiếm và không thể trò chuyện với ai nữa. Các kết đôi của bạn sẽ bị vô hiệu cho tới khi bạn sử dụng trở lại."),

              SizedBox(height: 10,),

              _tab_detail("Đổi mật khẩu", (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => UpdatePasswordPage()));
              }),

              SizedBox(height: 10,),

              _tab_detail("Xóa tài khoản", (){
                print("2");
              }),

              // SizedBox(height: 10,),
              // _tab_logout("Đăng xuất", (){
              //   setStatus("Offline");
              //   FirebaseAuth.instance.signOut().then((value) => {
              //     Navigator.pushNamedAndRemoveUntil(context, "welcome_page", (Route<dynamic> route) => false),
              //   });
              // }),

              SizedBox(height: 50,)
            ],
          ),
        ),
      ),
    );
  }

  void setStatus(String status) async {
    await _firestore.collection('USER').doc(_auth.currentUser!.uid).update({
      "status": status,
    });
  }

  _title(String text) => Text(
    text,
    style: TextStyle(
        color: Colors.grey,
        fontWeight: FontWeight.w500
    ),
  );

  _description(String description) => Text(
    description,
    style: TextStyle(
      color: Colors.black.withOpacity(0.5),
      fontWeight: FontWeight.w400
    ),
    textAlign: TextAlign.justify,
  );

  _detail(String name, String detail, Function funtion) => GestureDetector(
    onTap: (){
      funtion();
    },
    child: Container(
      padding: EdgeInsets.all(8),
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
          Text(
            detail,
            style: TextStyle(
              color: Colors.deepPurple,
              fontWeight: FontWeight.bold
            ),
          ),
          Icon(Icons.arrow_forward_ios_rounded, size: 15,)
        ],
      ),
    ),
  );

  _tab_detail(String name, Function funtion) => GestureDetector(
    onTap: (){
      funtion();
    },
    child: Container(
      padding: EdgeInsets.all(8),
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

  _tab_logout(String name, Function funtion) => GestureDetector(
    onTap: (){
      funtion();
    },
    child: Container(
      padding: EdgeInsets.all(8),
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.deepPurple.withOpacity(0.2)
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
}
