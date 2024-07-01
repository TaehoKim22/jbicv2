import 'package:jbicv2/src/models/book.dart';
import 'package:jbicv2/src/models/book_user.dart';
import 'package:jbicv2/src/models/review.dart';

abstract class ReviewRepository{
  Future<List<Review?>> getBookReview(String isbn);
  Future<void> savePost(Book book, BookUser user, String reviewType, String comment, int? pageNum, DateTime postTime, double rating);
}