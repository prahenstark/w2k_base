import 'package:flutter/material.dart';

class DustbinProvider extends ChangeNotifier{

  double _sum ;

  double get sum => _sum;

  void setUser (double sum){
    _sum = sum;
    notifyListeners();
  }
}