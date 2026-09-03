import 'package:flutter/material.dart';
import '../../../app_colours.dart'; // Adjust depth based on folder (../../ or ../../../)

class ScreenNamePlaceholder extends StatelessWidget {
  const ScreenNamePlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        title: const Text(
          'Screen Title',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: const Center(
        child: Text(
          'Dark Theme Screen Ready',
          style: TextStyle(color: AppColors.textSecondary),
        ),
      ),
    );
  }
}
