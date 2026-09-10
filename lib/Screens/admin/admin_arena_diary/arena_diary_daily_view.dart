import 'package:flutter/material.dart';
import '../../../app_colours.dart';

class ArenaDiaryDailyView extends StatelessWidget {
  const ArenaDiaryDailyView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _buildSlotCard(
          '08:00 AM - 09:00 AM',
          'Main Arena Hire',
          'Sarah Jenkins',
          false,
        ),
        const SizedBox(height: 10),
        _buildSlotCard(
          '09:30 AM - 10:30 AM',
          'Group Clinic',
          '4 Participants',
          false,
        ),
        const SizedBox(height: 10),
        _buildSlotCard(
          '11:00 AM - 12:00 PM',
          'Maintenance',
          'Blocked Out',
          true,
        ),
      ],
    );
  }

  Widget _buildSlotCard(
    String time,
    String title,
    String client,
    bool isBlocked,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isBlocked
            ? AppColors.cardSurface.withValues(alpha: 0.5)
            : AppColors.cardSurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isBlocked
              ? Colors.grey.shade800
              : AppColors.primaryOrange.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                time,
                style: const TextStyle(
                  color: AppColors.primaryOrange,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                client,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          Icon(
            isBlocked ? Icons.block : Icons.check_circle_outline,
            color: isBlocked ? AppColors.statusRed : AppColors.statusGreen,
          ),
        ],
      ),
    );
  }
}
