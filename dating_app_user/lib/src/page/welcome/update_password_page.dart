import 'package:dating_app_user/src/style/my_style.dart';
import 'package:dating_app_user/src/widgets/buttons/main_button.dart';
import 'package:dating_app_user/src/widgets/dialogs/loading_dialog.dart';
import 'package:dating_app_user/src/widgets/dialogs/msg_dilog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UpdatePasswordPage extends StatefulWidget {
  const UpdatePasswordPage({Key? key}) : super(key: key);

  @override
  _UpdatePasswordPageState createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {

  final TextEditingController _recentPasswordlController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
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
                  "Đổi mật khẩu",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                  ),
                ),
                //Miêu tả
                SizedBox(height: 5,),
                Text(
                  "Cung cấp chính xác mật khẩu hiện tại và \nmật khẩu mới để chúng tôi có thể giúp bạn thay đổi",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.w400
                  ),
                  textAlign: TextAlign.center,
                ),
                //email
                SizedBox(height: 40,),
                _recentPasswordTextField(),
                SizedBox(height: 15,),
                _newPasswordTextField(),
                SizedBox(height: 15,),
                _confirmPasswordTextField(),
                //nut
                SizedBox(height: 20,),
                MainButton(
                  name: "Xác nhận",
                  onpressed: _send,
                ),
                //quay lai
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _send() async {
    String recentPass = _recentPasswordlController.text.trim();
    String newPass = _newPasswordController.text.toString().trim();
    String conPass = _confirmPasswordController.text.toString().trim();

    if(_formkey.currentState!.validate()) {

      LoadingDialog.showLoadingDialog(context, "Đang kiểm tra...");

      if (newPass==conPass) {

        final user = await FirebaseAuth.instance.currentUser;
        final cred = EmailAuthProvider.credential(email: user!.email.toString(), password: recentPass);

        user.reauthenticateWithCredential(cred).then((value) {
          user.updatePassword(newPass).then((_) {
            LoadingDialog.hideLoadingDialog(context);
            MsgDialog.showMsgDialog(context, "Đổi thành công", "Mật khẩu đã được thay đổi.");

            _recentPasswordlController.clear();
            _newPasswordController.clear();
            _recentPasswordlController.clear();
          }).catchError((error) {
            //Error, show something
          });
        }).catchError((err) {
          LoadingDialog.hideLoadingDialog(context);
          MsgDialog.showMsgDialog(context, "Đổi thất bại", "Mật khẩu hiện tại không đúng.");
        });
      }
      else {
        LoadingDialog.hideLoadingDialog(context);
        MsgDialog.showMsgDialog(context, "Đổi thất bại", "Mật khẩu xác nhận không trùng khớp.");
      }
    }
  }

  _recentPasswordTextField() => TextFormField(
    obscureText: true,
    controller: _recentPasswordlController,
    decoration: my_decoration_textfield_style("Nhập mật khẩu hiện tại"),
    keyboardType: TextInputType.emailAddress,
    validator: (val) {
      if (val!.isEmpty) {
        return "Vui lòng nhập mật khẩu";
      }
      return null;
    },
  );

  _newPasswordTextField() => TextFormField(
    obscureText: true,
    controller: _newPasswordController,
    decoration: my_decoration_textfield_style("Nhập mật khẩu mới"),
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
    decoration: my_decoration_textfield_style("Nhập lại mật khẩu mới"),
    keyboardType: TextInputType.emailAddress,
    validator: (val) {
      if (val!.isEmpty) {
        return "Vui lòng nhập mật khẩu";
      }
      return null;
    },
  );
}
