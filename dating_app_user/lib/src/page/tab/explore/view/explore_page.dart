import 'dart:async';
import 'dart:ui';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        'https://cdn.nguyenkimmall.com/images/detailed/555/may-anh-cho-nguoi-moi.jpg'))),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 20, bottom: 8),
                child: Container(
                  width: double.infinity,
                  height: 600,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black.withOpacity(0.6),
                  ),
                  // child: BackdropFilter(
                  //   filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
                  // ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _text("Quỳnh Như, 20", 32, FontWeight.w600),
                        Container(
                          padding: const EdgeInsets.only(left: 5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.solidCircle,
                                size: 12,
                                color: Colors.green,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              _text("Mới hoạt động", 15, FontWeight.w400),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        _text(
                            "You only live once, but if you do it right, once is enough.",
                            17,
                            FontWeight.w400),
                        SizedBox(
                          height: 15,
                        ),
                        //Chiều cao
                        _textWithIcon("165 cm", 17, FontWeight.w400,
                            FontAwesomeIcons.ruler),
                        SizedBox(
                          height: 15,
                        ),
                        //Địa chỉ
                        _textWithIcon("Thành phố Hồ Chí Minh", 17,
                            FontWeight.w400, FontAwesomeIcons.home),
                        SizedBox(
                          height: 15,
                        ),
                        _textWithIcon("Hóc Môn, Thành phố Hồ Chí Minh", 17,
                            FontWeight.w400, FontAwesomeIcons.map),
                        SizedBox(
                          height: 15,
                        ),
                        _textWithIcon(
                            "25 km", 17, FontWeight.w400, Icons.location_on),
                        SizedBox(
                          height: 15,
                        ),
                        _textWithIcon("Kim Ngưu", 17, FontWeight.w400,
                            FontAwesomeIcons.star),
                        SizedBox(
                          height: 15,
                        ),
                        _text("16 nhóm tính cách", 17, FontWeight.w400),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _text("Mình là ENFP", 24, FontWeight.w600),
                            SizedBox(
                              width: 10,
                            ),
                            FaIcon(
                              FontAwesomeIcons.exclamationCircle,
                              size: 17,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        _text("Tìm kiếm", 17, FontWeight.w400),
                        SizedBox(
                          height: 20,
                        ),
                        _text("Tính cách", 17, FontWeight.w400),
                        SizedBox(
                          height: 10,
                        ),

                        Wrap(
                          spacing: 20,
                          runSpacing: 15,
                          children: [
                            _expandText("Dễ gần", Colors.pinkAccent,
                                FontAwesomeIcons.grinBeam),
                            _expandText("Vui tính", Colors.pinkAccent,
                                FontAwesomeIcons.laughSquint),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        _text("Kiểu hẹn hò", 17, FontWeight.w400),
                        SizedBox(
                          height: 10,
                        ),

                        Wrap(
                          spacing: 20,
                          runSpacing: 15,
                          children: [
                            _expandText("Hứng đâu đi đó", Colors.purpleAccent,
                                FontAwesomeIcons.lightbulb),
                            _expandText(
                              "Nấu ăn chung",
                              Colors.purpleAccent,
                              FontAwesomeIcons.utensils,
                            ),
                            _expandText("Đi ăn", Colors.purpleAccent,
                                FontAwesomeIcons.pizzaSlice),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        _text("Sở thích", 17, FontWeight.w400),
                        SizedBox(
                          height: 10,
                        ),
                        Wrap(
                          spacing: 20,
                          runSpacing: 15,
                          children: [
                            _expandText("Du lịch", Colors.lightBlue,
                                FontAwesomeIcons.paperPlane),
                            _expandText("Gym", Colors.lightBlue,
                                FontAwesomeIcons.dumbbell),
                            _expandText("Động vật", Colors.lightBlue,
                                FontAwesomeIcons.dog),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

_text(String text, double fontsize, fontweight) {
  return Text(text,
      style: GoogleFonts.roboto(
          textStyle: TextStyle(
              fontSize: fontsize,
              fontWeight: fontweight,
              color: Colors.white)));
}

_textWithIcon(String text, double fontsize, fontweight, IconData icon) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      FaIcon(
        icon,
        size: 17,
        color: Colors.white,
      ),
      SizedBox(
        width: 10,
      ),
      Text(text,
          style: GoogleFonts.roboto(
              textStyle: TextStyle(
                  fontSize: fontsize,
                  fontWeight: fontweight,
                  color: Colors.white))),
    ],
  );
}

_expandText(String text, Color color, IconData icon) {
  return Container(
    decoration:
        BoxDecoration(borderRadius: BorderRadius.circular(30), color: color),
    child: Padding(
      padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
      child: 
          Text(text,
              style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white))),
        
      
    ),
  );
}
