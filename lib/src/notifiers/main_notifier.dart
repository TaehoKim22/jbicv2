import 'package:flutter/material.dart';
import 'package:jbicv2/main.dart';
import 'package:jbicv2/src/models/book_user.dart';
import 'package:jbicv2/src/models/user_book_list.dart';
import 'package:jbicv2/src/repository/book_user_repository.dart';
import 'package:jbicv2/src/repository/user_book_list_repository.dart';

class MainNotifier extends ChangeNotifier {
  final BookUserRepository _userRepository = getIt();
  final UserBookListRepository _bookListRepository = getIt();
  BookUser? user;
  UserBookList? userBookList;
  var isLoading = true;

  void fetchUserAndBookList(String userName) async {
    isLoading = true;
    notifyListeners();

    try {
      // Get the user from the userRepository
      user = await _userRepository.getUser(userName);
      // Use the user to get the book list from the bookListRepository
      userBookList = await _bookListRepository.loadUserBookList(user!);
      // Do something with userBookList here...

      isLoading = false;
      notifyListeners();
    } catch (e) {
      // Handle any errors here...
      print(e);
      isLoading = false;
      notifyListeners();
    }
  }

}
