import 'package:flutter/material.dart';
import 'package:folheando/core/constants/app_colors.dart';
import 'package:folheando/providers/favorites_provider.dart';
import 'package:folheando/screens/book_details_screen/book_details_screen.dart';
import 'package:provider/provider.dart';

class ConsumerDetailsScreens extends StatelessWidget {
  const ConsumerDetailsScreens({
    super.key,
    required this.widget,
  });

  final BookDetailsScreen widget;

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoritesProvider>(
      builder: (context, provider, child) {
        return IconButton(
          iconSize: 28,
          icon: Icon(
            widget.book.isFavorite ? Icons.book_rounded : Icons.book_rounded,
            color: widget.book.isFavorite ? AppColors.primary : AppColors.white,
          ),
          onPressed: () {
            provider.toggleFavorite(widget.book);
          },
        );
      },
    );
  }
}