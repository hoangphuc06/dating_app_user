import 'package:dating_app_user/src/colors/colors.dart';
import 'package:dating_app_user/src/page/tab/discover/userModel/userModel.dart';
import 'package:dating_app_user/src/page/tab/discover/view/image.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/rpg_awesome_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:open_iconic_flutter/open_iconic_flutter.dart';
import "dart:math";

class InfoPage extends StatefulWidget {
  final userModel user;
  final userModel userCurrent;
  const InfoPage({Key? key, required this.user, required this.userCurrent})
      : super(key: key);

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  void initState() {
    // TODO: implement initState
    print(widget.user.images![0]);
  }

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
      body: Container(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              widget.user.images!.length == 1
                  ? Container(
                      width: size.width,
                      height: size.height / 2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              image: NetworkImage(widget.user.images![0]),
                              fit: BoxFit.cover,
                              alignment: Alignment(-0.3, 0))),
                    )
                  : image(size),
              info(size),
              SizedBox(
                height: 8,
              ),
              bio_character(size),
              SizedBox(
                height: 8,
              ),
              distance(size),
              SizedBox(
                height: 8,
              ),
              height_address(size),
              SizedBox(
                height: 8,
              ),
              chacracter_styleDating(size),
              SizedBox(
                height: 8,
              ),
              hobbies(size)
            ],
          ),
        ),
      ),
    );
  }

  Widget image(Size size) {
    double border = 20;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ImagePage(
                              user: widget.user,
                              index: 0,
                            )));
              },
              child: Container(
                width: size.width * 0.605,
                height: size.height / 3,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(border),
                    image: DecorationImage(
                        image: NetworkImage(widget.user.images![0]),
                        fit: BoxFit.cover,
                        alignment: Alignment(-0.3, 0))),
              ),
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ImagePage(
                                  user: widget.user,
                                  index: 1,
                                )));
                  },
                  child: Container(
                    width: size.width * 0.295,
                    height: size.height / 6.2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(border),
                        image: DecorationImage(
                            image: NetworkImage(widget.user.images![1]),
                            fit: BoxFit.cover,
                            alignment: Alignment(-0.3, 0))),
                  ),
                ),
                SizedBox(height: 8),
                widget.user.images![2] != ""
                    ? GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ImagePage(
                                        user: widget.user,
                                        index: 2,
                                      )));
                        },
                        child: Container(
                          width: size.width * 0.295,
                          height: size.height / 6.2,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(border),
                              image: DecorationImage(
                                  image: NetworkImage(widget.user.images![2]),
                                  fit: BoxFit.cover,
                                  alignment: Alignment(-0.3, 0))),
                        ),
                      )
                    : Container(
                        height: size.height / 6.2,
                      ),
              ],
            )
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            widget.user.images![3] != ""
                ? GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ImagePage(
                                    user: widget.user,
                                    index: 3,
                                  )));
                    },
                    child: Container(
                      width: size.width * 0.295,
                      height: size.height / 6.2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(border),
                          image: DecorationImage(
                              image: NetworkImage(widget.user.images![3]),
                              fit: BoxFit.cover,
                              alignment: Alignment(-0.3, 0))),
                    ),
                  )
                : Container(),
            widget.user.images![4] != ""
                ? GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ImagePage(
                                    user: widget.user,
                                    index: 4,
                                  )));
                    },
                    child: Container(
                      width: size.width * 0.295,
                      height: size.height / 6.2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(border),
                          image: DecorationImage(
                              image: NetworkImage(widget.user.images![4]),
                              fit: BoxFit.cover,
                              alignment: Alignment(-0.3, 0))),
                    ),
                  )
                : Container(),
            widget.user.images![5] != ""
                ? GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ImagePage(
                                    user: widget.user,
                                    index: 5,
                                  )));
                    },
                    child: Container(
                      width: size.width * 0.295,
                      height: size.height / 6.2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(border),
                          image: DecorationImage(
                              image: NetworkImage(widget.user.images![5]),
                              fit: BoxFit.cover,
                              alignment: Alignment(-0.3, 0))),
                    ),
                  )
                : Container(),
          ],
        )
      ],
    );
  }

  Widget info(Size size) {
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
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.user.name! +
                      ', ' +
                      (DateTime.now().year -
                              int.parse(widget.user.birthday
                                  .toString()
                                  .substring(
                                      widget.user.birthday.toString().length -
                                          4)))
                          .toString(),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 10,
                ),
                widget.user.status == 'Online'
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        //mainAxisAlignment: MainAxisAlignment.center,
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
          child: Stack(children: [
            Container(
              height: size.height * 0.12,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.deepPurple,
              ),
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(18),
                  decoration: ShapeDecoration(
                    shape: CircleBorder(),
                    color: Colors.pink,
                  ),
                  child: Icon(
                    RpgAwesome.taurus,
                    color: white,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: ShapeDecoration(
                    shape: CircleBorder(),
                    color: Colors.black,
                  ),
                  child: Container(
                      padding: EdgeInsets.all(1),
                      decoration: ShapeDecoration(
                        shape: CircleBorder(),
                        color: Colors.grey,
                      ),
                      child: FaIcon(
                        FontAwesomeIcons.infoCircle,
                        color: white,
                        size: 20,
                      ))),
            ),
          ]),
        )
      ],
    );
  }

  Widget bio_character(Size size) {
    return widget.user.interesting_fact != ""
        ? Row(
            children: [
              Expanded(
                child: Container(
                  height: size.height / 3,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[100],),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: ShapeDecoration(
                              shape: CircleBorder(),
                              image: DecorationImage(
                                  image: NetworkImage(widget.user.images![0]),
                                  fit: BoxFit.cover,
                                  alignment: Alignment(-0.3, 0))),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                            widget.user.interesting_fact!.substring(0, 4) +
                                '\n' +
                                widget.user.interesting_fact!.substring(4),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                            )),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Stack(children: [
                Container(
                  width: size.width * 0.605,
                  height: size.height / 3,
                  padding:
                      EdgeInsets.only(right: 16, left: 16, top: 40, bottom: 40),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[100]),
                  child: Center(
                    child: Text(widget.user.bio!,
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
          )
        : Container(
            child: Stack(children: [
              ConstrainedBox(
                constraints: new BoxConstraints(
                  minHeight: size.height * 0.12,
                  minWidth: 5.0,
                ),
                child: Container(
                  padding:
                      EdgeInsets.only(right: 16, left: 16, top: 40, bottom: 40),
                  width: size.width,
                  // height: size.height / 3,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[100],),
                  child: Center(
                    child: Text(widget.user.bio!,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.normal)),
                  ),
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
          );
  }

  Widget distance(Size size) {
    return widget.user.job == ""
        ? Container(
            width: size.width,
            height: size.height * 0.12,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.deepPurple,
            ),
            child: Row(
              children: [
                Icon(
                  OpenIconicIcons.mapMarker,
                  color: white,
                  size: 20,
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  "Cách bạn\n" +
                    calculateDistance(
                                double.parse(widget.userCurrent.latitude!),
                                double.parse(widget.userCurrent.longitude!),
                                double.parse(widget.user.latitude!),
                                double.parse(widget.user.longitude!))
                            .toStringAsFixed(2) +
                        ' km',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: white))
              ],
            ),
          )
        : Row(
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
                                    double.parse(widget.userCurrent.latitude!),
                                    double.parse(widget.userCurrent.longitude!),
                                    double.parse(widget.user.latitude!),
                                    double.parse(widget.user.longitude!))
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
                  children: [
                    FaIcon(
                      FontAwesomeIcons.suitcase,
                      color: Colors.black,
                      size: 20,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(widget.user.job!,
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black))
                  ],
                ),
              )
            ],
          );
  }

  Widget height_address(Size size) {
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
              children: [
                FaIcon(
                  FontAwesomeIcons.ruler,
                  color: Colors.black,
                  size: 22,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(widget.user.height! + ' cm',
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
        widget.user.address != ""
            ? Container(
                width: size.width * 0.65,
                height: size.height * 0.12,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[100],
                ),
                child: Row(children: [
                  FaIcon(
                    FontAwesomeIcons.mapMarkedAlt,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Text(
                      widget.user.address!,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                      ),
                    ),
                  ),
                ]),
              )
            : Container(
                width: size.width * 0.65,
                height: size.height * 0.12,
              ),
      ],
    );
  }

  Widget chacracter_styleDating(Size size) {
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
                    itemCount: widget.user.characters!.length,
                    itemBuilder: (context, i) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [card(widget.user.characters![i])],
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
                    itemCount: widget.user.styles_dating!.length,
                    itemBuilder: (context, i) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [card(widget.user.styles_dating![i])],
                      );
                    }),
              ],
            )),
      ],
    );
  }

  Widget hobbies(Size size) {
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
          Wrap(spacing: 8.0, children: _generateCard())
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
                fontSize: 15, color: Colors.black)),
      ),
    );
  }

  List<Widget> _generateCard() {
    List<Widget> items = [];

    for (int i = 0; i < widget.user.hobbies!.length; i++) {
      items.add(card(widget.user.hobbies![i]));
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
}
