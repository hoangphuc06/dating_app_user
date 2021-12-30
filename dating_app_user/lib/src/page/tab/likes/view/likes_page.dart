import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app_user/src/data/likes_json.dart';
import 'package:dating_app_user/src/widgets/cards/noti_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LikesPage extends StatefulWidget {
  const LikesPage({Key? key}) : super(key: key);

  @override
  _LikesPageState createState() => _LikesPageState();
}

class _LikesPageState extends State<LikesPage> {

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
        //_seenNoti(size),
      ],
    ),
  );

  _newNoti(Size size) => Padding(
    padding: const EdgeInsets.only(top: 10),
    child: StreamBuilder(
      stream: _firestore.collection("LIKE").where("uid", isEqualTo: _auth.currentUser!.uid).where("status", isEqualTo: "new").snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
        if (!snapshot.hasData) {
          return Center(
            child: Container(height: 0, width: 0,),
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
                return NewNotiCard(herid: x["herid"], func: (){});
              }
          );
        }
      },
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

}
