import 'package:flutter/material.dart';
import 'package:jbicv2/main.dart';
import 'package:jbicv2/src/models/book_list_book.dart';
import 'package:jbicv2/src/models/book_user.dart';
import 'package:jbicv2/src/models/user_book_list.dart';
import 'package:jbicv2/src/repository/auth_repository.dart';
import 'package:jbicv2/src/repository/book_list_book.repository.dart';
import 'package:jbicv2/src/repository/book_user_repository.dart';
import 'package:jbicv2/src/repository/user_book_list_repository.dart';

class BookListNotifier extends ChangeNotifier {
  List<BookListBook> booklistBooks = [];
  UserBookList? userBookList;
  BookUser? currentBookUser;
  bool isUserOwnPlayList = false;
  final AuthRepository _authRepository = getIt();
  final BookUserRepository _bookUserRepository = getIt();
  final UserBookListRepository _bookListRepository = getIt();
  final BookListBookRepository _bookListBookRepository = getIt();

  var isLoading = true;

  void fetchEveryThing(int bookListId) async{
    isLoading = true;

    notifyListeners();
    try {
      await fetchUser();
      await fetchBookList(bookListId);
      await fetchBookListBooks(bookListId);
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchUser() async {
    try {
      var user = _authRepository.getCurrentUser();
      if (user == null) {
        currentBookUser = null;
      } else {
        currentBookUser = await _bookUserRepository.getUser(user.email!);
      }
      notifyListeners();
    } catch (e) {
      return;
    }
  }

  Future<void> fetchBookList(int bookListId) async {
    try {
      userBookList = await _bookListRepository.loadBookListFromId(bookListId);

      if(currentBookUser != null){
        if(currentBookUser?.id == userBookList?.id){
          isUserOwnPlayList = true;
        }
      }
      notifyListeners();
    } catch (e) {}
  }

  Future<void> fetchBookListBooks(int bookListId) async {
    try {
      booklistBooks =
          await _bookListBookRepository.getBookListBooks(bookListId);
          notifyListeners();
    } catch (e) {}
  }
}
