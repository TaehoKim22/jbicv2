import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:jbicv2/src/models/book.dart';
import 'package:jbicv2/src/models/book_user.dart';
import 'package:jbicv2/src/models/user_book_list.dart';

class FirebaseDataSource {
  User get currentUser {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception('Not authenticated exception');
    return user;
  }

  FirebaseFirestore get firestore => FirebaseFirestore.instance;
  FirebaseStorage get storage => FirebaseStorage.instance;

  Future<List<BookUser>> getUserSearchResult(String query) async{
    String userSampleJson = await rootBundle.loadString('assets/userSample.json');
    Map<String, dynamic> userSampleMap = jsonDecode(userSampleJson);
    return (userSampleMap['users'] as List).map((userMap) => BookUser.fromJson(userMap)).toList();
  }

  Future<List<Book>> getBookSearchResult(String query) async{
    String bookSampleJson = await rootBundle.loadString('assets/bookSample.json');
    Map<String, dynamic> bookSampleMap = jsonDecode(bookSampleJson);
    return (bookSampleMap['books'] as List).map((bookMap) => Book.fromJson(bookMap)).toList();
  }

  Future<UserBookList> loadUserBookList(BookUser user)async{
    String jsonString = await rootBundle.loadString('assets/bookListSample.json');
    Map<String, dynamic> userBookListMap = jsonDecode(jsonString) as Map<String, dynamic>;
    var x = UserBookList.fromJson(userBookListMap);
    return x;
  }

  Future<void> saveMyUser(BookUser bookUser, File? image) async {

  }

  String newId() {
    return "s";
  }

  // Deletes the MyUser document. Also will delete the
  // image from Firebase Storage
  Future<void> deleteMyUser(BookUser bookUser) async {
  }

  Future<BookUser> getUser(String userName) async{
    String jsonString = await rootBundle.loadString('assets/userSample.json');
    Map<String, dynamic> BookUserListMap = jsonDecode(jsonString) as Map<String, dynamic>;
    var x = (BookUserListMap['users'] as List).map((bu) => BookUser.fromJson(bu)).toList();
    return x[0];
  }

}