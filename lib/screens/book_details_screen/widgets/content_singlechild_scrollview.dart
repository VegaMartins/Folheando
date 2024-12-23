import 'package:flutter/material.dart';
import 'package:folheando/core/constants/app_colors.dart';
import 'package:folheando/screens/book_details_screen/book_details_screen.dart';

class ContentSingleChildScrollView extends StatelessWidget {
  const ContentSingleChildScrollView({
    super.key,
    required this.widget,
  });

  final BookDetailsScreen widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Hero(
            tag: 'book-${widget.book.id}',
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: widget.book.coverUrl != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        widget.book.coverUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.book, size: 100, color: AppColors.white),
                      ),
                    )
                  : const Icon(Icons.book, size: 100, color: AppColors.white),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              widget.book.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
                fontFamily: 'Cargiona',
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.book.author ?? 'Autor Desconhecido',
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white70,
              fontFamily: 'Cargiona',
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
