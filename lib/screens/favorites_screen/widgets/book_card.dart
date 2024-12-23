import 'package:flutter/material.dart';
import 'package:folheando/core/constants/app_colors.dart';
import 'package:folheando/models/book.dart';
import 'package:folheando/providers/review_provider.dart';
import 'package:provider/provider.dart';

class BookCard extends StatelessWidget {
  final Book book;

  const BookCard({required this.book, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color:Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryLight.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Container(
              height: 120,
              decoration: BoxDecoration(color: AppColors.accent.withOpacity(0.5)),
              child: Row(
                children: [
                  if (book.coverUrl != null)
                    Container(
                      width: 80,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(book.coverUrl!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  else
                    Container(
                      width: 80,
                      color: AppColors.white,
                      child: const Icon(Icons.book, size: 40),
                    ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            book.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (book.author != null) ...[
                            const SizedBox(height: 4),
                            Text(
                              book.author!,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                          const SizedBox(height: 8),
                          Row(
                            children: List.generate(
                              5,
                              (index) => Icon(
                                index < (book.userRating ?? 0)
                                    ? Icons.star
                                    : Icons.star_border,
                                color: Colors.amber,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Sua Review',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  initialValue: book.userReview ?? '',
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Escreva sua opinião sobre o livro...',
                    filled: true,
                    fillColor: AppColors.white.withOpacity(0.3),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.all(12),
                  ),
                  onChanged: (value) {
                    Provider.of<ReviewProvider>(context, listen: false)
                        .updateBookReview(book, value, book.userRating ?? 0);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


