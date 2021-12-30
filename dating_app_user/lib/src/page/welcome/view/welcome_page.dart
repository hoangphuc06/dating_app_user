
import 'dart:ui';
import 'package:dating_app_user/src/page/welcome/home.dart';
import 'package:dating_app_user/src/page/welcome/view/test.dart';
import 'package:dating_app_user/src/widgets/buttons/main_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 28, vertical: 28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            _top(),
            _bottom(),
          ],
        ),
      ),
    );
  }

  _top() => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
          padding: EdgeInsets.symmetric(horizontal: 28, vertical: 28 * 2),
          alignment: Alignment.center,
          child: Image.asset(
            'assets/image/welcome.png',
          )
      ),

      Text(
        "Cộng đồng iLove",
        style: TextStyle(
            color: Color(0xFF363636),
            fontSize: 18.0
        ),
      ),

      SizedBox(height: 10),

      Text(
        "Nơi hoàn hảo để tìm kiếm người yêu tương lai của bạn",
        style: TextStyle(
            color: Color(0xFF1C1C1C),
            fontSize: 36.0,
            fontWeight: FontWeight.bold
        ),
      ),

      SizedBox(height: 20,),

      // MainButton(
      //   name: "Bắt đầu",
      //   onpressed: getStarted,
      // ),

    ],
  );

  _bottom() => Column(
    children: [
      MainButton(
        name: "Bắt đầu",
        onpressed: getStarted,
      ),
      SizedBox(height: 20,),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Chưa có tài khoản? ",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, "sign_up_page");
            },
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                "Đăng ký",
                style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
        ],
      ),
    ],
  );

  void getStarted() {
    //Navigator.push(context, MaterialPageRoute(builder: (context)=>Test()));
     Navigator.pushNamed(context, "login_page");
    // if (FirebaseAuth.instance.currentUser!=null)
    //   Navigator.pushReplacementNamed(context, "tab_page");
    // else
    //   Navigator.pushNamed(context, "login_page");
  }

}
