import 'package:cloud_firestore/cloud_firestore.dart';

class ShopModel {
  String name;
  String location;
  String longitude;
  String photoUrl;
  String longDescription;
  String latitude;
  String opnesAt;
  String closesAt;

  ShopModel({this.name,
    this.location,
    this.longitude,
    this.photoUrl,
    this.longDescription,
    this.latitude,
    this.closesAt,
    this.opnesAt,
  });

  ShopModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    location = json['location'];
    longitude = json['longitude'];
    photoUrl = json['url'];
    longDescription = json['description'];
    latitude = json['latitude'];
    opnesAt = json['opensAt'];
    closesAt = json['closesAt'];
  }
}
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['title'] = this.name;
//     data['shortInfo'] = this.location;
//     data['price'] = this.price;
//     if (this.longitude != null) {
//       data['publishedDate'] = this.longitude;
//     }
//     data['thumbnailUrl'] = this.photoUrl;
//     data['longDescription'] = this.longDescription;
//     data['status'] = this.latitude;
//     return data;
//   }
// }

// class PublishedDate {
//   String date;
//
//   PublishedDate({this.date});
//
//   PublishedDate.fromJson(Map<String, dynamic> json) {
//     date = json['$date'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['$date'] = this.date;
//     return data;
//   }
// }