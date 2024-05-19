import 'package:jbicv2/main.dart';
import 'package:jbicv2/src/data_source/firebase_data_source.dart';
import 'package:jbicv2/src/models/book.dart';
import 'package:jbicv2/src/models/book_user.dart';
import 'package:jbicv2/src/models/review.dart';
import 'package:jbicv2/src/repository/review_repository.dart';

class ReviewRepositoryImp extends ReviewRepository{
  final FirebaseDataSource _fDataSource = getIt();
  @override
  Future<List<Review>> getBookReview(int bookID)
  {
    return _fDataSource.getBookReview(bookID);
  }

  @override
  Future<void> savePost(Book book, BookUser user, String reviewType, String comment, int? pageNum, DateTime postTime, double rating) {
    return _fDataSource.savePost(book, user, reviewType, comment, pageNum, postTime, rating);
  }
}