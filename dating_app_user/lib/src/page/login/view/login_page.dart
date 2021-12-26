import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app_user/src/page/init_info/init_info_page.dart';
import 'package:dating_app_user/src/page/init_info/init_name_page.dart';
import 'package:dating_app_user/src/style/my_style.dart';
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.deepPurple
        ),
      ),
      backgroundColor: Colors.white,
      body: Form(
        key: _formkey,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Tựa đề
                Text(
                  "Xin chào!",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                  ),
                ),
                //Miêu tả
                SizedBox(height: 5,),
                Text(
                  "Vui lòng đăng nhập để tiếp tục",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.w400
                  ),
                ),
                //Email textfield
                SizedBox(height: 40,),
                _emailTextField(),
                //Pass textfield
                SizedBox(height: 15,),
                _passwordTextField(),
                //Nút bấm
                SizedBox(height: 20,),
                MainButton(
                  name: "Đăng nhập",
                  onpressed: _login,
                ),
                // Quên mật khẩu
                SizedBox(height: 20,),
                GestureDetector(
                  onTap: (){},
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Quên mật khẩu?",
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
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
          if (value["init"]=="false") {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => InitInfoPage()), (Route<dynamic> route) => false),
          }
          else {
            Navigator.pushNamedAndRemoveUntil(context, "tab_page", (Route<dynamic> route) => false),
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
    decoration: my_decoration_textfield_style("Nhập email"),
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
    decoration: my_decoration_textfield_style("Nhập mật khẩu"),
    keyboardType: TextInputType.emailAddress,
    validator: (val) {
      if (val!.isEmpty) {
        return "Vui lòng nhập mật khẩu";
      }
      return null;
    },
  );

}
