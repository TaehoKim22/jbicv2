import 'package:jbicv2/main.dart';
import 'package:jbicv2/src/data_source/firebase_data_source.dart';
import 'package:jbicv2/src/models/book.dart';
import 'package:jbicv2/src/repository/book_repository.dart';

class BookRepositoryImp extends BookRepository{
  final FirebaseDataSource _fDataSource = getIt();
  @override
  Future<List<Book>> getBookSearchResult(String query) {
    return _fDataSource.getBookSearchResult(query);
  }
  
  @override
  Future<Book?> getBook(String isbn) {
    return _fDataSource.getBook(isbn);
  }
  
}