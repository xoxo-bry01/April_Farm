import 'package:flutter/material.dart';
import '../../../app_colours.dart';

class AppSettingsScreen extends StatefulWidget {
  const AppSettingsScreen({super.key});

  @override
  State<AppSettingsScreen> createState() => _AppSettingsScreenState();
}

class _AppSettingsScreenState extends State<AppSettingsScreen> {
  bool _autoApproveBookings = false;
  bool _pushNotifications = true;
  bool _emailReminders = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'App Settings',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSwitchTile(
            title: 'Auto-Approve Arena Bookings',
            subtitle: 'Automatically accept incoming customer booking requests',
            value: _autoApproveBookings,
            onChanged: (val) => setState(() => _autoApproveBookings = val),
          ),
          const SizedBox(height: 12),
          _buildSwitchTile(
            title: 'Push Notifications',
            subtitle: 'Receive instant alerts on smartphone',
            value: _pushNotifications,
            onChanged: (val) => setState(() => _pushNotifications = val),
          ),
          const SizedBox(height: 12),
          _buildSwitchTile(
            title: 'Automated Email Reminders',
            subtitle: 'Send payment and booking reminders to clients',
            value: _emailReminders,
            onChanged: (val) => setState(() => _emailReminders = val),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: SwitchListTile(
        contentPadding: EdgeInsets.zero,
        activeColor: AppColors.primaryOrange,
        title: Text(
          title,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
        ),
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}
