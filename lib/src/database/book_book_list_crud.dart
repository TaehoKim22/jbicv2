import 'package:firebase_database/firebase_database.dart';
import 'package:jbicv2/src/models/book_list_book.dart';

class BookListBookCrud {
  final DatabaseReference _databaseRef =
      FirebaseDatabase.instance.ref('bookList_book');

  // Create
  Future<void> addBookToTheList(String title, String author, String isbn,
      int bookListId, int bookId) async {
    final snapshot = await _databaseRef.once();
    final bookListBookCount = snapshot.snapshot.children.length;
    final newBookId = bookListBookCount + 1;
    var newBookListBook = BookListBook(
        id: newBookId,
        bookId: bookId,
        bookListId: bookListId,
        title: title,
        author: author,
        isbn: isbn);
    final newBookRef = _databaseRef.child(newBookId.toString());
    await newBookRef.set(newBookListBook.toJson());
  }

  Future<List<BookListBook>> getBookListBooksById(int bookListId) async {
    final snapshot = await _databaseRef
        .orderByChild('bookListId')
        .equalTo(bookListId)
        .once();
    final List<BookListBook> bookListbooks = [];
    if (snapshot.snapshot.value != null) {
      if (snapshot.snapshot.value is Map<dynamic, dynamic>) {
        // The snapshot value is a Map
        final bookListBookMap =
            snapshot.snapshot.value as Map<dynamic, dynamic>;
        for (final bookListbook in bookListBookMap.entries) {
          if (bookListbook.value is Map<dynamic, dynamic>) {
            final bookListBook = BookListBook.fromJson(
                Map<String, dynamic>.from(
                    bookListbook.value as Map<dynamic, dynamic>));
            if (bookListBook.id == bookListId) {
              bookListbooks.add(bookListBook);
            }
          }
        }
      } else if (snapshot.snapshot.value is List) {
        // The snapshot value is a List
        final bookListBookList = snapshot.snapshot.value as List;
        for (int i = 0; i < bookListBookList.length; i++) {
          if (bookListBookList[i] != null &&
              bookListBookList[i] is Map<dynamic, dynamic>) {
            final bookListBookData =
                bookListBookList[i] as Map<dynamic, dynamic>;
            final bookListBook = BookListBook.fromJson(
                Map<String, dynamic>.from(bookListBookData));

            if (bookListBook.id == bookListId) {
              bookListbooks.add(bookListBook);
            }
          }
        }
      }
    }

    return bookListbooks;
  }

  // Delete
  Future<void> deleteBookListBook(int id) async {
    final bookRef = _databaseRef.child(id.toString());
    await bookRef.remove();
  }
}
