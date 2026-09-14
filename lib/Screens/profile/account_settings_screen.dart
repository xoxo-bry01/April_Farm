import 'package:flutter/material.dart';
import '../../app_colours.dart';

class AccountSettingsScreen extends StatefulWidget {
  const AccountSettingsScreen({super.key});

  @override
  State<AccountSettingsScreen> createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen> {
  bool _emailNotifications = true;
  bool _pushNotifications = true;
  bool _smsReminders = false;

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
          'Account Settings',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Security',
                style: TextStyle(
                  color: AppColors.primaryOrange,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.cardSurface,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(
                        Icons.lock_outline,
                        color: AppColors.textPrimary,
                      ),
                      title: const Text(
                        'Change Password',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.chevron_right,
                        color: AppColors.textSecondary,
                      ),
                      onTap: () {},
                    ),
                    const Divider(color: Colors.white10, height: 1),
                    ListTile(
                      leading: const Icon(
                        Icons.security,
                        color: AppColors.textPrimary,
                      ),
                      title: const Text(
                        'Two-Factor Authentication',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.chevron_right,
                        color: AppColors.textSecondary,
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              const Text(
                'Notifications',
                style: TextStyle(
                  color: AppColors.primaryOrange,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.cardSurface,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    SwitchListTile(
                      activeColor: AppColors.primaryOrange,
                      title: const Text(
                        'Push Notifications',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: const Text(
                        'Receive updates about arena bookings',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                      value: _pushNotifications,
                      onChanged: (val) =>
                          setState(() => _pushNotifications = val),
                    ),
                    const Divider(color: Colors.white10, height: 1),
                    SwitchListTile(
                      activeColor: AppColors.primaryOrange,
                      title: const Text(
                        'Email Updates',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: const Text(
                        'Receive invoices and receipts',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                      value: _emailNotifications,
                      onChanged: (val) =>
                          setState(() => _emailNotifications = val),
                    ),
                    const Divider(color: Colors.white10, height: 1),
                    SwitchListTile(
                      activeColor: AppColors.primaryOrange,
                      title: const Text(
                        'SMS Reminders',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: const Text(
                        'Text alerts 1 hour before scheduled slots',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                      value: _smsReminders,
                      onChanged: (val) => setState(() => _smsReminders = val),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
