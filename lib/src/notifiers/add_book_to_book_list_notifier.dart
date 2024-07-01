import 'package:flutter/foundation.dart';
import 'package:jbicv2/main.dart';
import 'package:jbicv2/src/models/book_user.dart';
import 'package:jbicv2/src/models/user_book_list.dart';
import 'package:jbicv2/src/repository/book_list_book.repository.dart';
import 'package:jbicv2/src/repository/user_book_list_repository.dart';

class AddBookToBookListNotifier extends ChangeNotifier {
  List<UserBookList> userBookListList = [];
  final UserBookListRepository _bookListRepository = getIt();
  final BookListBookRepository _bookListBookRepository = getIt();
  bool isLoading = true;

  void fetchBookList(BookUser currentBookUser) async {
    isLoading = true;
    notifyListeners();
    try {
      userBookListList =
          await _bookListRepository.loadUserBookLists(currentBookUser);
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addBookToTheList(int bookListId, int bookId, String title, String author, String isbn) async{
    await _bookListBookRepository.addBookToTheList(bookListId, bookId, title, author, isbn);
  }
}
