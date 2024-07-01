import 'package:json_annotation/json_annotation.dart';

part 'book_list_book.g.dart';

@JsonSerializable()
class BookListBook{
  final String title, author, isbn;
  final int id, bookListId, bookId;

  BookListBook({required this.id, required this.bookId, required this.bookListId, required this.title, required this.author, required this.isbn});
  factory BookListBook.fromJson(Map<String, dynamic> json) => _$BookListBookFromJson(json);
  Map<String, dynamic> toJson() => _$BookListBookToJson(this);
}