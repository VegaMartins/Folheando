import 'package:flutter/material.dart';
import 'package:folheando/providers/favorites_provider.dart';
import 'package:folheando/screens/favorites_screen/widgets/consumer_favorite_screenclear.dart';
import 'package:folheando/screens/favorites_screen/widgets/favorite_books_list.dart';
import 'package:folheando/screens/favorites_screen/widgets/favoritescreen_appbar.dart';
import 'package:provider/provider.dart';


class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
  return const SafeArea(
    child: Scaffold(
      appBar: FavoritesScreenAppBar(),
      body: ConsumerFavoriteScreen(),
    ),
  );
  }
}

class ConsumerFavoriteScreen extends StatelessWidget {
  const ConsumerFavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoritesProvider>(
      builder: (context, provider, child) {
        if (provider.favoriteBooks.isEmpty) {
          return const Center(
            child: ConsumerFavoriteScreenClean(),
          );
        }

        return FavoriteBooksList(favoriteBooks: provider.favoriteBooks);
      },
    );
  }
}


