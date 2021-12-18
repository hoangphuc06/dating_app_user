import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app_user/src/style/my_style.dart';
import 'package:dating_app_user/src/widgets/buttons/main_button.dart';
import 'package:dating_app_user/src/widgets/dialogs/loading_dialog.dart';
import 'package:dating_app_user/src/widgets/dialogs/msg_dilog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

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
      ),
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
                  "Đăng ký",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                  ),
                ),
                //Miêu tả
                SizedBox(height: 5,),
                Text(
                  "Bằng cách nhấp vào nút đăng ký nghĩa là \nbạn đã đồng ý với mọi điều khoản của chúng tôi",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.w400
                  ),
                  textAlign: TextAlign.center,
                ),
                //email
                SizedBox(height: 40,),
                _emailTextField(),
                SizedBox(height: 15,),
                _passwordTextField(),
                SizedBox(height: 15,),
                _confirmPasswordTextField(),
                //nut
                SizedBox(height: 20,),
                MainButton(
                  name: "Đăng ký",
                  onpressed: _signup,
                ),
                //quay lai
                SizedBox(height: 20,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Đã có tài khoản? ",
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Quay lại",
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
      ),
    );
  }

  void _signup() async {
    String email = _emailController.text.toString().trim();
    String pass = _passwordController.text.toString().trim();
    String conPass = _confirmPasswordController.text.toString().trim();

    if(_formkey.currentState!.validate()) {

      LoadingDialog.showLoadingDialog(context, "Đang kiểm tra...");

      if (pass==conPass) {
        try {
          UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: email,
              password: pass
          );

          FirebaseAuth.instance.signOut();
          
          FirebaseFirestore.instance.collection("USER").doc(userCredential.user!.uid.toString()).set({
            "uid": userCredential.user!.uid.toString(),
            "email": email,
            "name": "",
            "address": "",
            "bio": "",
            "birthday": "",
            "heigh": "",
            "hometown": "",
            "job": "",
            "sex": "",
            "info": "null",
            "status": "Offline",
            "avatar": "",
            "dating": "false",
          });

          _emailController.clear();
          _passwordController.clear();
          _confirmPasswordController.clear();

          LoadingDialog.hideLoadingDialog(context);

          MsgDialog.showMsgDialog(context, "Đăng ký thành công", "Vui lòng đăng nhập để tiếp tục sử dụng.");

        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {

            LoadingDialog.hideLoadingDialog(context);

            MsgDialog.showMsgDialog(context, "Đăng ký thất bại", "Mật khẩu quá yếu.");

          } else if (e.code == 'email-already-in-use') {

            LoadingDialog.hideLoadingDialog(context);

            MsgDialog.showMsgDialog(context, "Đăng ký thất bại", "Tài khoản đã tồn tại.");

          }
        } catch (e) {
          print(e);
        }
      }
      else {
        LoadingDialog.hideLoadingDialog(context);
        MsgDialog.showMsgDialog(context, "Đăng ký thất bại", "Mật khẩu xác nhận không trùng khớp.");
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

  _confirmPasswordTextField() => TextFormField(
    obscureText: true,
    controller: _confirmPasswordController,
    decoration: my_decoration_textfield_style("Nhập lại mật khẩu"),
    keyboardType: TextInputType.emailAddress,
    validator: (val) {
      if (val!.isEmpty) {
        return "Vui lòng nhập mật khẩu";
      }
      return null;
    },
  );
}
