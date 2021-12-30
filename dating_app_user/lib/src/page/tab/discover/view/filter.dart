import 'dart:math';

import 'package:dating_app_user/src/colors/colors.dart';
import 'package:dating_app_user/src/page/tab/discover/firebase/fb_filter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class FilterPage extends StatefulWidget {
  final int age_from;
  final int age_to;
  final int distance_from;
  final int distance_to;
  final String sex;
  const FilterPage(
      {Key? key,
      required this.age_from,
      required this.age_to,
      required this.distance_from,
      required this.distance_to,
      required this.sex})
      : super(key: key);

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  FilterFB filterFB = new FilterFB();
  bool isMale = false;
  bool isFeMale = false;
  bool isOther = false;

  int ageStart = 18;
  int ageEnd = 19;
  int distanceStart = 0;
  int distanceEnd = 50;
  String _sex = "";

  RangeValues _values = RangeValues(18.3, 19.0);

  RangeValues _distance = RangeValues(1, 1.1);
  @override
  void initState() {
    switch (widget.sex) {
      case "Nữ":
        isFeMale = true;
        break;
      case "Nam":
        isMale = true;
        break;
      default:
        isOther = true;
        break;
    }
    ageStart = widget.age_from;
    ageEnd = widget.age_to;
    distanceStart = widget.distance_from;
    distanceEnd = widget.distance_to;
    _sex = widget.sex;
    _values = RangeValues(double.parse(widget.age_from.toString()),
        double.parse(widget.age_to.toString()));
    _distance = RangeValues(0.0, double.parse(widget.distance_to.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {
                filterFB
                    .update(
                    FirebaseAuth.instance.currentUser!.uid,
                    ageStart.toString(),
                    ageEnd.toString(),
                    distanceStart.toString(),
                    distanceEnd.toString(),
                    _sex)
                    .then((value) => Navigator.pop(context, '1'));
              },
              child: Icon(Icons.save),
            ),
          )
        ],
        iconTheme: IconThemeData(
          color: Colors.deepPurple, //change your color here
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Bộ lọc",
          style:
              TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _text('Thiết lập tìm kiếm', 15, FontWeight.w400, Colors.black),
            SizedBox(
              height: 10,
            ),
            _card(FontAwesomeIcons.heart, "Thấy thích", _sex, 1),
            SizedBox(
              height: 10,
            ),
            _card(FontAwesomeIcons.circleNotch, "Độ tuổi",
                ageStart.toString() + '-' + ageEnd.toString() + " Tuổi", 2),
            SizedBox(
              height: 10,
            ),
            _card(FontAwesomeIcons.route, "Khoảng cách từ tôi ",
                distanceStart.toString() + '-' +distanceEnd.toString() + ' Km', 3),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),

      //bottomSheet: getBottomSheet(),
    );
  }

  _card(IconData icon, String text1, String text2, int check) {
    return GestureDetector(
      onTap: () {
        if (check == 1)
          _showBottomType();
        else if (check == 2)
          _showBottomAge();
        else
          _showBottomDistance();
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: Colors.deepPurple),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                FaIcon(
                  icon,
                  size: 17,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                _text(text1, 15, FontWeight.w500, Colors.white)
              ],
            ),
            _text(text2, 15, FontWeight.w500, white)
          ],
        ),
      ),
    );
  }

  _showBottomType() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        isScrollControlled: true,
        isDismissible: false,
        context: context,
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            //height: MediaQuery.of(context).size.height * 0.7,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(24),
                    child: Center(
                      child: _text('Bạn bị thu hút bởi giới tính nào?', 17,
                          FontWeight.bold, Colors.black),
                    )),
                Column(
                  children: [
                    _button('Nam', 1),
                    SizedBox(
                      height: 20,
                    ),
                    _button('Nữ', 2),
                    SizedBox(
                      height: 20,
                    ),
                    _button('Mọi người', 3),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }

  _showBottomAge() {
    int tempStart = ageStart;
    int tempEnd = ageEnd;
    RangeValues tempValues = _values;
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        isScrollControlled: true,
        isDismissible: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext context, setState) => Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              //height: MediaQuery.of(context).size.height * 0.4,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(24),
                      child: Center(
                        child: _text('Độ tuổi của người bạn tìm ?', 17, FontWeight.bold, Colors.black),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  _text(
                      tempStart.toString() + '-' + tempEnd.toString() + ' Tuổi',
                      15,
                      FontWeight.normal,
                      Colors.black),
                  Container(
                    width: 350,
                    child: RangeSlider(
                      activeColor: Colors.deepPurple,
                      inactiveColor: Colors.grey[300],
                      onChangeStart: null,
                      values: tempValues,
                      min: 18.0,
                      max: 70.0,
                      onChanged: (RangeValues newValues) {
                        setState(() {
                          tempValues = newValues;
                          tempEnd = newValues.end.round();
                          tempStart = newValues.start.round();
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  _buttonSave('Lưu', tempStart, tempEnd, tempValues, 1),
                  SizedBox(height: 20,)
                ],
              ),
            ),
          );
        });
  }

  _showBottomDistance() {
    int tempEnd = distanceEnd;
    int tempStart = distanceStart;
    RangeValues tempValues = _distance;
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        isScrollControlled: true,
        isDismissible: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext context, setState) => Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(24),
                      child: Center(
                        child: _text('Khoảng cách giữa 2 bạn ?', 17, FontWeight.bold, Colors.black),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  _text( tempStart.toString() + '-' + tempEnd.toString() + ' km', 15,
                      FontWeight.normal, Colors.black),
                  Container(
                    width: 350,
                    child: RangeSlider(
                      activeColor: Colors.deepPurple,
                      inactiveColor: Colors.grey[300],
                      values: tempValues,
                      min: 0.0,
                      max: 50.0,
                      onChanged: (RangeValues newValues) {
                        setState(() {
                          tempValues = newValues;
                          tempEnd = newValues.end.round();
                          tempStart = newValues.start.round();
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  _buttonSave('Lưu', tempStart, tempEnd, tempValues, 2),
                  SizedBox(height: 20,),
                ],
              ),
            ),
          );
        });
  }

  _button(String text, int check) {
    return ButtonTheme(
      minWidth: 200,
      child: RaisedButton(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: (check == 1 && isMale == true)
            ? Colors.deepPurple
            : (check == 2 && isFeMale == true)
                ? Colors.deepPurple
                : (check == 3 && isOther == true)
                    ? Colors.deepPurple : Color(0xFFF2F2F2),
        onPressed: () {
          Navigator.pop(context);
          setState(() {
            switch (check) {
              case 1:
                isMale = true;
                isOther = false;
                isFeMale = false;
                _sex = 'Nam';
                break;
              case 2:
                isMale = false;
                isOther = false;
                isFeMale = true;
                _sex = 'Nữ';
                break;
              default:
                isMale = false;
                isOther = true;
                isFeMale = false;
                _sex = 'Mọi người';
                break;
            }
          });
        },
        child: Container(
          width: 200,
          height: 50,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                  color: (check == 1 && isMale == true)
                  ? Colors.white
                  : (check == 2 && isFeMale == true)
                  ? Colors.white
                  : (check == 3 && isOther == true)
                  ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    ));
  }

  _buttonSave(String text, int start, int end, RangeValues values, int check) {
    return ButtonTheme(
      minWidth: 100,
      child: RaisedButton(
        elevation: 0.5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Colors.deepPurple,
        onPressed: () {
          Navigator.pop(context);
          setState(() {
            if (check == 1) {
              ageStart = start;
              ageEnd = end;
              _values = values;
            } else {
              distanceStart = start;
              distanceEnd = end;
              _distance = values;
            }
          });
        },
        child: Container(
          width: 50,
          height: 50,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                  fontSize: 15, fontWeight: FontWeight.bold, color: white),
            ),
          ),
        ),
      ),
    );
  }

  _text(String text, double fontsize, fontweight, Color color) {
    return Text(text,
        textAlign: TextAlign.center,
        style: GoogleFonts.roboto(
            textStyle: TextStyle(
                fontSize: fontsize, fontWeight: fontweight, color: color)));
  }
}
