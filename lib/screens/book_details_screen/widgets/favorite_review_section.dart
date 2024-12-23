import 'package:flutter/material.dart';
import 'package:folheando/core/constants/app_colors.dart';

class FavoriteReviewSection extends StatelessWidget {
  final bool isFavorite;
  final double rating;
  final TextEditingController reviewController;
  final Function(double) onRatingUpdate;
  final VoidCallback onReviewChanged;

  const FavoriteReviewSection({super.key, 
    required this.isFavorite,
    required this.rating,
    required this.reviewController,
    required this.onRatingUpdate,
    required this.onReviewChanged,
  });

  @override
  Widget build(BuildContext context) {
    return isFavorite
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Sua Avaliação',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryDark,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: List.generate(5, (index) {
                  return IconButton(
                    icon: Icon(
                      index < rating ? Icons.star : Icons.star_border,
                      color: AppColors.rating,
                      size: 32,
                    ),
                    onPressed: () => onRatingUpdate(index + 1.0),
                  );
                }),
              ),
              const SizedBox(height: 16),
              const Text(
                'Sua Review',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryDark,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: reviewController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Escreva sua review aqui...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: AppColors.accent.withOpacity(0.2),
                ),
                onChanged: (_) => onReviewChanged(),
              ),
            ],
          )
        : Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.accent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.book_rounded, color:AppColors.primary),
                SizedBox(width: 8),
                Text(
                  'Adicione aos seus livros para avaliar',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
  }
}