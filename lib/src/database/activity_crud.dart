import 'package:firebase_database/firebase_database.dart';
import 'package:jbicv2/src/models/activity.dart';

class ActivityCrud {
  final DatabaseReference _databaseRef =
      FirebaseDatabase.instance.ref('activity');

  Future<void> createBookList(
      String? title,
      String? author,
      String? isbn,
      String? query,
      String activityType,
      int userId,
      int? bookId,
      int? bookListId) async {
    final snapshot = await _databaseRef.once();
    final activityCount = snapshot.snapshot.children.length;
    final newAcitivityId = activityCount + 1;
    final activityTime = DateTime.now();

    var newAcitivity = Activity(
        id: newAcitivityId,
        activityType: activityType,
        userId: userId,
        activityTime: activityTime,
        title: title,
        author: author,
        isbn: isbn,
        query: query,
        bookId: bookId,
        bookListId: bookListId);
    final newAcitivityRef = _databaseRef.child(newAcitivityId.toString());
    await newAcitivityRef.set(newAcitivity.toJson());
  }
}
