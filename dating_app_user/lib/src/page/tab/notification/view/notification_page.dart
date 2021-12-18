import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app_user/src/widgets/buttons/main_button.dart';
import 'package:dating_app_user/src/widgets/buttons/sup_button.dart';
import 'package:dating_app_user/src/widgets/cards/noti_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("Những người thích bạn", style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),),
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
              return _bodyNonDating(size);
            else
              return _bodyDating(size);
          }
        },
      ),
    );
  }

  _bodyNonDating(Size size) => SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _title("Mới nhất"),
        _newNoti(size),
        SizedBox(height: 20,),
        _title("Đã xem"),
        _seenNoti(size),
      ],
    ),
  );

  Widget _bodyDating(Size) {
    var size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/image/love2.svg", height: size.height * 0.23,),
            SizedBox(height: 20,),
            Text(
              "Hãy thành thật với nhau 😉",
              style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 20,
                  fontWeight: FontWeight.w500
              ),
            ),
            SizedBox(height: 5,),
            Text(
              "Hãy thành thật với nhau nhưng cũng phải tỉnh táo \nđể không rơi vào những trường hợp đáng tiếc nhé.",
              style: TextStyle(
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }

  _title(String text) => Text(
    text,
    style: TextStyle(
        color: Colors.grey,
        fontWeight: FontWeight.w500
    ),
  );
  
  _newNoti(Size size) => Padding(
    padding: const EdgeInsets.only(top: 10),
    child: StreamBuilder(
      stream: _firestore.collection("NOTIFICATION").where("uid", isEqualTo: _auth.currentUser!.uid).where("status", isEqualTo: "new").snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
        if (!snapshot.hasData) {
          return Center(
            child: Container(),
          );
        }
        else {
          return GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
            ),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, i) {
              QueryDocumentSnapshot x = snapshot.data!.docs[i];
              return NewNotiCard(herid: x["herid"], func: (){_showBottomSheet(x["herid"]);});
            }
          );
        }
      },
    ),
  );

  _seenNoti(Size size) => Padding(
    padding: const EdgeInsets.only(top: 10),
    child: StreamBuilder(
      stream: _firestore.collection("NOTIFICATION").where("uid", isEqualTo: _auth.currentUser!.uid).where("status", isEqualTo: "seen").snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
        if (!snapshot.hasData) {
          return Center(
            child: Container(),
          );
        }
        else {
          return GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, i) {
                QueryDocumentSnapshot x = snapshot.data!.docs[i];
                return SeenNotiCard(herid: x["herid"], func: (){_showBottomSheet(x["herid"]);});
              }
          );
        }
      },
    ),
  );

  _showBottomSheet(String herid) => showModalBottomSheet(
    isScrollControlled: true,
    context:context,
    builder: (context) => StreamBuilder(
      stream: _firestore.collection("USER").where("uid", isEqualTo: herid).snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
        if (!snapshot.hasData) {
          return Center(
            child: Container(),
          );
        }
        else {
          QueryDocumentSnapshot x = snapshot.data!.docs[0];
          return Container(
            padding: EdgeInsets.all(12),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30,),
                  Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text("HỒ SƠ", style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold, fontSize: 20),)
                  ),
                  SizedBox(height: 30,),
                  _title("Thông tin cá nhân"),
                  SizedBox(height: 10,),
                  _detail("Họ tên", x["name"], (){}),
                  SizedBox(height: 10,),
                  _detail("Giới tính", x["sex"], (){}),
                  SizedBox(height: 10,),
                  _detail("Tuổi", "20", (){}),
                  SizedBox(height: 30,),
                  _title("Hình ảnh"),
                  SizedBox(height: 10,),
                  _imageView(x["avatar"]),
                  SizedBox(height: 30,),
                  _title("Miêu tả"),
                  SizedBox(height: 10,),
                  _bio(),
                  SizedBox(height: 10,),
                  _character(),
                  SizedBox(height: 10,),
                  _hobby(),
                  SizedBox(height: 10,),
                  _dating(),
                  SizedBox(height: 30,),
                  _title("Thông tin cơ bản"),
                  SizedBox(height: 10,),
                  _detail("Chiều cao", "160 cm", (){}),
                  SizedBox(height: 10,),
                  _detail("Đến từ", "TP.HCM, Việt Nam", (){}),
                  SizedBox(height: 10,),
                  _detail("Sống tại", "TP.HCM, Việt Nam", (){}),
                  SizedBox(height: 10,),
                  _detail("Nghề nghiệp", "Sinh viên", (){}),
                  SizedBox(height: 30,),
                  _title("Sự thật thú vị"),
                  SizedBox(height: 10,),
                  _detail("16 nhóm tính cách", "ENTP", (){
                  }),
                  SizedBox(height: 30,),
                  MainButton(name: "Đồng ý", onpressed: (){
                    _accept(x["uid"]);
                  }),
                  SizedBox(height: 10,),
                  SupButton(name: "Từ chối", onpressed: (){

                  }),
                  SizedBox(height: 50,),
                ],
              ),
            ),
          );
        }
      },
    )
  );

  void _accept(String herid) async {
    await _firestore.collection("DATING").doc(_auth.currentUser!.uid).set({
      "uid": _auth.currentUser!.uid,
      "herid": herid,
    });
    await _firestore.collection("DATING").doc(herid).set({
      "uid": herid,
      "herid": _auth.currentUser!.uid,
    });
    await _firestore.collection("USER").doc(_auth.currentUser!.uid).update({
      "dating": "true",
    });
    await _firestore.collection("USER").doc(herid).update({
      "dating": "true",
    });
    Navigator.pop(context);
  }

  _imageView(String link) => Container(
    height: 200,
    child: ListView(
      scrollDirection: Axis.horizontal,
      children: [
        _image(link),
        _image(link),
        _image(link),
        _image(link),
        _image(link),
        _image(link),
      ],
    ),
  );

  _image(String url) => Container(
    width: 150,
    margin: EdgeInsets.only(right: 10),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        image: DecorationImage(
            image: NetworkImage(url),
            fit: BoxFit.cover
        )
    ),
  );

  _bio() => Container(
    padding: EdgeInsets.all(16),
    height: 150,
    width: double.infinity,
    decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.all(Radius.circular(10))
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Bio",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: 10,),
        Text(
          "Mình thích đi dạo vào mỗi tối cuối tuần. Thích nuôi chó và mèo.",
          style: TextStyle(
              color: Colors.deepPurple,
              fontWeight: FontWeight.w500
          ),
          maxLines: 3,
          textAlign: TextAlign.justify,
        ),
      ],
    ),
  );

  _character() => Container(
    padding: EdgeInsets.all(16),
    width: double.infinity,
    decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.all(Radius.circular(10))
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Tính cách",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: 10,),
        Wrap(
          spacing: 20,
          runSpacing: 10,
          children: [
            _lable("🤠 Tự lập"),
            _lable("😐 Can đảm"),
            _lable("😊 Thận trọng"),
          ],
        )
      ],
    ),
  );

  _hobby() => Container(
    padding: EdgeInsets.all(16),
    width: double.infinity,
    decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.all(Radius.circular(10))
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Sở thích",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: 10,),
        Wrap(
          spacing: 20,
          runSpacing: 15,
          children: [
            _lable("📸 Chụp ảnh"),
            _lable("🎖 Tham gia tình nguyện"),
            _lable("🎮 Game online"),
          ],
        )
      ],
    ),
  );

  _dating() => Container(
    padding: EdgeInsets.all(16),
    width: double.infinity,
    decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.all(Radius.circular(10))
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Kiểu hẹn hò",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: 10,),
        Wrap(
          spacing: 20,
          runSpacing: 15,
          children: [
            _lable("🏍 Đi du lịch"),
            _lable("⚽ Chơi thể thao"),
            _lable("🎞 Xem phim"),
          ],
        ),
      ],
    ),
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
        ],
      ),
    ),
  );

  _lable(String text) => Container(
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.grey.withOpacity(0.2)
    ),
    child: Text(
      text,
      style: TextStyle(
          fontSize: 15
      ),
    ),
  );
}
