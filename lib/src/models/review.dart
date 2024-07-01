import 'package:json_annotation/json_annotation.dart';

part 'review.g.dart';

@JsonSerializable()
class Review{
  final String title, author, userName, reviewType, comment, isbn;
  final String? photoURL;
  final int bookID, userID, likes;
  final double rating;
  final DateTime postTime;
  final int? pageNum;
  Review({required this.title, required this.author, required this.userName, required this.reviewType,
  required this.comment, required this.isbn, required this.bookID, required this.userID, required this.likes,
  required this.rating, required this.postTime, this.photoURL, this.pageNum});
  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewToJson(this);
}