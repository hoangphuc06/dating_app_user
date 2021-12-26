import 'package:cloud_firestore/cloud_firestore.dart';

class FilterFB {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("FILTER");

  Future<void> add(
    String id,
    String age_from,
    String age_to,
    String distance_from,
    String distance_to,
    String sex,
  ) async {
    return FirebaseFirestore.instance
        .collection("FILTER")
        .doc(id)
        .set({
          "uid": id,
          "age_from": age_from,
          "age_to": age_to,
          "distance_from": distance_from,
          "distance_to": distance_to,
          "sex": sex,
        })
        .then((value) => print("completed"))
        .catchError((error) => print("fail"));
  }

  Future<void> update(
    String id,
    int age_from,
    int age_to,
    String distance_from,
    String distance_to,
    String sex,
  ) async {
    return FirebaseFirestore.instance
        .collection("FILTER")
        .doc(id)
        .update({
          "age_from": age_from,
          "age_to": age_to,
          "distance_from": distance_from,
          "distance_to": distance_to,
          "sex": sex,
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
