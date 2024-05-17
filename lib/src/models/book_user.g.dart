// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookUser _$BookUserFromJson(Map<String, dynamic> json) => BookUser(
      id: (json['id'] as num).toInt(),
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      photoURL: json['photoURL'] as String?,
      userName: json['userName'] as String,
      email: json['email'] as String,
    );

Map<String, dynamic> _$BookUserToJson(BookUser instance) => <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'userName': instance.userName,
      'photoURL': instance.photoURL,
      'id': instance.id,
    };
