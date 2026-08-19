import 'package:flutter/material.dart';
import '../app_colours.dart';
import 'category_detail_screen.dart';

class BookingCategoriesScreen extends StatelessWidget {
  const BookingCategoriesScreen({super.key});

  final List<Map<String, String>> categories = const [
    {
      'title': 'Private Lessons',
      'subtitle': '1-on-1 coaching tailored to your level',
      'icon': 'sports_score',
    },
    {
      'title': 'Group Lessons',
      'subtitle': 'Shared sessions for jump & flatwork',
      'icon': 'groups',
    },
    {
      'title': 'Arena Hire',
      'subtitle': 'Reserve indoor or outdoor arena slots',
      'icon': 'stadium',
    },
    {
      'title': 'Clinics',
      'subtitle': 'Intensive masterclasses with guest trainers',
      'icon': 'star',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Book Your Experience',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: AppColors.cardSurface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.08),
              ),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 12,
              ),
              title: Text(
                category['title']!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  category['subtitle']!,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 18,
                color: AppColors.primaryOrange,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoryDetailScreen(
                      categoryTitle: category['title']!,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}