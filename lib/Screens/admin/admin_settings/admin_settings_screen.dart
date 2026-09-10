import 'package:flutter/material.dart';
import '../../../app_colours.dart';
import 'app_settings_screen.dart';
import 'business_profile_screen.dart';
import 'staff_management_screen.dart';

class AdminSettingsScreen extends StatelessWidget {
  const AdminSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text(
          'Admin Settings',
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
          _buildSettingsTile(
            context,
            title: 'Business Profile',
            subtitle: 'Manage livery name, contact details & operating hours',
            icon: Icons.storefront_outlined,
            screen: const BusinessProfileScreen(),
          ),
          const SizedBox(height: 12),
          _buildSettingsTile(
            context,
            title: 'Staff Management',
            subtitle: 'Add staff members, roles, and permissions',
            icon: Icons.people_outline,
            screen: const StaffManagementScreen(),
          ),
          const SizedBox(height: 12),
          _buildSettingsTile(
            context,
            title: 'App Settings',
            subtitle: 'Configure booking rules, notifications & preferences',
            icon: Icons.tune,
            screen: const AppSettingsScreen(),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTile(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Widget screen,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.primaryOrange.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppColors.primaryOrange, size: 22),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
        ),
        trailing: const Icon(
          Icons.chevron_right,
          color: AppColors.textSecondary,
        ),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
        },
      ),
    );
  }
}
