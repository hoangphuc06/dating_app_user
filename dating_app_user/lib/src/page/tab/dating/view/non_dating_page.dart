import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NonDatingPage extends StatefulWidget {
  const NonDatingPage({Key? key}) : super(key: key);

  @override
  _NonDatingPageState createState() => _NonDatingPageState();
}

class _NonDatingPageState extends State<NonDatingPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/image/love1.svg", height: size.height * 0.23,),
              SizedBox(height: 20,),
              Text(
                "Bạn không có ai để hẹn hò 😢",
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 20,
                  fontWeight: FontWeight.w500
                ),
              ),
              SizedBox(height: 5,),
              Text(
                "Đi tới phần Khám phá và tìm ngay cho mình \nmột người thích hợp nào.",
                style: TextStyle(
                    color: Colors.black,
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
