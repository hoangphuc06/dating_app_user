import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app_user/src/page/tab/discover/firebase/fb_user.dart';
import 'package:flutter/material.dart';

enum CardStatus { like, dislike, superlike }

class CardProvider extends ChangeNotifier {
  List<String> _urlImages = [];
  bool _isDragging = false;
  double _angle = 0;
  Offset _position = Offset.zero;
  Size _screenSize = Size.zero;

  List<String> get urlImages => _urlImages;
  bool get isDragging => _isDragging;
  Offset get position => _position;
  double get angle => _angle;

  Future<List<String>> loadData() async {
    List<String> temp = [];
    await FirebaseFirestore.instance
        .collection('USER')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        temp.add(doc["avatar"]);
      });
    });
    return temp;
  }

  CardProvider() {
    resetUser();
  }

  void setScreenSize(Size sreenSize) => _screenSize = sreenSize;

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
        }
      }
    }
  }

  void resetUser() async{
    var temp= await loadData();
    _urlImages.addAll(temp);
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
    _angle = 0;
    _position -= Offset(0, _screenSize.height);
    _nextCard();
    notifyListeners();
  }
}
