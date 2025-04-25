import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:kmbal_movies_app/controllers/auth_controller.dart';
import 'package:kmbal_movies_app/models/api_response.dart';
import 'package:kmbal_movies_app/models/login_request.dart';
import 'package:kmbal_movies_app/models/login_response.dart';
import 'package:kmbal_movies_app/models/movie.dart';
import 'package:kmbal_movies_app/models/movies_index_response.dart';
import 'package:kmbal_movies_app/models/review_request.dart';
import 'package:kmbal_movies_app/models/review_response.dart';
import 'package:kmbal_movies_app/models/reviews_index_response.dart';
import 'package:kmbal_movies_app/models/validation_error_response.dart';

abstract class _AbstractApiClient extends GetConnect {
  final AuthController _authController = Get.find();

  final String _apiBaseUrl = "http://localhost:8000/api";
  String _url(String path) => "$_apiBaseUrl$path";

  final Map<String, String> _headers = {
    "Accept": "application/json",
  };

  Map<String, String> _headersWithAuth() => {
        ..._headers,
        "Authorization": "Bearer ${_authController.requireToken()}",
      };

  ApiResponse<T> _toApiResponse<T>(
      T Function(Map<String, dynamic>) fromJson, Response response) {
    if (response.status.isOk) {
      return ApiResponse.ok(response, fromJson(response.body));
    }

    if (response.statusCode == HttpStatus.unprocessableEntity ||
        response.statusCode == HttpStatus.badRequest) {
      return ApiResponse.validationError(
          response, ValidationErrorResponse.fromJson(response.body));
    }

    return ApiResponse.unknownError(response);
  }
}

class ApiClient extends _AbstractApiClient {
  late MoviesApiClient movies = MoviesApiClient();

  Future<ApiResponse<LoginResponse>> login(LoginRequest request) async {
    return _toApiResponse(
      LoginResponse.fromJson,
      await post(
        _url("/v1/login"),
        request.toJson(),
        headers: _headers,
      ),
    );
  }
}

class MoviesApiClient extends _AbstractApiClient {
  late MovieReviewsApiClient reviews = MovieReviewsApiClient();

  MoviesApiClient();

  Future<ApiResponse<MoviesIndexResponse>> index() async {
    return _toApiResponse(
      MoviesIndexResponse.fromJson,
      await get(
        _url("/v1/movies"),
        headers: _headersWithAuth(),
      ),
    );
  }

  Future<ApiResponse<Movie>> show(String id) async {
    return _toApiResponse(
      Movie.fromJson,
      await get(
        _url("/v1/movies/$id"),
        headers: _headersWithAuth(),
      ),
    );
  }
}

class MovieReviewsApiClient extends _AbstractApiClient {
  MovieReviewsApiClient();

  Future<ApiResponse<ReviewsIndexResponse>> index(String movieId) async {
    return _toApiResponse(
      ReviewsIndexResponse.fromJson,
      await get(
        _url("/v1/movies/$movieId/reviews"),
        headers: _headersWithAuth(),
      ),
    );
  }

  Future<ApiResponse<ReviewResponse>> store(
      String movieId, ReviewRequest request) async {
    return _toApiResponse(
      ReviewResponse.fromJson,
      await post(
        _url("/v1/movies/$movieId/reviews"),
        request.toJson(),
        headers: _headersWithAuth(),
      ),
    );
  }
}
