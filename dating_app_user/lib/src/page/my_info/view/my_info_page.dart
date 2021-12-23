import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app_user/src/data/characters_data.dart';
import 'package:dating_app_user/src/page/my_images/my_images_page.dart';
import 'package:dating_app_user/src/page/my_info/view/my_characters_page.dart';
import 'package:dating_app_user/src/page/my_info/view/my_describe_page.dart';
import 'package:dating_app_user/src/widgets/buttons/main_button.dart';
import 'package:dating_app_user/src/widgets/buttons/tag_button.dart';
import 'package:dating_app_user/src/widgets/dialogs/loading_dialog.dart';
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

  bool _isEditBio = false;

  List<bool> _listCharacterBool = [];

  bool a = false;

  TextEditingController _bioController = new TextEditingController();

  int _numOfCharacter = 0;

  final String title_INTJ = "INTJ - Người quân sư";
  final String strong_INTJ = "Có lý trí, hiểu biết rộng, độc lập, kiên định, tò mò và linh hoạt.";
  final String weak_INTJ = "Kiêu ngạo, xem thường cảm xúc người khác, hay chỉ trích, hơi hung năng, lãng mạn";
  final String descr_INTJ = "INTJ là người có các đặc điểm tính cách hướng nội, đầy trực giác, có suy nghĩ và đánh giá tốt."
      "Những nhà chiến thuật chu đáo này thích chú trọng các chi tiết của cuộc sống, áp dụng sự sáng tạo, hợp lý vào mọi việc họ làm. "
      "Thế giới nội tâm thường là một thế giới riêng tư và phức tạp.";
  final String inlove_INTJ = "INTJ quan tâm đến chiều sâu và trí tuệ, và quan trọng sự trung thực, cởi mở trong giao tiếp. "
      "Đối với họ, một mối quan hệ không dự trên những giá trị này sẽ khó có thể lâu dài.";
  final String dating_INTJ = "INTP, INFJ, INFP";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    characters_data.forEach((element) {
      _listCharacterBool.add(false);
    });
  }

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
          _hobby(x["hobbies"]),
          SizedBox(height: 10,),
         _dating(x["styles_dating"]),
          SizedBox(height: 30,),
          _title("Thông tin cơ bản"),
          SizedBox(height: 10,),
          _detail("Chiều cao", x["height"] + " cm", (){}),
          SizedBox(height: 10,),
          //_detail("Đến từ", "Tiền Giang, Việt Nam", (){}),
          SizedBox(height: 10,),
          //_detail("Sống tại", "TP.HCM, Việt Nam", (){}),
          SizedBox(height: 10,),
          //_detail("Nghề nghiệp", "Sinh viên", (){}),
          SizedBox(height: 30,),
          //_title("Sự thật thú vị"),
          SizedBox(height: 10,),
          // _detail("16 nhóm tính cách", "ENTP", (){
          //   _showTop16CharacterDialog();
          // }),
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

  _bio(String bio) => GestureDetector(
    onTap: () {
      setState(() {
        _isEditBio = true;
      });
    },
    child: Container(
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
              _isEditBio == true ? GestureDetector(
                onTap: (){
                  setState(() {
                    _updateBio(_bioController.text.trim());
                    _isEditBio = false;
                  });
                },
                child: Text(
                  "Cập nhật",
                  style: TextStyle(
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ) : Container(),
            ],
          ),
          SizedBox(height: 10,),
          TextFormField(
            onSaved: (value) => {
              _bioController.text = value!,
            },
            readOnly: _isEditBio == true? false : true,
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
            x[0] == "" ? Container(height: 0, width: 0,) : _lable(x[0]),
            x[1] == "" ? Container(height: 0, width: 0,) : _lable(x[1]),
            x[2] == "" ? Container(height: 0, width: 0,) : _lable(x[2]),
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
            x[0] == "" ? Container(height: 0, width: 0,) : _lable(x[0]),
            x[1] == "" ? Container(height: 0, width: 0,) : _lable(x[1]),
            x[2] == "" ? Container(height: 0, width: 0,) : _lable(x[2]),
          ],
        ),
      ],
    ),
  );

  _showBioDialog(String bio) => showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      context: context,
      builder: (context)=>SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Miêu tả về bản thân bạn?",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 10,),
              Text(
                "Viết ngắn ngọn để mọi người hiểu rõ bạn hơn",
                style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500
                ),
              ),
              SizedBox(height: 100,),
              TextFormField(
                maxLines: 5,
                minLines: 3,
                controller: _bioController,
                decoration: InputDecoration(
                  hintText: "Nhập họ và tên",
                  hintStyle: TextStyle(
                      color: Colors.grey.withOpacity(0.5),
                      fontWeight: FontWeight.w500,
                      fontSize: 15
                  ),
                  border: InputBorder.none
                ),
                style: TextStyle(
                  //color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 15
                ),
              ),
              SizedBox(height: 100,),
              MainButton(name: "Lưu", onpressed: (){

              })
            ],
          ),
        ),
      )
  );

  // _showCharacterDialog() => showModalBottomSheet(
  //   isScrollControlled: true,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.only(
  //         topLeft: Radius.circular(24),
  //         topRight: Radius.circular(24),
  //       ),
  //     ),
  //     context: context,
  //     builder: (context)=>Container(
  //       padding: EdgeInsets.all(16),
  //       child: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           Text(
  //             "Tính cách của bạn như thế nào?",
  //             style: TextStyle(
  //               fontSize: 20,
  //                 color: Colors.deepPurple,
  //                 fontWeight: FontWeight.bold
  //             ),
  //           ),
  //           SizedBox(height: 10,),
  //           Text(
  //             "Chọn 1-3 mục để miêu tả về bạn",
  //             style: TextStyle(
  //                 fontSize: 13,
  //                 color: Colors.grey,
  //                 fontWeight: FontWeight.w500
  //             ),
  //           ),
  //           SizedBox(height: 30,),
  //           Wrap(
  //             spacing: 20,
  //             runSpacing: 15,
  //             children: [
  //               // TagButton((){
  //               //   setState(() {
  //               //     a = !a;
  //               //   });
  //               // }, a,"😎 Phiêu lưu"),
  //               // _lable("😊 Dễ gần"),
  //               // _lable("🧐 Lý trí"),
  //               // _lable("😇 Tốt bụng"),
  //               // _lable("🙂 Khiêm tốn"),
  //               // _lable("☺ Nhạy cảm"),
  //               // _lable("😉 Tự tin"),
  //               // _lable("🤠 Tự lập"),
  //               // _lable("😐 Can đảm"),
  //               // _lable("😊 Thận trọng"),
  //               // _lable("😆 Thực tế"),
  //               // _lable("😂 Cởi mở"),
  //               // _lable("🙃 Hướng nội"),
  //               // _lable("🤣 Hướng ngoại"),
  //               // _lable("🤭 Thật thà"),
  //               // _lable("😬 Chung thủy"),
  //               // _lable("😄 Vui vẻ"),
  //               for (var item in characters_data)
  //                 _lableChoice(item,a,(){
  //                   setState(() {
  //                     a = !a;
  //                   });
  //                 }),
  //             ],
  //           ),
  //           SizedBox(height: 30,),
  //           _buttonSave(
  //               (){
  //
  //               }
  //           ),
  //         ],
  //       ),
  //     )
  // );

  // _showHobbyDialog() => showModalBottomSheet(
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.only(
  //         topLeft: Radius.circular(24),
  //         topRight: Radius.circular(24),
  //       ),
  //     ),
  //     context: context,
  //     builder: (context)=>Container(
  //       padding: EdgeInsets.all(16),
  //       child: Column(
  //         children: [
  //           Text(
  //             "Sở thích của bạn như thế nào?",
  //             style: TextStyle(
  //                 fontSize: 20,
  //                 color: Colors.deepPurple,
  //                 fontWeight: FontWeight.bold
  //             ),
  //           ),
  //           SizedBox(height: 10,),
  //           Text(
  //             "Chọn 1-3 mục để miêu tả về bạn",
  //             style: TextStyle(
  //                 fontSize: 13,
  //                 color: Colors.grey,
  //                 fontWeight: FontWeight.w500
  //             ),
  //           ),
  //           SizedBox(height: 30,),
  //           Wrap(
  //             spacing: 20,
  //             runSpacing: 15,
  //             children: [
  //               _lable("🛍 Mua sắm"),
  //               _lable("🎞 Phim ảnh"),
  //               _lable("✈ Du lịch"),
  //               _lable("⚽ Thể thao"),
  //               _lable("🤸‍♂ Yoga"),
  //               _lable("💪 Gym"),
  //               _lable("🎖 Tham gia tình nguyện"),
  //               _lable("📚 Đọc sách"),
  //               _lable("🍕 Ăn uống"),
  //               _lable("🎵 Âm nhạc"),
  //               _lable("🎭 Ngôn ngữ"),
  //               _lable("📸 Chụp ảnh"),
  //               _lable("🎮 Game online"),
  //               _lable("🖼 Nghệ thuật"),
  //               _lable("🐈 Động vật"),
  //             ],
  //           ),
  //           SizedBox(height: 30,),
  //           _buttonSave(
  //                   (){
  //
  //               }
  //           ),
  //         ],
  //       ),
  //     )
  // );

  // _showDatingDialog() => showModalBottomSheet(
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.only(
  //         topLeft: Radius.circular(24),
  //         topRight: Radius.circular(24),
  //       ),
  //     ),
  //     context: context,
  //     builder: (context)=>Container(
  //       padding: EdgeInsets.all(16),
  //       child: Column(
  //         children: [
  //           Text(
  //             "Kiểu hẹn hò của bạn như thế nào?",
  //             style: TextStyle(
  //                 fontSize: 20,
  //                 color: Colors.deepPurple,
  //                 fontWeight: FontWeight.bold
  //             ),
  //           ),
  //           SizedBox(height: 10,),
  //           Text(
  //             "Chọn 1-3 mục để miêu tả về bạn",
  //             style: TextStyle(
  //                 fontSize: 13,
  //                 color: Colors.grey,
  //                 fontWeight: FontWeight.w500
  //             ),
  //           ),
  //           SizedBox(height: 30,),
  //           Wrap(
  //             spacing: 20,
  //             runSpacing: 15,
  //             children: [
  //               _lable("🎏 Đi picnic"),
  //               _lable("🎮 Chơi game"),
  //               _lable("🌳 Đi dạo"),
  //               _lable("🎶 Nghe nhạc"),
  //               _lable("🏍 Đi du lịch"),
  //               _lable("⚽ Chơi thể thao"),
  //               _lable("🎞 Xem phim"),
  //               _lable("👨‍❤️‍👨 Chăm nhắn tin"),
  //               _lable("🎎 Hứng đi đâu đó"),
  //               _lable("🥗 Nấu ăn chung"),
  //               _lable("🥘 Đi ăn"),
  //               _lable("🥂 Đi bar"),
  //               _lable("🥤 Đi cà phê"),
  //               _lable("👨🏾‍🤝‍👨🏼 Đi cùng nhóm bạn"),
  //             ],
  //           ),
  //           SizedBox(height: 30,),
  //           _buttonSave(
  //                   (){
  //
  //               }
  //           ),
  //         ],
  //       ),
  //     )
  // );

  _showTop16CharacterDialog() => showModalBottomSheet(
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
    ),
    context: context,
    builder: (context)=>Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Tính cách thật gì của bạn là gì?",
            style: TextStyle(
                fontSize: 20,
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height: 10,),
          Text(
            "Khám phá nhóm tính cách của bạn và người ấy dựa trên trắc nghiệm 16 nhóm tính cách",
            style: TextStyle(
                fontSize: 13,
                color: Colors.grey,
                fontWeight: FontWeight.w500
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 30,),
          Wrap(
            spacing: 20,
            runSpacing: 15,
            children: [
              _characterBox(
                "INTJ",
                "assets/image/1.jpg",
                (){_showCharacterDetailDialog(title_INTJ,strong_INTJ,weak_INTJ,descr_INTJ,inlove_INTJ,dating_INTJ);}
              ),
              _characterBox(
                  "ENTJ",
                  "assets/image/2.jpg",
                      (){_showCharacterDetailDialog(title_INTJ,strong_INTJ,weak_INTJ,descr_INTJ,inlove_INTJ,dating_INTJ);}
              ),
              _characterBox(
                  "INTP",
                  "assets/image/3.jpg",
                      (){_showCharacterDetailDialog(title_INTJ,strong_INTJ,weak_INTJ,descr_INTJ,inlove_INTJ,dating_INTJ);}
              ),
              _characterBox(
                  "ENTP",
                  "assets/image/4.jpg",
                      (){_showCharacterDetailDialog(title_INTJ,strong_INTJ,weak_INTJ,descr_INTJ,inlove_INTJ,dating_INTJ);}
              ),
              _characterBox(
                  "INFJ",
                  "assets/image/5.jpg",
                      (){_showCharacterDetailDialog(title_INTJ,strong_INTJ,weak_INTJ,descr_INTJ,inlove_INTJ,dating_INTJ);}
              ),
              _characterBox(
                  "ENFJ",
                  "assets/image/6.jpg",
                      (){_showCharacterDetailDialog(title_INTJ,strong_INTJ,weak_INTJ,descr_INTJ,inlove_INTJ,dating_INTJ);}
              ),
              _characterBox(
                  "INFP",
                  "assets/image/7.jpg",
                      (){_showCharacterDetailDialog(title_INTJ,strong_INTJ,weak_INTJ,descr_INTJ,inlove_INTJ,dating_INTJ);}
              ),
              _characterBox(
                  "ENFP",
                  "assets/image/8.jpg",
                      (){_showCharacterDetailDialog(title_INTJ,strong_INTJ,weak_INTJ,descr_INTJ,inlove_INTJ,dating_INTJ);}
              ),
              _characterBox(
                  "ISTJ",
                  "assets/image/9.jpg",
                      (){_showCharacterDetailDialog(title_INTJ,strong_INTJ,weak_INTJ,descr_INTJ,inlove_INTJ,dating_INTJ);}
              ),
              _characterBox(
                  "ESTJ",
                  "assets/image/10.jpg",
                      (){_showCharacterDetailDialog(title_INTJ,strong_INTJ,weak_INTJ,descr_INTJ,inlove_INTJ,dating_INTJ);}
              ),
              _characterBox(
                  "ISFJ",
                  "assets/image/11.jpg",
                      (){_showCharacterDetailDialog(title_INTJ,strong_INTJ,weak_INTJ,descr_INTJ,inlove_INTJ,dating_INTJ);}
              ),
              _characterBox(
                  "ESFJ",
                  "assets/image/12.jpg",
                      (){_showCharacterDetailDialog(title_INTJ,strong_INTJ,weak_INTJ,descr_INTJ,inlove_INTJ,dating_INTJ);}
              ),
              _characterBox(
                  "ISTP",
                  "assets/image/13.jpg",
                      (){_showCharacterDetailDialog(title_INTJ,strong_INTJ,weak_INTJ,descr_INTJ,inlove_INTJ,dating_INTJ);}
              ),
              _characterBox(
                  "ESTP",
                  "assets/image/14.jpg",
                      (){_showCharacterDetailDialog(title_INTJ,strong_INTJ,weak_INTJ,descr_INTJ,inlove_INTJ,dating_INTJ);}
              ),
              _characterBox(
                  "ISFP",
                  "assets/image/5.jpg",
                      (){_showCharacterDetailDialog(title_INTJ,strong_INTJ,weak_INTJ,descr_INTJ,inlove_INTJ,dating_INTJ);}
              ),
              _characterBox(
                  "ESFP",
                  "assets/image/1.jpg",
                      (){_showCharacterDetailDialog(title_INTJ,strong_INTJ,weak_INTJ,descr_INTJ,inlove_INTJ,dating_INTJ);}
              ),
            ],
          ),
          SizedBox(height: 30,),
          Text(
            "Không biết mình thuộc nhóm tính cách nào?",
            style: TextStyle(
                color: Colors.deepPurple,
                fontWeight: FontWeight.w500
            ),
          ),
        ],
      ),
    )
  );

  _showCharacterDetailDialog(String title, String strong, String weak, String descr, String inlove, String dating) => showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      context: context,
      builder: (context)=>Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10,),

            Container(
              alignment: Alignment.center,
              child: Text(
                title,
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),

            SizedBox(height: 10,),
            Container(
              alignment: Alignment.center,
              child: Wrap(
                spacing: 20,
                runSpacing: 15,
                children: [
                  _lable("🤭 Thật thà"),
                  _lable("😬 Chung thủy"),
                  _lable("😄 Vui vẻ"),
                ],
              ),
            ),

            SizedBox(height: 10,),
            Text(
              "Điểm mạnh",
              style: TextStyle(
                  color: Colors.pink,
                  fontWeight: FontWeight.bold
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10,),
            Text(
              strong,
              style: TextStyle(
                  height: 1.5
              ),
              textAlign: TextAlign.justify,
            ),

            SizedBox(height: 10,),
            Text(
              "Điểm yếu",
              style: TextStyle(
                  color: Colors.pink,
                  fontWeight: FontWeight.bold
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10,),
            Text(
              weak,
              style: TextStyle(
                  height: 1.5
              ),
              textAlign: TextAlign.justify,
            ),

            SizedBox(height: 10,),
            Text(
              "Miêu tả",
              style: TextStyle(
                  color: Colors.pink,
                  fontWeight: FontWeight.bold
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10,),
            Text(
              descr,
              style: TextStyle(
                height: 1.5
              ),
              textAlign: TextAlign.justify,
            ),

            SizedBox(height: 10,),
            Text(
              "Khi trong mối quan hệ",
              style: TextStyle(
                  color: Colors.pink,
                  fontWeight: FontWeight.bold
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10,),
            Text(
              inlove,
              style: TextStyle(
                  height: 1.5
              ),
              textAlign: TextAlign.justify,
            ),

            SizedBox(height: 10,),
            Text(
              "Phù hợp với",
              style: TextStyle(
                  color: Colors.pink,
                  fontWeight: FontWeight.bold
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10,),
            Text(
              dating,
              style: TextStyle(
                  height: 1.5
              ),
              textAlign: TextAlign.justify,
            ),

            SizedBox(height: 30,),
            Container(
              alignment: Alignment.center,
              child: _buttonSave((){}),
            ),

            SizedBox(height: 30,)
          ],
        ),
      )
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

  _lableChoice(String text, bool isActive, func) => Container(
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      color: isActive ? Colors.deepPurple : Colors.grey.withOpacity(0.2),
    ),
    child: GestureDetector(
      onTap: func,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 15,
          color: isActive ? Colors.white : Colors.black,
        ),
      ),
    ),
  );

  _buttonSave(Function function) => Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      color: Colors.deepPurple
    ),
    child: FlatButton(
      onPressed: function(),
      child: Text("Lưu", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
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

  _characterBox(String name, String url, funtion) => Container(
    child: GestureDetector(
      onTap: funtion,
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: AssetImage(url),
                    fit: BoxFit.cover)),
          ),
          SizedBox(height: 5,),
          Text(
            name,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500
            ),
          ),
        ],
      ),
    ),
  );

  void _updateBio(String bio) {

    LoadingDialog.showLoadingDialog(context, "Đang lưu...");

    FirebaseFirestore.instance.collection("USER").doc(FirebaseAuth.instance.currentUser!.uid).update({
      "bio": bio,
    }).then((value) => {
      LoadingDialog.hideLoadingDialog(context),
    });
  }
}

Widget TagButton(func, bool isActive, String labelText) {
  return ButtonTheme(
    minWidth: 80,
    height: 30,
    child: RaisedButton(
      onPressed: func,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        //side: BorderSide(color: orange)
      ),
      color: isActive ? Colors.deepPurple : Colors.grey.withOpacity(0.2),
      elevation: 0.5,
      child: Text(
        labelText,
        style: TextStyle(
            fontSize: 15
        ),
      ),
    ),
  );
}