import 'package:flutter/material.dart';
import '../../app_colours.dart';
import 'booking_details_screen.dart';

class BookingServiceScreen extends StatelessWidget {
  const BookingServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text(
          'Book a Service',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildServiceCard(
            context,
            title: 'Arena Hire',
            subtitle: 'Indoor & Outdoor arenas available for private hire',
            price: 'From £25/hr',
            icon: Icons.stadium_outlined,
          ),
          const SizedBox(height: 12),
          _buildServiceCard(
            context,
            title: 'Private Lessons',
            subtitle: '1-on-1 instruction with senior trainers',
            price: 'From £45/hr',
            icon: Icons.person_outline,
          ),
          const SizedBox(height: 12),
          _buildServiceCard(
            context,
            title: 'Group Clinics',
            subtitle: 'Showjumping & dressage group workshops',
            price: 'From £30/session',
            icon: Icons.groups_outlined,
          ),
          const SizedBox(height: 12),
          _buildServiceCard(
            context,
            title: 'Youngstars Club',
            subtitle: 'Junior equestrian development and pony care',
            price: 'From £20/session',
            icon: Icons.child_care_outlined,
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required String price,
    required IconData icon,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookingDetailsScreen(serviceTitle: title),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.cardSurface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: AppColors.primaryOrange, size: 28),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    price,
                    style: const TextStyle(
                      color: AppColors.primaryOrange,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }
}
