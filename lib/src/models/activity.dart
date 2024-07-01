import 'package:json_annotation/json_annotation.dart';

part 'activity.g.dart';

@JsonSerializable()
class Activity{
  final String? title, author, isbn;
  final String? query;
  final String activityType;
  final int id, userId;
  final int? bookId, bookListId;
  final DateTime activityTime;

  Activity({required this.id, required this.activityType, required this.userId, this.title, this.author, this.isbn, this.query, this.bookId, this.bookListId, required this.activityTime});
  factory Activity.fromJson(Map<String, dynamic> json) => _$ActivityFromJson(json);
  Map<String, dynamic> toJson() => _$ActivityToJson(this);
}