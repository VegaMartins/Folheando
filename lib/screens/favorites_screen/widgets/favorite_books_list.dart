import 'package:flutter/material.dart';
import 'package:folheando/models/book.dart';
import 'package:folheando/screens/favorites_screen/widgets/favorite_book_item.dart';

class FavoriteBooksList extends StatelessWidget {
  final List<Book> favoriteBooks;

  const FavoriteBooksList({required this.favoriteBooks, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: favoriteBooks.length,
      itemBuilder: (context, index) {
        final book = favoriteBooks[index];
        return FavoriteBookItem(book: book);
      },
    );
  }
}

