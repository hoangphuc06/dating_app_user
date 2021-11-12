import 'package:dating_app_user/src/page/login/view/login_page.dart';
import 'package:dating_app_user/src/page/tab/tab_page.dart';
import 'package:flutter/material.dart';

final routes = <String, WidgetBuilder>{
  "login_page": (BuildContext context) => LoginPage(),
  "tab_page": (BuildContext context) => TabPage(),
};
