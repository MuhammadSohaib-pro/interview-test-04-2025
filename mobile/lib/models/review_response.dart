import 'package:json_annotation/json_annotation.dart';

part 'review_response.g.dart';

@JsonSerializable()
class ReviewResponse {
  @JsonKey(name: 'movie_id')
  final int movieId;

  @JsonKey(name: 'user_id')
  final int userId;

  final int rating;
  final String review;

  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  final int id;

  ReviewResponse({
    required this.movieId,
    required this.userId,
    required this.rating,
    required this.review,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory ReviewResponse.fromJson(Map<String, dynamic> json) => 
      _$ReviewResponseFromJson(json);
  
  Map<String, dynamic> toJson() => _$ReviewResponseToJson(this);
}