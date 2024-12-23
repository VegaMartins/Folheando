import 'package:flutter/material.dart';
import 'package:folheando/providers/review_provider.dart';
import 'package:folheando/screens/book_details_screen/widgets/book_appbar.dart';
import 'package:folheando/screens/book_details_screen/widgets/book_description.dart';
import 'package:folheando/screens/book_details_screen/widgets/book_download_links.dart';
import 'package:folheando/screens/book_details_screen/widgets/content_singlechild_scrollview.dart';
import 'package:folheando/screens/book_details_screen/widgets/favorite_review_section.dart';
import 'package:provider/provider.dart';
import '../../models/book.dart';


class BookDetailsScreen extends StatefulWidget {
  final Book book;

  const BookDetailsScreen({Key? key, required this.book}) : super(key: key);

  @override
  _BookDetailsScreenState createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  final _reviewController = TextEditingController();
  double _rating = 0;

  @override
  void initState() {
    super.initState();
    _reviewController.text = widget.book.userReview ?? '';
    _rating = widget.book.userRating ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: BookAppBar(widget: widget),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ContentSingleChildScrollView (widget: widget),
              const SizedBox(height: 24),
              if (widget.book.description != null &&
                  widget.book.description!.isNotEmpty)
                BookDescription(description: widget.book.description!),
              const SizedBox(height: 24),
              if (widget.book.downloadLinks != null &&
                  widget.book.downloadLinks!.isNotEmpty)
                BookDownloadLinks(
                  links: widget.book.downloadLinks!,
                ),
              const SizedBox(height: 24),
             Padding(
              padding: const EdgeInsets.all(16),
               child: FavoriteReviewSection(
                 isFavorite: widget.book.isFavorite,
                 rating: _rating,
                 reviewController: _reviewController,
                onRatingUpdate: (newRating) {
                  setState(() {
                 _rating = newRating;
                  });
                 _updateReviewAndRating();
                },
                 onReviewChanged: _updateReviewAndRating,
               ),
             ),
            ],
          ),
        ),
      ),
    );
  }

  void _updateReviewAndRating() {
    context.read<ReviewProvider>().updateBookReview(
          widget.book,
          _reviewController.text,
          _rating,
        );
  }

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }
}

















