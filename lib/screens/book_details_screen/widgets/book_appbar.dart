import 'package:flutter/material.dart';
import 'package:folheando/core/constants/app_colors.dart';
import 'package:folheando/core/themes/app_typography.dart';
import 'package:folheando/screens/book_details_screen/book_details_screen.dart';
import 'package:folheando/screens/book_details_screen/widgets/consumer_details_screens.dart';

class BookAppBar extends StatelessWidget implements PreferredSizeWidget {
  final BookDetailsScreen widget;

  const BookAppBar({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Detalhes do Livro',
      style: AppTypography.heading.copyWith(
        color: AppColors.white,
      ),),
      actions: [
        ConsumerDetailsScreens(widget: widget),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}