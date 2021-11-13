import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyInfoPage extends StatefulWidget {
  const MyInfoPage({Key? key}) : super(key: key);

  @override
  _MyInfoPageState createState() => _MyInfoPageState();
}

class _MyInfoPageState extends State<MyInfoPage> {

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
  Widget build(BuildContext context) {

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
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _title("Hình ảnh"),
              SizedBox(height: 10,),
              _imageView(),
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
              _detail("Chiều cao", "175 cm", (){}),
              SizedBox(height: 10,),
              _detail("Đến từ", "Tiền Giang, Việt Nam", (){}),
              SizedBox(height: 10,),
              _detail("Sống tại", "TP.HCM, Việt Nam", (){}),
              SizedBox(height: 10,),
              _detail("Nghề nghiệp", "Sinh viên", (){}),
              SizedBox(height: 30,),
              _title("Sự thật thú vị"),
              SizedBox(height: 10,),
              _detail("16 nhóm tính cách", "ENTP", (){
                _showTop16CharacterDialog();
              }),
              SizedBox(height: 50,),
            ],
          ),
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

  _imageView() => Container(
    height: 200,
    child: ListView(
      scrollDirection: Axis.horizontal,
      children: [
        _image("https://firebasestorage.googleapis.com/v0/b/dating-app-689e4.appspot.com/o/145757914_1596428657212263_8128998582553759676_n.jpg?alt=media&token=c087b993-f8ce-4fea-be7f-6f220e7597a8"),
        _image("https://firebasestorage.googleapis.com/v0/b/dating-app-689e4.appspot.com/o/145757914_1596428657212263_8128998582553759676_n.jpg?alt=media&token=c087b993-f8ce-4fea-be7f-6f220e7597a8"),
        _image("https://firebasestorage.googleapis.com/v0/b/dating-app-689e4.appspot.com/o/145757914_1596428657212263_8128998582553759676_n.jpg?alt=media&token=c087b993-f8ce-4fea-be7f-6f220e7597a8"),
        _image("https://firebasestorage.googleapis.com/v0/b/dating-app-689e4.appspot.com/o/145757914_1596428657212263_8128998582553759676_n.jpg?alt=media&token=c087b993-f8ce-4fea-be7f-6f220e7597a8"),
        _image("https://firebasestorage.googleapis.com/v0/b/dating-app-689e4.appspot.com/o/145757914_1596428657212263_8128998582553759676_n.jpg?alt=media&token=c087b993-f8ce-4fea-be7f-6f220e7597a8"),
        _image("https://firebasestorage.googleapis.com/v0/b/dating-app-689e4.appspot.com/o/145757914_1596428657212263_8128998582553759676_n.jpg?alt=media&token=c087b993-f8ce-4fea-be7f-6f220e7597a8"),
        // _image("https://upload.wikimedia.org/wikipedia/commons/thumb/f/fe/Son_Tung_M-TP_1_%282017%29.png/1200px-Son_Tung_M-TP_1_%282017%29.png"),
        // _image("https://upload.wikimedia.org/wikipedia/commons/thumb/f/fe/Son_Tung_M-TP_1_%282017%29.png/1200px-Son_Tung_M-TP_1_%282017%29.png"),
        // _image("https://upload.wikimedia.org/wikipedia/commons/thumb/f/fe/Son_Tung_M-TP_1_%282017%29.png/1200px-Son_Tung_M-TP_1_%282017%29.png"),
        // _image("https://upload.wikimedia.org/wikipedia/commons/thumb/f/fe/Son_Tung_M-TP_1_%282017%29.png/1200px-Son_Tung_M-TP_1_%282017%29.png"),
        // _image("https://upload.wikimedia.org/wikipedia/commons/thumb/f/fe/Son_Tung_M-TP_1_%282017%29.png/1200px-Son_Tung_M-TP_1_%282017%29.png"),
        // _image("https://upload.wikimedia.org/wikipedia/commons/thumb/f/fe/Son_Tung_M-TP_1_%282017%29.png/1200px-Son_Tung_M-TP_1_%282017%29.png"),
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
                _showCharacterDialog();
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
                _showHobbyDialog();
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
                _showDatingDialog();
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
            _lable("🏍 Đi du lịch"),
            _lable("⚽ Chơi thể thao"),
            _lable("🎞 Xem phim"),
          ],
        ),
      ],
    ),
  );

  _showCharacterDialog() => showModalBottomSheet(
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
          children: [
            Text(
              "Tính cách của bạn như thế nào?",
              style: TextStyle(
                fontSize: 20,
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 10,),
            Text(
              "Chọn 1-3 mục để miêu tả về bạn",
              style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500
              ),
            ),
            SizedBox(height: 30,),
            Wrap(
              spacing: 20,
              runSpacing: 15,
              children: [
                _lable("😎 Phiêu lưu"),
                _lable("😊 Dễ gần"),
                _lable("🧐 Lý trí"),
                _lable("😇 Tốt bụng"),
                _lable("🙂 Khiêm tốn"),
                _lable("☺ Nhạy cảm"),
                _lable("😉 Tự tin"),
                _lable("🤠 Tự lập"),
                _lable("😐 Can đảm"),
                _lable("😊 Thận trọng"),
                _lable("😆 Thực tế"),
                _lable("😂 Cởi mở"),
                _lable("🙃 Hướng nội"),
                _lable("🤣 Hướng ngoại"),
                _lable("🤭 Thật thà"),
                _lable("😬 Chung thủy"),
                _lable("😄 Vui vẻ"),
              ],
            ),
            SizedBox(height: 30,),
            _buttonSave(
                (){

                }
            ),
          ],
        ),
      )
  );

  _showHobbyDialog() => showModalBottomSheet(
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
          children: [
            Text(
              "Sở thích của bạn như thế nào?",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 10,),
            Text(
              "Chọn 1-3 mục để miêu tả về bạn",
              style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500
              ),
            ),
            SizedBox(height: 30,),
            Wrap(
              spacing: 20,
              runSpacing: 15,
              children: [
                _lable("🛍 Mua sắm"),
                _lable("🎞 Phim ảnh"),
                _lable("✈ Du lịch"),
                _lable("⚽ Thể thao"),
                _lable("🤸‍♂ Yoga"),
                _lable("💪 Gym"),
                _lable("🎖 Tham gia tình nguyện"),
                _lable("📚 Đọc sách"),
                _lable("🍕 Ăn uống"),
                _lable("🎵 Âm nhạc"),
                _lable("🎭 Ngôn ngữ"),
                _lable("📸 Chụp ảnh"),
                _lable("🎮 Game online"),
                _lable("🖼 Nghệ thuật"),
                _lable("🐈 Động vật"),
              ],
            ),
            SizedBox(height: 30,),
            _buttonSave(
                    (){

                }
            ),
          ],
        ),
      )
  );

  _showDatingDialog() => showModalBottomSheet(
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
          children: [
            Text(
              "Kiểu hẹn hò của bạn như thế nào?",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 10,),
            Text(
              "Chọn 1-3 mục để miêu tả về bạn",
              style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500
              ),
            ),
            SizedBox(height: 30,),
            Wrap(
              spacing: 20,
              runSpacing: 15,
              children: [
                _lable("🎏 Đi picnic"),
                _lable("🎮 Chơi game"),
                _lable("🌳 Đi dạo"),
                _lable("🎶 Nghe nhạc"),
                _lable("🏍 Đi du lịch"),
                _lable("⚽ Chơi thể thao"),
                _lable("🎞 Xem phim"),
                _lable("👨‍❤️‍👨 Chăm nhắn tin"),
                _lable("🎎 Hứng đi đâu đó"),
                _lable("🥗 Nấu ăn chung"),
                _lable("🥘 Đi ăn"),
                _lable("🥂 Đi bar"),
                _lable("🥤 Đi cà phê"),
                _lable("👨🏾‍🤝‍👨🏼 Đi cùng nhóm bạn"),
              ],
            ),
            SizedBox(height: 30,),
            _buttonSave(
                    (){

                }
            ),
          ],
        ),
      )
  );

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
                "https://www.topcv.vn/images/mbti/web/istj.png",
                (){_showCharacterDetailDialog(title_INTJ,strong_INTJ,weak_INTJ,descr_INTJ,inlove_INTJ,dating_INTJ);}
              ),
              _characterBox(
                  "INTJ",
                  "https://www.topcv.vn/images/mbti/web/istj.png",
                      (){_showCharacterDetailDialog(title_INTJ,strong_INTJ,weak_INTJ,descr_INTJ,inlove_INTJ,dating_INTJ);}
              ),
              _characterBox(
                  "INTJ",
                  "https://www.topcv.vn/images/mbti/web/istj.png",
                      (){_showCharacterDetailDialog(title_INTJ,strong_INTJ,weak_INTJ,descr_INTJ,inlove_INTJ,dating_INTJ);}
              ),
              _characterBox(
                  "INTJ",
                  "https://www.topcv.vn/images/mbti/web/istj.png",
                      (){_showCharacterDetailDialog(title_INTJ,strong_INTJ,weak_INTJ,descr_INTJ,inlove_INTJ,dating_INTJ);}
              ),
              _characterBox(
                  "INTJ",
                  "https://www.topcv.vn/images/mbti/web/istj.png",
                      (){_showCharacterDetailDialog(title_INTJ,strong_INTJ,weak_INTJ,descr_INTJ,inlove_INTJ,dating_INTJ);}
              ),
              _characterBox(
                  "INTJ",
                  "https://www.topcv.vn/images/mbti/web/istj.png",
                      (){_showCharacterDetailDialog(title_INTJ,strong_INTJ,weak_INTJ,descr_INTJ,inlove_INTJ,dating_INTJ);}
              ),
              _characterBox(
                  "INTJ",
                  "https://www.topcv.vn/images/mbti/web/istj.png",
                      (){_showCharacterDetailDialog(title_INTJ,strong_INTJ,weak_INTJ,descr_INTJ,inlove_INTJ,dating_INTJ);}
              ),
              _characterBox(
                  "INTJ",
                  "https://www.topcv.vn/images/mbti/web/istj.png",
                      (){_showCharacterDetailDialog(title_INTJ,strong_INTJ,weak_INTJ,descr_INTJ,inlove_INTJ,dating_INTJ);}
              ),
              _characterBox(
                  "INTJ",
                  "https://www.topcv.vn/images/mbti/web/istj.png",
                      (){_showCharacterDetailDialog(title_INTJ,strong_INTJ,weak_INTJ,descr_INTJ,inlove_INTJ,dating_INTJ);}
              ),
              _characterBox(
                  "INTJ",
                  "https://www.topcv.vn/images/mbti/web/istj.png",
                      (){_showCharacterDetailDialog(title_INTJ,strong_INTJ,weak_INTJ,descr_INTJ,inlove_INTJ,dating_INTJ);}
              ),
              _characterBox(
                  "INTJ",
                  "https://www.topcv.vn/images/mbti/web/istj.png",
                      (){_showCharacterDetailDialog(title_INTJ,strong_INTJ,weak_INTJ,descr_INTJ,inlove_INTJ,dating_INTJ);}
              ),
              _characterBox(
                  "INTJ",
                  "https://www.topcv.vn/images/mbti/web/istj.png",
                      (){_showCharacterDetailDialog(title_INTJ,strong_INTJ,weak_INTJ,descr_INTJ,inlove_INTJ,dating_INTJ);}
              ),
              _characterBox(
                  "INTJ",
                  "https://www.topcv.vn/images/mbti/web/istj.png",
                      (){_showCharacterDetailDialog(title_INTJ,strong_INTJ,weak_INTJ,descr_INTJ,inlove_INTJ,dating_INTJ);}
              ),
              _characterBox(
                  "INTJ",
                  "https://www.topcv.vn/images/mbti/web/istj.png",
                      (){_showCharacterDetailDialog(title_INTJ,strong_INTJ,weak_INTJ,descr_INTJ,inlove_INTJ,dating_INTJ);}
              ),
              _characterBox(
                  "INTJ",
                  "https://www.topcv.vn/images/mbti/web/istj.png",
                      (){_showCharacterDetailDialog(title_INTJ,strong_INTJ,weak_INTJ,descr_INTJ,inlove_INTJ,dating_INTJ);}
              ),
              _characterBox(
                  "INTJ",
                  "https://www.topcv.vn/images/mbti/web/istj.png",
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

  _lableChoice(String text, bool isCheck) => Container(
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: isCheck == false? Colors.grey.withOpacity(0.2) : Colors.deepPurple.withOpacity(0.3)
    ),
    child: GestureDetector(
      onTap: () async {
        setState(() {
          isCheck = true;
        });
      },
      child: Text(
        text,
        style: TextStyle(
            fontSize: 15
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
                    image: NetworkImage(url),
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
}
