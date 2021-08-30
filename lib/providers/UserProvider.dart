import 'package:flutter/cupertino.dart';
import 'package:w2k/model/UserModel.dart';


class UserProvider extends ChangeNotifier{

  AdminModel _user = AdminModel();

  AdminModel get user => _user;

  void setUser (AdminModel user){
    _user = user;
    notifyListeners();
  }
}