import 'package:flutter/material.dart';
import '../app_colours.dart';
import 'admin.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            ListTile(
              tileColor: AppColors.cardSurface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              leading: const Icon(Icons.admin_panel_settings, color: AppColors.primaryOrange),
              title: const Text(
                'Owner / Admin Controls',
                style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold),
              ),
              subtitle: const Text(
                'Manage diary, block slots, and add manual bookings',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, color: AppColors.textSecondary, size: 16),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const AdminScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}