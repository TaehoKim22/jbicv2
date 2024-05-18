import 'package:jbicv2/src/models/book.dart';
import 'package:jbicv2/src/models/review.dart';

abstract class ReviewRepository{
  Future<List<Review>> getBookReview(Book book);
}