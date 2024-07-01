import 'package:firebase_database/firebase_database.dart';
import 'package:jbicv2/src/models/user_book_list.dart';

class BookListCrud {
  final DatabaseReference _databaseRef =
      FirebaseDatabase.instance.ref('bookLists');

  // Create
  Future<int> createBookList(int userId, String bookListName) async {
    final snapshot = await _databaseRef.once();
    final bookListCount = snapshot.snapshot.children.length;
    final newBookListId = bookListCount + 1;
    final date = DateTime.now();
    var newBookList = UserBookList(
        userID: userId,
        id: newBookListId,
        bookListName: bookListName,
        createdDate: date);
    final newBookListRef = _databaseRef.child(newBookListId.toString());
    await newBookListRef.set(newBookList.toJson());
    return newBookListId;
  }

  Future<List<UserBookList>> getUserBookListByUserId(int userId) async {
    final snapshot =
        await _databaseRef.orderByChild('userID').equalTo(userId).once();
    final List<UserBookList> bookLists = [];
    if (snapshot.snapshot.value != null) {
      if (snapshot.snapshot.value is Map<dynamic, dynamic>) {
        // The snapshot value is a Map
        final bookListMap = snapshot.snapshot.value as Map<dynamic, dynamic>;
        for (final bookListItem in bookListMap.entries) {
          if (bookListItem.value is Map<dynamic, dynamic>) {
            final resultList = UserBookList.fromJson(Map<String, dynamic>.from(
                bookListItem.value as Map<dynamic, dynamic>));
            if (resultList.userID == userId) {
              bookLists.add(resultList);
            }
          }
        }
      } else if (snapshot.snapshot.value is List) {
        // The snapshot value is a List
        final bookListList = snapshot.snapshot.value as List;
        for (int i = 0; i < bookListList.length; i++) {
          if (bookListList[i] != null &&
              bookListList[i] is Map<dynamic, dynamic>) {
            final bookListData = bookListList[i] as Map<dynamic, dynamic>;
            final resultList =
                UserBookList.fromJson(Map<String, dynamic>.from(bookListData));

            if (resultList.userID == userId) {
              bookLists.add(resultList);
            }
          }
        }
      }
    }
    return bookLists;
  }

  Future<UserBookList?> getUserBookListById(int bookListId) async {
    final snapshot = await _databaseRef
        .orderByChild('id')
        .equalTo(bookListId)
        .limitToFirst(1)
        .once();
    if (snapshot.snapshot.value != null) {
      if (snapshot.snapshot.value is Map<dynamic, dynamic>) {
        // The snapshot value is a Map
        final bookMap = snapshot.snapshot.value as Map<dynamic, dynamic>;
        for (final userEntry in bookMap.entries) {
          if (userEntry.value is Map<dynamic, dynamic>) {
            final bookList = UserBookList.fromJson(Map<String, dynamic>.from(
                userEntry.value as Map<dynamic, dynamic>));
            return bookList;
          }
        }
      } else if (snapshot.snapshot.value is List) {
        // The snapshot value is a List
        final resultList = snapshot.snapshot.value as List;
        for (int i = 0; i < resultList.length; i++) {
          if (resultList[i] != null && resultList[i] is Map<dynamic, dynamic>) {
            final userData = resultList[i] as Map<dynamic, dynamic>;
            final bookList =
                UserBookList.fromJson(Map<String, dynamic>.from(userData));
            return bookList;
          }
        }
      }
    }
    return null;
  }

  // Delete
  Future<void> deleteBookListBook(int id) async {
    final bookRef = _databaseRef.child(id.toString());
    await bookRef.remove();
  }
}
