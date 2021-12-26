import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app_user/src/colors/colors.dart';
import 'package:dating_app_user/src/page/tab/discover/tinderCard/cardProvider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:open_iconic_flutter/open_iconic_flutter.dart';
import 'package:provider/provider.dart';
import 'package:fluttericon/elusive_icons.dart';

import "dart:math";

class TinderCard extends StatefulWidget {
  final String urlImage;
  final bool isFront;

  const TinderCard(
      {Key? key,
      required this.urlImage,
      required this.isFront,
     })
      : super(key: key);

  @override
  _TinderCardState createState() => _TinderCardState();
}

class _TinderCardState extends State<TinderCard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      final size = MediaQuery.of(context).size;

      final provider = Provider.of<CardProvider>(context, listen: false);
      provider.setScreenSize(size);
    });
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
            final milliseconds = provider.isDragging ? 0 : 400;

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
                FaIcon(
                  FontAwesomeIcons.solidHeart,
                  color: white,
                  size: 30,
                ),
                SizedBox(
                  height: 20,
                ),
                Icon(
                  Icons.dashboard,
                  color: white,
                  size: 30,
                ),
                SizedBox(
                  height: 20,
                ),
                Icon(
                  Icons.more_horiz,
                  color: white,
                  size: 30,
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
            height: size.height / 8,
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
                      color: Colors.green,
                      size: 14,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                       'Huyền An, 19',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
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
                      "Cách bạn 4.3 km",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
