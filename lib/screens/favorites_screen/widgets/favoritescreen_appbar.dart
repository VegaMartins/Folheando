import 'package:flutter/material.dart';
import 'package:folheando/core/constants/app_colors.dart';
import 'package:folheando/core/themes/app_typography.dart';

class FavoritesScreenAppBar extends StatelessWidget implements PreferredSizeWidget{
  const FavoritesScreenAppBar({
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'Meus Livros',
        style: AppTypography.heading.copyWith(
          fontSize: 26,
          color: AppColors.white,
        ),
      ),
      centerTitle: true,
    );
  }
}