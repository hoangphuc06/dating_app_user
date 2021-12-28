import 'package:dating_app_user/src/page/tab/discover/userModel/userModel.dart';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

class ImagePage extends StatefulWidget {
  final userModel user;
  final int index;
  const ImagePage({Key? key, required this.user, required this.index})
      : super(key: key);

  @override
  _ImagePageState createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  int page = 1;
  late LiquidController liquidController;
  @override
  void initState() {
    liquidController = LiquidController();
    widget.user.images!.removeWhere((item) => item == "");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          "Hình ảnh",
          style:
              TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
    
      body: LiquidSwipe.builder(
        itemCount: widget.user.images!.length,
        itemBuilder: (context, index) {
          return Container(
            width: double.infinity,
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(widget.user.images![index]),
                      fit: BoxFit.cover,
                      alignment: Alignment(-0.3, 0))),
            ),
          );
        },
        initialPage: widget.index,
        waveType: WaveType.circularReveal,
        liquidController: liquidController,
        fullTransitionValue: 880,
        enableSideReveal: true,
        enableLoop: true,
        ignoreUserGestureWhileAnimating: true,
      ),
    );
  }

  pageChangeCallback(int lpage) {
    setState(() {
      page = lpage;
    });
  }
}
