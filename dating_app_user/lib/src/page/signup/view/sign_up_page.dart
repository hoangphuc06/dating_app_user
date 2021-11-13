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
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Đăng ký",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 10,),
                Text(
                  "Vui lòng cung cấp chính xác thông tin để tạo tài khoản.",
                  style: TextStyle(

                  ),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 30,),
                _emailTextField(),
                SizedBox(height: 10,),
                _passwordTextField(),
                SizedBox(height: 10,),
                _confirmPasswordTextField(),
                SizedBox(height: 30,),
                MainButton(
                  name: "Đăng ký",
                  onpressed: _signup,
                ),
                SizedBox(height: 30,),
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
    decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        hintText: "Nhập email...",
        border: InputBorder.none,
        filled: true,
        fillColor: Colors.deepPurple.withOpacity(0.1),
        prefixIcon: Icon(Icons.email, color: Colors.deepPurple,)
    ),
    keyboardType: TextInputType.emailAddress,
    validator: (val) {
      if (val!.isEmpty) {
        return "Vui lòng nhập email";
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

  _confirmPasswordTextField() => TextFormField(
    obscureText: true,
    controller: _confirmPasswordController,
    decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        hintText: "Xác nhận mật khẩu...",
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
}
