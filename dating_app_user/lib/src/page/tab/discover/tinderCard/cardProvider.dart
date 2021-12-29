import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app_user/src/page/tab/discover/firebase/fb_user.dart';
import 'package:dating_app_user/src/page/tab/discover/userModel/userModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:math';

enum CardStatus { like, dislike, superlike, down }

class CardProvider extends ChangeNotifier {
  List<userModel> _listUser = [];
  bool _isDragging = false;
  double _angle = 0;
  Offset _position = Offset.zero;
  Size _screenSize = Size.zero;
  int _index = 0;

  userModel usercurrent = new userModel();

  List<String> filter = [];

  List<userModel> get listUser => _listUser;
  bool get isDragging => _isDragging;
  Offset get position => _position;
  double get angle => _angle;

  userModel get userCurrent => usercurrent;
  Future<List<String>> loadDataFilter1() async {
    List<String> temp = [];
    await FirebaseFirestore.instance
        .collection('USER')
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((QuerySnapshot q1) async {
      usercurrent = userModel.fromDocument(q1.docs[0]);
      await FirebaseFirestore.instance
          .collection('FILTER')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((QuerySnapshot q2) async {
        await FirebaseFirestore.instance
            .collection('USER')
            .where('sex', isEqualTo: q2.docs[0]['sex'])
            .where('dating', isEqualTo: 'false')
            .get()
            .then((QuerySnapshot q) {
          q.docs.forEach((element) {
            print((DateTime.now().year -
                int.parse(element['birthday']
                    .toString()
                    .substring(element['birthday'].toString().length - 4))));
            if ((DateTime.now().year -
                        int.parse(element['birthday'].toString().substring(
                            element['birthday'].toString().length - 4))) >=
                    int.parse(q2.docs[0]['age_from'].toString()) &&
                (DateTime.now().year -
                        int.parse(element['birthday'].toString().substring(
                            element['birthday'].toString().length - 4))) <=
                    int.parse(q2.docs[0]['age_to'].toString()) &&
                calculateDistance(
                        double.parse(q1.docs[0]['latitude']),
                        double.parse(q1.docs[0]['longitude']),
                        double.parse(element['latitude']),
                        double.parse(element['longitude'])) <=
                    double.parse(q2.docs[0]['distance_to']))
              temp.add(element.id);
          });
        });
      });
    });

    return temp;
  }

  Future<List<userModel>> loadDataUser(List list) async {
    List<userModel> temp = [];
    userModel user;
    await FirebaseFirestore.instance
        .collection('USER')
        .where('uid', whereIn: list)
        .where('uid', isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((x) {
        user = userModel.fromDocument(x);
        temp.add(user);
      });
    });

    return temp;
  }

  CardProvider() {
    resetUser();
  }

  void setScreenSize(Size sreenSize) => _screenSize = sreenSize;
  // void resetIndex(int index) {
  //   temp = index;
  //   notifyListeners();
  // }

  void startPosition(DragStartDetails details) {
    _isDragging = true;
    notifyListeners();
  }

  void updatePosition(DragUpdateDetails details) {
    if (details.delta.dy >= _position.dy) {
      _position += details.delta;
      final x = _position.dx;
      _angle = 45 * x / _screenSize.width;
      notifyListeners();
    }
  }

  void endPosition() {
    _isDragging = false;
    notifyListeners();

    final status = getStatus();

    // if (status != null) {
    //   Fluttertoast.showToast(msg: 'asd', fontSize: 36);
    // }

    switch (status) {
      case CardStatus.like:
        like();
        break;
      case CardStatus.dislike:
        dislike();
        break;

      default:
        resetPosition();
    }
  }

  void resetPosition() {
    _isDragging = false;
    _position = Offset.zero;
    _angle = 0;
    notifyListeners();
  }

  CardStatus? getStatus() {
    final x = _position.dx;
    final y = _position.dy;
    final forceSuperLike = x.abs() < 20;
    final delta = 20;

    if (x > delta) {
      print('right');
      return CardStatus.like;
    } else {
      if (x < -delta) {
        print('left');
        return CardStatus.dislike;
      } else {
        if (y <= -delta / 2 && forceSuperLike) {
          print('up');
          return CardStatus.superlike;
        } else {
          if (y > delta / 2 && forceSuperLike) {
            print('down');
            return CardStatus.down;
          }
        }
      }
    }
  }

  void resetUser() async {
    filter = await loadDataFilter1();

    if (filter.length != 0) {
      var temp = await loadDataUser(filter);

      _listUser = temp.reversed.toList();
    }

    notifyListeners();
  }

  void like() {
    _angle = 20;
    _position += Offset(_screenSize.width * 2, 0);
    _nextCard();
    notifyListeners();
  }

  Future _nextCard() async {
    if (_listUser.isEmpty) return;
    await Future.delayed(Duration(milliseconds: 200));
    _listUser.removeLast();
    resetPosition();
  }

  void dislike() {
    _angle = -20;
    _position -= Offset(_screenSize.width * 2, 0);
    _nextCard();
    notifyListeners();
  }

  void nextUser() {
    _nextCard();
    notifyListeners();
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }
}
