import 'package:dating_app_user/src/page/login/view/login_page.dart';
import 'package:dating_app_user/src/page/my_info/view/my_info_page.dart';
import 'package:dating_app_user/src/page/setting/view/setting_page.dart';
import 'package:dating_app_user/src/page/tab/tab_page.dart';
import 'package:flutter/material.dart';

final routes = <String, WidgetBuilder>{
  "login_page": (BuildContext context) => LoginPage(),
  "tab_page": (BuildContext context) => TabPage(),
  "setting_page": (BuildContext context) => SettingPage(),
  "my_info_page": (BuildContext context) => MyInfoPage(),
};
