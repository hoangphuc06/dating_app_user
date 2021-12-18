import 'package:dating_app_user/src/page/init_info/init_name_page.dart';
import 'package:dating_app_user/src/widgets/buttons/main_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class InitInfoPage extends StatefulWidget {
  const InitInfoPage({Key? key}) : super(key: key);

  @override
  _InitInfoPageState createState() => _InitInfoPageState();
}

class _InitInfoPageState extends State<InitInfoPage> {

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height * 0.1,),
                Text(
                  "iLove chào bạn,",
                  style: TextStyle(
                    color: Colors.pink,
                    fontSize: 25,
                    fontWeight: FontWeight.w500
                  ),
                ),
                SizedBox(height: 10,),
                Wrap(
                  children: [
                    Text(
                      "iLove là 1 ứng dụng hẹn hò và thêm bạn. Bất kì ai cảm thấy cô đơn hoặc muốn có những mối quan hệ xịn xò vô lo, iLove là một nền tảng sẽ biến điều đó thành hiện thực. Cùng xác thực hồ sơ để gặp người trong mơ thôi nè!",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: Colors.black,
                        height: 1.5,
                        fontSize: 15
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20,),
                Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Team iLove tặng bạn trái tym to bự 💖",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.05,),
                SvgPicture.asset("assets/image/couple.svg", height: size.height * 0.4,),
              ],
            ),
            MainButton(name: "Tôi hiểu", onpressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => InitNamePage()));
            })
          ],
        ),
      ),
    );
  }

}
