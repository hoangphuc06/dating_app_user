import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class NewNotiCard extends StatelessWidget {
  final String herid;
  final func;
  const NewNotiCard({Key? key, required this.herid, required this.func}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return StreamBuilder(
      stream: _firestore.collection("USER").where("uid", isEqualTo: herid).snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
        if (!snapshot.hasData) {
          return Center(
            child: Container(
              height: size.height / 20,
              width: size.height / 20,
              child: CircularProgressIndicator(),
            ),
          );
        }
        else {
          QueryDocumentSnapshot x = snapshot.data!.docs[0];
          return _cardBody(x,size);
        }
      },
    );
  }

  _cardBody(x, Size size) => GestureDetector(
    onTap: func,
    child: Container(
      height: 500,
      child: Stack(
        children: [
          Container(
            height: 500,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: NetworkImage((x["images"][0])),
                    fit: BoxFit.cover)),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.25),
                      Colors.black.withOpacity(0),
                    ],
                    end: Alignment.topCenter,
                    begin: Alignment.bottomCenter)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                x['status'] == "Online"
                    ? Padding(
                  padding:
                  const EdgeInsets.only(left: 8, bottom: 8),
                  child: Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Online",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      )
                    ],
                  ),
                )
                    : Padding(padding: const EdgeInsets.only(left: 8, bottom: 8),
                  child: Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            shape: BoxShape.circle),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Offline",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}

class SeenNotiCard extends StatelessWidget {
  final String herid;
  final func;
  const SeenNotiCard({Key? key, required this.herid, required this.func}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return StreamBuilder(
      stream: _firestore.collection("USER").where("uid", isEqualTo: herid).snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
        if (!snapshot.hasData) {
          return Center(
            child: Container(
              height: size.height / 20,
              width: size.height / 20,
              child: CircularProgressIndicator(),
            ),
          );
        }
        else {
          QueryDocumentSnapshot x = snapshot.data!.docs[0];
          return _cardBody(x,size);
        }
      },
    );
  }

  _cardBody(x, Size size) => GestureDetector(
    onTap: func,
    child: Container(
      height: 500,
      child: Stack(
        children: [
          Container(
            height: 500,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: NetworkImage((x["avatar"])),
                    fit: BoxFit.cover)),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.25),
                      Colors.black.withOpacity(0),
                    ],
                    end: Alignment.topCenter,
                    begin: Alignment.bottomCenter)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                x['status'] == "Online"
                    ? Padding(
                  padding:
                  const EdgeInsets.only(left: 8, bottom: 8),
                  child: Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Online",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      )
                    ],
                  ),
                )
                    : Padding(padding: const EdgeInsets.only(left: 8, bottom: 8),
                  child: Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            shape: BoxShape.circle),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Offline",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}

