import 'package:flutter/material.dart';
import 'package:folheando/core/constants/app_colors.dart';
import 'package:folheando/core/themes/app_typography.dart';
import 'package:folheando/providers/theme_provider.dart';
import 'package:folheando/screens/favorites_screen/favorites_screen.dart';
import 'package:provider/provider.dart';

class HomeScreenAppBar extends StatelessWidget implements PreferredSizeWidget  {
  const HomeScreenAppBar({
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(      
      title: Text(
        'Folheando',
        style: AppTypography.heading.copyWith(color: AppColors.white),
      ),
        leading: IconButton(
        icon: Icon(
    context.watch<ThemeProvider>().isDarkMode 
      ? Icons.light_mode 
      : Icons.dark_mode,
    color: AppColors.white,
        ),
        iconSize: 26,
        onPressed: () {
    context.read<ThemeProvider>().toggleTheme();
        },
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.book_rounded, color: AppColors.white),
          iconSize: 28,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const FavoritesScreen(),
              ),
            );
          },
        ),
      ],
    );
  }
}