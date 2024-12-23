import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/book.dart';

class FavoritesProvider with ChangeNotifier {
  List<Book> _favoriteBooks = [];

  FavoritesProvider() {
    _loadFavoriteBooks();
  }

  List<Book> get favoriteBooks => _favoriteBooks;

  Future<void> _loadFavoriteBooks() async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesJson = prefs.getStringList('favorites') ?? [];
    _favoriteBooks = favoritesJson
        .map((json) => Book.fromJson(jsonDecode(json)))
        .toList();
    notifyListeners();
  }

  Future<void> saveFavoriteBooks() async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesJson = _favoriteBooks
        .map((book) => jsonEncode(book.toJson()))
        .toList();
    await prefs.setStringList('favorites', favoritesJson);
  }

  Future<void> toggleFavorite(Book book) async {
    book.isFavorite = !book.isFavorite;
    if (book.isFavorite) {
      _favoriteBooks.add(book);
    } else {
      _favoriteBooks.removeWhere((b) => b.id == book.id);
    }
    await saveFavoriteBooks();
    notifyListeners();
  }

  bool isFavorite(String bookId) {
    return _favoriteBooks.any((book) => book.id == bookId);
  }
}