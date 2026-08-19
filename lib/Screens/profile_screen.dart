// lib/screens/profile/profile_screen.dart
import 'package:flutter/material.dart';
import '../app_colours.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Avatar Header
            Center(
              child: Stack(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: AppColors.primaryOrange,
                    child: Icon(Icons.person, size: 50, color: Colors.white),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: AppColors.primaryOrange,
                      child: const Icon(Icons.edit, size: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Rider Profile',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const Text(
              'April Farm Member',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),

            // Profile Sections / Navigation
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  _buildProfileTile(
                    icon: Icons.person_outline,
                    title: 'Personal Details',
                    subtitle: 'Manage name, phone number, and email',
                    onTap: () {},
                  ),
                  _buildProfileTile(
                    icon: Icons.pets_outlined,
                    title: 'Horse & Livery Information',
                    subtitle: 'Rider skill level & horse preferences',
                    onTap: () {},
                  ),
                  _buildProfileTile(
                    icon: Icons.receipt_long_outlined,
                    title: 'Invoices & Payments',
                    subtitle: 'View billing history and receipts',
                    onTap: () {},
                  ),
                  _buildProfileTile(
                    icon: Icons.notifications_none,
                    title: 'Notification Settings',
                    subtitle: 'Reminders & daily arena alerts',
                    onTap: () {},
                  ),
                  _buildProfileTile(
                    icon: Icons.help_outline,
                    title: 'FAQs & Support',
                    subtitle: 'Contact farm support and guidance',
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primaryOrange),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}