import 'package:flutter/material.dart';

class ConsumerFavoriteScreenClean extends StatelessWidget {
  const ConsumerFavoriteScreenClean({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.book_rounded,
          size: 62,
          color: Colors.grey[400],
        ),
        const SizedBox(height: 16),
        Text(
          'Nenhum livro favorito ainda',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Adicione livros aos favoritos para vê-los aqui',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[500],
          ),
        ),
      ],
    );
  }
}

