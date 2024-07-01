// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_list_book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookListBook _$BookListBookFromJson(Map<String, dynamic> json) => BookListBook(
      id: (json['id'] as num).toInt(),
      bookId: (json['bookId'] as num).toInt(),
      bookListId: (json['bookListId'] as num).toInt(),
      title: json['title'] as String,
      author: json['author'] as String,
      isbn: json['isbn'] as String,
    );

Map<String, dynamic> _$BookListBookToJson(BookListBook instance) =>
    <String, dynamic>{
      'title': instance.title,
      'author': instance.author,
      'isbn': instance.isbn,
      'id': instance.id,
      'bookListId': instance.bookListId,
      'bookId': instance.bookId,
    };
