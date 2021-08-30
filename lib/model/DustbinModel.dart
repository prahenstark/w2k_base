class DustbinModel {
  String dustbinId;
  String userId;
  String weight;
  String points;
  String longitude;
  String latitude;
  String location;

  DustbinModel({this.dustbinId,
    this.weight,
    this.points,
    this.userId,
    this.longitude,
    this.latitude,
    this.location,
  });


  factory DustbinModel.fromMap(Map data) {
    return DustbinModel(
      dustbinId: data['dustbinId'] ?? '',
      points: data['points'] ?? '',
      weight: data['weight'] ?? '',
    );
  }


  DustbinModel.fromJson(Map<String, dynamic> json) {
    dustbinId = json['dustbinId'];
    weight = json['weight'];
    points = json['points'];
    userId = json['userId'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    location = json['location'];
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