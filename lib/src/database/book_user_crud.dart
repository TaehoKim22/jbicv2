import 'package:firebase_database/firebase_database.dart';
import 'package:jbicv2/src/models/book_user.dart';

class BookUserCRUD {
  // Reference to the Realtime Database
  final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref().child('users');

  // Create
  Future<void> createBookUser({
    required String email,
    required String userName,
    String? photoURL,
  }) async {
    // Get the current number of users in the database
    final snapshot = await _databaseRef.once();
    final userCount = snapshot.snapshot.children.length;

    // Generate a new ID starting from 1
    final newUserId = userCount + 1;
    final emailKey = email.replaceAll('.', '_');

    // Create a new BookUser object
    final bookUser = BookUser(
      id: newUserId,
      email: emailKey,
      userName: userName,
      photoURL: photoURL,
    );

    final newUserRef = _databaseRef.child(newUserId.toString());
    await newUserRef.set(bookUser.toJson({}));
  }
  // Read
  Future<BookUser?> getBookUserByID(String userId) async {
    final snapshot = await _databaseRef.child(userId).once();
    if (snapshot.snapshot.value != null && snapshot.snapshot.value is Map<dynamic, dynamic>) {
      return BookUser.fromJson(Map<String, dynamic>.from(snapshot.snapshot.value as Map<dynamic, dynamic>));
    }
    return null;
  }

Future<BookUser?> getBookUserByEmail(String email) async {
  
  final emailKey = email.replaceAll('.', '_');
  final snapshot = await _databaseRef.orderByChild('email').equalTo(emailKey).once();
  if (snapshot.snapshot.value != null) {
    if (snapshot.snapshot.value is Map<dynamic, dynamic>) {
      // The snapshot value is a Map
      final userMap = snapshot.snapshot.value as Map<dynamic, dynamic>;
      for (final userEntry in userMap.entries) {
        if (userEntry.value is Map<dynamic, dynamic>) {
          final bookUser = BookUser.fromJson(Map<String, dynamic>.from(userEntry.value as Map<dynamic, dynamic>));
          if (bookUser.email == emailKey) {
            return bookUser;
          }
        }
      }
    } else if (snapshot.snapshot.value is List) {
      // The snapshot value is a List
      final userDataList = snapshot.snapshot.value as List;
      for (int i = 0; i < userDataList.length; i++) {
        if (userDataList[i] != null && userDataList[i] is Map<dynamic, dynamic>) {
          final userData = userDataList[i] as Map<dynamic, dynamic>;
          final bookUser = BookUser.fromJson(Map<String, dynamic>.from(userData));
          if (bookUser.email == emailKey) {
            return bookUser;
          }
        }
      }
    }
  }

  return null;
}



  Future<BookUser?> getBookUserByUserName(String userName) async {
    final snapshot = await _databaseRef.orderByChild('userName').equalTo(userName).limitToFirst(1).once();
    if (snapshot.snapshot.value != null && snapshot.snapshot.value is Map<dynamic, dynamic>) {
      final userMap = snapshot.snapshot.value as Map<dynamic, dynamic>;
      if (userMap.isNotEmpty) {
        final userValue = userMap.values.first;
        if (userValue is Map<dynamic, dynamic>) {
          return BookUser.fromJson(Map<String, dynamic>.from(userValue));
        }
      }
    }
    return null;
  }

  // Update
  Future<void> updateBookUser(BookUser bookUser) async {
    final userRef = _databaseRef.child(bookUser.id.toString());
    await userRef.update(bookUser.toJson({}));
  }

  // Delete
  Future<void> deleteBookUser(String userId) async {
    final userRef = _databaseRef.child(userId);
    await userRef.remove();
  }

  Future<List<BookUser>> getBookUsersByUserNameSubstring(String substring) async {
    final snapshot = await _databaseRef.orderByChild('userName').startAt(substring).endAt('$substring\uf8ff').once();
    if (snapshot.snapshot.value != null && snapshot.snapshot.value is Map<dynamic, dynamic>) {
      final userMap = snapshot.snapshot.value as Map<dynamic, dynamic>;
      return userMap.values.map((userValue) {
        if (userValue is Map<dynamic, dynamic>) {
          return BookUser.fromJson(Map<String, dynamic>.from(userValue));
        }
        return BookUser.fromJson({});
      }).toList();
    }
    return [];
  }
}
