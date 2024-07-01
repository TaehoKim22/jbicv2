import 'package:jbicv2/src/models/book_user.dart';
import 'package:jbicv2/src/models/user_book_list.dart';

abstract class UserBookListRepository{
  Future<List<UserBookList>> loadUserBookLists(BookUser user);
  Future<int> createBookList(String name, BookUser bookUser);
  Future<UserBookList?> loadBookListFromId(int bookListId);
}