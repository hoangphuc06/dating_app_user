import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app_user/src/page/tab/discover/firebase/fb_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum CardStatus { like, dislike, superlike, down }

class CardProvider extends ChangeNotifier {
  List<String> _urlImages = [];
  bool _isDragging = false;
  double _angle = 0;
  Offset _position = Offset.zero;
  Size _screenSize = Size.zero;
  int temp = 0;
  String? id;
  List<String> filter1 = [];
  List<String> filter2 = [];
  List<String> filter3 = [];

  List<String> get urlImages => _urlImages;
  bool get isDragging => _isDragging;
  Offset get position => _position;
  double get angle => _angle;
  String get uid => id!;

  Future<List<String>> loadDataUser1() async {
    List<String> temp = [];
    await FirebaseFirestore.instance
        .collection('FILTER')
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((QuerySnapshot querySnapshot) async {
      await FirebaseFirestore.instance
          .collection('USER')
          .where('sex', isEqualTo: querySnapshot.docs[0]['sex'])
          .where('dating', isEqualTo: false)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((element) {
          temp.add(element.id);
        });
      });
    });

    return temp;
  }

  Future<List<String>> loadDataUser2() async {
    List<String> temp = [];
    await FirebaseFirestore.instance
        .collection('FILTER')
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((QuerySnapshot querySnapshot) async {
      await FirebaseFirestore.instance
          .collection('USER')
          .where('age',
              isGreaterThanOrEqualTo: querySnapshot.docs[0]['age_from'])
          .where('age', isLessThanOrEqualTo: querySnapshot.docs[0]['age_to'])
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((element) {
          temp.add(element.id);
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
        .where('uid',isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
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
    filter1 = await loadDataUser1();
    print(filter1);
    print('filter1');
    filter2 = await loadDataUser2();
    print(filter2);
    print('filter2');
    filter3 = filter1;
    filter3.removeWhere((item) => !filter2.contains(item));
    print(filter3);
    var temp = await loadDataUser(index, filter3);
    _urlImages = temp.reversed.toList();
    print(id);
    // _urlImages = <String>[
    //   'https://cellphones.com.vn/sforum/wp-content/uploads/2020/04/LR-29-scaled.jpg',
    //   'https://cdn.nguyenkimmall.com/images/detailed/555/may-anh-cho-nguoi-moi.jpg',
    //   'https://digitalphoto.com.vn/wp-content/uploads/2018/08/39999935574_11b6d8805f_o-1.jpg',
    //   'https://halotravel.vn/wp-content/uploads/2020/07/thach_trangg_101029297_573874646879779_1794923475739360981_n.jpg',
    //   'https://i.pinimg.com/originals/35/2b/87/352b87e5dfa5b6f689edab8fc18b61ad.jpg',
    //   'https://aphoto.vn/wp-content/uploads/2019/07/anh-chan-dung-nghe-thuat-top-aphoto5.jpg',
    //   'https://vietyouth.vn/wp-content/uploads/2018/10/ngoi-vao-la-hot-anh-dep-10-chiec-ghe-quyen-luc-vang-danh-khap-hoi-da-lat-13598.jpg',
    //   'https://photographer.vn/wp-content/uploads/2020/10/chup-anh-chan-dung-nghe-thuat5-800x1200.jpg'
    // ].reversed.toList();
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

  void dislike() {
    _angle = -20;
    _position -= Offset(_screenSize.width * 2, 0);
    _nextCard();
    notifyListeners();
  }

  void superlike() {
    temp++;
    _angle = 0;
    _position -= Offset(0, _screenSize.height);
    print(temp);
    resetUser(temp);
    resetPosition();
    notifyListeners();
  }

  void down() {
    temp--;
    _angle = 0;
    _position += Offset(0, _screenSize.height);
    print(temp);
    resetUser(temp);
    resetPosition();
    notifyListeners();
  }
}
