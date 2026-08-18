import 'package:flutter/material.dart';
import '../app_colours.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: const Center(
        child: Text(
          'Livery Updates & Arena Alerts',
          style: TextStyle(color: AppColors.textPrimary, fontSize: 16),
        ),
      ),
    );
  }
}