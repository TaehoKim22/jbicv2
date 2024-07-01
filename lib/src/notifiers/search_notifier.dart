import 'package:flutter/material.dart';
import 'package:jbicv2/main.dart';
import 'package:jbicv2/src/models/book.dart';
import 'package:jbicv2/src/models/book_user.dart';
import 'package:jbicv2/src/repository/book_repository.dart';
import 'package:jbicv2/src/repository/book_user_repository.dart';

class BookSearchController extends ChangeNotifier {
  List<BookUser> userResults = [];
  List<Book> bookResults = [];

  BookRepository _bookRepository = getIt();
  BookUserRepository _bookUserRepository = getIt();

  Future<void> search(String query) async {
    userResults = await _bookUserRepository.getUserSearchResult(query);
    bookResults = await _bookRepository.getBookSearchResult(query);
    notifyListeners();
  }

  
}
