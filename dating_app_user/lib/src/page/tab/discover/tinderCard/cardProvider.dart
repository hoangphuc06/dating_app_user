import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app_user/src/page/tab/discover/firebase/fb_user.dart';
import 'package:dating_app_user/src/page/tab/discover/userModel/userModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:math';

enum CardStatus { like, dislike, superlike, down }

class CardProvider extends ChangeNotifier {
  List<String> _urlImages = [];
  bool _isDragging = false;
  double _angle = 0;
  Offset _position = Offset.zero;
  Size _screenSize = Size.zero;
  int temp = 0;
  userModel user = new userModel();
  userModel usercurrent = new userModel();
  String? id;
  List<String> filter = [];

  List<String> get urlImages => _urlImages;
  bool get isDragging => _isDragging;
  Offset get position => _position;
  double get angle => _angle;
  String get uid => id!;
  userModel get usermodel => user;
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

  Future<List<String>> loadDataUser(int index, List list) async {
    List<String> temp = [];
    await FirebaseFirestore.instance
        .collection('USER')
        .where('uid', whereIn: list)
        .where('uid', isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      print(querySnapshot.docs[index]['images'].toString());
      id = querySnapshot.docs[index].id;
      user = userModel.fromDocument(querySnapshot.docs[index]);
      temp = querySnapshot.docs[index]['images']
          .toString()
          .replaceAll('[', "")
          .replaceAll(']', "")
          .split(', ');
    });

    return temp;
  }

  CardProvider() {
    resetUser(0);
  }

  void setScreenSize(Size sreenSize) => _screenSize = sreenSize;
  void resetIndex(int index) {
    temp = index;
    notifyListeners();
  }

  void startPosition(DragStartDetails details) {
    _isDragging = true;
    notifyListeners();
  }

  void updatePosition(DragUpdateDetails details) {
    _position += details.delta;
    final x = _position.dx;
    _angle = 45 * x / _screenSize.width;
    notifyListeners();
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
      case CardStatus.superlike:
        superlike();
        break;
      case CardStatus.down:
        down();
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
    final delta = 100;

    if (x >= delta) {
      print('right');
      return CardStatus.like;
    } else {
      if (x <= -delta) {
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

  void resetUser(int index) async {
    filter = await loadDataFilter1();
    print(filter);

    if (filter.length != 0) {
      var temp = await loadDataUser(index, filter);
      temp.removeWhere((item) => item == "");
      print(temp);
      _urlImages = temp.reversed.toList();
      print(id);
      print(user.images);
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
    if (_urlImages.isEmpty) return;
    await Future.delayed(Duration(milliseconds: 200));
    _urlImages.removeLast();
    resetPosition();
  }

  Future _preCard() async {
    if (_urlImages.isEmpty) return;
    await Future.delayed(Duration(milliseconds: 200));
    _urlImages.removeLast();
    resetPosition();
  }

  void dislike() {
    _angle = -20;
    _position -= Offset(_screenSize.width * 2, 0);
    _nextCard();
    notifyListeners();
  }

  void superlike() {
    if (temp < filter.length - 1) {
      temp++;
      _angle = 0;
      _position -= Offset(0, _screenSize.height);
      print(temp);
      resetUser(temp);
      resetPosition();
      notifyListeners();
    } else {
      _angle = 0;
      _position -= Offset(0, _screenSize.height);
      print(temp);
      resetPosition();
      notifyListeners();
    }
  }

  void nextUser() {
    if (temp < filter.length - 1) {
      temp++;
      _angle = 0;
      _position -= Offset(0, _screenSize.height);
      print(temp);
      resetUser(temp);
      resetPosition();
      notifyListeners();
    } else {}
  }

  void down() {
    print(temp);
    if (temp > 0) {
      temp--;
      _angle = 0;
      _position += Offset(0, _screenSize.height);
      print(temp);
      resetUser(temp);
      resetPosition();
      notifyListeners();
    } else {
      _angle = 0;
      _position += Offset(0, _screenSize.height);
      print(temp);

      resetPosition();
      notifyListeners();
    }
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
