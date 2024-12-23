import 'package:flutter/foundation.dart';
import '../models/book.dart';
import '../repositories/book_repository.dart';

class SearchProvider with ChangeNotifier {
  final BookRepository _repository;
  List<Book> _books = [];
  bool _isLoading = false;

  SearchProvider(this._repository);

  List<Book> get books => _books;
  bool get isLoading => _isLoading;

  Future<void> searchBooks(String query) async {
    _isLoading = true;
    notifyListeners();

    try {
      _books = await _repository.searchBooks(query);
    } catch (e) {
      print(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}