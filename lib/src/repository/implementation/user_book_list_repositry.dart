import 'package:jbicv2/main.dart';
import 'package:jbicv2/src/data_source/firebase_data_source.dart';
import 'package:jbicv2/src/models/book_user.dart';
import 'package:jbicv2/src/models/user_book_list.dart';
import 'package:jbicv2/src/repository/user_book_list_repository.dart';

class UserBookListRepositoryImp extends UserBookListRepository{
  final FirebaseDataSource _fDataSource = getIt();  
  @override
  Future<int> createBookList(String name, BookUser bookUser) {
    // TODO: implement CreateBookList
    return _fDataSource.createBookList(name, bookUser);
  }
  
  @override
  Future<UserBookList?> loadBookListFromId(int bookListId) {
    // TODO: implement loadBookListFromId
    return _fDataSource.loadBookListFromId(bookListId);
  }
  
  @override
  Future<List<UserBookList>> loadUserBookLists(BookUser user) {
    // TODO: implement loadUserBookLists
    return _fDataSource.loadUserBookList(user);
  }

}