import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({Key? key}) : super(key: key);

  @override
  _MyAccountPageState createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
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
              //avatar
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage("https://firebasestorage.googleapis.com/v0/b/dating-app-689e4.appspot.com/o/145757914_1596428657212263_8128998582553759676_n.jpg?alt=media&token=c087b993-f8ce-4fea-be7f-6f220e7597a8"),
                      fit: BoxFit.cover)),
              ),

              //Tên
              SizedBox(height: 20,),
              Text(
                "Lê Hoàng Phúc, 19",
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
                  "Điều bạn làm hôm nay sẽ hay đổi những gì bạn có trong tương lai.",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    height: 1.3
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              //Nút bấm
              SizedBox(height: 15,),
              Container(
                padding: EdgeInsets.only(left: 24, right: 24),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        child: FlatButton(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.mode_edit, color: Colors.deepPurple,),
                              SizedBox(width: 5,),
                              Text("Chỉnh sửa thông tin", style: TextStyle(color: Colors.deepPurple),),
                            ],
                          ),
                          onPressed: (){
                            Navigator.pushNamed(context, "my_info_page");
                          },
                        ),
                      ),
                    ),
                    //SizedBox(width: 10,),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.withOpacity(0.2),
                      ),
                      child: FlatButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "setting_page");
                        },
                        child: Icon(Icons.settings, color: Colors.deepPurple,),
                      ),
                    ),
                  ],
                ),
              ),

              //Số người kết nối
              SizedBox(height: 20,),
              Container(
                width: double.infinity,
                margin: EdgeInsets.all(16),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.grey.withOpacity(0.1)
                ),
                child: Column(
                  children: [
                    Text(
                      "Số người đã kết nối:",
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      "6",
                      style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(height: 20,),
                    Text(
                      "Kết nối nhiều người giúp chúng ta mở rộng qan hệ hơn và từ đó có thể tìm được nửa kia của mình.",
                      style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400,),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              //Điểm tích lũy
              Container(
                width: double.infinity,
                margin: EdgeInsets.all(16),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.grey.withOpacity(0.1)
                ),
                child: Column(
                  children: [
                    Text(
                      "Điểm Vima của bạn là:",
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      "500",
                      style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(height: 20,),
                    Text(
                      "Điểm tích lũy càng nhiều thì càng nhận được nhiều giá trị cao hơn cũng như đặc quyền tốt hơn.",
                      style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400,),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              //Mã giới thiệu
              Container(
                width: double.infinity,
                margin: EdgeInsets.all(16),
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Mã giới thiệu",
                      style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 15,),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.1),
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Nhập tại đây", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.deepPurple,
                          ),
                          child: FlatButton(
                            onPressed: () {

                            },
                            child: Icon(Icons.arrow_forward, color: Colors.white,),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),

              //Mã giới thiệu của bạn
              Container(
                width: double.infinity,
                margin: EdgeInsets.all(16),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.deepPurple.withOpacity(1)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Mã giới thiệu của bạn:",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "KJ7T5M",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        SizedBox(width: 10,),
                        Icon(Icons.copy, color: Colors.white,)
                      ],
                    ),
                    SizedBox(height: 20,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
