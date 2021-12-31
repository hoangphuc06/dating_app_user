import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app_user/src/data/16_characters_data.dart';
import 'package:dating_app_user/src/page/my_info/view/detail_16_characters_page.dart';
import 'package:dating_app_user/src/widgets/buttons/main_button.dart';
import 'package:dating_app_user/src/widgets/dialogs/loading_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

class My16CharactersPage extends StatefulWidget {
  final String name;
  const My16CharactersPage({Key? key, required this.name}) : super(key: key);

  @override
  _My16CharactersPageState createState() => _My16CharactersPageState();
}

class _My16CharactersPageState extends State<My16CharactersPage> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<bool> _listCharacterBool = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    for (var i = 0; i < characters_16_data.length; i++) {
      if (characters_16_data[i]["name"] == this.widget.name) {
        _listCharacterBool.add(true);
      }
      else {
        _listCharacterBool.add(false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.deepPurple, //change your color here
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: _getBody(),
    );
  }

  Widget _getBody() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(left: 32, right: 32, bottom: 32, top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Nhóm tính cách\nbạn thuộc loại nào? 🧐",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  color: Colors.black
              ),
            ),
            SizedBox(height: 10,),
            _description("Tìm hiểu về nhóm tính cách sẽ giúp hiểu rõ hơn về bản thân bạn cũng như người ấy"),
            SizedBox(height: 10,),
            InkWell(
              onTap: () => launch("https://pub.dev/packages/url_launcher/example"),
              child: Text(
                "Làm bài trắc nghiệm tính cách",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.deepPurple
                ),
              ),
            ),
            // Link(
            //   uri: Uri.parse(
            //       'https://pub.dev/documentation/url_launcher/latest/link/link-library.html'),
            //   target: LinkTarget.blank,
            //   builder: (BuildContext ctx, FollowLink? openLink) {
            //     return TextButton.icon(
            //       onPressed: openLink,
            //       label: const Text('Link Widget documentation'),
            //       icon: const Icon(Icons.read_more),
            //     );
            //   },
            // ),
            SizedBox(height: 30,),
            _characterView(),
            SizedBox(height: 40,),
            MainButton(name: "Lưu", onpressed: (){
              _onClick();
            }),
            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }

  Widget _characterView() {
    List<Widget> list = [];
    for (var i = 0; i < characters_16_data.length; i++) {
      list.add(
          _lableChoice(characters_16_data[i], _listCharacterBool[i], (){
            for (var j = 0; j < _listCharacterBool.length; j++) {
              if (i == j) {
                setState(() {
                  _listCharacterBool[j] = true;
                });
              }
              else {
                setState(() {
                  _listCharacterBool[j] = false;
                });
              }
            }
          })
      );
    }
    return Wrap(
      spacing: 20,
      runSpacing: 20,
      children: list,
    );
  }

  _lableChoice(x, bool isActive, func) => GestureDetector(
    onTap: func,
    child: Container(
      width: (MediaQuery.of(context).size.width - 64 - 20)/2,
      //height: 200,
      padding: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: isActive ? Colors.deepPurple[400] : Colors.grey.withOpacity(0.2),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: (){
              print("hello");
              Navigator.push(context, MaterialPageRoute(builder: (context) => Detail16CharactersPage(data: x)));
            },
            child: Align(
              alignment: Alignment.topRight,
              child: Icon(
                Icons.info_outlined,
                size: 22,
                color: isActive ? Colors.white : Colors.black,
              ),
            ),
          ),
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(x["image"]),
          ),
          SizedBox(height: 15,),
          Text(
            x["name"],
            style: TextStyle(
              fontSize: 15,
              color: isActive ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    ),
  );

  _description(String description) => Text(
    description,
    style: TextStyle(
        color: Colors.black.withOpacity(0.5),
        fontWeight: FontWeight.w400
    ),
    textAlign: TextAlign.justify,
  );

  void _onClick() {

    String name;

    LoadingDialog.showLoadingDialog(context, "Đang lưu...");

    for (var j = 0; j < _listCharacterBool.length; j++) {
      if (_listCharacterBool[j] == true ) {
        name = characters_16_data[j]["name"];
        _firestore.collection("USER").doc(_auth.currentUser!.uid).update({
          "interesting_fact": name,
        }).then((value) => {
          LoadingDialog.hideLoadingDialog(context),
          Navigator.pop(context),
        });
      }
    }
  }

  Future<void> _launchInBrowser(String url) async {
    if (!await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
      headers: <String, String>{'my_header_key': 'my_header_value'},
    )) {
      throw 'Could not launch $url';
    }
  }
}
