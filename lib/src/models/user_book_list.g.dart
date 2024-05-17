// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_book_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserBookList _$UserBookListFromJson(Map<String, dynamic> json) => UserBookList(
      userID: (json['userID'] as num).toInt(),
      bookList: (json['bookList'] as List<dynamic>?)
          ?.map((e) => Book.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: (json['id'] as num).toInt(),
      bookListName: json['bookListName'] as String,
    );

Map<String, dynamic> _$UserBookListToJson(UserBookList instance) =>
    <String, dynamic>{
      'userID': instance.userID,
      'id': instance.id,
      'bookList': instance.bookList,
      'bookListName': instance.bookListName,
    };
