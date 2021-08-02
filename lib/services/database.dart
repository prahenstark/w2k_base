import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseManager {
  final CollectionReference firestoreShopList =
  FirebaseFirestore.instance.collection('shop');

  Future getShopList() async {
    List shopsList = [];

    try {
      await firestoreShopList.get().then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          shopsList.add(element.data);
          print(shopsList.runtimeType);
        });
      });
      return shopsList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

