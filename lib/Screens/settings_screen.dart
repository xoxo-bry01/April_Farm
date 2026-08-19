import 'package:flutter/material.dart';
import '../app_colours.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.background,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.cardSurface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.08),
              ),
            ),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.credit_card, color: AppColors.primaryOrange),
                  title: const Text(
                    'Payment Methods',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  subtitle: const Text(
                    'Visa, Mastercard',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: AppColors.textSecondary),
                  onTap: () {},
                ),
                Divider(color: Colors.white.withValues(alpha: 0.08), height: 1),
                ListTile(
                  leading: const Icon(Icons.notifications_none, color: AppColors.primaryOrange),
                  title: const Text(
                    'Notification Preferences',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  subtitle: const Text(
                    'Booking alerts & offer updates',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: AppColors.textSecondary),
                  onTap: () {},
                ),
                Divider(color: Colors.white.withValues(alpha: 0.08), height: 1),
                ListTile(
                  leading: const Icon(Icons.lock_outline, color: AppColors.primaryOrange),
                  title: const Text(
                    'Account Security',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  subtitle: const Text(
                    'Change password & login options',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: AppColors.textSecondary),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}