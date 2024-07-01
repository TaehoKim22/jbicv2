import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jbicv2/main.dart';
import 'package:jbicv2/src/models/book_user.dart';
import 'package:jbicv2/src/repository/auth_repository.dart';
import 'package:jbicv2/src/repository/book_user_repository.dart';

class BottomNavNotifier extends ChangeNotifier {
  int wIndex = 0;
  BookUser? currentBookUser;
  bool isLoading = false;
  final AuthRepository _authRepository = getIt();
  final BookUserRepository _bookUserRepository = getIt();

  Future<void> initializeUserName() async{
    isLoading = true;
    notifyListeners();
    var authUser = _authRepository.getCurrentUser();
    if (authUser != null){
      String? currentUserName = authUser!.email;
    await Future.delayed(const Duration(seconds: 2));
    currentBookUser = await _bookUserRepository.getUser(currentUserName!);
    }
    isLoading = false;
    notifyListeners();
  }

  void setIndex(int ind) {
    wIndex = ind;
    notifyListeners();
  }
}
