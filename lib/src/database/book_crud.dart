import 'package:firebase_database/firebase_database.dart';
import 'package:jbicv2/src/models/book.dart';

class BookCrud {
  final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref('books');

  // Create
  Future<Book> createBook(Book book) async {
    final snapshot = await _databaseRef.once();
    final bookCount = snapshot.snapshot.children.length;
    final newBookId = bookCount + 1;
    final newBook = Book(
        id: newBookId, title: book.title, author: book.author, isbn: book.isbn);
    final newBookRef = _databaseRef.child(newBookId.toString());
    await newBookRef.set(newBook.toJson());
    return newBook;
  }

  // Read
  Future<Book?> getBookById(int id) async {
    final snapshot = await _databaseRef.child(id.toString()).get();
    if (snapshot.exists) {
      return Book.fromJson(snapshot.value as Map<String, dynamic>);
    }
    return null;
  }

  Future<Book?> getBookByAuthorNameAndTitle(String author, String title) async{
        final snapshot =
        await _databaseRef.orderByChild('title').equalTo(title).once();
    if (snapshot.snapshot.value != null) {
      if (snapshot.snapshot.value is Map<dynamic, dynamic>) {
        // The snapshot value is a Map
        final bookMap = snapshot.snapshot.value as Map<dynamic, dynamic>;
        for (final userEntry in bookMap.entries) {
          if (userEntry.value is Map<dynamic, dynamic>) {
            final book = Book.fromJson(Map<String, dynamic>.from(
                userEntry.value as Map<dynamic, dynamic>));
            if (book.author == author && book.title == title) {
              return book;
            }
          }
        }
      } else if (snapshot.snapshot.value is List) {
        // The snapshot value is a List
        final bookList = snapshot.snapshot.value as List;
        for (int i = 0; i < bookList.length; i++) {
          if (bookList[i] != null &&
              bookList[i] is Map<dynamic, dynamic>) {
            final userData = bookList[i] as Map<dynamic, dynamic>;
            final book = Book.fromJson(Map<String, dynamic>.from(userData));
            if (book.author == author && book.title == title) {
              return book;
            }
          }
        }
      }
    }
    return null;
  }

  Future<Book?> getBookByISBN(String ISBN) async {
    final snapshot =
        await _databaseRef.orderByChild('isbn').equalTo(ISBN).once();
    if (snapshot.snapshot.value != null) {
      if (snapshot.snapshot.value is Map<dynamic, dynamic>) {
        // The snapshot value is a Map
        final bookMap = snapshot.snapshot.value as Map<dynamic, dynamic>;
        for (final userEntry in bookMap.entries) {
          if (userEntry.value is Map<dynamic, dynamic>) {
            final book = Book.fromJson(Map<String, dynamic>.from(
                userEntry.value as Map<dynamic, dynamic>));
            if (book.isbn == ISBN) {
              return book;
            }
          }
        }
      } else if (snapshot.snapshot.value is List) {
        // The snapshot value is a List
        final bookList = snapshot.snapshot.value as List;
        for (int i = 0; i < bookList.length; i++) {
          if (bookList[i] != null &&
              bookList[i] is Map<dynamic, dynamic>) {
            final userData = bookList[i] as Map<dynamic, dynamic>;
            final book = Book.fromJson(Map<String, dynamic>.from(userData));
            if (book.isbn == ISBN) {
              return book;
            }
          }
        }
      }
    }
    return null;
  }

  Future<List<Book>> getAllBooks() async {
    final snapshot = await _databaseRef.get();
    if (snapshot.exists) {
      final booksMap = snapshot.value as Map<String, dynamic>;
      return booksMap.values
          .map((bookMap) => Book.fromJson(bookMap as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  // Update
  Future<void> updateBook(Book book) async {
    final bookRef = _databaseRef.child(book.id.toString());
    await bookRef.update(book.toJson());
  }

  // Delete
  Future<void> deleteBook(int id) async {
    final bookRef = _databaseRef.child(id.toString());
    await bookRef.remove();
  }
}
