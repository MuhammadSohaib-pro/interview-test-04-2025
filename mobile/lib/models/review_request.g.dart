// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewRequest _$ReviewRequestFromJson(Map<String, dynamic> json) =>
    ReviewRequest(
      rating: (json['rating'] as num).toInt(),
      review: json['review'] as String,
    );

Map<String, dynamic> _$ReviewRequestToJson(ReviewRequest instance) =>
    <String, dynamic>{
      'rating': instance.rating,
      'review': instance.review,
    };
