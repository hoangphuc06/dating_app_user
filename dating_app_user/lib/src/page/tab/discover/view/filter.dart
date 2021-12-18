import 'package:dating_app_user/src/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  bool isMale = true;
  bool isFeMale = false;
  bool isOther = false;
  int ageStart = 18;
  int ageEnd = 19;
  RangeValues _values = RangeValues(18.3, 19.0);
   int distance = 1;
  RangeValues _distance = RangeValues(1, 1.1);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.deepPurple, //change your color here
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Tìm kiếm",
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
            _card(FontAwesomeIcons.heart, "Thấy thích", "Nữ", 1),
            SizedBox(
              height: 10,
            ),
            _card(FontAwesomeIcons.circleNotch, "Độ tuổi", "18-30 Tuổi", 2),
            SizedBox(
              height: 10,
            ),
            _card(FontAwesomeIcons.route, "Khoảng cách từ tôi", "25 km", 3),
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
            borderRadius: BorderRadius.circular(12), color: MyPurple),
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
                _text(text1, 17, FontWeight.w500, Colors.white)
              ],
            ),
            _text(text2, 17, FontWeight.w500, white)
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
                color: backgr,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            height: MediaQuery.of(context).size.height * 0.7,
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(24),
                    child: Center(
                      child: _text('Bạn bị thu hút bởi giới tính nào?', 28,
                          FontWeight.bold, white),
                    )),
                SizedBox(
                  height: 60,
                ),
                Column(
                  children: [
                    _button('Nam', isMale),
                    SizedBox(
                      height: 20,
                    ),
                    _button('Nữ', isFeMale),
                    SizedBox(
                      height: 20,
                    ),
                    _button('Mọi người', isOther),
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
                  color: backgr,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              height: MediaQuery.of(context).size.height * 0.4,
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(24),
                      child: Center(
                        child: _text('Độ tuổi', 28, FontWeight.bold, white),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  _text(ageStart.toString() + '-' + ageEnd.toString() + ' Tuổi',
                      17, FontWeight.bold, white),
               
                  Container(
                    width: 350,
                    child: RangeSlider(
                      activeColor: MyPurple,
                      inactiveColor: white,
                      onChangeStart: null,
                      values: _values,
                      min: 18.0,
                      max: 70.0,
                      onChanged: (RangeValues newValues) {
                        setState(() {
                          _values = newValues;
                          ageEnd = newValues.end.round();
                          ageStart = newValues.start.round();
                        });
                      },
                    ),
                  ),
                     SizedBox(
                    height: 40,
                  ),
                  _button('Lưu', true)
                ],
              ),
            ),
          );
        });
  }

  _showBottomDistance() {
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
                  color: backgr,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              height: MediaQuery.of(context).size.height * 0.4,
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(24),
                      child: Center(
                        child: _text('Khoảng cách', 28, FontWeight.bold, white),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  _text('from 0 to ' + distance.toString() + ' km',
                      17, FontWeight.bold, white),
               
                  Container(
                    width: 350,
                    child: RangeSlider(
                      activeColor: MyPurple,
                      inactiveColor: white,
                      onChangeStart: null,
                      values: _distance,
                      min: 1,
                      max: 50,
                      onChanged: (RangeValues newValues) {
                        setState(() {
                          _distance = newValues;
                          distance = newValues.end.round();
                         
                        });
                      },
                    ),
                  ),
                     SizedBox(
                    height: 40,
                  ),
                  _button('Lưu', true)
                ],
              ),
            ),
          );
        });
}

  _button(String text, bool check) {
    return ButtonTheme(
      minWidth: 200,
      child: RaisedButton(
        elevation: 0.5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: check ? MyPurple : Colors.deepPurple,
        onPressed: () {
          // Navigator.pop(context);
        },
        child: Container(
          width: 200,
          height: 50,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                  fontSize: 28, fontWeight: FontWeight.bold, color: white),
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
