import 'package:firebase_database/firebase_database.dart';
import 'package:jbicv2/src/models/review.dart';

class ReviewCrud {
  final DatabaseReference _databaseRef =
      FirebaseDatabase.instance.ref('reviews');

  Future<void> createReview(Review review) async {
    final snapshot = await _databaseRef.once();
    final reviewCount = snapshot.snapshot.children.length;

    final reviewId = reviewCount + 1;
    final newBookRef = _databaseRef.child(reviewId.toString());
    await newBookRef.set(review.toJson());
  }

  Future<List<Review>> getReviewsByBook(int bookID) async {
    final snapshot = await _databaseRef.child(bookID.toString()).once();
    final reviews = <Review>[];
    if (snapshot.snapshot.value != null) {
      final data = Map<String, dynamic>.from(snapshot.snapshot.value as Map);
      data.forEach((key, value) {
        final review = Review.fromJson(Map<String, dynamic>.from(value));
        reviews.add(review);
      });
    }
    return reviews;
  }

  Future<List<Review>> getBookReviewsByISBN(String ISBN) async {
    final snapshot =
        await _databaseRef.orderByChild('isbn').equalTo(ISBN).once();
    final List<Review> reviews = [];
    if (snapshot.snapshot.value != null) {
      if (snapshot.snapshot.value is Map<dynamic, dynamic>) {
        // The snapshot value is a Map
        final reviewMap = snapshot.snapshot.value as Map<dynamic, dynamic>;
        for (final userEntry in reviewMap.entries) {
          if (userEntry.value is Map<dynamic, dynamic>) {
            final review = Review.fromJson(Map<String, dynamic>.from(
                userEntry.value as Map<dynamic, dynamic>));
            if (review.isbn == ISBN) {
              reviews.add(review);
            }
          }
        }
      } else if (snapshot.snapshot.value is List) {
        // The snapshot value is a List
        final bookReviewList = snapshot.snapshot.value as List;
        for (int i = 0; i < bookReviewList.length; i++) {
          if (bookReviewList[i] != null &&
              bookReviewList[i] is Map<dynamic, dynamic>) {
            final userData = bookReviewList[i] as Map<dynamic, dynamic>;
            final book = Review.fromJson(Map<String, dynamic>.from(userData));
            if (book.isbn == ISBN) {
              reviews.add(book);
            }
          }
        }
      }
    }

    return reviews;
  }

  Future<void> updateReview(Review review) async {
    await _databaseRef
        .child(review.bookID.toString())
        .child(review.userID.toString())
        .child(review.postTime.toString())
        .set(review.toJson());
  }

  Future<void> deleteReview(Review review) async {
    await _databaseRef
        .child(review.bookID.toString())
        .child(review.userID.toString())
        .child(review.postTime.toString())
        .remove();
  }
}
