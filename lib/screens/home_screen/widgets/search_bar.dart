import 'package:flutter/material.dart';
import 'package:folheando/core/constants/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:folheando/providers/search_provider.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final String selectedCategory;
  final List<Map<String, dynamic>> categories;
  final Function(String) onCategorySelected;

  const CustomSearchBar({
    super.key,
    required this.controller,
    required this.selectedCategory,
    required this.categories,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color:Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryLight.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: AppColors.primaryLight),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Procure livros...',
                border: InputBorder.none,
              ),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  context.read<SearchProvider>().searchBooks(value);
                  onCategorySelected('all');
                }
              },
            ),
          ),
          PopupMenuButton<String>(
            icon: Icon(
              Icons.filter_list,
              color: selectedCategory != 'all' ? AppColors.primaryDark : AppColors.primaryLight,
            ),
            tooltip: 'Filtrar por categoria',
            onSelected: onCategorySelected,
            itemBuilder: (BuildContext context) {
              return categories.map((category) {
                return PopupMenuItem<String>(
                  value: category['id'],
                  child: Row(
                    children: [
                      Icon(
                        category['icon'],
                        color: selectedCategory == category['id']
                            ?  AppColors.primaryLight
                            :  AppColors.grey,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        category['name'],
                        style: TextStyle(
                          color: selectedCategory == category['id']
                              ? AppColors.primaryLight
                              : AppColors.primaryDark,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList();
            },
          ),
        ],
      ),
    );
  }
}