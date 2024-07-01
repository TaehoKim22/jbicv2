// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookUser _$BookUserFromJson(Map<String, dynamic> json) => BookUser(
      id: (json['id'] as num).toInt(),
      photoURL: json['photoURL'] as String?,
      userName: json['userName'] as String,
      email: json['email'] as String,
    );

Map<String, dynamic> _$BookUserToJson(BookUser instance) => <String, dynamic>{
      'email': instance.email,
      'userName': instance.userName,
      'photoURL': instance.photoURL,
      'id': instance.id,
    };
