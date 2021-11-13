import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), (){
      if (FirebaseAuth.instance.currentUser!=null)
        Navigator.pushReplacementNamed(context, "tab_page");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _button("Đăng nhập bằng Email", "assets/icon/ic_mail.png", (){
              Navigator.pushNamed(context, "login_page");
            }),
            SizedBox(height: 10,),
            _button("Đăng nhập bằng Facebook", "assets/icon/ic_facebook.png", (){}),
            SizedBox(height: 10,),
            _button("Đăng nhập bằng Google", "assets/icon/ic_google.png", (){}),
          ],
        ),
      ),
    );
  }

  _button(String name, String image, funtion) => Container(
    height: 50,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(30)),
    ),
    child: FlatButton(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            width: 25,
            height: 25,
          ),
          SizedBox(width: 10,),
          Text(name, style: TextStyle(color: Colors.black),),
        ],
      ),
      onPressed: funtion,
    ),
  );
}
