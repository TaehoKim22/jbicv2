import 'package:jbicv2/main.dart';
import 'package:jbicv2/src/data_source/firebase_data_source.dart';
import 'package:jbicv2/src/models/book.dart';
import 'package:jbicv2/src/models/review.dart';
import 'package:jbicv2/src/repository/review_repository.dart';

class ReviewRepositoryImp extends ReviewRepository{
  final FirebaseDataSource _fDataSource = getIt();
  @override
  Future<List<Review>> getBookReview(Book book)
  {
    return _fDataSource.getBookReview(book);
  }
}