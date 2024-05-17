import 'package:flutter/material.dart';


class BottomNavNotifier extends ChangeNotifier{
  int wIndex;
  String currentUserName;
  BottomNavNotifier({
    this.wIndex = 0,
    //this.currentUserName = _authRepository.getCurrentUser().userName,
    this.currentUserName = "x",
  });
  
  void setIndex(int ind){
    wIndex = ind;
    notifyListeners();
  }
}