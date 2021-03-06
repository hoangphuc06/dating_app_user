import 'dart:async';
import 'dart:ui';
import 'package:dating_app_user/src/page/tab/explore/model/person_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  List<String> imageList = [
    'https://cellphones.com.vn/sforum/wp-content/uploads/2020/04/LR-29-scaled.jpg',
    'https://cdn.nguyenkimmall.com/images/detailed/555/may-anh-cho-nguoi-moi.jpg',
    'https://digitalphoto.com.vn/wp-content/uploads/2018/08/39999935574_11b6d8805f_o-1.jpg',
    'https://halotravel.vn/wp-content/uploads/2020/07/thach_trangg_101029297_573874646879779_1794923475739360981_n.jpg'
  ];
  final imageList1 = [
    'https://i.pinimg.com/originals/35/2b/87/352b87e5dfa5b6f689edab8fc18b61ad.jpg',
    'https://aphoto.vn/wp-content/uploads/2019/07/anh-chan-dung-nghe-thuat-top-aphoto5.jpg',
    'https://vietyouth.vn/wp-content/uploads/2018/10/ngoi-vao-la-hot-anh-dep-10-chiec-ghe-quyen-luc-vang-danh-khap-hoi-da-lat-13598.jpg',
    'https://photographer.vn/wp-content/uploads/2020/10/chup-anh-chan-dung-nghe-thuat5-800x1200.jpg'
  ];
  final imageList2 = [
    'https://chupanhvn.s3.ap-southeast-1.amazonaws.com/wp-content/uploads/2020/10/25044432/chup-anh-nghe-thuat.jpg',
    'https://cdn.nguyenkimmall.com/images/detailed/555/may-anh-cho-nguoi-moi.jpg',
    'https://digitalphoto.com.vn/wp-content/uploads/2018/08/39999935574_11b6d8805f_o-1.jpg',
    'https://halotravel.vn/wp-content/uploads/2020/07/thach_trangg_101029297_573874646879779_1794923475739360981_n.jpg'
  ];
  final imageList3 = [
    'https://chupanhvn.s3.ap-southeast-1.amazonaws.com/wp-content/uploads/2020/10/25065126/chup-anh-chan-dung-pc-han.jpg',
    'https://cdn.nguyenkimmall.com/images/detailed/555/may-anh-cho-nguoi-moi.jpg',
    'https://digitalphoto.com.vn/wp-content/uploads/2018/08/39999935574_11b6d8805f_o-1.jpg',
    'https://dotobjyajpegd.cloudfront.net/photo/5d3a66f962710e25dc99ffa3'
  ];

  bool isEnd = false;
  bool ishide = false;
  SwiperController swiperController = new SwiperController();
  LiquidController _liquidController = new LiquidController();
  double check = 0;
  int temp = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Swiper(
          //     pagination: SwiperPagination(),
          //     itemCount: imageList.length,
          //     loop: false,
          //     controller: swiperController,
          //     onTap: (index){
          //       if(check==imageList.length)
          //       {
          //         setState(() {
          //           isEnd=false;
          //           check--;
          //         });
          //       }
          //     },
          //     itemBuilder: (context, index) {
          //       return
          SwipeDetector(
              onSwipeRight: () {
                setState(() {
                  _previous();
                });
              },
              onSwipeLeft: () {
                setState(() {
                  _next(imageList.length);
                  print(check);
                });
              },
              onSwipeUp: () {
                setState(() {
                  if (temp < 4) {
                    isEnd = false;
                    temp++;
                    _liquidController.jumpToPage(page: 0);
                    print(temp);
                    check = 0;
                  }
                  if (temp == 4)
                    setState(() {
                      ishide = true;
                    });
                });
              },
              onSwipeDown: () {
                setState(() {
                  if (temp > 0) {
                    isEnd = false;
                    temp--;
                    _liquidController.jumpToPage(page: 0);
                    print(temp);
                    check = 0;
                  }
                  ishide = false;
                });
              },
              child: GestureDetector(
                  onTap: () {
                    print(temp);
                    if (isEnd) {
                      setState(() {
                        isEnd = false;
                      });
                    }
                  },
                  child: _switchImage(temp))),
          isEnd == true
              ? _switchInfo(temp)
              : Container(
                  width: 1,
                  height: 1,
                ),
          temp == 4
              ? _emptyInfo()
              : Container(
                  width: 1,
                  height: 1,
                ),
          ishide == false
              ? Positioned.fill(
                  child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.only(bottom: 8),
                    child: DotsIndicator(
                      dotsCount: imageList.length,
                      position: check,
                      decorator: DotsDecorator(
                        color: Colors.grey, // Inactive color
                        activeColor: Colors.blueAccent,
                        size: const Size.square(9.0),
                        activeSize: const Size(18.0, 9.0),
                        activeShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                    ),
                  ),
                ))
              : Container(
                  width: 1,
                  height: 1,
                )
        ],
      ),
    );
  }

  void _next(int length) {
    if (check < length) check++;
    if (check == length) {
      isEnd = true;
      check--;
    }
  }

  void _previous() {
    if (isEnd)
      isEnd = false;
    else {
      if (check != 0) check--;
      isEnd = false;
    }
  }

  _switchImage(int temp) {
    switch (temp) {
      case 0:
        return _imageNetwork(imageList);
        break;
      case 1:
        return _imageNetwork(imageList1);
        break;
      case 2:
        return _imageNetwork(imageList2);
        break;
      case 3:
        return _imageNetwork(imageList3);
        break;
      default:
    }
  }

  _switchInfo(int temp) {
    switch (temp) {
      case 0:
        return _info(
            "Qu???nh Anh",
            "20",
            "YOLO",
            "162 cm",
            "Th??nh ph??? H??? Ch?? Minh",
            "H??c M??n, Th??nh ph??? H??? Ch?? Minh",
            "25 km",
            "Kim Ng??u",
            "M??nh l?? ENFP");
        break;
      case 1:
        return _info(
            "Y???n Nhi",
            "21",
            "This too, shall pass",
            "158 cm",
            "Th??nh ph??? H??? Ch?? Minh",
            "Qu???n 1, Th??nh ph??? H??? Ch?? Minh",
            "30 km",
            "Song Ng??",
            "M??nh l?? ESFJ");
        break;
      case 2:
        return _info(
            "An Anh",
            "25",
            "Be where your feet are",
            "168 cm",
            "Th??nh ph??? H??? Ch?? Minh",
            "C??? Chi, Th??nh ph??? H??? Ch?? Minh",
            "100 km",
            "B???o B??nh",
            "M??nh l?? ESFP");
        break;
      case 3:
        return _info(
            "H???ng Nhung",
            "19",
            "You only live once, but if you do it right, once is enough",
            "160 cm",
            "Th??nh ph??? H??? Ch?? Minh",
            "Qu???n 7, Th??nh ph??? H??? Ch?? Minh",
            "56 km",
            "Nh??n M??",
            "M??nh l?? ESTP");
        break;
      default:
    }
  }

  _emptyInfo() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.deepPurple,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FaIcon(
            FontAwesomeIcons.searchLocation,
            size: 70,
            color: Colors.white70,
          ),
          SizedBox(
            height: 30,
          ),
          Text(
              "B???n ???? xem h???t c??c h??? s?? c?? trong khu v???c c???a m??nh. \n H??y m??? r???ng t??m ki???m ho???c quay l???i sau nh??! ????",
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: Colors.white))),
          SizedBox(
            height: 25,
          ),
          RaisedButton(
              onPressed: () {
                setState(() {
                  check = 0;
                  isEnd = false;
                  ishide = false;
                  temp = 0;
                });
              },
              elevation: 0.5,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Container(
                padding: EdgeInsets.all(10),
                child: Text("T???i l???i",
                    style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.deepPurple))),
              )),
          SizedBox(
            height: 20,
          ),
          _text("Thay ?????i b??? l???c t??m ki???m", 17, FontWeight.w400)
        ],
      ),
    );
  }

  _imageNetwork(List a) {
    return LiquidSwipe.builder(
      itemCount: a.length,
      itemBuilder: (context, index) {
        return Image.network(
          a[index],
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
        );
      },
      onPageChangeCallback: (index) {
        setState(() {
          check=double.parse(index.toString());
          if(index==3)
          {
            isEnd=true;
          }
          else{
            isEnd=false;
          }
        });
      },
      waveType: WaveType.liquidReveal,
      liquidController: _liquidController,
      fullTransitionValue: 880,
      enableLoop: false,
    );
  }
}

_info(String name, String age, String description, String height, String city,
    String address, String location, String star, String personality) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Padding(
        padding: const EdgeInsets.only(
          right: 20,
          left: 20,
        ),
        child: Container(
          width: double.infinity,
          height: 650,
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
                _text(name + ", " + age, 32, FontWeight.w600),
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
                      _text("M???i ho???t ?????ng", 15, FontWeight.w400),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                _text(description, 17, FontWeight.w400),
                SizedBox(
                  height: 15,
                ),
                //Chi???u cao
                _textWithIcon(
                    height, 17, FontWeight.w400, FontAwesomeIcons.ruler),
                SizedBox(
                  height: 15,
                ),
                //?????a ch???
                _textWithIcon(city, 17, FontWeight.w400, FontAwesomeIcons.home),
                SizedBox(
                  height: 15,
                ),
                _textWithIcon(
                    address, 17, FontWeight.w400, FontAwesomeIcons.map),
                SizedBox(
                  height: 15,
                ),
                _textWithIcon(location, 17, FontWeight.w400, Icons.location_on),
                SizedBox(
                  height: 15,
                ),
                _textWithIcon(star, 17, FontWeight.w400, FontAwesomeIcons.star),
                SizedBox(
                  height: 15,
                ),
                _text("16 nh??m t??nh c??ch", 17, FontWeight.w400),
                SizedBox(
                  height: 15,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _text(personality, 24, FontWeight.w600),
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
                _text("T??m ki???m", 17, FontWeight.w400),
                SizedBox(
                  height: 20,
                ),
                _text("T??nh c??ch", 17, FontWeight.w400),
                SizedBox(
                  height: 10,
                ),

                Wrap(
                  spacing: 20,
                  runSpacing: 15,
                  children: [
                    _expandText("???? D??? g???n", Colors.pinkAccent,
                        FontAwesomeIcons.grinBeam),
                    _expandText("???? Vui t??nh", Colors.pinkAccent,
                        FontAwesomeIcons.laughSquint),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                _text("Ki???u h???n h??", 17, FontWeight.w400),
                SizedBox(
                  height: 10,
                ),

                Wrap(
                  spacing: 20,
                  runSpacing: 15,
                  children: [
                    _expandText("???? H???ng ????u ??i ????", Colors.purpleAccent,
                        FontAwesomeIcons.lightbulb),
                    _expandText(
                      "???? N???u ??n chung",
                      Colors.purpleAccent,
                      FontAwesomeIcons.utensils,
                    ),
                    _expandText("???? ??i ??n", Colors.purpleAccent,
                        FontAwesomeIcons.pizzaSlice),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                _text("S??? th??ch", 17, FontWeight.w400),
                SizedBox(
                  height: 10,
                ),
                Wrap(
                  spacing: 20,
                  runSpacing: 15,
                  children: [
                    _expandText("??? Du l???ch", Colors.lightBlue,
                        FontAwesomeIcons.paperPlane),
                    _expandText(
                        "???? Gym", Colors.lightBlue, FontAwesomeIcons.dumbbell),
                    _expandText(
                        "???? ?????ng v???t", Colors.lightBlue, FontAwesomeIcons.dog),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
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
      child: Text(text,
          style: GoogleFonts.roboto(
              textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white))),
    ),
  );
}
