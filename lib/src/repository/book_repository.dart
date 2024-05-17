import 'package:jbicv2/src/models/book.dart';

abstract class BookRepository{
  Future<List<Book>> getBookSearchResult(String query);
}