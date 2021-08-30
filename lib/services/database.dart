// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:w2k/model/DustbinModel.dart';
//
// class DataBaseService {
//   final FirebaseFirestore _db = FirebaseFirestore.instance;
//
//   Future<DustbinModel> getDustbin(String id) async {
//     var snap = await _db.collection('dustbin').doc(id).get();
//
//     return DustbinModel.fromMap(snap.data());
//
//   }
//   Stream<DustbinModel> dustbinStream(String id) {
//     return _db
//         .collection('dustbin')
//         .doc(id)
//         .snapshots()
//         .map((snap) => DustbinModel.fromMap(snap.data()));
//   }
// }






