import 'package:flutter/material.dart';
import '../app_colours.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  final List<Map<String, String>> services = const [
    {
      'title': 'Private Lessons',
      'description': 'Personalized coaching with top instructors.',
      'image': 'assets/images/private_lessons.jpg',
    },
    {
      'title': 'Group Lessons',
      'description': 'Learn and grow with fellow riders.',
      'image': 'assets/images/group_lessons.jpg',
    },
    {
      'title': 'Arena Hire',
      'description': 'Rent our facilities for independent riding.',
      'image': 'assets/images/arena_hire.jpg',
    },
    {
      'title': 'Clinics',
      'description': 'Intensive training with guest experts.',
      'image': 'assets/images/clinics.jpg',
    },
    {
      'title': 'Youngstars',
      'description': 'Fun and safe intro to riding for kids.',
      'image': 'assets/images/youngstars.jpg',
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
            fontSize: 22,
          ),
        ),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: services.length,
        itemBuilder: (context, index) {
          final item = services[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.cardSurface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.08),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text details & Book button on the left
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['title']!,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        item['description']!,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 14),
                      ElevatedButton(
                        onPressed: () {
                          // Handle booking navigation
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryOrange,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: const StadiumBorder(),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 8,
                          ),
                        ),
                        child: const Text(
                          'Book Now',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                // Image preview on the right
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    item['image']!,
                    width: 120,
                    height: 110,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 120,
                        height: 110,
                        color: Colors.white.withValues(alpha: 0.1),
                        child: const Icon(
                          Icons.pets,
                          color: AppColors.textSecondary,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}