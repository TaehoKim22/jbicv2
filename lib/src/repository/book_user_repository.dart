import 'dart:io';
import 'package:jbicv2/src/models/book_user.dart';

abstract class BookUserRepository {
  Future<String> newId(String email, String password);

  Future<void> saveMyUser(BookUser bookUser, File? image);

  Future<void> deleteMyUser(BookUser bookUser);

  Future<List<BookUser>> getUserSearchResult(String query);

  Future<BookUser?> getUser(String userName);

  Future<void> createUser(String userName, File? image);

  void addUserChangedListener(Null Function(dynamic bookUser) param0) {}
}
