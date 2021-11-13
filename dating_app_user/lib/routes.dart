import 'package:dating_app_user/src/page/login/view/login_page.dart';
import 'package:dating_app_user/src/page/my_info/view/my_info_page.dart';
import 'package:dating_app_user/src/page/setting/view/setting_page.dart';
import 'package:dating_app_user/src/page/signup/view/sign_up_page.dart';
import 'package:dating_app_user/src/page/tab/tab_page.dart';
import 'package:dating_app_user/src/page/welcome/view/welcome_page.dart';
import 'package:flutter/material.dart';

final routes = <String, WidgetBuilder>{
  "welcome_page": (BuildContext context) => WelcomePage(),
  "login_page": (BuildContext context) => LoginPage(),
  "sign_up_page": (BuildContext context) => SignUpPage(),
  "tab_page": (BuildContext context) => TabPage(),
  "setting_page": (BuildContext context) => SettingPage(),
  "my_info_page": (BuildContext context) => MyInfoPage(),
};
