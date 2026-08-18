import 'package:flutter/material.dart';
import '../app_colours.dart';

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
      body: const Center(
        child: Text(
          'Personal Details & Hamburger Settings Menu',
          style: TextStyle(color: AppColors.textPrimary, fontSize: 16),
        ),
      ),
    );
  }
}