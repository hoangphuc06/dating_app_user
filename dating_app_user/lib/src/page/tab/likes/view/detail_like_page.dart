import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app_user/src/colors/colors.dart';
import 'package:dating_app_user/src/data/16_characters_data.dart';
import 'package:dating_app_user/src/page/tab/discover/view/info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:open_iconic_flutter/open_iconic_flutter.dart';

class DetailLikePage extends StatefulWidget {
  final String userUid;
  final String myUid;
  final String like_id;
  const DetailLikePage({Key? key, required this.userUid, required this.myUid, required this.like_id}) : super(key: key);

  @override
  _DetailLikePageState createState() => _DetailLikePageState();
}

class _DetailLikePageState extends State<DetailLikePage> with SingleTickerProviderStateMixin{

  late AnimationController controller = AnimationController(
    duration: Duration(seconds: 3),
    vsync: this,
  );

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          iconTheme: IconThemeData(
            color: Colors.deepPurple, //change your color here
          ),
          backgroundColor: Colors.white,
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.close,
                color: Colors.deepPurple,
                size: 24,
              ),
            ),
            SizedBox(
              width: 10,
            )
          ],
          elevation: 0,
          title: Text(
            "Thông tin",
            style:
            TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: StreamBuilder(
          stream: _firestore.collection("USER").where("uid", isEqualTo: widget.userUid).snapshots(),
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
              return StreamBuilder(
                stream: _firestore.collection("USER").where("uid", isEqualTo: widget.myUid).snapshots(),
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
                    QueryDocumentSnapshot y = snapshot.data!.docs[0];
                    return _getBody(x,y);
                  }
                },
              );
            }
          },
        )
    );
  }

  Widget _getBody(QueryDocumentSnapshot x, QueryDocumentSnapshot y) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              imageView(x["images"]),
              SizedBox(height: 10,),
              info(x),
              SizedBox(height: 10,),
              bio_character(x),
              SizedBox(height: 10,),
              distance_job(x,y),
              SizedBox(height: 10,),
              height_address(x),
              SizedBox(height: 10,),
              chacracter_styleDating(x),
              SizedBox(height: 10,),
              hobbies(x),
              SizedBox(height: 10,),
              Text("Lịch sử hẹn hò", style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),),
              SizedBox(height: 10,),
              history(x),
              SizedBox(height: 20,),
              Align(
                alignment: Alignment.center,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);

                      _firestore.collection("USER").doc(this.widget.userUid).update({
                        "dating": "true",
                      });
                      _firestore.collection("USER").doc(this.widget.myUid).update({
                        "dating": "true",
                      });
                      String id = (new DateTime.now().millisecondsSinceEpoch).toString();
                      String id1 = id + "1";
                      String id2 = id + "2";
                      _firestore.collection("DATING").doc(id1).set({
                        "id": id1,
                        "uid" : this.widget.userUid,
                        "herid": this.widget.myUid,
                        "status": "dating",
                        "time_start": new DateTime.now().day.toString() + "/" + new DateTime.now().month.toString() + "/" + new DateTime.now().year.toString(),
                        "time_end": "",
                        "who_end": "",
                        "why_end": "",
                      });
                      _firestore.collection("DATING").doc(id2).set({
                        "id": id2,
                        "uid" : this.widget.myUid,
                        "herid": this.widget.userUid,
                        "status": "dating",
                        "time_start": new DateTime.now().day.toString() + "/" + new DateTime.now().month.toString() + "/" + new DateTime.now().year.toString(),
                        "time_end": "",
                        "who_end": "",
                        "why_end": "",
                      });
                      _firestore.collection("LIKE").doc(this.widget.like_id).delete();

                    },
                    child: FaIcon(
                      FontAwesomeIcons.solidHeart,
                      color: Colors.red,
                      size: 50,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50,)
            ]
        )
    );
  }


  Widget imageView(x) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        x[5] == "" && x[4] == "" && x[3] == "" && x[2] == "" && x[1] == "" && x[0] != "" ? _view1(x)
            : x[5] == "" && x[4] == "" && x[3] == "" && x[2] == "" && x[1] != "" && x[0] != "" ? _view2(x)
            : x[5] == "" && x[4] == "" && x[3] == "" && x[2] != "" && x[1] != "" && x[0] != "" ? _view3(x)
            : x[5] == "" && x[4] == "" && x[3] != "" && x[2] != "" && x[1] != "" && x[0] != "" ? _view4(x)
            : x[5] == "" && x[4] != "" && x[3] != "" && x[2] != "" && x[1] != "" && x[0] != "" ? _view5(x)
            : _view6(x),
        // ?
      ],
    );
  }

  Widget _view1(x) {
    var size = MediaQuery.of(context).size;
    return _image(250.0, size.width, x[0]);
  }

  Widget _view2(x) {
    var size = MediaQuery.of(context).size;
    return Row(
      children: [
        _image(250.0, (size.width - 32 - 10) /2 , x[0]),
        SizedBox(width: 10,),
        _image(250.0, (size.width - 32 - 10) /2 , x[1])
      ],
    );
  }

  Widget _view3(x) {
    var size = MediaQuery.of(context).size;
    return Row(
      children: [
        _image(300.0, (size.width - 32 - 10) * 2 / 3 , x[0]),
        SizedBox(width: 10,),
        Column(
          children: [
            _image(145.0, (size.width - 32 - 10) * 1 / 3 , x[1]),
            SizedBox(height: 10,),
            _image(145.0, (size.width - 32 - 10) * 1 / 3 , x[2])
          ],
        )
      ],
    );
  }

  Widget _view4(x) {
    var size = MediaQuery.of(context).size;
    return Row(
      children: [
        Column(
          children: [
            _image(180.0, (size.width - 32 - 10) * 1 / 2 , x[0]),
            SizedBox(height: 10,),
            _image(180.0, (size.width - 32 - 10) * 1 / 2 , x[1])
          ],
        ),
        SizedBox(width: 10,),
        Column(
          children: [
            _image(180.0, (size.width - 32 - 10) * 1 / 2 , x[2]),
            SizedBox(height: 10,),
            _image(180.0, (size.width - 32 - 10) * 1 / 2 , x[3])
          ],
        )
      ],
    );
  }

  Widget _view5(x) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          children: [
            _image(300.0, (size.width - 32 - 10) * 2 / 3 , x[0]),
            SizedBox(width: 10,),
            Column(
              children: [
                _image(145.0, (size.width - 32 - 10) * 1 / 3 , x[1]),
                SizedBox(height: 10,),
                _image(145.0, (size.width - 32 - 10) * 1 / 3 , x[2])
              ],
            )
          ],
        ),
        SizedBox(height: 10,),
        Row(
          children: [
            _image(150.0, (size.width - 32 - 10) * 1 / 2 , x[3]),
            SizedBox(width: 10,),
            _image(150.0, (size.width - 32 - 10) * 1 / 2 , x[4]),
          ],
        ),
      ],
    );
  }

  Widget _view6(x) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          children: [
            _image(300.0, (size.width - 32 - 10) * 2 / 3 , x[0]),
            SizedBox(width: 10,),
            Column(
              children: [
                _image(145.0, (size.width - 32 - 10) * 1 / 3 , x[1]),
                SizedBox(height: 10,),
                _image(145.0, (size.width - 32 - 10) * 1 / 3 , x[2])
              ],
            )
          ],
        ),
        SizedBox(height: 10,),
        Row(
          children: [
            _image(150.0, (size.width - 32 - 20) * 1 / 3 , x[3]),
            SizedBox(width: 10,),
            _image(150.0, (size.width - 32 - 20) * 1 / 3 , x[4]),
            SizedBox(width: 10,),
            _image(150.0, (size.width - 32 - 20) * 1 / 3 , x[5]),
          ],
        ),
      ],
    );
  }

  _image(h , w, img) => Container(
    height: h,
    width: w,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        image: DecorationImage(
          image: NetworkImage(img),
          fit: BoxFit.cover,
        )
    ),
  );

  Widget info(x) {
    var size = MediaQuery.of(context).size;
    return Row(
      children: [
        Container(
          width: size.width * 0.65,
          height: size.height * 0.12,
          padding: EdgeInsets.only(right: 16, top: 16, bottom: 16, left: 24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey[100],
          ),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  x["name"] + ', ' + (DateTime.now().year - int.parse(x["birthday"].toString().substring(x["birthday"].toString().length - 4))).toString(),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 10,
                ),
                x["status"] == 'Online'
                    ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.circle,
                      color: Colors.green,
                      size: 12,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Online',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,),
                    )
                  ],
                )
                    : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.circle,
                      color: Colors.grey,
                      size: 12,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Offline',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,),
                    )
                  ],
                )
              ]),
        ),
        SizedBox(
          width: 8,
        ),
        Expanded(
          child: Container(
            height: size.height * 0.12,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey[100],
            ),
            child: Center(
              child: Container(
                padding: EdgeInsets.all(18),
                decoration: ShapeDecoration(
                  shape: CircleBorder(),
                  color: Colors.pink,
                ),
                child: Icon(
                  x["sex"] == "Nam" ? FontAwesomeIcons.mars : x["sex"] == "Nữ" ? FontAwesomeIcons.venus : FontAwesomeIcons.transgender,
                  color: white,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget bio_character(x) {
    int index = -1;
    var size = MediaQuery.of(context).size;
    if (x["interesting_fact"] != null) {
      for (int i = 0; i < characters_16_data.length; i++) {
        if (characters_16_data[i]["name"] == x["interesting_fact"]) {
          index = i;
        }
      }
    }
    return Row(
      children: [
        x["interesting_fact"] != "" ? Container(
          height: size.height / 4,
          width: size.width / 4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey[100],),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: ShapeDecoration(
                    shape: CircleBorder(),
                  ),
                  child: SvgPicture.asset(characters_16_data[index]["image"]),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                    characters_16_data[index]["name"] + '\n' + characters_16_data[index]["who"],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    )),
              ],
            ),
          ),
        ) : Container(height: 0, width: 0,),
        SizedBox(
          width: x["interesting_fact"] != "" ? 10 : 0,
        ),
        Stack(children: [
          Container(
            width: x["interesting_fact"] != "" ? (size.width * 0.75) - 42 : size.width - 32,
            height: size.height / 4,
            padding:
            EdgeInsets.only(right: 16, left: 16, top: 40, bottom: 40),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey[100]),
            child: Center(
              child: Text(x["bio"],
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                  )),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                  padding: EdgeInsets.only(left: 16, top: 16),
                  child: FaIcon(
                    FontAwesomeIcons.quoteLeft,
                    color: Colors.black,
                    size: 13,
                  )),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                  padding: EdgeInsets.only(right: 16, bottom: 16),
                  child: FaIcon(
                    FontAwesomeIcons.quoteRight,
                    color: Colors.black,
                    size: 13,
                  )),
            ),
          ),
        ]),
      ],
    );
  }

  Widget distance_job(x,y) {
    var size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: size.width * 0.45,
          height: size.height * 0.12,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey[100],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                OpenIconicIcons.mapMarker,
                color: Colors.black,
                size: 20,
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                  "Cách bạn \n" +
                      calculateDistance(
                          double.parse(y["latitude"]),
                          double.parse(y["longitude"]),
                          double.parse(x["latitude"]),
                          double.parse(x["longitude"]))
                          .toStringAsFixed(2) +
                      ' km',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black))
            ],
          ),
        ),
        Container(
          width: size.width * 0.45,
          height: size.height * 0.12,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey[100],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FaIcon(
                FontAwesomeIcons.suitcase,
                color: Colors.black,
                size: 20,
              ),
              SizedBox(
                width: 15,
              ),
              Text(x["job"],
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black))
            ],
          ),
        )
      ],
    );
  }

  Widget height_address(x) {
    var size = MediaQuery.of(context).size;
    return Row(
      children: [
        Expanded(
          child: Container(
            height: size.height * 0.12,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey[100],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FaIcon(
                  FontAwesomeIcons.ruler,
                  color: Colors.black,
                  size: 22,
                ),
                SizedBox(
                  height: x["height"] !=  "" ? 10 : 0,
                ),
                Text(x["height"] !=  "" ? x["height"] + ' cm' : "",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ))
              ],
            ),
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Container(
          width: size.width * 0.65,
          height: size.height * 0.12,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey[100],
          ),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FaIcon(
                  FontAwesomeIcons.mapMarkedAlt,
                  color: Colors.black,
                ),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Text(
                    x["address"],
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
              ]),
        )
      ],
    );
  }

  Widget chacracter_styleDating(x) {
    var size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            width: size.width * 0.45,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey[100],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  FaIcon(
                    FontAwesomeIcons.smile,
                    color: Colors.black,
                    size: 18,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Tính cách',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black))
                ]),
                SizedBox(
                  height: 10,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: x["characters"].length,
                    itemBuilder: (context, i) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [x["characters"][i] == ""?  Container(height: 0, width: 0,) : card(x["characters"][i])],
                      );
                    }),
              ],
            )),
        Container(
            width: size.width * 0.45,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey[100],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  FaIcon(
                    FontAwesomeIcons.heart,
                    color: Colors.black,
                    size: 18,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Kiểu hẹn hò',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black))
                ]),
                SizedBox(
                  height: 10,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: x["styles_dating"].length,
                    itemBuilder: (context, i) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [x["styles_dating"][i] == ""?  Container(height: 0, width: 0,) : card(x["styles_dating"][i])],
                      );
                    }),
              ],
            )),
      ],
    );
  }

  Widget hobbies(x) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.grey[100], borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(children: [
            FaIcon(
              FontAwesomeIcons.music,
              color: Colors.black,
              size: 18,
            ),
            SizedBox(
              width: 10,
            ),
            Text('Sở thích',
                style: TextStyle(
                  fontSize: 15, color: Colors.black, fontWeight: FontWeight.w500,))
          ]),
          SizedBox(
            height: 10,
          ),
          // ListView.builder(
          //     shrinkWrap: true,
          //     physics: ScrollPhysics(),
          //     itemCount: widget.user.hobbies!.length,
          //     itemBuilder: (context, i) {
          //       return Wrap(
          //         children: [card(widget.user.hobbies![i])],
          //       );
          //     }),
          Wrap(spacing: 8.0, children: _generateCard(x))
        ],
      ),
    );
  }

  Widget card(String text) {
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Container(
        padding: EdgeInsets.only(top: 8, bottom: 8, left: 14, right: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey[300],
        ),
        child: Text(text,
            style: TextStyle(
                fontSize: 15, color: Colors.black, height: 1.3)),
      ),
    );
  }

  List<Widget> _generateCard(x) {
    List<Widget> items = [];

    for (int i = 0; i < x["hobbies"].length; i++) {
      items.add(x["hobbies"][i] == ""?  Container(height: 0, width: 0,) : card(x["hobbies"][i]));
    }

    return items;
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  Widget history(x) {
    var size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.centerLeft,
      height: 150,
      child: StreamBuilder(
        stream: _firestore.collection("DATING").where("uid", isEqualTo: x["uid"]).where("status", isEqualTo: "break up").snapshots(),
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
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, i) {
                  QueryDocumentSnapshot a = snapshot.data!.docs[i];
                  return StreamBuilder(
                    stream: _firestore.collection("USER").where("uid", isEqualTo: a["herid"]).snapshots(),
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
                        QueryDocumentSnapshot data1 = snapshot.data!.docs[0];
                        return StreamBuilder(
                          stream: _firestore.collection("USER").where("uid", isEqualTo: a["uid"]).snapshots(),
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
                              QueryDocumentSnapshot data2 = snapshot.data!.docs[0];
                              return _historyCard(data1, data2, a);
                            }
                          },
                        );
                      }
                    },
                  );
                });
          }
        },
      ),
    );
  }

  Widget _historyCard(x,y,a) {
    return GestureDetector(
      onTap: (){
        _showMyDialog(x,y,a);
      },
      child: Container(
        margin: EdgeInsets.only(right: 10),
        width: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.pink,
            image: DecorationImage(
                image: NetworkImage(x["images"][0]),
                fit: BoxFit.cover
            )
        ),
      ),
    );
  }

  Future<void> _showMyDialog(x,y,a) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Chi tiết hồ sơ'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(x["images"][0]),
                          fit: BoxFit.cover
                      )
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text("Tên: ", style: TextStyle(fontWeight: FontWeight.w500),),
                    Text(x["name"]),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text("Ngày sinh: ", style: TextStyle(fontWeight: FontWeight.w500),),
                    Text(x["birthday"]),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text("Giới tính: ", style: TextStyle(fontWeight: FontWeight.w500),),
                    Text(x["sex"]),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text("Ngày bắt đầu: ", style: TextStyle(fontWeight: FontWeight.w500),),
                    Text(a["time_start"]),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text("Ngày kết thúc: ", style: TextStyle(fontWeight: FontWeight.w500),),
                    Text(a["time_end"]),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text("Người kết thúc: ", style: TextStyle(fontWeight: FontWeight.w500),),
                    Text(a["who_end"] == x["uid"] ? x["name"] : y["name"]),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text("Lí do: ", style: TextStyle(fontWeight: FontWeight.w500),),
                    Text(a["why_end"]),
                  ],
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Đóng'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
