// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Activity _$ActivityFromJson(Map<String, dynamic> json) => Activity(
      id: (json['id'] as num).toInt(),
      activityType: json['activityType'] as String,
      userId: (json['userId'] as num).toInt(),
      title: json['title'] as String?,
      author: json['author'] as String?,
      isbn: json['isbn'] as String?,
      query: json['query'] as String?,
      bookId: (json['bookId'] as num?)?.toInt(),
      bookListId: (json['bookListId'] as num?)?.toInt(),
      activityTime: DateTime.parse(json['activityTime'] as String),
    );

Map<String, dynamic> _$ActivityToJson(Activity instance) => <String, dynamic>{
      'title': instance.title,
      'author': instance.author,
      'isbn': instance.isbn,
      'query': instance.query,
      'activityType': instance.activityType,
      'id': instance.id,
      'userId': instance.userId,
      'bookId': instance.bookId,
      'bookListId': instance.bookListId,
      'activityTime': instance.activityTime.toIso8601String(),
    };
