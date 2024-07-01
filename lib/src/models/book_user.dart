import 'package:json_annotation/json_annotation.dart';

part 'book_user.g.dart';

@JsonSerializable()
class BookUser{
  final String email, userName;
  final String? photoURL;
  final int id;

  BookUser({required this.id, this.photoURL, 
  required this.userName, required this.email});
  factory BookUser.fromJson(Map<String, dynamic> json) => _$BookUserFromJson(json);
  Map<String, dynamic> toJson(Map<String, dynamic> data) => _$BookUserToJson(this);
}