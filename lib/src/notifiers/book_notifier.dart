import 'package:flutter/material.dart';
import 'package:jbicv2/main.dart';
import 'package:jbicv2/src/models/book.dart';
import 'package:jbicv2/src/models/review.dart';
//import 'package:jbicv2/src/repository/auth_repository.dart';
import 'package:jbicv2/src/repository/review_repository.dart';

class BookNotifier extends ChangeNotifier{
  List<Review> coverMyReviewList = [];
  List<Review> middleMyReviewList = [];
  List<Review> finalMyReviewList = [];
  List<Review> coverOtherReviewList = [];
  List<Review> middleOtherReviewList = [];
  List<Review> finalOtherReviewList = [];
  final ReviewRepository _reviewRepository = getIt();
  var isLoading;
  //final AuthRepository _authRepository = getIt();

  void fetchBookReviews(int bookID) async{
    try{
      isLoading = true;
      var reviews = await _reviewRepository.getBookReview(bookID);
      //var user = _authRepository.getCurrentUser();
      coverMyReviewList = reviews.where((review) => review.reviewType == 'Cover').toList();
      middleMyReviewList = reviews.where((review) => review.reviewType == 'Middle').toList();
      finalMyReviewList = reviews.where((review) =>  review.reviewType == 'Final').toList();
      coverOtherReviewList = reviews.where((review) => review.reviewType == 'Cover').toList();
      middleOtherReviewList = reviews.where((review) => review.reviewType == 'Middle').toList();
      finalOtherReviewList = reviews.where((review) => review.reviewType == 'Final').toList();
      isLoading = false;
      notifyListeners();
    }
    catch(e){
      isLoading = false;
      notifyListeners();
    }


  }
}