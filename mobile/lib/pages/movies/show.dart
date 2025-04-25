// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kmbal_movies_app/controllers/movies_controller.dart';
import 'package:kmbal_movies_app/models/movie.dart';
import 'package:kmbal_movies_app/models/review.dart';
import 'package:kmbal_movies_app/tokens.dart';

class ShowMoviePage extends StatefulWidget {
  const ShowMoviePage({super.key});

  @override
  State<StatefulWidget> createState() => MoviesPageState();
}

class MoviesPageState extends State<ShowMoviePage> {
  final MoviesController _moviesController = Get.find();
  late String _movieId;

  late Future<Movie> _movie;
  late Future<List<Review>> _reviews;

  @override
  void initState() {
    super.initState();
    _movieId = Get.parameters['id']!;
    _loadData();
  }

  void _loadData() {
    setState(() {
      _movie = _moviesController.fetchMovie(_movieId);
      _reviews = _moviesController.fetchMovieReviews(_movieId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: Get.back,
          icon: Icon(
            Icons.chevron_left,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedSize(
                    alignment: Alignment.topCenter,
                    duration: Duration(milliseconds: 200),
                    child: SizedBox(
                      width: double.infinity,
                      child: FutureBuilder(
                        future: _movie,
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text("Error loading movie.");
                          }

                          if (snapshot.hasData) {
                            return MovieUi(snapshot.requireData);
                          }

                          return Text("Loading movie...");
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Reviews",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Get.toNamed('/movies/add-review',
                              parameters: {'id': _movieId});
                        },
                        child: Text('Add Review'),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  AnimatedSize(
                    alignment: Alignment.topCenter,
                    duration: Duration(milliseconds: 200),
                    child: SizedBox(
                      width: double.infinity,
                      child: FutureBuilder(
                        future: _reviews,
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text("Error loading movie reviews.");
                          }

                          if (snapshot.hasData) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              children: snapshot.requireData
                                  .map<Widget>((review) => ReviewItem(review))
                                  .toList(),
                            );
                          }

                          return Text("Loading reviews...");
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MovieUi extends StatelessWidget {
  final Movie _movie;

  const MovieUi(this._movie, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        color: ColorTokens.lightBlue100,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _movie.title,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(height: 4),
          Text(
            _movie.description,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

class ReviewItem extends StatelessWidget {
  final Review _review;

  const ReviewItem(this._review, {super.key});

  String _rating() {
    return "★" * _review.rating + "☆" * (5 - _review.rating);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(bottom: 8),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        color: ColorTokens.lightBlue100,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _rating(),
            style: Theme.of(context).textTheme.bodySmall,
          ),
          SizedBox(height: 4),
          Text(
            _review.review,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
