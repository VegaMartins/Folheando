import 'package:flutter/material.dart';
import 'package:folheando/core/constants/app_colors.dart';
import 'package:folheando/models/book.dart';
import 'package:folheando/providers/favorites_provider.dart';
import 'package:folheando/screens/book_details_screen/book_details_screen.dart';
import 'package:folheando/screens/favorites_screen/widgets/book_card.dart';
import 'package:provider/provider.dart';

class FavoriteBookItem extends StatelessWidget {
  final Book book;

  const FavoriteBookItem({required this.book, super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FavoritesProvider>(context, listen: false);

    return Dismissible(
      key: Key(book.id),
      background: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.red[400],
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(
          Icons.delete,
          color: AppColors.white,
          size: 32,
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        provider.toggleFavorite(book);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Livro removido dos favoritos'),
            action: SnackBarAction(
              label: 'Desfazer',
              onPressed: () => provider.toggleFavorite(book),
            ),
          ),
        );
      },
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookDetailsScreen(book: book),
            ),
          );
        },
        child: BookCard(book: book),
      ),
    );
  }
}

