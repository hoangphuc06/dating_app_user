import 'package:dating_app_user/src/widgets/buttons/main_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Form(
        key: _formkey,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(36),
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
                  "Chào mừng bạn đã trợ lại, vui lòng đăng nhập để tiếp tục sử dụng ứng dụng.",
                  style: TextStyle(

                  ),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 100,),
                _emailTextField(),
                SizedBox(height: 10,),
                _passwordTextField(),
                SizedBox(height: 30,),
                MainButton(
                  name: "Đăng nhập",
                  onpressed: _login,
                ),
                SizedBox(height: 30,),
                Row(
                  children: [
                    GestureDetector(
                      onTap: (){},
                      child: Container(
                        child: Text(
                          "Quên mật khẩu?",
                        ),
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, "sign_up_page");
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          "Đăng ký",
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _login() {
    String email = _emailController.text.toString().trim();
    String pass = _passwordController.text.toString().trim();

    if(_formkey.currentState!.validate()) {
      FirebaseAuth _firebaseAuth =FirebaseAuth.instance;
      _firebaseAuth.signInWithEmailAndPassword(email: email, password: pass).then((user) {
        Navigator.pushReplacementNamed(context, "tab_page");
      });
    }
  }

  _emailTextField() => TextFormField(
    controller: _emailController,
    decoration: InputDecoration(
      hintText: "Nhập email...",
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
      hintText: "Nhập mật khẩu...",
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
