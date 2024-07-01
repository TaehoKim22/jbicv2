import 'package:flutter/material.dart';
import 'package:jbicv2/main.dart';
import 'package:jbicv2/src/models/book.dart';
import 'package:jbicv2/src/models/book_user.dart';
import 'package:jbicv2/src/models/review.dart';
import 'package:jbicv2/src/repository/book_repository.dart';
import 'package:jbicv2/src/repository/auth_repository.dart';
import 'package:jbicv2/src/repository/book_user_repository.dart';
import 'package:jbicv2/src/repository/review_repository.dart';

class BookNotifier extends ChangeNotifier {
  List<Review?> coverMyReviewList = [];
  List<Review?> middleMyReviewList = [];
  List<Review?> finalMyReviewList = [];
  List<Review?> coverOtherReviewList = [];
  List<Review?> middleOtherReviewList = [];
  List<Review?> finalOtherReviewList = [];
  final ReviewRepository _reviewRepository = getIt();
  final BookRepository _bookRepository = getIt();
  var isLoading = true;
  Book? book;
  final AuthRepository _authRepository = getIt();
  final BookUserRepository _bookUserRepository = getIt();
  BookUser? bookUser;

  void fetchBookReviews(String bookISBN) async {
    try {
      isLoading = true;
      var reviews = await _reviewRepository.getBookReview(bookISBN);
      var user = _authRepository.getCurrentUser();
      if (user == null) {
        bookUser = null;
      } 
      else {
        bookUser = await  _bookUserRepository.getUser(user.email!);
        coverMyReviewList =
            reviews.where((review) => review!.reviewType == 'Cover' && review.userID == bookUser?.id).toList();
        middleMyReviewList =
            reviews.where((review) => review!.reviewType == 'Middle'&& review.userID == bookUser?.id).toList();
        finalMyReviewList =
            reviews.where((review) => review!.reviewType == 'Final'&& review.userID == bookUser?.id).toList();
      }

      coverOtherReviewList =
          reviews.where((review) => review!.reviewType == 'Cover'&& review.userID != bookUser?.id).toList();
      middleOtherReviewList =
          reviews.where((review) => review!.reviewType == 'Middle'&& review.userID != bookUser?.id).toList();
      finalOtherReviewList =
          reviews.where((review) => review!.reviewType == 'Final'&& review.userID != bookUser?.id).toList();
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
    }
  }

  void fetchBook(String bookISBN) async {
    isLoading = true;
    try {
      
      book = await _bookRepository.getBook(bookISBN);
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
    }
  }
}
