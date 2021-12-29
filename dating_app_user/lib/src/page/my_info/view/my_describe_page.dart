
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app_user/src/data/characters_data.dart';
import 'package:dating_app_user/src/data/hobbies_data.dart';
import 'package:dating_app_user/src/data/styles_dating_data.dart';
import 'package:dating_app_user/src/widgets/buttons/main_button.dart';
import 'package:dating_app_user/src/widgets/dialogs/loading_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDescribePage extends StatefulWidget {
  final myCharacters;
  final myHobbies;
  final myStyleDating;
  const MyDescribePage({Key? key,
  required this.myCharacters,
  required this.myHobbies,
  required this.myStyleDating}) : super(key: key);

  @override
  _MyDescribePageState createState() => _MyDescribePageState();
}

class _MyDescribePageState extends State<MyDescribePage> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<bool> _listCharacterBool = [];
  List<bool> _listHobbyBool = [];
  List<bool> _listStyleDatingBool = [];

  int _numOfCharacter = 0;
  int _numOfHobby = 0;
  int _numOfStyleDating = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    for (var i = 0; i < characters_data.length; i++) {
      if (characters_data[i] == this.widget.myCharacters[0] || characters_data[i] == this.widget.myCharacters[1] || characters_data[i] == this.widget.myCharacters[2]) {
        _listCharacterBool.add(true);
        _numOfCharacter++;
      }
      else {
        _listCharacterBool.add(false);
      }
    }

    for (var i = 0; i < hobbies_data.length; i++) {
      if (hobbies_data[i] == this.widget.myHobbies[0] || hobbies_data[i] == this.widget.myHobbies[1] || hobbies_data[i] == this.widget.myHobbies[2]) {
        _listHobbyBool.add(true);
        _numOfHobby++;
      }
      else {
        _listHobbyBool.add(false);
      }
    }

    for (var i = 0; i < style_dating_data.length; i++) {
      if (style_dating_data[i] == this.widget.myStyleDating[0] || style_dating_data[i] == this.widget.myStyleDating[1] || style_dating_data[i] == this.widget.myStyleDating[2]) {
        _listStyleDatingBool.add(true);
        _numOfStyleDating++;
      }
      else {
        _listStyleDatingBool.add(false);
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
            _title("Tính cách"),
            SizedBox(height: 5,),
            _supTitle("Chọn 1 - 3 tag"),
            SizedBox(height: 10,),
            _characterView(),
            SizedBox(height: 40,),
            _title("Sở thích"),
            SizedBox(height: 5,),
            _supTitle("Chọn 1 - 3 tag"),
            SizedBox(height: 10,),
            _hobbyView(),
            SizedBox(height: 40,),
            _title("Kiểu hẹn hò"),
            SizedBox(height: 5,),
            _supTitle("Chọn 1 - 3 tag"),
            SizedBox(height: 10,),
            _styleDatingView(),
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

  _title(String text) => Text(
    text,
    style: TextStyle(
        color: Colors.pink,
        fontSize: 17,
        fontWeight: FontWeight.w500
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

  _supTitle(String text) => Text(
    text,
    style: TextStyle(
        color: Colors.grey,
        fontWeight: FontWeight.w500
    ),
  );

  _lableChoice(String text, bool isActive, func) => Container(
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      color: isActive ? Colors.deepPurple[400] : Colors.grey.withOpacity(0.2),
    ),
    child: GestureDetector(
      onTap: func,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 15,
          color: isActive ? Colors.white : Colors.black,
        ),
      ),
    ),
  );

  Widget _characterView() {
    List<Widget> list = [];
    for (var i = 0; i < characters_data.length; i++) {
      list.add(
        _lableChoice(characters_data[i], _listCharacterBool[i], (){
          if (_numOfCharacter == 3) {
            if (_listCharacterBool[i] == true) {
              setState(() {
                _listCharacterBool[i] = false;
                _numOfCharacter--;
              });
              print(_numOfCharacter);
              print(_listCharacterBool[i]);
            }
          }
          else {
            if (_listCharacterBool[i] == true) {
              setState(() {
                _listCharacterBool[i] = false;
                _numOfCharacter--;
              });
              print(_numOfCharacter);
              print(_listCharacterBool[i]);
            }
            else {
              setState(() {
                _listCharacterBool[i] = true;
                _numOfCharacter++;
              });
              print(_numOfCharacter);
              print(_listCharacterBool[i]);
            }
          }
        })
      );
    }
    return Wrap(
      spacing: 20,
      runSpacing: 15,
      children: list,
    );
  }

  Widget _hobbyView() {
    List<Widget> list = [];
    for (var i = 0; i < hobbies_data.length; i++) {
      list.add(
          _lableChoice(hobbies_data[i], _listHobbyBool[i], (){
            setState(() {
              if (_numOfHobby == 3) {
                if (_listHobbyBool[i] == true) {
                  _listHobbyBool[i] = false;
                  _numOfHobby = 2;
                }
              }
              else {
                if (_listHobbyBool[i] == true) {
                  _listHobbyBool[i] = false;
                  _numOfHobby = _numOfHobby - 1;
                }
                else {
                  _listHobbyBool[i] = true;
                  _numOfHobby = _numOfHobby + 1;
                }
              }
            });
          })
      );
    }
    return Wrap(
      spacing: 20,
      runSpacing: 15,
      children: list,
    );
  }

  Widget _styleDatingView() {
    List<Widget> list = [];
    for (var i = 0; i < style_dating_data.length; i++) {
      list.add(
          _lableChoice(style_dating_data[i], _listStyleDatingBool[i], (){
            setState(() {
              if (_numOfStyleDating == 3) {
                if (_listStyleDatingBool[i] == true) {
                  _listStyleDatingBool[i] = false;
                  _numOfStyleDating = 2;
                }
              }
              else {
                if (_listStyleDatingBool[i] == true) {
                  _listStyleDatingBool[i] = false;
                  _numOfStyleDating = _numOfStyleDating - 1;
                }
                else {
                  _listStyleDatingBool[i] = true;
                  _numOfStyleDating = _numOfStyleDating + 1;
                }
              }
            });
          })
      );
    }
    return Wrap(
      spacing: 20,
      runSpacing: 15,
      children: list,
    );
  }

  void _onClick() {

    LoadingDialog.showLoadingDialog(context, "Đang lưu...");

    List<String> listCharacter = [];
    List<String> listHobby = [];
    List<String> listStyleDating = [];

    for (var i = 0; i < characters_data.length; i++) {
      if (_listCharacterBool[i] == true) {
        listCharacter.add(characters_data[i]);
      }
    }

    for (var i = 0; i < hobbies_data.length; i++) {
      if (_listHobbyBool[i] == true) {
        listHobby.add(hobbies_data[i]);
      }
    }

    for (var i = 0; i < style_dating_data.length; i++) {
      if (_listStyleDatingBool[i] == true) {
        listStyleDating.add(style_dating_data[i]);
      }
    }

    while (listCharacter.length < 3) {
      listCharacter.add("");
    }

    while (listHobby.length < 3) {
      listHobby.add("");
    }

    while (listStyleDating.length < 3) {
      listStyleDating.add("");
    }

    print(listCharacter);
    print(listHobby);
    print(listStyleDating);

    _firestore.collection("USER").doc(_auth.currentUser!.uid).update({
      "characters" : listCharacter,
      "hobbies": listHobby,
      "styles_dating": listStyleDating,
    }).then((value) => {
      LoadingDialog.hideLoadingDialog(context),
      Navigator.pop(context),
    });
  }
}

