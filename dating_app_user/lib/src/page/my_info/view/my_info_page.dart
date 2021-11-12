import 'package:flutter/material.dart';

class MyInfoPage extends StatefulWidget {
  const MyInfoPage({Key? key}) : super(key: key);

  @override
  _MyInfoPageState createState() => _MyInfoPageState();
}

class _MyInfoPageState extends State<MyInfoPage> {
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
              _detail("Đến từ", "TP.HCM, Việt Nam", (){}),
              SizedBox(height: 10,),
              _detail("Sống tại", "TP.HCM, Việt Nam", (){}),
              SizedBox(height: 10,),
              _detail("Nghề nghiệp", "Sinh viên", (){}),
              SizedBox(height: 30,),
              _title("Sự thật thú vị"),
              SizedBox(height: 10,),
              _detail("16 nhóm tính cách", "ENTP", (){}),
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
        ),
        Text(
          "Mình thích đi dạo vào mỗi tối cuối tuần 🤣.",
          style: TextStyle(
            color: Colors.deepPurple,
            fontWeight: FontWeight.w500
          ),
        ),
      ],
    ),
  );

  _character() => Container(
    padding: EdgeInsets.all(16),
    height: 100,
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
                    fontWeight: FontWeight.w500
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  _hobby() => Container(
    padding: EdgeInsets.all(16),
    height: 100,
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
                    fontWeight: FontWeight.w500
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  _dating() => Container(
    padding: EdgeInsets.all(16),
    height: 100,
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
                    fontWeight: FontWeight.w500
                ),
              ),
            ),
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
                _lable("🎶 Đighe nhạc"),
                _lable("🏍 Đi du lịch"),
                _lable("⚽ Chơi thể thao"),
                _lable("🎞 Xem phim"),
                _lable("👨‍❤️‍👨 Chăm nhắn tin"),
                _lable("🎎 Hứng đi đâu đó"),
                _lable("🥗 Nấu ăn chung"),
                _lable("🥘 Đi ăn"),
                _lable("🥂 Đi uống rượu"),
                _lable("🌳 Đi dạo"),
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
}
