import 'package:dating_app_user/src/data/constData.dart';
import 'package:dating_app_user/src/data/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> with TickerProviderStateMixin{

  CardController controller = new CardController();

  List itemsTemp = [];
  int itemLength = 0;

  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      itemsTemp = discover_json;
      itemLength = discover_json.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.deepPurple, //change your color here
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions:[
          IconButton(
            icon: Icon(Icons.filter_list_alt),
            onPressed: () {},
          ),
        ],
        title: Text("Khám phá", style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: getBody(),
      //bottomSheet: getBottomSheet(),
    );
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
                      gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.25),
                            Colors.black.withOpacity(0),
                          ],
                          end: Alignment.topCenter,
                          begin: Alignment.bottomCenter)
                  ),
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
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            itemsTemp[index]['age'],
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),

                      //Trạng thái hoạt động
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle),
                          ),
                          SizedBox(width: 10,),
                          Text(
                            "Online",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 10,),
                      Text(
                        "Đến từ " + itemsTemp[index]['hometown'],
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 10,),
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
}
