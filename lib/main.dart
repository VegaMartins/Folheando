import 'package:flutter/material.dart';
import 'package:folheando/app/app_widget.dart';
import 'package:provider/provider.dart';
import 'providers/theme_provider.dart';
import 'providers/search_provider.dart';
import 'providers/favorites_provider.dart';
import 'providers/review_provider.dart';
import 'repositories/book_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SearchProvider(BookRepository()),
        ),
        ChangeNotifierProvider(
          create: (_) => FavoritesProvider(),
        ),
        ChangeNotifierProxyProvider<FavoritesProvider, ReviewProvider>(
          create: (context) => ReviewProvider(
            context.read<FavoritesProvider>(),
          ),
          update: (context, favorites, previous) => 
            ReviewProvider(favorites),
        ),
      ],
      child: const MyApp(),
    ),
  );
}