import 'package:flutter/material.dart';
import 'package:folheando/core/constants/app_colors.dart';
import 'package:folheando/core/themes/app_typography.dart';
import 'package:url_launcher/url_launcher.dart';

class BookDownloadLinks extends StatelessWidget {
  final List<String> links;

  const BookDownloadLinks({super.key, required this.links});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text(
            'Onde encontrar',
            style: AppTypography.title.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryDark ,
            ),
          ),
          const SizedBox(height: 16),
          ...links.map((link) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: InkWell(
                  onTap: () async {
                    if (!await launchUrl(Uri.parse(link))) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Não foi possível abrir o link')),
                      );
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE1BEE7),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.link, color: AppColors.primary),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            link.contains('download') ? 'Download' : 'Ler Online',
                            style: const TextStyle(
                              color: AppColors.primaryDark,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Icon(Icons.arrow_forward_ios,
                            color: AppColors.primary, size: 16),
                      ],
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
