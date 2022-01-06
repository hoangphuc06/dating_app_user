import 'package:dating_app_user/src/style/my_style.dart';
import 'package:dating_app_user/src/widgets/buttons/main_button.dart';
import 'package:dating_app_user/src/widgets/dialogs/loading_dialog.dart';
import 'package:dating_app_user/src/widgets/dialogs/msg_dilog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {

  final TextEditingController _emailController = TextEditingController();

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
                  "Quên mật khẩu",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                  ),
                ),
                //Miêu tả
                SizedBox(height: 5,),
                Text(
                  "Cung cấp đúng email để bộ phận hỗ trợ bạn kịp thời",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.w400
                  ),
                ),
                //Email textfield
                SizedBox(height: 40,),
                _emailTextField(),
                //Nút bấm
                SizedBox(height: 20,),
                MainButton(
                  name: "Xác nhận",
                  onpressed: _send,
                ),
              ],
            ),
          ),
        ),
      ),
    );
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

  void _send() async {
    String email = _emailController.text.toString().trim();

    if(_formkey.currentState!.validate()) {

      LoadingDialog.showLoadingDialog(context, "Đang kiểm tra...");
      
      FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((value) => {

        LoadingDialog.hideLoadingDialog(context),

        MsgDialog.showMsgDialog(context, "Thành công", "Vui lòng kiểm tra email để thực hiện cập nhật mật khẩu"),

        _emailController.clear(),

      }).catchError((error){

        LoadingDialog.hideLoadingDialog(context);

        MsgDialog.showMsgDialog(context, "Thất bại", "Vui lòng kiểm tra lại email");

      });

    }
  }
}
