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
  PageController pageController = new PageController();
  int check = 0;
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
                });
              },
              onSwipeUp: () {
                setState(() {
                  if (temp < 4) {
                    isEnd = false;
                    temp++;
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
                  child: _switchImage(temp, check))),
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
                      position: double.parse(check.toString()),
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

  _switchImage(int temp, int index) {
    switch (temp) {
      case 0:
        return _imageNetwork(imageList, index);
        break;
      case 1:
        return _imageNetwork(imageList1, index);
        break;
      case 2:
        return _imageNetwork(imageList2, index);
        break;
      case 3:
        return _imageNetwork(imageList3, index);
        break;
      default:
    }
  }

  _switchInfo(int temp) {
    switch (temp) {
      case 0:
        return _info(
            "Quỳnh Anh",
            "20",
            "YOLO",
            "162 cm",
            "Thành phố Hồ Chí Minh",
            "Hóc Môn, Thành phố Hồ Chí Minh",
            "25 km",
            "Kim Ngưu",
            "Mình là ENFP");
        break;
      case 1:
        return _info(
            "Yến Nhi",
            "21",
            "This too, shall pass",
            "158 cm",
            "Thành phố Hồ Chí Minh",
            "Quận 1, Thành phố Hồ Chí Minh",
            "30 km",
            "Song Ngư",
            "Mình là ESFJ");
        break;
      case 2:
        return _info(
            "An Anh",
            "25",
            "Be where your feet are",
            "168 cm",
            "Thành phố Hồ Chí Minh",
            "Củ Chi, Thành phố Hồ Chí Minh",
            "100 km",
            "Bảo Bình",
            "Mình là ESFP");
        break;
      case 3:
        return _info(
            "Hồng Nhung",
            "19",
            "You only live once, but if you do it right, once is enough",
            "160 cm",
            "Thành phố Hồ Chí Minh",
            "Quận 7, Thành phố Hồ Chí Minh",
            "56 km",
            "Nhân Mã",
            "Mình là ESTP");
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
        SizedBox(height: 30,),
        Text(
            "Bạn đã xem hết các hồ sơ có trong khu vực của mình. \n Hãy mở rộng tìm kiếm hoặc quay lại sau nhé! 😄",
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
                textStyle: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    color: Colors.white))),
                      SizedBox(height: 25,),
        RaisedButton(
            onPressed: () {
              setState(() {
                check=0;
                isEnd=false;
                ishide=false;
                temp=0;
              });
            },
            elevation: 0.5,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Container(
              padding: EdgeInsets.all(10),
              child: Text("Tải lại",
                  style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.deepPurple))),
            )),
        SizedBox(
          height: 20,
        ),
        _text("Thay đổi bộ lọc tìm kiếm", 17, FontWeight.w400)
      ],
    ),
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
                      _text("Mới hoạt động", 15, FontWeight.w400),
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
                //Chiều cao
                _textWithIcon(
                    height, 17, FontWeight.w400, FontAwesomeIcons.ruler),
                SizedBox(
                  height: 15,
                ),
                //Địa chỉ
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
                _text("16 nhóm tính cách", 17, FontWeight.w400),
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
                    _expandText("😊 Dễ gần", Colors.pinkAccent,
                        FontAwesomeIcons.grinBeam),
                    _expandText("😄 Vui tính", Colors.pinkAccent,
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
                    _expandText("💡 Hứng đâu đi đó", Colors.purpleAccent,
                        FontAwesomeIcons.lightbulb),
                    _expandText(
                      "🍳 Nấu ăn chung",
                      Colors.purpleAccent,
                      FontAwesomeIcons.utensils,
                    ),
                    _expandText("🍕 Đi ăn", Colors.purpleAccent,
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
                    _expandText("✈ Du lịch", Colors.lightBlue,
                        FontAwesomeIcons.paperPlane),
                    _expandText(
                        "💪 Gym", Colors.lightBlue, FontAwesomeIcons.dumbbell),
                    _expandText(
                        "🐈 Động vật", Colors.lightBlue, FontAwesomeIcons.dog),
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

_imageNetwork(List a, int index) {
  return Image.network(
    a[index],
    fit: BoxFit.cover,
    height: double.infinity,
    width: double.infinity,
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
