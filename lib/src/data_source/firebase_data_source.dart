import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:jbicv2/src/database/book_book_list_crud.dart';
import 'package:jbicv2/src/database/book_list_crud.dart';
import 'package:jbicv2/src/database/book_user_crud.dart';
import 'package:jbicv2/src/database/review_crud.dart';
import 'package:jbicv2/src/models/activity.dart';
import 'package:jbicv2/src/models/book.dart';
import 'package:jbicv2/src/models/book_list_book.dart';
import 'package:jbicv2/src/models/book_user.dart';
import 'package:jbicv2/src/models/review.dart';
import 'package:jbicv2/src/models/user_book_list.dart';
import 'package:http/http.dart' as http;
import 'package:jbicv2/src/database/book_crud.dart';

class FirebaseDataSource {
  final BookUserCRUD bookUserCRUD = BookUserCRUD();
  final BookCrud bookCrud = BookCrud();
  final ReviewCrud reviewCrud = ReviewCrud();
  final BookListCrud bookListCrud = BookListCrud();
  final BookListBookCrud bookListBookCrud = BookListBookCrud();
  User get currentUser {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception('Not authenticated exception');
    return user;
  }

  FirebaseFirestore get firestore => FirebaseFirestore.instance;
  FirebaseStorage get storage => FirebaseStorage.instance;

  Future<List<BookUser>> getUserSearchResult(String query) async {
    return [];
  }

  Future<List<Book>> getBookSearchResult(String query) async {
    final url = Uri.parse(
        'https://openlibrary.org/search.json?q=${query}+language:eng&fields=key,title,author_name,editions,editions.isbn');
    final response = await http.get(url);
    Map<String, dynamic> responseJson = jsonDecode(response.body);

    // Access the 'docs' part of your JSON
    var docs = responseJson['docs'];

    // Map each ISBN to a Book object, if ISBN is present
    List<Book> books = [];
    int id = 0; // Initialize a counter for the ID

    for (var doc in docs) {
      if (!doc['editions']['docs'][0].containsKey('isbn') ||
          !doc.containsKey('author_name')) {
        continue;
      }
      var authorName = doc['author_name'].toString().replaceAll("[","").replaceAll("]", ""); // Use null-aware access
      var title = doc['title']; // Use null-aware access
      var isbns = doc['editions']['docs'][0]['isbn'] as List<dynamic>;
      var resultIsbn =
          isbns.firstWhere((isbn) => isbn.length == 13, orElse: () => null);
      if (resultIsbn == null) {
        continue;
      }

      var isbnString = resultIsbn.toString();
      // Create a Book object for each ISBN with index as ID
      var book =
          Book(id: id++, title: title, author: authorName, isbn: isbnString);
      books.add(book);
    }
    // Return the list of books
    return books;
  }

  Future<List<UserBookList>> loadUserBookList(BookUser user) async {
    return await bookListCrud.getUserBookListByUserId(user.id);
  }

  Future<void> saveMyUser(BookUser bookUser, File? image) async {}

  Future<String> newId(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      String userName = email.split("@")[0];
      final random = Random();
      int number = random.nextInt(9000000) + 1000000;
      userName = userName + number.toString();
      await bookUserCRUD.createBookUser(email: email, userName: userName);
      return "Success";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    } catch (e) {
      return e.toString();
    }
  }

  // Deletes the MyUser document. Also will delete the
  // image from Firebase Storage
  Future<void> deleteMyUser(BookUser bookUser) async {}

  Future<BookUser?> getUser(String userName) async {
    var user = await bookUserCRUD.getBookUserByEmail(userName);
    return user;
  }

  Future<void> saveUser(String userName, File? image) async {
    final user = FirebaseAuth.instance.currentUser;
    try {
      bookUserCRUD.createBookUser(userName: userName, email: user?.email ?? '');
    } catch (e) {}
  }

  Future<List<Review?>> getBookReview(String isbn) async {
    var reviews = await reviewCrud.getBookReviewsByISBN(isbn);
    return reviews;
  }

  Future<void> savePost(Book book, BookUser user, String reviewType,
      String comment, int? pageNum, DateTime postTime, double rating) async {
    Review review = Review(
        title: book.title,
        author: book.author,
        userName: user.userName,
        reviewType: reviewType,
        comment: comment,
        isbn: book.isbn,
        bookID: book.id,
        userID: user.id,
        likes: 0,
        rating: rating,
        postTime: postTime);
    var create = await reviewCrud.createReview(review);
  }

  Future<Book?> getBook(String isbn) async {
    Book? book = await bookCrud.getBookByISBN(isbn);
    if (book == null) {
      final url = Uri.parse(
          'https://openlibrary.org/search.json?isbn=$isbn&fields=key,title,author_name,editions,editions.language,editions.isbn');
      final response = await http.get(url);
      Map<String, dynamic> responseJson = jsonDecode(response.body);
      if (responseJson['docs'].length == 0) {
        return null;
      }
      var doc = responseJson['docs'][0];
      if (!doc['editions']['docs'][0].containsKey('isbn') ||
          !doc.containsKey('author_name')) {
        return null;
      }
      var authorName = doc['author_name'].toString().replaceAll("[","").replaceAll("]", ""); // Use null-aware access
      var title = doc['title']; // Use null-aware access
      var isbns = doc['editions']['docs'][0]['isbn'] as List<dynamic>;
      var resultIsbn = isbns.firstWhere((isbn) => isbn.length == 13,
          orElse: () => null); // Use an empty list if 'isbn' is not present
      // Create a Book object for each ISBN with index as ID
      book = await bookCrud.getBookByAuthorNameAndTitle(authorName, title);

      if (book == null) {
        book = Book(id: 0, title: title, author: authorName, isbn: resultIsbn);
        final resultBook = bookCrud.createBook(book);
        return resultBook;
      }
    }
    return book;
  }

  Future<List<BookListBook>> getBookListBooks(int bookListId) async{
    return bookListBookCrud.getBookListBooksById(bookListId);
  }

  Future<int> createBookList(String name, BookUser bookUser)async {
    int resultId = await bookListCrud.createBookList(bookUser.id, name);
    return resultId;
  }
  Future<UserBookList?> loadBookListFromId (int bookListId) async{
    return await bookListCrud.getUserBookListById(bookListId);

  }

  Future<void> addBookToTheList(int bookListId, int bookId, String title, String author, String isbn) async{
    await bookListBookCrud.addBookToTheList(title, author, isbn, bookListId, bookId);
  }

  Future<List<Activity>> getLatest2Activities(int bookUserId) async{
    return [];
  }
}
