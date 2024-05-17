import 'package:flutter/material.dart';
import 'package:jbicv2/main.dart';
import 'package:jbicv2/src/repository/auth_repository.dart';

class BottomNavNotifier extends ChangeNotifier{
  int wIndex;
  final AuthRepository _authRepository = getIt();
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