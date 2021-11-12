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
                      image: NetworkImage("https://upload.wikimedia.org/wikipedia/commons/thumb/f/fe/Son_Tung_M-TP_1_%282017%29.png/1200px-Son_Tung_M-TP_1_%282017%29.png"),
                      fit: BoxFit.cover)),
              ),

              //Tên
              SizedBox(height: 20,),
              Text(
                "Lê Hoàng Phúc",
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

              //Điểm tích lũy
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
