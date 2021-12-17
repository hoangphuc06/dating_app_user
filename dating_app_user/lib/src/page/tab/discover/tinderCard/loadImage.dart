// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';

// class FireStorageService extends ChangeNotifier{
//   FireStorageService();
//   static Future<dynamic>loadImage(BuildContext context,String image)async{
//     return await FirebaseStorage.instance.ref().child(image).getDownloadURL();
//   }
// }

// Future<Widget>_getImage(BuildContext context,String imageName)async{
//   Image image;
//      await FireStorageService.loadImage(context, imageName).then((value) => {
//        image=Image.network(src)
//      });
//   }