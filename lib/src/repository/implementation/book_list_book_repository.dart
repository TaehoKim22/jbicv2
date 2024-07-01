import 'package:jbicv2/main.dart';
import 'package:jbicv2/src/data_source/firebase_data_source.dart';
import 'package:jbicv2/src/models/book_list_book.dart';
import 'package:jbicv2/src/repository/book_list_book.repository.dart';

class BookListBookRepositoryImp extends BookListBookRepository{
  final FirebaseDataSource _fDataSource = getIt();

  @override
  Future<List<BookListBook>> getBookListBooks(int bookListId) {
    return _fDataSource.getBookListBooks(bookListId);
  }
  
  @override
  Future<void> addBookToTheList(int bookListId, int bookId, String title, String author, String isbn) {
    return _fDataSource.addBookToTheList(bookListId, bookId, title, author, isbn);
  }
  
}