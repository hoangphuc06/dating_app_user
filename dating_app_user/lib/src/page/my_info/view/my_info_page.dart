import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app_user/src/page/my_info/view/my_16_characters_page.dart';
import 'package:dating_app_user/src/page/my_info/view/my_bio_page.dart';
import 'package:dating_app_user/src/page/my_info/view/my_images_page.dart';
import 'package:dating_app_user/src/page/my_info/view/my_address_page.dart';
import 'package:dating_app_user/src/page/my_info/view/my_describe_page.dart';
import 'package:dating_app_user/src/page/my_info/view/my_height_page.dart';
import 'package:dating_app_user/src/page/my_info/view/my_job_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyInfoPage extends StatefulWidget {
  const MyInfoPage({Key? key}) : super(key: key);

  @override
  _MyInfoPageState createState() => _MyInfoPageState();
}

class _MyInfoPageState extends State<MyInfoPage> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  TextEditingController _bioController = new TextEditingController();

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
        title: Text("Chỉnh sửa hồ sơ", style: TextStyle(color: Colors.deepPurple),),
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
            _bioController.text = x["bio"];
            return _getBody(x);
          }
        },
      ),
    );
  }

  _getBody(QueryDocumentSnapshot x) => SingleChildScrollView(
    child: Container(
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title("Hình ảnh"),
          SizedBox(height: 10,),
          _imageView(x["images"]),
          SizedBox(height: 30,),
          _title("Miêu tả"),
          SizedBox(height: 10,),
          _bio(x["bio"]),
          SizedBox(height: 10,),
          _character(x),
          SizedBox(height: 10,),
          _hobby(x),
          SizedBox(height: 10,),
         _dating(x),
          SizedBox(height: 30,),
          _title("Thông tin cơ bản"),
          SizedBox(height: 10,),
          _detail("Chiều cao", x["height"] != ""? x["height"] + " cm" : "", (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => MyHeightPage(height: x["height"],)));
          }),
          SizedBox(height: 10,),
          _detail("Sống tại", x["address"], (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => MyAddressPage(long: x["longitude"], lat: x["latitude"], addr: x["address"],)));
          }),
          SizedBox(height: 10,),
          _detail("Nghề nghiệp", x["job"], (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => MyJobPage(job: x["job"])));
          }),
          SizedBox(height: 30,),
          _title("Sự thật thú vị"),
          SizedBox(height: 10,),
          _detail("16 nhóm tính cách", x["interesting_fact"], (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => My16CharactersPage(name: x["interesting_fact"])));
          }),
          SizedBox(height: 50,),
        ],
      ),
    ),
  );

  _title(String text) => Text(
    text,
    style: TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.w500
    ),
  );

  _imageView(x) => Container(
    height: 200,
    child: ListView(
      scrollDirection: Axis.horizontal,
      children: [
        _image(x[0]),
        x[1] == "" ? _imageNull() : _image(x[1]),
        x[2] == "" ? _imageNull() : _image(x[2]),
        x[3] == "" ? _imageNull() : _image(x[3]),
        x[4] == "" ? _imageNull() : _image(x[4]),
        x[5] == "" ? _imageNull() : _image(x[5]),
      ],
    ),
  );

  _image(String url) => GestureDetector(
    onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context) => MyImagesPage()));
    },
    child: Container(
      width: 150,
      margin: EdgeInsets.only(right: 10),
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
      Navigator.push(context, MaterialPageRoute(builder: (context) => MyImagesPage()));
    },
    child: Container(
      width: 150,
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.grey[200]
      ),
      child: Center(
        child: Icon(Icons.add_circle, color: Colors.deepPurple, size: 30,),
      ),
    ),
  );

  _bio(String bio) => Container(
    padding: EdgeInsets.all(16),
    width: double.infinity,
    decoration: BoxDecoration(
      color: Colors.grey.withOpacity(0.1),
      borderRadius: BorderRadius.all(Radius.circular(10))
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Bio",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyBioPage(bio: bio)));
              },
              child: Text(
                "Cập nhật",
                style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold
                ),
              ),
            )
          ],
        ),
        //SizedBox(height: 10,),
        TextFormField(
          readOnly: true,
          onSaved: (value) => {
            _bioController.text = value!,
          },
          maxLines: 5,
          minLines: 3,
          controller: _bioController,
          decoration: InputDecoration(
              hintText: "Nhập miêu tả về bạn",
              hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 15
              ),
              border: InputBorder.none
          ),
          style: TextStyle(
            //color: Colors.black,
              fontWeight: FontWeight.normal,
              fontSize: 15
          ),
          textAlign: TextAlign.justify,
        ),
      ],
    ),
  );

  _character(x) => Container(
    padding: EdgeInsets.all(16),
    width: double.infinity,
    decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.all(Radius.circular(10))
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Tính cách",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyDescribePage(
                  myCharacters: x["characters"],
                  myHobbies: x["hobbies"],
                  myStyleDating: x["styles_dating"],
                )));
              },
              child: Text(
                "Cập nhật",
                style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10,),
        Wrap(
          spacing: 20,
          runSpacing: 10,
          children: [
            x["characters"][0] == "" ? Container(height: 0, width: 0,) : _lable(x["characters"][0]),
            x["characters"][1] == "" ? Container(height: 0, width: 0,) : _lable(x["characters"][1]),
            x["characters"][2] == "" ? Container(height: 0, width: 0,) : _lable(x["characters"][2]),
          ],
        )
      ],
    ),
  );

  _hobby(x) => Container(
    padding: EdgeInsets.all(16),
    width: double.infinity,
    decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.all(Radius.circular(10))
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Sở thích",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyDescribePage(
                  myCharacters: x["characters"],
                  myHobbies: x["hobbies"],
                  myStyleDating: x["styles_dating"],
                )));
              },
              child: Text(
                "Cập nhật",
                style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10,),
        Wrap(
          spacing: 20,
          runSpacing: 15,
          children: [
            x["hobbies"][0] == "" ? Container(height: 0, width: 0,) : _lable(x["hobbies"][0]),
            x["hobbies"][1] == "" ? Container(height: 0, width: 0,) : _lable(x["hobbies"][1]),
            x["hobbies"][2] == "" ? Container(height: 0, width: 0,) : _lable(x["hobbies"][2]),
          ],
        )
      ],
    ),
  );

  _dating(x) => Container(
    padding: EdgeInsets.all(16),
    width: double.infinity,
    decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.all(Radius.circular(10))
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Kiểu hẹn hò",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyDescribePage(
                  myCharacters: x["characters"],
                  myHobbies: x["hobbies"],
                  myStyleDating: x["styles_dating"],
                )));
              },
              child: Text(
                "Cập nhật",
                style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10,),
        Wrap(
          spacing: 20,
          runSpacing: 15,
          children: [
            x["styles_dating"][0] == "" ? Container(height: 0, width: 0,) : _lable(x["styles_dating"][0]),
            x["styles_dating"][1] == "" ? Container(height: 0, width: 0,) : _lable(x["styles_dating"][1]),
            x["styles_dating"][2] == "" ? Container(height: 0, width: 0,) : _lable(x["styles_dating"][2]),
          ],
        ),
      ],
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
}
