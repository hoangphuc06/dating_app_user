import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app_user/src/colors/colors.dart';
import 'package:dating_app_user/src/page/tab/discover/tinderCard/cardProvider.dart';
import 'package:dating_app_user/src/page/tab/discover/userModel/userModel.dart';
import 'package:dating_app_user/src/page/tab/discover/view/info.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_iconic_flutter/open_iconic_flutter.dart';
import 'package:provider/provider.dart';
import 'package:fluttericon/elusive_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import "dart:math";

class TinderCard extends StatefulWidget {
  final String urlImage;
  final bool isFront;
  final userModel user;
  final userModel userCurrent;
  const TinderCard({
    Key? key,
    required this.urlImage,
    required this.user,
    required this.userCurrent,
    required this.isFront,
  }) : super(key: key);

  @override
  _TinderCardState createState() => _TinderCardState();
}

class _TinderCardState extends State<TinderCard>
    with SingleTickerProviderStateMixin {
  late AnimationController controller = AnimationController(
    duration: Duration(seconds: 3),
    vsync: this,
  );
  bool flag = false;
  @override
  void initState() {
    // TODO: implement initState
    controller = AnimationController(
      vsync: this,
    );
    controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        final provider = Provider.of<CardProvider>(context, listen: false);
        controller.reset();

        Navigator.of(context).pop();
        provider.nextUser();
      }
    });
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      final size = MediaQuery.of(context).size;
      final provider = Provider.of<CardProvider>(context, listen: false);
      provider.setScreenSize(size);
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: widget.isFront ? buildFrontCard() : buildCard(),
    );
  }

  Widget buildFrontCard() => GestureDetector(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final provider = Provider.of<CardProvider>(context);
            final position = provider.position;
            final milliseconds = provider.isDragging ? 0 : 600;

            final center = constraints.smallest.center(Offset.zero);
            final angle = provider.angle * pi / 180;
            final rotatedMatrix = Matrix4.identity()
              ..translate(center.dx, center.dy)
              ..rotateZ(angle)
              ..translate(-center.dx, -center.dy);

            return AnimatedContainer(
                curve: Curves.easeInOut,
                duration: Duration(milliseconds: milliseconds),
                transform: rotatedMatrix..translate(position.dx, position.dy),
                child: buildCard());
          },
        ),
        onPanStart: (details) {
          final provider = Provider.of<CardProvider>(context, listen: false);
          provider.startPosition(details);
        },
        onPanUpdate: (details) {
          final provider = Provider.of<CardProvider>(context, listen: false);
          provider.updatePosition(details);
        },
        onPanEnd: (details) {
          final provider = Provider.of<CardProvider>(context, listen: false);
          provider.endPosition();
        },
      );

  Widget buildCard() {
    final size = MediaQuery.of(context).size;
    return ClipRRect(
      // borderRadius: BorderRadius.circular(20),
      child: Stack(children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(widget.urlImage),
                  fit: BoxFit.cover,
                  alignment: Alignment(-0.3, 0))),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Container(
            height: size.height / 3,
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    flag
                        ? Container()
                        : showAnimatedDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext context) {
                              return Center(
                                  child: Lottie.asset('assets/heart.json',
                                      repeat: false, controller: controller,
                                      onLoaded: (composition) {
                                controller.duration = composition.duration;
                                controller.forward();
                              }));
                            },
                            animationType: DialogTransitionType.size,
                            curve: Curves.linear,
                          );
                    setState(() {
                      flag = !flag;
                    });
                    String id = (new DateTime.now().millisecondsSinceEpoch).toString();
                    FirebaseFirestore.instance.collection("LIKE").doc(id).set({
                      "id": id,
                      "uid": widget.user.uid,
                      "herid": widget.userCurrent.uid,
                    });
                  },
                  child: FaIcon(
                    FontAwesomeIcons.solidHeart,
                    color: flag ? Colors.red : white,
                    size: 30,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => InfoPage(
                                  userUid: widget.user.uid!,
                                  myUid: widget.userCurrent.uid!,
                                )));
                  },
                  child: Icon(
                    Icons.dashboard,
                    color: white,
                    size: 30,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    _showBottom();
                  },
                  child: Icon(
                    Icons.more_horiz,
                    color: white,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.all(16),
            width: size.width,
            height: size.height / 7,
            // color: Colors.black,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Colors.black.withOpacity(0.8),
              Colors.black.withOpacity(0),
            ], end: Alignment.topCenter, begin: Alignment.bottomCenter)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tên tuổi
                Row(
                  children: [
                    Icon(
                      Icons.circle,
                      color: widget.user.status == 'Online'
                          ? Colors.green
                          : Colors.grey,
                      size: 14,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        widget.user.name! +
                            ', ' +
                            (DateTime.now().year -
                                    int.parse(widget.user.birthday
                                        .toString()
                                        .substring(widget.user.birthday
                                                .toString()
                                                .length -
                                            4)))
                                .toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(
                      OpenIconicIcons.mapMarker,
                      color: white,
                      size: 14,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Cách bạn " +
                          calculateDistance(
                                  double.parse(widget.userCurrent.latitude!),
                                  double.parse(widget.userCurrent.longitude!),
                                  double.parse(widget.user.latitude!),
                                  double.parse(widget.user.longitude!))
                              .toStringAsFixed(2) +
                          " km",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  _showBottom() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
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
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                          color: primary_two,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30))),
                      alignment: Alignment.center,
                      child: Center(
                        child: _text('Thêm', 20, FontWeight.bold, white),
                      )),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: EdgeInsets.all(30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            FaIcon(
                              FontAwesomeIcons.flag,
                              color: white,
                              size: 20,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            _text(
                                'Báo cáo vi phạm', 17, FontWeight.bold, white),
                          ],
                        ),
                        Icon(
                          Icons.navigate_next,
                          color: white,
                          size: 25,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  _text(String text, double fontsize, fontweight, Color color) {
    return Text(text,
        textAlign: TextAlign.center,
        style: GoogleFonts.roboto(
            textStyle: TextStyle(
                fontSize: fontsize, fontWeight: fontweight, color: color)));
  }
}
