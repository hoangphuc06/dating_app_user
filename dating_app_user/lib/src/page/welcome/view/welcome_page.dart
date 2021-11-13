import 'dart:async';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

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
      else
        Navigator.pushReplacementNamed(context, "login_page");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.deepPurple.withOpacity(0.9),
                    Colors.deepPurple.withOpacity(0.5),
                    Colors.deepPurple.withOpacity(0.4),
                    Colors.pink.withOpacity(0.3),
                    Colors.pink.withOpacity(0.5),
                  ],
                  end: Alignment.bottomRight,
                  begin: Alignment.topLeft
                )
              ),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'VI',
                        style: GoogleFonts.amaticaSc(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold,
                          fontSize: 80,
                        ),
                      ),
                      Text(
                        'MA',
                        style: GoogleFonts.amaticaSc(
                          color: Colors.pink,
                          fontWeight: FontWeight.bold,
                          fontSize: 80,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(30),
              alignment: Alignment.bottomCenter,
              child: Text(
                "Phiên bản 1.0",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w100
                ),
              ),
            ),
          ],
        ));
  }

}
