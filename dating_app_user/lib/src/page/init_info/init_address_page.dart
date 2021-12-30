import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app_user/src/page/init_info/init_filter_sex_page.dart';
import 'package:dating_app_user/src/widgets/buttons/main_button.dart';
import 'package:dating_app_user/src/widgets/dialogs/loading_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class InitAddressPage extends StatefulWidget {
  const InitAddressPage({Key? key}) : super(key: key);

  @override
  _InitAddressPageState createState() => _InitAddressPageState();
}

class _InitAddressPageState extends State<InitAddressPage> {

  String? latitude;
  String? longitude;
  String? address;

  bool _isload = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    load();
  }

  Future<void> load() async {
    Position position = await _determinePosition();
    print(position.longitude);
    print(position.latitude);
    setState(() {
      longitude = position.longitude.toString();
      latitude = position.latitude.toString();
    });
    GetAddressFromLatLong(position);
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemark = await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemark[0];
    String new_address = place.subAdministrativeArea.toString() + ", " + place.administrativeArea.toString();
    setState(() {
      address = new_address;
      _isload = false;
    });
    print(address);
  }

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
      body: Container(
        padding: EdgeInsets.only(left: 32, right: 32, bottom: 32, top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Chỗ ở \nhiện tại của bạn ? 🏠",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      color: Colors.black
                  ),
                ),
                SizedBox(height: 20,),
                _description("Cập nhật đúng vị trí của bạn để có thể tìm ra những người phù hợp gần bạn nhất."),
              ],
            ),
            _isload == true ? Center(
              child: Container(
                height: size.height / 20,
                width: size.height / 20,
                child: CircularProgressIndicator(),
              ),
            ) : Center(
              child: Column(
                children: [
                  Text(
                    address!,
                    style: TextStyle(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.w500,
                        fontSize: 20
                    ),
                  ),
                  SizedBox(height: 10,),
                  GestureDetector(
                    onTap: load,
                    child: Text("Cập nhật địa chỉ"),
                  )
                ],
              ),
            ),
            MainButton(name: "Lưu", onpressed: (){
              onClick();
            })
          ],
        ),
      ),
    );
  }

  void onClick() {
    print(address);
    print(longitude);
    print(latitude);

    LoadingDialog.showLoadingDialog(context, "Đang lưu...");

    FirebaseFirestore.instance.collection("USER").doc(
        FirebaseAuth.instance.currentUser!.uid).update({
      "address": address,
      "longitude": longitude,
      "latitude": latitude,
    }).then((value) =>
    {

      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => InitFilterSexPage())),

    });
  }

  _description(String description) => Text(
    description,
    style: TextStyle(
        color: Colors.black.withOpacity(0.5),
        fontWeight: FontWeight.w400
    ),
    textAlign: TextAlign.justify,
  );
}
