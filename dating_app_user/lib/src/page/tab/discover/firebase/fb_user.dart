import 'package:cloud_firestore/cloud_firestore.dart';

class UserFB {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("USER");

  Future<void> add(
    String address,
    String avatar,
    String bio,
    String birthday,
    String email,
    String height,
    String hoomtown,
    String info,
    String job,
    String name,
    String sex,
    String status,
  ) async {
    String id = (new DateTime.now().millisecondsSinceEpoch).toString();
    return FirebaseFirestore.instance
        .collection("USER")
        .doc(id)
        .set({
          "uid": id,
          "address": address,
          "avatar": avatar,
          "bio": bio,
          "birthday": birthday,
          "email": email,
          "height": height,
          "hoomtown": hoomtown,
          "info": info,
          "job": job,
          "name": name,
          "sex": sex,
          "status": status
        })
        .then((value) => print("completed"))
        .catchError((error) => print("fail"));
  }

  Future<void> update(
    String id,
    String address,
    String avatar,
    String bio,
    String birthday,
    String email,
    String height,
    String hoomtown,
    String info,
    String job,
    String name,
    String sex,
    String status,
  ) async {
    return FirebaseFirestore.instance
        .collection("USER")
        .doc(id)
        .update({
          "address": address,
          "avatar": avatar,
          "bio": bio,
          "birthday": birthday,
          "email": email,
          "height": height,
          "hoomtown": hoomtown,
          "info": info,
          "job": job,
          "name": name,
          "sex": sex,
          "status": status
        })
        .then((value) => print("completed"))
        .catchError((error) => print("fail"));
  }

  // Future<void> delete(String id) async {
  //   return FirebaseFirestore.instance
  //       .collection("contract")
  //       .doc(id)
  //       .update({"isVisible": false})
  //       .then((value) => print("completed"))
  //       .catchError((error) => print("fail"));
  // }

  // Future<void> liquidation(String id) async {
  //   return FirebaseFirestore.instance
  //       .collection("contract")
  //       .doc(id)
  //       .update({"liquidation": true})
  //       .then((value) => print("completed"))
  //       .catchError((error) => print("fail"));
  // }
}
