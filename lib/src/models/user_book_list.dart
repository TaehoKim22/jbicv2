import 'package:json_annotation/json_annotation.dart';
import './book.dart';

part 'user_book_list.g.dart';

@JsonSerializable()
class UserBookList{
  final int userID, id;
  final List<Book>? bookList;
  final String bookListName;

  UserBookList({required this.userID, this.bookList, required this.id, required this.bookListName});

  factory UserBookList.fromJson(Map<String, dynamic> json) => _$UserBookListFromJson(json);
  Map<String, dynamic> toJson() => _$UserBookListToJson(this);
}