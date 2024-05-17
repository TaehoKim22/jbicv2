import 'package:jbicv2/main.dart';
import 'package:jbicv2/src/data_source/firebase_data_source.dart';
import 'package:jbicv2/src/models/book_user.dart';
import 'package:jbicv2/src/models/user_book_list.dart';
import 'package:jbicv2/src/repository/user_book_list_repository.dart';

class UserBookListRepositoryImp extends UserBookListRepository{
  final FirebaseDataSource _fDataSource = getIt();
  @override
  Future<UserBookList> loadUserBookList(BookUser user) {
    return _fDataSource.loadUserBookList(user);
  }

}