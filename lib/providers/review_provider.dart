import 'package:flutter/foundation.dart';
import 'package:folheando/providers/favorites_provider.dart';
import '../models/book.dart';

class ReviewProvider with ChangeNotifier {
  final FavoritesProvider _favoritesProvider;

  ReviewProvider(this._favoritesProvider);

  Future<void> updateBookReview(Book book, String review, double rating) async {
    final index = _favoritesProvider.favoriteBooks.indexWhere((b) => b.id == book.id);
    if (index != -1) {
      book.userReview = review;
      book.userRating = rating;
      await _favoritesProvider.saveFavoriteBooks();
      notifyListeners();
    }
  }
}