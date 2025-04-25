import 'package:json_annotation/json_annotation.dart';

part 'review_request.g.dart';

@JsonSerializable()
class ReviewRequest {
  final int rating;
  final String review;

  ReviewRequest({required this.rating, required this.review});

  factory ReviewRequest.fromJson(Map<String, dynamic> json) =>
      _$ReviewRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewRequestToJson(this);
}
