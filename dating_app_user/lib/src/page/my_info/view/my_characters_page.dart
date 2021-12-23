import 'package:dating_app_user/src/data/characters_data.dart';
import 'package:flutter/material.dart';

class MyChacractersPage extends StatefulWidget {
  final x;
  const MyChacractersPage({Key? key, required this.x}) : super(key: key);

  @override
  _MyChacractersPageState createState() => _MyChacractersPageState();
}

class _MyChacractersPageState extends State<MyChacractersPage> {

  bool a = false;

  List<bool> _listCharacterBool = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    characters_data.forEach((element) {
      _listCharacterBool.add(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Tính cách",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: (){
                  _showCharacterDialog();
                },
                child: Text(
                  "Cập nhật",
                  style: TextStyle(
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Wrap(
            spacing: 20,
            runSpacing: 10,
            children: [
              widget.x[0] == "" ? Container() : _lable(widget.x[0]),
              widget.x[1] == "" ? Container() : _lable(widget.x[1]),
              widget.x[2] == "" ? Container() : _lable(widget.x[2]),
            ],
          )
        ],
      ),
    );
  }

  _lable(String text) => Container(
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.grey.withOpacity(0.2)
    ),
    child: Text(
      text,
      style: TextStyle(
          fontSize: 15
      ),
    ),
  );

  _showCharacterDialog() => showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      context: context,
      builder: (context)=>Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Tính cách của bạn như thế nào?",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 10,),
            Text(
              "Chọn 1-3 mục để miêu tả về bạn",
              style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500
              ),
            ),
            SizedBox(height: 30,),
            Wrap(
              spacing: 20,
              runSpacing: 15,
              children: [

              ],
            ),
            SizedBox(height: 30,),
            _buttonSave(
                    (){

                }
            ),
          ],
        ),
      )
  );

  _lableChoice(String text, bool isActive, func) => Container(
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      color: isActive ? Colors.deepPurple : Colors.grey.withOpacity(0.2),
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

  _buttonSave(Function function) => Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.deepPurple
    ),
    child: FlatButton(
      onPressed: function(),
      child: Text("Lưu", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
    ),
  );
}

Widget _roundedButtonFilter(func, bool isActive, String labelText) {
  return ButtonTheme(
    minWidth: 80,
    height: 30,
    child: RaisedButton(
      onPressed: func,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        //side: BorderSide(color: orange)
      ),
      color: isActive ? Colors.deepPurple : Colors.grey.withOpacity(0.2),
      elevation: 0.5,
      child: Text(
        labelText,
        style: TextStyle(
          fontSize: 15,
          color: isActive ? Colors.white : Colors.black,
        ),
      ),
    ),
  );
}
