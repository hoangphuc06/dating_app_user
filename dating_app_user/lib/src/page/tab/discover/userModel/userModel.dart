import 'package:cloud_firestore/cloud_firestore.dart';

class userModel {
  String? uid;
  String? address;
  String? bio;
  String? birthday;
  String? dating;
  List? images;
  String? email;
  String? height;
  String? job;
  String? name;
  String? sex;
  String? status;
  String? latitude;
  String? longitude;
   String? init;
  List? characters;
  List? hobbies;
  String? interesting_fact;
  List? styles_dating;
  userModel(
      {this.uid,
      this.address,
      this.bio,
      this.birthday,
      this.dating,
      this.images,
      this.email,
      this.height,
      this.job,
      this.name,
      this.sex,
      this.status,
      this.latitude,
      this.longitude,
      this.init,
      this.characters,
      this.hobbies,
      this.interesting_fact,
      this.styles_dating});

  factory userModel.fromDocument(DocumentSnapshot doc) {
    return userModel(
      uid: doc["uid"],
      address: doc["address"],
      bio: doc['bio'],
      birthday: doc['birthday'],
      dating: doc['dating'],
      images: doc['images'],
      email: doc['email'],
      height: doc['height'],
      job: doc["job"],
      name: doc["name"],
      sex: doc['sex'],
      status: doc["status"],
      latitude: doc['latitude'],
      longitude: doc["longitude"],
      init: doc["init"],
      characters: doc['characters'],
      hobbies: doc["hobbies"],
      interesting_fact: doc['interesting_fact'],
      styles_dating: doc['styles_dating'],
    );
  }
}
