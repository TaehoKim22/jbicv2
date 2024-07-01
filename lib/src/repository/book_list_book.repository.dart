

import 'package:jbicv2/src/models/book_list_book.dart';

abstract class BookListBookRepository{
  Future<List<BookListBook>> getBookListBooks(int bookListId);
  Future<void> addBookToTheList(int bookListId, int bookId, String title, String author, String isbn);
}