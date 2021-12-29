import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app_user/src/data/16_characters_data.dart';
import 'package:dating_app_user/src/widgets/buttons/main_button.dart';
import 'package:dating_app_user/src/widgets/dialogs/loading_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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

  int _numOfCharacter = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    for (var i = 0; i < characters_16_data.length; i++) {
      if (characters_16_data[i]["name"] == this.widget.name) {
        _listCharacterBool.add(true);
        _numOfCharacter = 1;
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
              "Miêu tả\nvề bản thân bạn? 😝",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  color: Colors.black
              ),
            ),
            SizedBox(height: 10,),
            _description("Chọn các tag bên dưới để mọi người hiểu rõ hơn về bạn"),
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
            if (_numOfCharacter == 1) {
              if (_listCharacterBool[i] == true) {
                setState(() {
                  _listCharacterBool[i] = false;
                  _numOfCharacter = 0;
                });
              }
            }
            else {
              setState(() {
                _listCharacterBool[i] = true;
                _numOfCharacter = 1;
              });
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
                image: DecorationImage(
                    image: AssetImage(x["image"]),
                    fit: BoxFit.cover)),
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

    LoadingDialog.showLoadingDialog(context, "Đang lưu...");

    _firestore.collection("USER").doc(_auth.currentUser!.uid).update({

    }).then((value) => {
      LoadingDialog.hideLoadingDialog(context),
      Navigator.pop(context),
    });
  }
}
