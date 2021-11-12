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
      body: Form(
        key: _formkey,
        child: SingleChildScrollView(
          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 200,),
              _emailTextField(),
              _passwordTextField(),
              SizedBox(height: 10,),
              MainButton(
                name: "Đăng nhập",
                onpressed: _login,
              )
            ],
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
