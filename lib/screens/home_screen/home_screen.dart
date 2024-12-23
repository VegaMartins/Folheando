import 'package:flutter/material.dart';
import 'package:folheando/core/constants/app_colors.dart';
import 'package:folheando/core/themes/app_typography.dart';
import 'package:folheando/providers/favorites_provider.dart';
import 'package:folheando/providers/search_provider.dart';
import 'package:folheando/screens/home_screen/widgets/book_grid_item.dart';
import 'package:folheando/screens/home_screen/widgets/home_appbar.dart';
import 'package:folheando/screens/home_screen/widgets/search_bar.dart';
import 'package:provider/provider.dart';
import '../book_details_screen/book_details_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();
  String _selectedCategory = 'all';

  final List<Map<String, dynamic>> _categories = [
    {'id': 'all', 'name': 'Todos os livros', 'icon': Icons.library_books, 'query': ''},
    {'id': 'fiction', 'name': 'Ficção', 'icon': Icons.auto_stories, 'query': 'fiction'},
    {'id': 'romance', 'name': 'Romance', 'icon': Icons.favorite, 'query': 'romance'},
    {'id': 'fantasy', 'name': 'Fantasia', 'icon': Icons.castle, 'query': 'fantasy'},
    {'id': 'science', 'name': 'Ciência', 'icon': Icons.science, 'query': 'science'},
    {'id': 'biography', 'name': 'Biografia', 'icon': Icons.person, 'query': 'biography'},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const HomeScreenAppBar(),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomSearchBar(
                controller: _searchController,
                selectedCategory: _selectedCategory,
                categories: _categories,
                onCategorySelected: (String categoryId) {
                  setState(() {
                    _selectedCategory = categoryId;
                    _searchController.clear();
                  });
                  
                  final selectedCategory = _categories.firstWhere(
                    (category) => category['id'] == categoryId,
                    orElse: () => _categories.first,
                  );
                  
                  if (categoryId != 'all') {
                    context.read<SearchProvider>().searchBooks(selectedCategory['query']);
                  }
                },
              ),
            ),
            Expanded(
              child: Consumer2<SearchProvider, FavoritesProvider>(
                builder: (context, searchProvider, favoritesProvider, child) {
                  if (searchProvider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (searchProvider.books.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _selectedCategory == 'all' ? Icons.search : Icons.category,
                            size: 62,
                            color: AppColors.accent
                          ,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _selectedCategory == 'all'
                                ? 'Procure por livros para iniciar'
                                : 'Nenhum livro encontrado nesta categoria',
                            style: AppTypography.body.copyWith(
                              fontSize: 14,
                              color: AppColors.accent,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.65,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: searchProvider.books.length,
                    itemBuilder: (context, index) {
                      final book = searchProvider.books[index];
                      book.isFavorite = favoritesProvider.isFavorite(book.id);
                      return BookGridItem(
                        book: book,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookDetailsScreen(book: book),
                          ),
                        ),
                        onFavoritePressed: () => favoritesProvider.toggleFavorite(book),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}