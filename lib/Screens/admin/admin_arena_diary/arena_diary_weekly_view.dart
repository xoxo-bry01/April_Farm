import 'package:flutter/material.dart';
import '../../../app_colours.dart';

class ArenaDiaryWeeklyView extends StatelessWidget {
  const ArenaDiaryWeeklyView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _buildDaySummary('Monday', '8 Slots Booked'),
        const SizedBox(height: 10),
        _buildDaySummary('Tuesday', '5 Slots Booked'),
        const SizedBox(height: 10),
        _buildDaySummary('Wednesday', '12 Slots Booked (Full)'),
      ],
    );
  }

  Widget _buildDaySummary(String day, String info) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            day,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            info,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
