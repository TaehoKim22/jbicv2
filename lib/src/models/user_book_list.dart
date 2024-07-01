import 'package:json_annotation/json_annotation.dart';

part 'user_book_list.g.dart';

@JsonSerializable()
class UserBookList{
  final int userID, id;
  final String bookListName;
  final DateTime createdDate;
  final String? photoURL;

  UserBookList({required this.userID,  required this.id, required this.bookListName, required this.createdDate, this.photoURL});

  factory UserBookList.fromJson(Map<String, dynamic> json) => _$UserBookListFromJson(json);
  Map<String, dynamic> toJson() => _$UserBookListToJson(this);
}