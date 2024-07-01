import 'package:flutter/material.dart';
import 'package:jbicv2/main.dart';
import 'package:jbicv2/src/models/book_list_book.dart';

import 'package:jbicv2/src/models/book_user.dart';
import 'package:jbicv2/src/models/user_book_list.dart';
import 'package:jbicv2/src/repository/book_list_book.repository.dart';
import 'package:jbicv2/src/repository/user_book_list_repository.dart';

class MainNotifier extends ChangeNotifier {
  final UserBookListRepository _bookListRepository = getIt();
  List<UserBookList> userBookLists = [];
  var isLoading = true;

  void fetchUserAndBookList(BookUser bookUser) async {
    isLoading = true;
    notifyListeners();
    try {
      userBookLists = await _bookListRepository.loadUserBookLists(bookUser);
      isLoading = false;
      notifyListeners();
    } catch (e) {
      // Handle any errors here...
      isLoading = false;
      notifyListeners();
    }
  }
}
