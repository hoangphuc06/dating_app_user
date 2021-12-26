import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app_user/src/data/constData.dart';
import 'package:dating_app_user/src/data/icons.dart';
import 'package:dating_app_user/src/page/tab/discover/firebase/fb_filter.dart';
import 'package:dating_app_user/src/page/tab/discover/tinderCard/cardProvider.dart';
import 'package:dating_app_user/src/page/tab/discover/tinderCard/tinderCard.dart';
import 'package:dating_app_user/src/page/tab/discover/view/filter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage>
    with TickerProviderStateMixin {
  CardController controller = new CardController();

  List itemsTemp = [];
  int itemLength = 0;
  int ageStart = 0;
  int ageEnd = 0;
  String sex = "";

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> loadData() async {
    FilterFB filterFB = new FilterFB();
    Stream<QuerySnapshot> query = filterFB.collectionReference
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
    await query.forEach((x) {
      x.docs.asMap().forEach((key, value) {
        var t = x.docs[key];
        ageStart = t['age_from'];
        ageEnd = t['age_to'];
        sex = t['sex'];
      });
    });
  }

  void initState() {
    loadData();
    // TODO: implement initState
    super.initState();

    setState(() {
      itemsTemp = discover_json;
      itemLength = discover_json.length;
    });
  }

  List<String> images = <String>[];

  int i = 0;
  int j = 0;
  QueryDocumentSnapshot? x;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.deepPurple, //change your color here
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(Icons.filter_list_alt),
              onPressed: () {
                _gotoPage();
              },
            ),
          ],
          title: Text(
            "Khám phá",
            style: TextStyle(
                color: Colors.deepPurple, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        // body: StreamBuilder(
        //   stream: _firestore
        //       .collection("USER")
        //       .where("uid", isNotEqualTo: _auth.currentUser!.uid)
        //       .snapshots(),
        //   builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        //     if (!snapshot.hasData) {
        //       return Center(
        //         child: Container(
        //           height: size.height / 20,
        //           width: size.height / 20,
        //           child: CircularProgressIndicator(),
        //         ),
        //       );
        //     } else {
        //       x = snapshot.data!.docs[i];
        //      images= x!['images'].toString().replaceAll('[', "").replaceAll(']', "").split(', ');
        //      print(images.length);
        //        return images.isEmpty
        //   ? _emptyInfo()
        //   : Stack(
        //       children: images
        //           .map((urlImage) => TinderCard(
        //               urlImage: urlImage, isFront: images.last == urlImage))
        //           .toList(),
        //     );
        //     }
        //   },
        // ),
        // //bottomSheet: getBottomSheet(),
        body: buildCard());
  }

  Widget buildCard() {
    final provider = Provider.of<CardProvider>(context);
    final urlImages = provider.urlImages;
    return urlImages.isEmpty
        ? _emptyInfo()
        : Stack(
            children: urlImages
                .map((urlImage) => TinderCard(
                    urlImage: urlImage, isFront: urlImages.last == urlImage))
                .toList(),
          );
  }

  _emptyInfo() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.deepPurple,
      ),
      width: double.infinity,
      height: double.infinity,
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
              "Bạn đã xem hết các hồ sơ có trong khu vực của mình. \n Hãy mở rộng tìm kiếm hoặc quay lại sau nhé! 😄",
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
                final provider =
                    Provider.of<CardProvider>(context, listen: false);
                provider.resetUser(0);
                provider.resetIndex(0);
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

  _text(String text, double fontsize, fontweight) {
    return Text(text,
        style: GoogleFonts.roboto(
            textStyle: TextStyle(
                fontSize: fontsize,
                fontWeight: fontweight,
                color: Colors.white)));
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      child: TinderSwapCard(
        totalNum: itemLength,
        cardController: controller = CardController(),
        maxWidth: MediaQuery.of(context).size.width,
        maxHeight: MediaQuery.of(context).size.height * 0.85,
        minWidth: MediaQuery.of(context).size.width * 0.85,
        minHeight: MediaQuery.of(context).size.height * 0.7,
        cardBuilder: (context, index) => Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 5,
                    spreadRadius: 2),
              ]),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Stack(
              children: [
                // Hình ảnh
                Container(
                  width: size.width,
                  height: size.height,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(itemsTemp[index]['image']),
                        fit: BoxFit.cover),
                  ),
                ),
                //Nội dung
                Container(
                  padding: EdgeInsets.all(16),
                  width: size.width,
                  height: size.height,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Colors.black.withOpacity(0.25),
                    Colors.black.withOpacity(0),
                  ], end: Alignment.topCenter, begin: Alignment.bottomCenter)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Tên tuổi
                      Row(
                        children: [
                          Text(
                            itemsTemp[index]['name'] + ",",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            itemsTemp[index]['age'],
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),

                      //Trạng thái hoạt động
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                                color: Colors.green, shape: BoxShape.circle),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Online",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Đến từ " + itemsTemp[index]['hometown'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Đang sống tại " + itemsTemp[index]['address'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                )
                // Nút
              ],
            ),
          ),
        ),
        // swipeUpdateCallback: (DragUpdateDetails details, Alignment align) {
        //   /// Get swiping card's alignment
        //   if (align.x < 0) {
        //     //Card is LEFT swiping
        //   } else if (align.x > 0) {
        //     //Card is RIGHT swiping
        //   }
        //   // print(itemsTemp.length);
        // },
        // swipeCompleteCallback: (CardSwipeOrientation orientation, int index) {
        //   /// Get orientation & index of swiped card!
        //   if (index == (itemsTemp.length - 1)) {
        //     setState(() {
        //       itemLength = itemsTemp.length - 1;
        //     });
        //   }
        // },
      ),
    );
  }

  Widget getDatingBody() {
    var size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/image/love3.svg",
              height: size.height * 0.23,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Bạn đang hẹn hò với nửa kia 😊",
              style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "Hãy tìm hiểu nửa kia thật có phù hợp \nvới mình không nhé!",
              style: TextStyle(
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }

  Widget getBottomSheet() {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 120,
      decoration: BoxDecoration(color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(item_icons.length, (index) {
            return Container(
              width: item_icons[index]['size'],
              height: item_icons[index]['size'],
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.withOpacity(0.2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 10,
                      // changes position of shadow
                    ),
                  ]),
              child: Center(
                child: SvgPicture.asset(
                  item_icons[index]['icon'],
                  width: item_icons[index]['icon_size'],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  void _gotoPage() async {
    var id = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FilterPage(
                  age_from: ageStart,
                  age_to: ageEnd,
                  sex: sex,
                )));
    final provider = Provider.of<CardProvider>(context, listen: false);
    provider.resetUser(0);
    provider.resetIndex(0);
  }
}
