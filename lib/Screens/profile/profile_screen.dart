import 'package:flutter/material.dart';
import '../../app_colours.dart';
import 'edit_profile_screen.dart';
import 'my_horses_screen.dart';
import 'payment_methods_screen.dart';
import 'account_settings_screen.dart';
import 'help_support_screen.dart';
import 'about_screen.dart';
import 'logout_confirm_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text(
          'My Profile',
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
          _buildProfileHeader(context),
          const SizedBox(height: 24),
          _buildSectionTitle('Account'),
          _buildTile(
            icon: Icons.person_outline,
            title: 'Edit Profile',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const EditProfileScreen()),
            ),
          ),
          _buildTile(
            icon: Icons.pets_outlined,
            title: 'My Horses',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const MyHorsesScreen()),
            ),
          ),
          _buildTile(
            icon: Icons.credit_card_outlined,
            title: 'Payment Methods',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const PaymentMethodsScreen()),
            ),
          ),
          _buildTile(
            icon: Icons.settings_outlined,
            title: 'Account Settings',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AccountSettingsScreen()),
            ),
          ),
          const SizedBox(height: 16),
          _buildSectionTitle('Support & Info'),
          _buildTile(
            icon: Icons.help_outline,
            title: 'Help & Support',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const HelpSupportScreen()),
            ),
          ),
          _buildTile(
            icon: Icons.info_outline,
            title: 'About April Farm',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AboutScreen()),
            ),
          ),
          const SizedBox(height: 16),
          _buildTile(
            icon: Icons.logout,
            title: 'Log Out',
            textColor: AppColors.statusRed,
            iconColor: AppColors.statusRed,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const LogoutConfirmScreen()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: AppColors.primaryOrange.withValues(alpha: 0.2),
            child: const Icon(
              Icons.person,
              color: AppColors.primaryOrange,
              size: 36,
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Equestrian User',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'user@example.com',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 4.0),
      child: Text(
        title,
        style: const TextStyle(
          color: AppColors.textSecondary,
          fontSize: 13,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color textColor = AppColors.textPrimary,
    Color iconColor = AppColors.primaryOrange,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: iconColor),
        title: Text(
          title,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right,
          color: AppColors.textSecondary,
        ),
        onTap: onTap,
      ),
    );
  }
}
