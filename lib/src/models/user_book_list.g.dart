// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_book_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserBookList _$UserBookListFromJson(Map<String, dynamic> json) => UserBookList(
      userID: (json['userID'] as num).toInt(),
      id: (json['id'] as num).toInt(),
      bookListName: json['bookListName'] as String,
      createdDate: DateTime.parse(json['createdDate'] as String),
      photoURL: json['photoURL'] as String?,
    );

Map<String, dynamic> _$UserBookListToJson(UserBookList instance) =>
    <String, dynamic>{
      'userID': instance.userID,
      'id': instance.id,
      'bookListName': instance.bookListName,
      'createdDate': instance.createdDate.toIso8601String(),
      'photoURL': instance.photoURL,
    };
