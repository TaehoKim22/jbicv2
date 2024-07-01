import 'package:jbicv2/main.dart';
import 'package:jbicv2/src/models/book_user.dart';
import 'package:jbicv2/src/repository/user_book_list_repository.dart';

class AddBookListController{
  final UserBookListRepository _userBookListRepository = getIt();
  Future<int> createBookList(String name, BookUser bookUser) async {
    return await _userBookListRepository.createBookList(name, bookUser);
  }
}