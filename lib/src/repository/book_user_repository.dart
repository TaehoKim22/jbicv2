import 'dart:io';
import 'package:jbicv2/src/models/book_user.dart';


abstract class MyUserRepository {
  String newId();

  Stream<Iterable<BookUser>> getMyUsers();

  Future<void> saveMyUser(BookUser bookUser, File? image);

  Future<void> deleteMyUser(BookUser bookUser);
}