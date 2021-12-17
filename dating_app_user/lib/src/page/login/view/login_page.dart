import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app_user/responsive.dart';
import 'package:dating_app_user/src/page/init_info/init_info_page.dart';
import 'package:dating_app_user/src/page/init_info/init_name_page.dart';
import 'package:dating_app_user/src/widgets/buttons/main_button.dart';
import 'package:dating_app_user/src/widgets/dialogs/loading_dialog.dart';
import 'package:dating_app_user/src/widgets/dialogs/msg_dilog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.deepPurple, //change your color here
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Form(
        key: _formkey,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Đăng nhập",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 10,),
                Text(
                  "Chào mừng bạn đã trở lại, vui lòng đăng nhập để tiếp tục sử dụng ứng dụng.",
                  style: TextStyle(

                  ),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 30,),
                _emailTextField(),
                SizedBox(height: 10,),
                _passwordTextField(),
                SizedBox(height: 20,),
                GestureDetector(
                  onTap: (){},
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Quên mật khẩu?",
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                MainButton(
                  name: "Đăng nhập",
                  onpressed: _login,
                ),
                SizedBox(height: 10,),
                _button("Đăng nhập bằng Facebook", "assets/icon/ic_facebook.png", (){}),
                SizedBox(height: 10,),
                _button("Đăng nhập bằng Google", "assets/icon/ic_google.png", (){}),
                SizedBox(height: 30,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Chưa có tài khoản? ",
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, "sign_up_page");
                      },
                      child: Text(
                        "Đăng ký",
                        style: TextStyle(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        //---------------------------------------------------

        // child: SingleChildScrollView(
        //   child: SafeArea(
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         Container(
        //           width: double.infinity,
        //           height: getScreenPropotionHeight(orientation == Orientation.portrait ? 390 : 450, size),
        //           child: Stack(
        //             children: [
        //               Positioned(
        //                   left: getScreenPropotionWidth(64, size),
        //                   top: getScreenPropotionHeight(90, size),
        //                   child: Image.asset(
        //                     'assets/image/heart.png',
        //                     width: getScreenPropotionHeight(67, size),
        //                   )
        //               ),
        //
        //               Positioned(
        //                   right: 0,
        //                   child: SvgPicture.asset(
        //                     'assets/image/couple.svg',
        //                     height: getScreenPropotionHeight(390, size),
        //                   )
        //               ),
        //
        //               Positioned(
        //                   left: getScreenPropotionWidth(28, size),
        //                   top: getScreenPropotionHeight(190, size),
        //                   child: Text(
        //                     'Login to\na lovely\nlife.',
        //                     style: TextStyle(
        //                         fontSize: 36,
        //                         fontWeight: FontWeight.bold,
        //                         color: Color(0xFF1C1C1C)
        //                     ),
        //                   )
        //               ),
        //             ],
        //           ),
        //         ),
        //
        //         SizedBox(height: 28),
        //
        //         Padding(
        //           padding: EdgeInsets.symmetric(horizontal: 28),
        //           child: Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               Text(
        //                 'Enter your email',
        //                 style: TextStyle(
        //                     fontSize: 16,
        //                     color: Color(0xFF5E5E5E),
        //                     fontWeight: FontWeight.w600
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ),
        //       ]
        //     ),
        //   ),
        // ),
      ),
    );
  }

  void _login() async {
    String email = _emailController.text.toString().trim();
    String pass = _passwordController.text.toString().trim();

    if(_formkey.currentState!.validate()) {

      LoadingDialog.showLoadingDialog(context, "Đang kiểm tra...");

      try {
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email,
            password: pass
        );

        FirebaseFirestore.instance.collection("USER").doc(userCredential.user!.uid).get().then((value) => {
          if (value["info"]=="null") {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => InitInfoPage())),
          }
          else {
            Navigator.pushReplacementNamed(context, "tab_page"),
          }
        });

      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {

          LoadingDialog.hideLoadingDialog(context);

          MsgDialog.showMsgDialog(context, "Đăng nhập thất bại", "Tài khoản này chưa được đăng kí");

        } else if (e.code == 'wrong-password') {

          LoadingDialog.hideLoadingDialog(context);

          MsgDialog.showMsgDialog(context, "Đăng nhập thất bại", "Mật khẩu không chính xác");

        }
      }
    }
  }

  _emailTextField() => TextFormField(
    controller: _emailController,
    // decoration: InputDecoration(
    //   enabledBorder: OutlineInputBorder(
    //     borderSide: BorderSide(color: Colors.transparent),
    //     borderRadius: BorderRadius.all(Radius.circular(10))
    //   ),
    //   focusedBorder: OutlineInputBorder(
    //       borderSide: BorderSide(color: Colors.transparent),
    //       borderRadius: BorderRadius.all(Radius.circular(10))
    //   ),
    //   hintText: "Nhập email...",
    //   border: InputBorder.none,
    //   filled: true,
    //   fillColor: Colors.deepPurple.withOpacity(0.1),
    //   prefixIcon: Icon(Icons.email, color: Colors.deepPurple,)
    // ),
    decoration: InputDecoration(
        prefixIcon: Icon(Icons.email, color: Colors.deepPurple,),
      hintText: "Nhập email...",
      fillColor: Colors.deepPurple.withOpacity(0.1),
        filled: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide.none
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 28 / 2),
    ),
    keyboardType: TextInputType.emailAddress,
    validator: (val) {
      if (val!.isEmpty) {
        return "Vui lòng nhập email";
      }
      var isValidEmail = RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
          .hasMatch(val);
      if (!isValidEmail) {
        return "Định dạng email không đúng";
      }
      return null;
    },
  );

  _passwordTextField() => TextFormField(
    obscureText: true,
    controller: _passwordController,
    decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        hintText: "Nhập mật khẩu...",
        border: InputBorder.none,
        filled: true,
        fillColor: Colors.deepPurple.withOpacity(0.1),
        prefixIcon: Icon(Icons.lock, color: Colors.deepPurple,)
    ),
    keyboardType: TextInputType.emailAddress,
    validator: (val) {
      if (val!.isEmpty) {
        return "Vui lòng nhập mật khẩu";
      }
      return null;
    },
  );

  _button(String name, String image, funtion) => Container(
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
