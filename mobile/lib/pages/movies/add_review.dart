import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kmbal_movies_app/controllers/movies_controller.dart';

class AddReviewPage extends StatefulWidget {
  final int movieId;

  const AddReviewPage({super.key, required this.movieId});

  @override
  State<AddReviewPage> createState() => _AddReviewPageState();
}

class _AddReviewPageState extends State<AddReviewPage> {
  final MoviesController _moviesController = Get.find();
  final TextEditingController _reviewController = TextEditingController();

  int _selectedRating = 0;
  bool _isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Review'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    index < _selectedRating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 40,
                  ),
                  onPressed: () {
                    setState(() {
                      _selectedRating = index + 1;
                    });
                  },
                );
              }),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _reviewController,
              decoration: InputDecoration(
                hintText: 'Write your review...',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
            SizedBox(height: 16),
            !_isSubmitting
                ? ElevatedButton(
                    onPressed: _isSubmitting ? null : _submitReview,
                    child: Text('Submit Review'),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
          ],
        ),
      ),
    );
  }

  void _submitReview() async {
    if (_selectedRating == 0) {
      Get.snackbar('Error', 'Please select a rating');
      return;
    }

    if (_reviewController.text.trim().isEmpty) {
      Get.snackbar('Error', 'Please write a review');
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      await _moviesController.addReview(
          movieId: widget.movieId,
          rating: _selectedRating,
          reviewText: _reviewController.text.trim());

      Get.offAndToNamed('/movies/show',
          parameters: {'id': widget.movieId.toString()}, arguments: true);
    } catch (e) {
      Get.snackbar('Error', 'Failed to submit review');
    } finally {
      setState(() {
        _isSubmitting = false;
      });
    }
  }

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }
}
