import 'dart:io';
import 'package:jbicv2/src/models/book_user.dart';


abstract class BookUserRepository {
  String newId();

  Future<void> saveMyUser(BookUser bookUser, File? image);

  Future<void> deleteMyUser(BookUser bookUser);

  Future<List<BookUser>> getUserSearchResult(String query);
  
  Future<BookUser> getUser(String userName);
}