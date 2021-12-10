import 'dart:async';
import 'dart:ui';

import 'package:dating_app_user/responsive.dart';
import 'package:dating_app_user/src/widgets/buttons/main_button.dart';
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
  

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 28),
            child: Column(
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
                  "Let's get closer",
                  style: TextStyle(
                      color: Color(0xFF363636),
                      fontSize: 18.0
                  ),
                ),

                SizedBox(height: 10),

                Text(
                  "The best place to\nmeet your future\npartner.",
                  style: TextStyle(
                      color: Color(0xFF1C1C1C),
                      fontSize: 36.0,
                      fontWeight: FontWeight.bold
                  ),
                ),

                SizedBox(height: 50),

                MainButton(
                  name: 'Get Started',
                  onpressed: getStarted,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void getStarted() {
    Navigator.pushNamed(context, "login_page");
    // if (FirebaseAuth.instance.currentUser!=null)
    //   Navigator.pushReplacementNamed(context, "tab_page");
    // else
    //   Navigator.pushNamed(context, "login_page");
  }

}
