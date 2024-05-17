// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Review _$ReviewFromJson(Map<String, dynamic> json) => Review(
      title: json['title'] as String,
      author: json['author'] as String,
      userName: json['userName'] as String,
      reviewType: json['reviewType'] as String,
      comment: json['comment'] as String,
      id: (json['id'] as num).toInt(),
      bookID: (json['bookID'] as num).toInt(),
      userID: (json['userID'] as num).toInt(),
      likes: (json['likes'] as num).toInt(),
      rating: (json['rating'] as num).toDouble(),
      postTime: DateTime.parse(json['postTime'] as String),
      photoURL: json['photoURL'] as String?,
    );

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
      'title': instance.title,
      'author': instance.author,
      'userName': instance.userName,
      'reviewType': instance.reviewType,
      'comment': instance.comment,
      'photoURL': instance.photoURL,
      'id': instance.id,
      'bookID': instance.bookID,
      'userID': instance.userID,
      'likes': instance.likes,
      'rating': instance.rating,
      'postTime': instance.postTime.toIso8601String(),
    };