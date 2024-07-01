import 'package:flutter/material.dart';
import 'package:jbicv2/main.dart';
import 'package:jbicv2/src/models/book.dart';
import 'package:jbicv2/src/repository/auth_repository.dart';
import 'package:jbicv2/src/repository/book_user_repository.dart';
import 'package:jbicv2/src/repository/review_repository.dart';

class PostNotifier extends ChangeNotifier{
  final ReviewRepository _reviewRepository = getIt();
  final AuthRepository _authRepository = getIt();
  final BookUserRepository _bookUserRepository = getIt();
  double rating = 0.0;
  
  Future<void> savePost(Book book, String reviewType, String comment, int? pageNum, DateTime postTime) async{
    var currentUser = _authRepository.getCurrentUser();
    
    if (currentUser != null){
      var user = await _bookUserRepository.getUser(currentUser.email!);
      _reviewRepository.savePost(book, user!, reviewType, comment, pageNum, postTime, rating);
    }

  }

  void setRating(double value){
    rating = value;
    notifyListeners();
  }
}