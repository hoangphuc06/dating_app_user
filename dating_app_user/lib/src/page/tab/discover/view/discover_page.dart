import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app_user/src/data/constData.dart';
import 'package:dating_app_user/src/data/icons.dart';
import 'package:dating_app_user/src/page/tab/discover/firebase/fb_filter.dart';
import 'package:dating_app_user/src/page/tab/discover/tinderCard/cardProvider.dart';
import 'package:dating_app_user/src/page/tab/discover/tinderCard/tinderCard.dart';
import 'package:dating_app_user/src/page/tab/discover/userModel/userModel.dart';
import 'package:dating_app_user/src/page/tab/discover/view/filter.dart';
import 'package:dating_app_user/src/page/welcome/view/test.dart';
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
  int distanceFrom = 0;
  int distanceEnd = 0;
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
        ageStart = int.parse(t['age_from'].toString());
        ageEnd = int.parse(t['age_to'].toString());
        distanceFrom = int.parse(t['distance_from'].toString());
        distanceEnd = int.parse(t['distance_to'].toString());
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
        // leading: GestureDetector(
        //     onTap: () {
        //       _goto();
        //     },
        //     child: Icon(Icons.explore)),
        iconTheme: IconThemeData(
          color: Colors.deepPurple, //change your color here
        ),
        backgroundColor: Colors.transparent,
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
          "Kh??m ph??",
          style:
              TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: StreamBuilder(
        stream: _firestore.collection("USER").where("uid", isEqualTo: _auth.currentUser!.uid).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
          if (!snapshot.hasData) {
            return Center(
              child: Container(
                height: size.height / 20,
                width: size.height / 20,
                child: CircularProgressIndicator(),
              ),
            );
          }
          else {
            QueryDocumentSnapshot x = snapshot.data!.docs[0];
            if (x["dating"]=="false")
              return buildCard();
            else
              return getDatingBody();
          }
        },
      ),
    );
  }

  Widget buildCard() {
    final provider = Provider.of<CardProvider>(context);
    final list_user = provider.listUser;
    final userCurrent = provider.userCurrent;
    return list_user.isEmpty
        ? _emptyInfo()
        : Stack(
            children: list_user
                .map((urlImage) => TinderCard(
                      urlImage: urlImage.images![0],
                      isFront: list_user.last == urlImage,
                      userCurrent: userCurrent,
                      user: urlImage,
                    ))
                .toList(),
          );
  }

  _emptyInfo() {
    return Container(
      decoration: BoxDecoration(
        //borderRadius: BorderRadius.circular(20),
        color: Colors.deepPurple,
      ),
      //height: 500,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FaIcon(
            FontAwesomeIcons.search,
            size: 50,
            color: Colors.white,
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Text(
                "B???n ???? xem h???t c??c h??? s?? c?? trong khu v???c c???a m??nh. H??y m??? r???ng t??m ki???m ho???c quay l???i sau nh??! ????",
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: Colors.white))),
          ),
          RaisedButton(
              onPressed: () {
                final provider =
                    Provider.of<CardProvider>(context, listen: false);
                provider.resetUser();
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
                // H??nh ???nh
                Container(
                  width: size.width,
                  height: size.height,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(itemsTemp[index]['image']),
                        fit: BoxFit.cover),
                  ),
                ),
                //N???i dung
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
                      // T??n tu???i
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

                      //Tr???ng th??i ho???t ?????ng
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
                        "?????n t??? " + itemsTemp[index]['hometown'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "??ang s???ng t???i " + itemsTemp[index]['address'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                )
                // N??t
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
              "B???n ??ang h???n h?? v???i n???a kia ????",
              style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "H??y t??m hi???u n???a kia th???t c?? ph?? h???p \nv???i m??nh kh??ng nh??!",
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
                  distance_from: distanceFrom,
                  distance_to: distanceEnd,
                  sex: sex,
                )));
    final provider = Provider.of<CardProvider>(context, listen: false);
    provider.resetUser();
  }

  void _goto() async {
    var id = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => Test()));
  }
}
