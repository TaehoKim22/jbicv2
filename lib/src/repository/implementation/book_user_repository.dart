
import 'dart:io';

import 'package:jbicv2/main.dart';
import 'package:jbicv2/src/data_source/firebase_data_source.dart';
import 'package:jbicv2/src/models/book_user.dart';
import 'package:jbicv2/src/repository/book_user_repository.dart';

class BookUserRepositoryImp extends BookUserRepository{
  final FirebaseDataSource _fDataSource = getIt();
  @override
  Future<void> deleteMyUser(BookUser bookUser) {

    return _fDataSource.deleteMyUser(bookUser);
  }

  @override
  Future<List<BookUser>> getUserSearchResult(String query) {
    return _fDataSource.getUserSearchResult(query);
  }

  @override
  String newId() {
    return _fDataSource.newId();
  }

  @override
  Future<void> saveMyUser(BookUser bookUser, File? image) {
    return _fDataSource.saveMyUser(bookUser, image);
  }
  
  @override
  Future<BookUser> getUser(String userName) {
    return _fDataSource.getUser(userName);
  }
  
  

}