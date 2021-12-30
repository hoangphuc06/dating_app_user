import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app_user/src/page/tab/chat/view/chat_page.dart';
import 'package:dating_app_user/src/page/tab/dating/view/dating_page.dart';
import 'package:dating_app_user/src/page/tab/discover/view/discover_page.dart';
import 'package:dating_app_user/src/page/tab/explore/view/explore_page.dart';
import 'package:dating_app_user/src/page/tab/likes/view/likes_page.dart';
import 'package:dating_app_user/src/page/tab/my_account/view/my_account_page.dart';
import 'package:dating_app_user/src/page/tab/notification/view/notification_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TabPage extends StatefulWidget {
  const TabPage({Key? key}) : super(key: key);

  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> with WidgetsBindingObserver {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  int _selectedItemIndex = 0;

  void _cambiarWidget(int index) {
    setState(() {
      _selectedItemIndex = index;
    });
  }

  List<Widget> _widgetOptions=[
    DiscoverPage(),
    //NotificationPage(),
    LikesPage(),
    //ChatPage(),
    DatingPage(),
    MyAccountPage(),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    setStatus("Online");
  }

  void setStatus(String status) async {
    await _firestore.collection('USER').doc(_auth.currentUser!.uid).update({
      "status": status,
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // online
      setStatus("Online");
    } else {
      // offline
      setStatus("Offline");
    }
  }

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
      iconSize: 20.0,
      selectedItemColor: Colors.deepPurple,
      unselectedItemColor: Colors.grey,
      currentIndex: _selectedItemIndex,
      onTap: _cambiarWidget,
      showUnselectedLabels: true,
      showSelectedLabels: true,
  
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          label: "Khám phá",
          icon: FaIcon(FontAwesomeIcons.hotjar),
        ),
        BottomNavigationBarItem(
          label: "Thích",
          icon: FaIcon(FontAwesomeIcons.solidHeart),
        ),
        BottomNavigationBarItem(
          label: "Hẹn hò",
          icon: FaIcon(FontAwesomeIcons.grinHearts),
        ),
        BottomNavigationBarItem(
          label: "Tài khoản",
          icon: FaIcon(FontAwesomeIcons.userAlt),
        ),
      ],
    );
  }
}
