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
            _card(FontAwesomeIcons.heart, "Thấy thích", "Nữ"),
            SizedBox(
              height: 10,
            ),
            _card(FontAwesomeIcons.circleNotch, "Độ tuổi", "18-30 Tuổi"),
            SizedBox(
              height: 10,
            ),
            _card(FontAwesomeIcons.route, "Khoảng cách từ tôi", "25 km"),
            SizedBox(
              height: 10,
            ),
            _card(FontAwesomeIcons.heart, "Thấy thích", "Nữ"),
          ],
        ),
      ),

      //bottomSheet: getBottomSheet(),
    );
  }

  _card(IconData icon, String text1, String text2) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(12), color: MyPurple),
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
    );
  }

  _text(String text, double fontsize, fontweight, Color color) {
    return Text(text,
        style: GoogleFonts.roboto(
            textStyle: TextStyle(
                fontSize: fontsize, fontWeight: fontweight, color: color)));
  }
}
