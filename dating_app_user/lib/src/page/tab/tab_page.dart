import 'package:dating_app_user/src/page/tab/chat/view/chat_page.dart';
import 'package:dating_app_user/src/page/tab/explore/view/explore_page.dart';
import 'package:dating_app_user/src/page/tab/my_account/view/my_account_page.dart';
import 'package:dating_app_user/src/page/tab/notification/view/notification_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TabPage extends StatefulWidget {
  const TabPage({Key? key}) : super(key: key);

  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {

  int _selectedItemIndex = 0;

  void _cambiarWidget(int index) {
    setState(() {
      _selectedItemIndex = index;
    });
  }

  List<Widget> _widgetOptions=[
    ExplorePage(),
    NotificationPage(),
    ChatPage(),
    MyAccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _widgetOptions.elementAt(_selectedItemIndex),
      bottomNavigationBar: _bottomNavigationBar(context),
    );
  }

  Widget _bottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      iconSize: 30.0,
      selectedItemColor: Colors.pink,
      unselectedItemColor: Colors.grey,
      currentIndex: _selectedItemIndex,
      onTap: _cambiarWidget,
      showUnselectedLabels: false,
      showSelectedLabels: false,
  
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          label: "Explore",
          icon: FaIcon(FontAwesomeIcons.hotjar),
        ),
        BottomNavigationBarItem(
          label: "Notification",
          icon: FaIcon(FontAwesomeIcons.bell),
        ),
        BottomNavigationBarItem(
          label: "Chat",
          icon: FaIcon(FontAwesomeIcons.rocketchat),
        ),
        BottomNavigationBarItem(
          label: "Account",
          icon: FaIcon(FontAwesomeIcons.userCircle),
        ),
      ],
    );
  }
}
