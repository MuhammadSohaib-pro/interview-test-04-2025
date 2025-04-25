// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewResponse _$ReviewResponseFromJson(Map<String, dynamic> json) =>
    ReviewResponse(
      movieId: (json['movie_id'] as num).toInt(),
      userId: (json['user_id'] as num).toInt(),
      rating: (json['rating'] as num).toInt(),
      review: json['review'] as String,
      updatedAt: DateTime.parse(json['updated_at'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
      id: (json['id'] as num).toInt(),
    );

Map<String, dynamic> _$ReviewResponseToJson(ReviewResponse instance) =>
    <String, dynamic>{
      'movie_id': instance.movieId,
      'user_id': instance.userId,
      'rating': instance.rating,
      'review': instance.review,
      'updated_at': instance.updatedAt.toIso8601String(),
      'created_at': instance.createdAt.toIso8601String(),
      'id': instance.id,
    };
