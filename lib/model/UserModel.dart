import 'package:cloud_firestore/cloud_firestore.dart';

class AdminModel {
  String name;
  String phoneNumber;
  String userId;
  String email;
  String password;
  String longitude;
  String latitude;
  String location;
  //DocumentReference reference;

  AdminModel({
    this.name,
    this.phoneNumber,
    this.email,
    this.password,
    this.userId,
    this.longitude,
    this.latitude,
    this.location,
    //this.reference,
  });

  // factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
  //   UserModel newUser = UserModel.fromJson(snapshot.data());
  //   newUser.reference = snapshot.reference;
  //   return newUser;
  // }

  AdminModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phoneNumber = json['phone'];
    email = json['email'];
    password = json['password'];
    userId = json['userId'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone'] = this.phoneNumber;
    data['email'] = this.email;
    data['password'] = this.password;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    // if (this.longitude != null) {
    //   data['longitude'] = this.longitude;
    // }
    // if (this.latitude != null) {
    //   data['latitude'] = this.latitude;
    // }
    //data['thumbnailUrl'] = this.userId;
    data['location'] = this.location;
    return data;
  }
}