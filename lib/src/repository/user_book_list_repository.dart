import 'package:jbicv2/src/models/book_user.dart';
import 'package:jbicv2/src/models/user_book_list.dart';

abstract class UserBookListRepository{
  Future<UserBookList> loadUserBookList(BookUser user);
}