import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Detail16CharactersPage extends StatefulWidget {
  final data;
  const Detail16CharactersPage({Key? key, required this.data}) : super(key: key);

  @override
  _Detail16CharactersPageState createState() => _Detail16CharactersPageState();
}

class _Detail16CharactersPageState extends State<Detail16CharactersPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.deepPurple, //change your color here
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Text(
                  this.widget.data["name"] + " - " + this.widget.data["who"],
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                      fontSize: 20
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Center(
                child: Container(

                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(this.widget.data["image"]),
                ),
              ),
              SizedBox(height: 20,),
              Center(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    _lable(this.widget.data["tag"][0]),
                    _lable(this.widget.data["tag"][1]),
                    _lable(this.widget.data["tag"][2])
                  ],
                ),
              ),

              SizedBox(height: 20,),
              _descr(this.widget.data["description"]),

              SizedBox(height: 20,),
              _title("Điểm mạnh"),
              SizedBox(height: 10,),
              Wrap(
                runSpacing: 10,
                spacing: 15,
                children: [
                  _lable2(this.widget.data["strong"][0]),
                  _lable2(this.widget.data["strong"][1]),
                  _lable2(this.widget.data["strong"][2]),
                ],
              ),

              SizedBox(height: 20,),
              _title("Điểm yếu"),
              SizedBox(height: 10,),
              Wrap(
                runSpacing: 10,
                spacing: 15,
                children: [
                  _lable3(this.widget.data["weak"][0]),
                  _lable3(this.widget.data["weak"][1]),
                  _lable3(this.widget.data["weak"][2]),
                ],
              ),

              SizedBox(height: 20,),
              _title("Nghề nghiệp"),
              SizedBox(height: 10,),
              Wrap(
                runSpacing: 10,
                spacing: 15,
                children: [
                  _lable4(this.widget.data["job"][0]),
                  _lable4(this.widget.data["job"][1]),
                  _lable4(this.widget.data["job"][2]),
                  _lable4(this.widget.data["job"][3]),
                ],
              ),

              SizedBox(height: 20,),
              _title("Nối quan hệ"),
              SizedBox(height: 10,),
              Wrap(
                runSpacing: 10,
                spacing: 15,
                children: [
                  _lable5(this.widget.data["love"][0]),
                  _lable5(this.widget.data["love"][1]),
                  _lable5(this.widget.data["love"][2]),
                  _lable5(this.widget.data["love"][3]),
                ],
              ),

              SizedBox(height: 20,),
              _title("Bạn bè"),
              SizedBox(height: 10,),
              Wrap(
                runSpacing: 10,
                spacing: 15,
                children: [
                  _lable6(this.widget.data["friend"][0]),
                  _lable6(this.widget.data["friend"][1]),
                  _lable6(this.widget.data["friend"][2]),
                  _lable6(this.widget.data["friend"][3]),
                ],
              ),

              SizedBox(height: 30,)
            ],
          ),
        ),
      ),
    );
  }

  _lable(String text) => Container(
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.deepPurple.withOpacity(0.2)
    ),
    child: Text(
      text,
      style: TextStyle(
          fontSize: 15
      ),
    ),
  );

  _lable2(String text) => Container(
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.orange.withOpacity(0.2)
    ),
    child: Text(
      text,
      style: TextStyle(
          fontSize: 15
      ),
    ),
  );

  _lable3(String text) => Container(
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.blue.withOpacity(0.2)
    ),
    child: Text(
      text,
      style: TextStyle(
          fontSize: 15
      ),
    ),
  );

  _lable4(String text) => Container(
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.pink.withOpacity(0.2)
    ),
    child: Text(
      text,
      style: TextStyle(
          fontSize: 15
      ),
    ),
  );

  _lable5(String text) => Container(
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.teal.withOpacity(0.2)
    ),
    child: Text(
      text,
      style: TextStyle(
          fontSize: 15
      ),
    ),
  );

  _lable6(String text) => Container(
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.brown.withOpacity(0.2)
    ),
    child: Text(
      text,
      style: TextStyle(
          fontSize: 15
      ),
    ),
  );
  
  _title(String text) => Text(
    text,
    style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w500
    ),
  );

  _descr(String text) => Text(
    text,
    style: TextStyle(
      fontSize: 15,
      color: Colors.black,
      height: 1.25
    ),
    textAlign: TextAlign.justify,
  );
}
